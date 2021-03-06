/******************************************************************************

    Application entry point.

    Contains the main loop and the hardware initialization.

******************************************************************************/
#include <stdio.h>
#include <stdbool.h>

#include <platform.h>
#include <uart0.h>
#include <spi.h>
#include <rc_receiver.h>
#include <preprocessor_output.h>

#include <LPC8xx_ROM_API.h>


#ifndef BAUDRATE
    #define BAUDRATE 115200
#endif


void SysTick_handler(void);
void PININT0_irq_handler(void);
void SCT_irq_handler(void);
void MRT_irq_handler(void);
void switch_gpio_according_rx_protocol(rx_protocol_t rx_protocol);



// Global flag that is true for one mainloop every __SYSTICK_IN_MS
bool systick;
volatile uint32_t milliseconds;

// Global flag indicating 8-channel hardware based on TSSOP20 version
bool is8channel;

uint32_t gpio_mask_led = (1 << GPIO_4CH_BIT_LED);
uint32_t gpio_mask_nrf_ce = (1 << GPIO_4CH_BIT_NRF_CE);

static volatile uint32_t systick_count;



// ****************************************************************************
static void feed_the_watchdog(void)
{
    LPC_WWDT->FEED = 0xaa;
    LPC_WWDT->FEED = 0x55;
}


// ****************************************************************************
static void service_systick(void)
{
    if (!systick_count) {
        systick = false;
        return;
    }

    systick = true;
    milliseconds += __SYSTICK_IN_MS;

    // Disable the SysTick interrupt. Use memory barriers to ensure that no
    // interrupt is pending in the pipeline.
    // More info:
    // http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dai0321a/BIHHFHJD.html
    SysTick->CTRL &= ~(1 << 1);
    __DSB();
    __ISB();
    --systick_count;
    SysTick->CTRL |= (1 << 1);      // Re-enable the system tick interrupt
}


// ****************************************************************************
static void stack_check(void)
{
#ifndef NO_DEBUG
    #define CANARY 0xcafebabe

    static uint32_t *last_found = (uint32_t *)(0x10001000 - 48);
    uint32_t *now;

    if (last_found == (uint32_t *)0x10000000) {
        return;
    }

    now = last_found;
    while (*now != CANARY && now > (uint32_t *)0x10000000) {
        --now;
    }

    if (now != last_found) {
        last_found = now;
        uart0_send_cstring("Stack down to 0x");
        uart0_send_uint32_hex((uint32_t)now);
        uart0_send_linefeed();
    }
#endif
}


