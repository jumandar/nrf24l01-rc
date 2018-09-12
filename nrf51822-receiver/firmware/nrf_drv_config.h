#pragma once

#define GPIO_LED                    18
#define GPIO_SERVO_1                21
#define GPIO_SERVO_2                22
#define GPIO_SERVO_3                23
#define GPIO_SERVO_4                24
#define GPIO_SERVO_5                25
#define GPIO_SERVO_6                28
#define GPIO_SERVO_7                29
#define GPIO_SERVO_8                30

#define GPIO_BIND                   16

#define GPIO_TEST                   0


#define CLOCK_ENABLED               1
#define CLOCK_CONFIG_XTAL_FREQ      NRF_CLOCK_XTALFREQ_Default
#define CLOCK_CONFIG_LF_SRC         CLOCK_LFCLKSRC_SRC_Xtal
#define CLOCK_CONFIG_IRQ_PRIORITY   APP_IRQ_PRIORITY_LOW


#define NRF_MAXIMUM_LATENCY_US      1000


#define RTC0_ENABLED                1
#define RTC0_CONFIG_FREQUENCY       1000
#define RTC0_CONFIG_IRQ_PRIORITY    APP_IRQ_PRIORITY_LOW
#define RTC0_CONFIG_RELIABLE        false
#define RTC0_INSTANCE_INDEX         0
#define RTC_COUNT                   1


#define UART0_ENABLED               1
#define UART0_CONFIG_HWFC           NRF_UART_HWFC_DISABLED
#define UART0_CONFIG_PARITY         NRF_UART_PARITY_EXCLUDED
#define UART0_CONFIG_BAUDRATE       NRF_UART_BAUDRATE_115200
#define UART0_CONFIG_PSEL_TXD       9
#define UART0_CONFIG_PSEL_RXD       11
#define UART0_CONFIG_PSEL_CTS       10
#define UART0_CONFIG_PSEL_RTS       8
#define UART0_CONFIG_IRQ_PRIORITY   APP_IRQ_PRIORITY_HIGH
#define UART0_CONFIG_RX_BUFFER_SIZE 512
#define UART0_CONFIG_TX_BUFFER_SIZE 512


#define RNG_ENABLED                 1
#define RNG_CONFIG_ERROR_CORRECTION true
#define RNG_CONFIG_POOL_SIZE        8
#define RNG_CONFIG_IRQ_PRIORITY     APP_IRQ_PRIORITY_LOW


#define GPIOTE_ENABLED              1
#define GPIOTE_CONFIG_USE_SWI_EGU   false
#define GPIOTE_CONFIG_IRQ_PRIORITY  APP_IRQ_PRIORITY_LOW
#define GPIOTE_CONFIG_NUM_OF_LOW_POWER_EVENTS 0


#define TIMER0_ENABLED             1
#define TIMER0_CONFIG_FREQUENCY    NRF_TIMER_FREQ_16MHz
#define TIMER0_CONFIG_MODE         TIMER_MODE_MODE_Timer
#define TIMER0_CONFIG_BIT_WIDTH    TIMER_BITMODE_BITMODE_16Bit
#define TIMER0_CONFIG_IRQ_PRIORITY APP_IRQ_PRIORITY_LOW
#define TIMER0_INSTANCE_INDEX      0

#define TIMER1_ENABLED             1
#define TIMER1_CONFIG_FREQUENCY    NRF_TIMER_FREQ_16MHz
#define TIMER1_CONFIG_MODE         TIMER_MODE_MODE_Timer
#define TIMER1_CONFIG_BIT_WIDTH    TIMER_BITMODE_BITMODE_16Bit
#define TIMER1_CONFIG_IRQ_PRIORITY APP_IRQ_PRIORITY_LOW
#define TIMER1_INSTANCE_INDEX      1

#define TIMER_COUNT                2
// NOTE: the micro ESB code uses TIMER2 internally with direct register access