// ****************************************************************************
static void init_hardware(void)
{
    int i;

#if __SYSTEM_CLOCK != 12000000
#error Clock initialization code expexts __SYSTEM_CLOCK to be set to 1200000
#endif


    if (is8channel) {
        gpio_mask_led = (1 << GPIO_8CH_BIT_LED);
        gpio_mask_nrf_ce = (1 << GPIO_8CH_BIT_NRF_CE);
    }


    // Set flash wait-states to 1 system clock
    LPC_FLASHCTRL->FLASHCFG = 0;


    // ------------------------
    // Turn on peripheral clocks for SCTimer, IOCON, SPI0, MRT, WWDT
    // (GPIO, SWM alrady enabled after reset)
    LPC_SYSCON->SYSAHBCLKCTRL |=
        (1 << 18) | (1 << 17) | (1 << 11) | (1 << 10) | (1 << 8);


    // ------------------------
    // Turn on brown-out detection and reset
    LPC_SYSCON->BODCTRL = (1 << 4) | (1 << 2) | (3 << 0);


    // ------------------------
    // Multi Rate Timer configuration
    // This timer is used for the delay_us functionality
    LPC_MRT->Channel[0].CTRL = (0x1 << 1); // One-shot mode


#ifdef USE_IRC
    // All special functions disabled, including reset
    LPC_SWM->PINENABLE0 = 0xffffffff;
#endif


#ifndef USE_IRC
    // XTALIN and XTALOUT enabled, others disabled (including reset)
    LPC_IOCON->PIO0_8 = 0;              // Turn pull-up off
    LPC_IOCON->PIO0_9 = 0;
    LPC_SWM->PINENABLE0 = 0xffffffcf;

    if (is8channel) {
        // A 12 MHz crystal is used on 8-channel hardware.
        // Directly used as system clock
        LPC_SYSCON->SYSOSCCTRL = (0 << 1);          // 1..20 MHz range

        LPC_SYSCON->PDRUNCFG &= ~(1 << 5);          // Enable the system oscillator
        delay_us(600);

        LPC_SYSCON->SYSPLLCLKSEL = 0x1;             // PLL input is the crystal oscillator
        LPC_SYSCON->SYSPLLCLKUEN = 0;               // Toggle PLL-enable
        LPC_SYSCON->SYSPLLCLKUEN = 1;

        LPC_SYSCON->MAINCLKSEL = 0x1;               // Use the PLL clock input as main clock
        LPC_SYSCON->MAINCLKUEN = 0;                 // Toggle CLK-enable
        LPC_SYSCON->MAINCLKUEN = 1;
    }
    else {
        // A 16 MHz crystal is used on 4-channel hardware, so we use the PLL
        // to make 48 MHz, then divide by 4 for 12 MHz system clock

        LPC_SYSCON->SYSOSCCTRL = (1 << 1);          // 15..25 MHz range
        LPC_SYSCON->PDRUNCFG &= ~(1 << 5);          // Enable the system oscillator
        delay_us(600);

        LPC_SYSCON->PDRUNCFG &= ~(1 << 7);          // Enable the PLL
        LPC_SYSCON->SYSPLLCLKSEL = 0x1;             // PLL input is the crystal oscillator
        LPC_SYSCON->SYSPLLCLKUEN = 0;               // Toggle PLL-enable
        LPC_SYSCON->SYSPLLCLKUEN = 1;

        // Set the PLL to 16Mhz * 3 = 48 Mhz
        LPC_SYSCON->SYSPLLCTRL = (0x2 << 0);        // M = 3

        while (!(LPC_SYSCON->SYSPLLSTAT & 1)) {     // Wait for PLL lock
            ;
        }

        LPC_SYSCON->SYSAHBCLKDIV = 4;               // Divide 48 MHz PLL output by 4 for 12 MHz system clock

        LPC_SYSCON->MAINCLKSEL = 0x3;               // Use the PLL clock output as main clock
        LPC_SYSCON->MAINCLKUEN = 0;                 // Toggle CLK-enable
        LPC_SYSCON->MAINCLKUEN = 1;
    }
#endif


    // ------------------------
    // IO configuration

    // Enable hardware inputs and outputs
    if (is8channel) {
        // 8ch pin configuration
#ifndef NO_DEBUG
        // When debug is active we enable the UART output on CH5
        LPC_SWM->PINASSIGN0 = (0xff << 24) |
                              (0xff << 16) |
                              (0xff << 8) |                     // UART0_RX
                              (GPIO_BIT_TX << 0);               // UART0_TX
#endif

        LPC_SWM->PINASSIGN3 = (GPIO_8CH_BIT_NRF_SCK << 24) |    // SPI0_SCK
                              (0xff << 16) |
                              (0xff << 8) |
                              (0xff << 0);

        LPC_SWM->PINASSIGN4 = (0xff << 24) |
                              (GPIO_8CH_BIT_NRF_CSN << 16) |    // SPI0_SSEL
                              (GPIO_8CH_BIT_NRF_MISO << 8) |    // SPI0_MISO
                              (GPIO_8CH_BIT_NRF_MOSI << 0);     // SPI0_MOSI

        // Make all servo outputs High initially
        LPC_GPIO_PORT->SET0 = (1 << GPIO_8CH_BIT_CH1) |
                              (1 << GPIO_8CH_BIT_CH2) |
                              (1 << GPIO_8CH_BIT_CH3) |
                              (1 << GPIO_8CH_BIT_CH4) |
                              (1 << GPIO_8CH_BIT_CH5) |
                              (1 << GPIO_8CH_BIT_CH6) |
                              (1 << GPIO_8CH_BIT_CH7) |
                              (1 << GPIO_8CH_BIT_CH8);

        // Configure outputs
        LPC_GPIO_PORT->DIR0 = (1 << GPIO_8CH_BIT_NRF_SCK) |
                              (1 << GPIO_8CH_BIT_NRF_MOSI) |
                              (1 << GPIO_8CH_BIT_NRF_CSN) |
                              (1 << GPIO_8CH_BIT_NRF_CE) |
                              (1 << GPIO_8CH_BIT_CH1) |
                              (1 << GPIO_8CH_BIT_CH2) |
                              (1 << GPIO_8CH_BIT_CH3) |
                              (1 << GPIO_8CH_BIT_CH4) |
                              (1 << GPIO_8CH_BIT_CH5) |
                              (1 << GPIO_8CH_BIT_CH6) |
                              (1 << GPIO_8CH_BIT_CH7) |
                              (1 << GPIO_8CH_BIT_CH8) |
                              (1 << GPIO_8CH_BIT_LED);
    }
    else {
        // 4ch pin configuration
        LPC_SWM->PINASSIGN0 = (0xff << 24) |
                              (0xff << 16) |
                              (0xff << 8) |                     // UART0_RX
                              (GPIO_BIT_TX << 0);               // UART0_TX

        LPC_SWM->PINASSIGN3 = (GPIO_4CH_BIT_NRF_SCK << 24) |    // SPI0_SCK
                              (0xff << 16) |
                              (0xff << 8) |
                              (0xff << 0);

        LPC_SWM->PINASSIGN4 = (0xff << 24) |
                              (GPIO_4CH_BIT_NRF_CSN << 16) |    // SPI0_SSEL
                              (GPIO_4CH_BIT_NRF_MISO << 8) |    // SPI0_MISO
                              (GPIO_4CH_BIT_NRF_MOSI << 0);     // SPI0_MOSI

        // Make all servo outputs High initially
        LPC_GPIO_PORT->SET0 = (1 << GPIO_4CH_BIT_CH1) |
                              (1 << GPIO_4CH_BIT_CH2) |
                              (1 << GPIO_4CH_BIT_CH3) |
                              (1 << GPIO_4CH_BIT_CH4);

        // Configure outputs
        LPC_GPIO_PORT->DIR0 = (1 << GPIO_4CH_BIT_NRF_SCK) |
                              (1 << GPIO_4CH_BIT_NRF_MOSI) |
                              (1 << GPIO_4CH_BIT_NRF_CSN) |
                              (1 << GPIO_4CH_BIT_NRF_CE) |
                              (1 << GPIO_4CH_BIT_CH1) |
                              (1 << GPIO_4CH_BIT_CH2) |
                              (1 << GPIO_4CH_BIT_CH3) |
                              (1 << GPIO_4CH_BIT_CH4) |
                              (1 << GPIO_4CH_BIT_LED);
    }

    // CE = 0; LED on
    LPC_GPIO_PORT->CLR0 = gpio_mask_led | gpio_mask_nrf_ce;


    // ------------------------
    // Configure SCTimer globally for two 16-bit counters
    LPC_SCT->CONFIG = 0;
    LPC_SCT->CTRL_H |= (1 << 3) | (1 << 2);         // Reset and Halt Counter H
    LPC_SCT->CTRL_L |= (1 << 3) | (1 << 2);         // Reset and Halt Counter L

    // Timer H is used for the servo outputs, setting the servo pins
    // on timer reload and clearing them when a match condition occurs.
    // Up to 4 servo pulses are generated with MATCH/EVENT registers 1..4 and
    // corresponding timer outputs 0..3.
    // MATCH/EVENT register 0 is used for auto-reload of the timer period.

    // Set up the events that the match registers trigger. EVENT[0] is for the
    // servo pulse period, EVENTS[1..4] for 4 servo channel outputs.
    // All 5 events are setup in the same way:
    //    - Event happens in all states
    //    - Match register of the same number
    //    - HEVENT: Match counter H
    //    - COMBMODE: Match condition only
    for (i = 0; i < 5; i++) {
        LPC_SCT->EVENT[i].STATE = 0xFFFF;           // Event happens in all states
        LPC_SCT->EVENT[i].CTRL = (i << 0) |         // Match register
                                 (1 << 4) |         // Select H counter
                                 (0x1 << 12);       // Match condition only
    }
    LPC_SCT->LIMIT_H = (1 << 0);                    // EVENT0 limits (resets) the counter

    LPC_SCT->OUTPUT = (1 << 0) |                    // Force all timer outputs initially High
                      (1 << 1) |
                      (1 << 2) |
                      (1 << 3);

    // 8-channel multiplexing
    //
    // All 4 channel events are triggering an interrupt. Whenever an event fires,
    // we load the corresponding MATCHREL with the value for the other servo
    // channel, and CTOUT with the port number of that other servo channel.
    // The next EVENT0 reseting the timer will output the other channel and
    // the cycle repeats.


    // All servo outputs will be SET with timer reload event 0, and CLEARED
    // with the indivual servo pulse time EVENTs
    LPC_SCT->OUT[0].SET = (1 << 0);
    LPC_SCT->OUT[1].SET = (1 << 0);
    LPC_SCT->OUT[2].SET = (1 << 0);
    LPC_SCT->OUT[3].SET = (1 << 0);

    LPC_SCT->OUT[0].CLR = (1 << 1);                 // Event 1 will clear CTOUT_0
    LPC_SCT->OUT[1].CLR = (1 << 2);                 // Event 2 will clear CTOUT_1
    LPC_SCT->OUT[2].CLR = (1 << 3);                 // Event 3 will clear CTOUT_2
    LPC_SCT->OUT[3].CLR = (1 << 4);                 // Event 4 will clear CTOUT_3


    // Timer L is used for frequency hopping. It is configured as a simple
    // auto-reload that fires an interrupt in regular intervals, using EVENT[5].
    // The rc_receiver.c takes care of setting the counter and limit values.

    LPC_SCT->CTRL_L |= (1 << 3) | (1 << 2) |        // Reset and Halt Counter L
        (((__SYSTEM_CLOCK / 1000000) - 1) << 5);    // PRE_L[12:5] = divide for 1 MHz
    LPC_SCT->EVENT[5].STATE = 0xFFFF;               // Event happens in all states
    LPC_SCT->EVENT[5].CTRL = (0 << 0) |             // Match register
                             (0 << 4) |             // Select counter L
                             (0x1 << 12);           // Match condition only
    LPC_SCT->LIMIT_L = (1u << 5);                   // EVENT[5] limits (resets) the counter
    LPC_SCT->EVEN |= (1u << 5);                     // EVENT[5] generates an interrupt


    // ------------------------
    // Configure the exernal interrupt from the NRF chip
    LPC_SYSCON->PINTSEL[0] = is8channel ? GPIO_8CH_BIT_NRF_IRQ : GPIO_4CH_BIT_NRF_IRQ; // NRF_IRQ on PININT0
    LPC_PIN_INT->IENF = (1 << 0);               // Enable falling edge on PININT0


    // ------------------------
    // Watchdog configuration
    LPC_SYSCON->WDTOSCCTRL = (1 << 5) |     // 0.6 MHz
                             (0xff << 0);   // Divide by 64 for ~9.4 kHz Watchdog clock
    LPC_SYSCON->PDRUNCFG &= ~(1 << 6);      // Watchdog oscillator on
    LPC_WWDT->MOD = (1 << 0) |              // Watchdog enabled
                    (1 << 1);               // Watchdog causes reset
    // Set approx 200ms watchdog timeout.
    // The application can use more than 100ms when erasing a single page
    // of flash, so we give us more than that.
    LPC_WWDT->TC = 2000;
    feed_the_watchdog();

    // ------------------------
    // SysTick configuration
    SysTick->LOAD = __SYSTEM_CLOCK * __SYSTICK_IN_MS / 1000;
    SysTick->VAL = __SYSTEM_CLOCK * __SYSTICK_IN_MS / 1000;
    SysTick->CTRL = (1 << 0) |              // Enable System Tick counter
                    (1 << 1) |              // System Tick interrupt enable
                    (1 << 2);               // Use system clock

}


// ****************************************************************************
static void init_hardware_final(void)
{
    // Turn off peripheral clock for IOCON to preserve power
    LPC_SYSCON->SYSAHBCLKCTRL &= ~(1 << 18);

    NVIC_EnableIRQ(PININT0_IRQn);
    NVIC_EnableIRQ(SCT_IRQn);
}


// ****************************************************************************
void switch_gpio_according_rx_protocol(rx_protocol_t protocol)
{
    // HaLt the counter. This is required before changing bits in the
    // CTRL register other than HALT or STOP.
    LPC_SCT->CTRL_H = (1 << 2);

    if (is8channel && (protocol == PROTOCOL_8CH)) {
        // The timer is running at 2 MHz clock (500ns resolution).
        LPC_SCT->CTRL_H = (1 << 3) | (1 << 2) |
          (((__SYSTEM_CLOCK / 2000000) - 1) << 5);

        // The repeat frequency is 8ms, leading to a pulse repeat rate of 16ms
        // because we process 2 sets of 4 servo outputs.
        // NOTE: Hitec HS65-HB don't work well with 10ms repeat rate, but fine
        // with 16 or above
        LPC_SCT->MATCHREL[0].H = (8000 * 2) - 1;

        // Servo pulse 1.5 ms intially
        LPC_SCT->MATCHREL[1].H = SERVO_PULSE_CENTER * 2;
        LPC_SCT->MATCHREL[2].H = SERVO_PULSE_CENTER * 2;
        LPC_SCT->MATCHREL[3].H = SERVO_PULSE_CENTER * 2;
        LPC_SCT->MATCHREL[4].H = SERVO_PULSE_CENTER * 2;

        // EVENT[1..4] generate an interrupt
        LPC_SCT->EVEN |= (1u << 1) |
                         (1u << 2) |
                         (1u << 3) |
                         (1u << 4);
    }
    else {
        // The timer is running at 1.3 MHz clock (750ns resolution).
        // The repeat frequency is 10ms (a multiple of the on-air packet repeat
        // rate).
        LPC_SCT->CTRL_H = (1 << 3) | (1 << 2) |
          (((__SYSTEM_CLOCK / 1333333) - 1) << 5);

        // 10 ms servo pulse repeat time
        LPC_SCT->MATCHREL[0].H = (10000 * 4 / 3) - 1;

        // Servo pulse 1.5 ms intially
        LPC_SCT->MATCHREL[1].H = SERVO_PULSE_CENTER * 4 / 3;
        LPC_SCT->MATCHREL[2].H = SERVO_PULSE_CENTER * 4 / 3;
        LPC_SCT->MATCHREL[3].H = SERVO_PULSE_CENTER * 4 / 3;
        LPC_SCT->MATCHREL[4].H = SERVO_PULSE_CENTER * 4 / 3;

        // EVENT[1..4] DON'T generate an interrupt
        LPC_SCT->EVEN &= ~((1u << 1) |
                           (1u << 2) |
                           (1u << 3) |
                           (1u << 4));

        if (is8channel) {
            LPC_SWM->PINASSIGN6 = (GPIO_8CH_BIT_CH1 << 24) |        // CTOUT_0
                                  (0xff << 16) |
                                  (0xff << 8) |
                                  (0xff << 0);

            LPC_SWM->PINASSIGN7 = (0xff << 24) |
                                  (GPIO_8CH_BIT_CH4 << 16) |        // CTOUT_3
                                  (GPIO_8CH_BIT_CH3 << 8) |         // CTOUT_2
                                  (GPIO_8CH_BIT_CH2 << 0);          // CTOUT_1
        }
        else {
            LPC_SWM->PINASSIGN6 = (GPIO_4CH_BIT_CH1 << 24) |        // CTOUT_0
                                  (0xff << 16) |
                                  (0xff << 8) |
                                  (0xff << 0);

            LPC_SWM->PINASSIGN7 = (0xff << 24) |
                                  (0xff << 16) |                    // CTOUT_3 (by default we enable the UART output!)
                                  (GPIO_4CH_BIT_CH3 << 8) |         // CTOUT_2
                                  (GPIO_4CH_BIT_CH2 << 0);          // CTOUT_1
        }
    }


    if (is8channel) {
        // 8ch hardware
        switch (protocol) {
            case PROTOCOL_8CH:
#ifdef NO_DEBUG
                // Disable UART0_TX
                LPC_SWM->PINASSIGN0 |= (0xff << 0);
#endif
                break;

            case PROTOCOL_3CH:
            case PROTOCOL_4CH:
            default:
                // Enable UART0_TX
                // Since the TX pin is on (unused) CH5 we can use it as
                // preprocessor output regardless weather the protocol is 3ch
                // or 4ch
                LPC_SWM->PINASSIGN0 = (0xff << 24) |
                                      (0xff << 16) |
                                      (0xff << 8) |
                                      (GPIO_BIT_TX << 0);
                break;
        }

        return;
    }

    // 4ch hardware
    switch (protocol) {
        case PROTOCOL_4CH:
        case PROTOCOL_8CH:
#ifdef NO_DEBUG
            // Disable UART0_TX
            LPC_SWM->PINASSIGN0 |= (0xff << 0);

            // Enable CH4 on CTOUT_3 without disturbing the other settings
            LPC_SWM->PINASSIGN7 = (LPC_SWM->PINASSIGN7 & 0xff00ffff) | (GPIO_4CH_BIT_CH4 << 16);
#endif
            break;

        case PROTOCOL_3CH:
        default:
            // Disable CTOUT_3 (CH4)
            LPC_SWM->PINASSIGN7 |= (0xff << 16);

            // enable UART0_TX
            LPC_SWM->PINASSIGN0 = (0xff << 24) |
                                  (0xff << 16) |
                                  (0xff << 8) |
                                  (GPIO_BIT_TX << 0);
            break;
    }

}


// ****************************************************************************
void PININT0_irq_handler(void)
{
    LPC_PIN_INT->IST = (1 << 0);          // Clear the interrupt status flag
    rf_interrupt_handler();
}


// ****************************************************************************
void SCT_irq_handler(void)
{
    if (LPC_SCT->EVFLAG & (1u << 5)) {
        LPC_SCT->EVFLAG = (1u << 5);
        hop_timer_handler();
    }

    // Events 1..4 for 8ch multiplexing
    if (LPC_SCT->EVFLAG & ((1u << 1) | (1u << 2) | (1u << 3) | (1u << 4))) {
      // Note: flags are cleared within the function!
      servo_pulse_timer_handler();
    }
}


// ****************************************************************************
void SysTick_handler(void)
{
    if (SysTick->CTRL & (1 << 16)) {       // Read and clear Countflag
        ++systick_count;
    }
}


// ****************************************************************************
void invoke_ISP(void)
{
    unsigned int param[5];

    // Release all special function pins
    LPC_SWM->PINASSIGN0 = 0xffffffff;
    LPC_SWM->PINASSIGN1 = 0xffffffff;
    LPC_SWM->PINASSIGN2 = 0xffffffff;
    LPC_SWM->PINASSIGN3 = 0xffffffff;
    LPC_SWM->PINASSIGN4 = 0xffffffff;
    LPC_SWM->PINASSIGN5 = 0xffffffff;
    LPC_SWM->PINASSIGN6 = 0xffffffff;
    LPC_SWM->PINASSIGN7 = 0xffffffff;
    LPC_SWM->PINASSIGN8 = 0xffffffff;

    // Make the ISP RX pin an input
    LPC_GPIO_PORT->DIR0 &= ~(1 << 0);

    // Disable the watchdog through power-down of the watchdog osc
    LPC_SYSCON->PDRUNCFG |= (1 << 6);

    param[0] = 57;  // Reinvoke ISP
    __disable_irq();
    iap_entry(param, param);

#ifndef NO_DEBUG
    // This should never execute ...
    __enable_irq();
    uart0_send_cstring("ERROR: Reinvoke ISP failed\n");
    while(1);
#endif
}


// ****************************************************************************
void delay_us(uint32_t microseconds)
{
    LPC_MRT->Channel[0].STAT |= 1;
    LPC_MRT->Channel[0].INTVAL =
        ((__SYSTEM_CLOCK / 1000000) * microseconds) & 0x7fffffff;

    while (!(LPC_MRT->Channel[0].STAT & 1)) {
        ;
    }
}


// ****************************************************************************
int main(void)
{
    // is8channel gets set if MCU is LPC812M101JDH20 (20 pin TSSSOP version)
    is8channel = (LPC_SYSCON->DEVICE_ID == 0x00008122);

    init_hardware();
    init_uart0(BAUDRATE);
    init_spi();
    init_hardware_final();

#ifndef NO_DEBUG
    uart0_send_cstring("Hardware initialized\n");
#endif

    // Wait a for a short time after power up before talking to the nRF24
    delay_us(20000);
    init_receiver();

#ifndef NO_DEBUG
    uart0_send_cstring("Receiver initialized\n");
#endif

    for (;;) {
        service_systick();
        process_receiver();

#ifdef ENABLE_PREPROCESSOR_OUTPUT
        output_preprocessor();
#endif

        stack_check();
        feed_the_watchdog();
    }
}
