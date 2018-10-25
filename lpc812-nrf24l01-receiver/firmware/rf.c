#include <stdlib.h>
#include <stdint.h>
#include <stdbool.h>

#include <platform.h>
#include <spi.h>
#include <rf.h>

static uint8_t spi_buffer[RF_MAX_BUFFER_LENGTH + 1];


// ****************************************************************************
// Helper function to convert DATA_PIPE_0..5 bit mask into the pipe number 0..5
// ****************************************************************************
static uint8_t get_pipe_no(uint8_t pipe)
{
    int pipe_no;

    for (pipe_no = 0; pipe_no < 6; pipe_no++) {
        if (pipe == (1 << pipe_no)) {
            return pipe_no;
        }
    }
    return 0;
}


// ****************************************************************************
// Send a one-byte command to the nRF24.
// Returns the STATUS register value
// ****************************************************************************
static uint8_t rf_command(uint8_t cmd)
{
    spi_buffer[0] = cmd;
    return spi_transaction(1, spi_buffer);
}


// ****************************************************************************
// Write a command to the nRF24, followed by data bytes
// Returns the STATUS register value
// ****************************************************************************
static uint8_t rf_write_command_buffer(uint8_t cmd, uint8_t count, const uint8_t *buffer)
{
    int i;

    if (count > RF_MAX_BUFFER_LENGTH) {
        count = RF_MAX_BUFFER_LENGTH;
    }

    spi_buffer[0] = cmd;
    for (i = 0; i < count; i++) {
        spi_buffer[i + 1] = buffer[i];
    }

    return spi_transaction(count + 1, spi_buffer);
}


// ****************************************************************************
// Send a command to the nRF24 and read *count* bytes of data from the nRF24.
// Returns the STATUS register value
// ****************************************************************************
static uint8_t rf_read_command_buffer(uint8_t cmd, uint8_t count, uint8_t *buffer)
{
    int i;

    if (count > RF_MAX_BUFFER_LENGTH) {
        count = RF_MAX_BUFFER_LENGTH;
    }

    spi_buffer[0] = cmd;

    spi_transaction(count + 1, spi_buffer);

    for (i = 0; i < count; i++) {
        buffer[i] = spi_buffer[i + 1];
    }

    return spi_buffer[0];
}


// ****************************************************************************
static uint8_t rf_read_register(uint8_t reg)
{
    spi_buffer[0] = R_REGISTER | reg;
    spi_buffer[1] = 0;

    spi_transaction(2, spi_buffer);

    return spi_buffer[1];
}


// ****************************************************************************
static void rf_write_register(uint8_t reg, uint8_t value)
{
    // Data sheet page 52: The nRF24L01+ must be in a standby or power down mode
    // before writing to the configuration registers.
    // i.e. CE must be 0 in receive mode
    //
    // It is unclear what a "configuration register" is, because in order
    // to change to power down mode one has to write the CONFIG register?!
    // We assume that registers that configure the transceiver are meant, like
    // setting the channel, address, payload size, CRC, etc.
    //
    // It is left to the user of this library to set/clear CE properly.

    spi_buffer[0] = W_REGISTER | reg;
    spi_buffer[1] = value;

    spi_transaction(2, spi_buffer);
}


// ****************************************************************************
// Write a register that accepts multiple bytes of data
// Example: TX_ADDR register has up to 5 bytes of data
// Returns the STATUS register
// ****************************************************************************
static uint8_t rf_write_multi_byte_register(uint8_t reg, uint8_t count, const uint8_t *buffer)
{
    return rf_write_command_buffer(W_REGISTER | reg, count, buffer);
}


// ****************************************************************************
// Only available on the nRF24LE1; N/A on nRF24L01+
// ****************************************************************************
void rf_enable_clock(void)
{
    // rfcken = 1
}


// ****************************************************************************
// Only available on the nRF24LE1; N/A on nRF24L01+
// ****************************************************************************
void rf_disable_clock(void)
{
    // rfcken = 0
}


// ****************************************************************************
// Return the contents of the STATUS register by issuing a NOP command
// ****************************************************************************
uint8_t rf_get_status(void)
{
    return rf_command(NOP);
}


// ****************************************************************************
void rf_set_ce(void)
{
    LPC_GPIO_PORT->SET0 = gpio_mask_nrf_ce;

    // Data sheet page 24: Delay from CE positive edge to CSN low: 4us
    // To ensure that we always delay for 4us.
    delay_us(4);
}


// ****************************************************************************
void rf_clear_ce(void)
{
    LPC_GPIO_PORT->CLR0 = gpio_mask_nrf_ce;
}


// ****************************************************************************
// Sets the receive address for the given pipe.
//
// Note that pipes 2..5 share the 4 MSB with pipe 1.
// ****************************************************************************
void rf_set_rx_address(uint8_t pipe, uint8_t address_width, const uint8_t address[])
{
    uint8_t pipe_no;

    pipe_no = get_pipe_no(pipe);

    // Pipes 2..5 inherit the 4 MSB of address from pipe 1
    // See datasheet page 50, 51
    if (pipe_no >= 2) {
        address_width = 1;
    }

    rf_write_multi_byte_register(RX_ADDR_P0 + pipe_no, address_width, address);
}


// ****************************************************************************
// RF frequency in MHz = 2400 + channel
//
// The nRF24L01+ can use channel 0..125 (2.4 .. 2.525 GHz)
// The world-wide ISM band is 2.4 .. 2.5 GHz, so only channels 0..100 can
// be used legally.
// ****************************************************************************
void rf_set_channel(uint8_t channel)
{
    rf_write_register(RF_CH, channel & 0x7f);
}


// ****************************************************************************
// Return true if the receiver FIFO is empty
// ****************************************************************************
bool rf_is_rx_fifo_emtpy(void)
{
    return (rf_get_status() & 0x0e) == 0x0e;
}


// ****************************************************************************
// Return true if the transmit FIFO is full
// ****************************************************************************
bool rf_is_tx_fifo_full(void)
{
    return rf_get_status() & 0x01;
}


// ****************************************************************************
// Read one packet from the receive FIFO
// ****************************************************************************
void rf_read_fifo(uint8_t *buffer, size_t byte_count)
{
    rf_read_command_buffer(R_RX_PAYLOAD, byte_count, buffer);
}


// ****************************************************************************
// Read RX payload width for the top R_RX_PAYLOAD in the RX FIFO
// ****************************************************************************
uint8_t rf_read_payload_width(void)
{
    uint8_t payload_width;

    rf_read_command_buffer(R_RX_PL_WID, 1, &payload_width);
    return payload_width;
}


// ****************************************************************************
void rf_flush_rx_fifo(void)
{
    rf_command(FLUSH_RX);
}


// ****************************************************************************
void rf_flush_tx_fifo(void)
{
    rf_command(FLUSH_TX);
}


// ****************************************************************************
// Enable or disable which events trigger the IRQ pin on the nRF24.
//
// irq_source:
//  RX_DR: A packet has been received
//  TX_DS: A packet was sent
//  MAX_RT: The maximum number of retries was exceeded
//
// Multiple values can be or'ed together.
// ****************************************************************************
void rf_set_irq_source(uint8_t irq_source)
{
    uint8_t config;

    // Datasheet page 56: The IRQ mask in the CONFIG register is used to select
    // the IRQ sources that are allowed to assert the IRQ pin. By setting one of
    // the MASK bits high, the corresponding IRQ source is disabled. By default
    // all IRQ sources are enabled.

    config = rf_read_register(CONFIG);
    config |= 0x70;
    config &= ~irq_source;      // Toggle bits as 1 = irq source disabled
    rf_write_register(CONFIG, config);
}


// ****************************************************************************
// Clear the given interrupt source
//
// irq_source:
//  RX_DR: Clear "packet received" interrupt flag
//  TX_DS: Clear "packet sent" interrupt flag
//  MAX_RT: Clear "maximum retries" interrupt flag
//
// Multiple values can be or'ed together.
// ****************************************************************************
void rf_clear_irq(uint8_t irq_source)
{
    rf_write_register(STATUS, irq_source & 0x70);
}


// ****************************************************************************
// Configure whether packets should be protected by a CRC.
//
// crc_size:
//  NO_CRC: No CRC protection
//  CRC_1_BYTE: 1 byte CRC
//  CRC_2_BYTES: 2 byte CRC
// ****************************************************************************
void rf_set_crc(uint8_t crc_size)
{
    uint8_t config;

    config = rf_read_register(CONFIG);
    config &= ~(EN_CRC | CRC0);
    if (crc_size == 1) {
        config |= EN_CRC;
    }
    else if (crc_size == 2) {
        config |= EN_CRC | CRC0;
    }
    rf_write_register(CONFIG, config);
}


// ****************************************************************************
// Configures which of the 6 data pipes are active, and whether the pipe
// uses "Auto Acknowledgment" or not.
//
// pipes:
//  DATA_PIPE_0..5, multiple values or'ed for all enabled pipes
//
// auto_acknowledge_pipes:
//  DATA_PIPE_0..5, multiple values or'ed for all pipes that shall use
//  Auto Acknowedgement
// ****************************************************************************
void rf_set_data_pipes(uint8_t pipes, uint8_t auto_acknowledge_pipes)
{
    rf_write_register(EN_RXADDR, pipes & 0x3f);
    rf_write_register(EN_AA,     auto_acknowledge_pipes & 0x3f);
}


// ****************************************************************************
// Sets the number of bytes an address is comprised of.
// Can be 3..5 bytes.
// Applies to both receiver and transmitter, and to all receive pipes.
// ****************************************************************************
void rf_set_address_width(uint8_t aw)
{
    if (aw < 3) {
        aw = 3;
    }

    if (aw > 5) {
        aw = 5;
    }

    rf_write_register(SETUP_AW, aw - 2);
}


// ****************************************************************************
// Returns the number of bytes an address is comprised of.
// ****************************************************************************
uint8_t rf_get_address_width(void)
{
    return rf_read_register(SETUP_AW) + 2;
}


// ****************************************************************************
// Set the RF data rate.
//
// data_rate:
//  DATA_RATE_250K:     250 Kbps
//  DATA_RATE_1M:       1 Mbps
//  DATA_RATE_2M:       2 Mbps
//
// Applies to both transmitter and receiver.
// ****************************************************************************
void rf_set_data_rate(uint8_t data_rate)
{
    uint8_t rf_setup;

    rf_setup = rf_read_register(RF_SETUP);

    // Clear everything except transmit power
    rf_setup &= 0x06;
    if (data_rate == DATA_RATE_250K) {
        rf_setup |= RF_DR_LOW;
    }
    else if (data_rate == DATA_RATE_1M) {
        // Nothing to do, both bits are already cleared
    }
    else { // 2Mbps (default)
        rf_setup |= RF_DR_HIGH;
    }

    rf_write_register(RF_SETUP, rf_setup);
}


// ****************************************************************************
// Configure the receive payload size for one or more pipes.
//
// pipes
//  DATA_PIPE_0..5, multiple values or'ed for all enabled pipes
//
// payload_size
//  The number of bytes to expect receiving on the given pipes.
// ****************************************************************************
void rf_set_payload_size(uint8_t pipes, uint8_t payload_size)
{
    int i;

    for (i = 0; i < 6; i++) {
        if ((pipes & (1 << i))) {
            rf_write_register(RX_PW_P0 + i, payload_size);
        }
    }
}


// ****************************************************************************
// Put the nRF24 in power down mode by clearing the PWR_UP bit in the CONFIG
// register.
// ****************************************************************************
void rf_power_down(void)
{
    uint8_t config;

    config = rf_read_register(CONFIG);
    config &= ~PWR_UP;                      // Clear PWR_UP
    rf_write_register(CONFIG, config);
}


// ****************************************************************************
// Power up the nRF24 and configure it in transmit mode
// ****************************************************************************
void rf_enable_transmitter(void)
{
    uint8_t config;
    bool powered;

    config = rf_read_register(CONFIG);
    powered = (config & PWR_UP);

    config |= PWR_UP;                       // Set PWR_UP
    config &= ~PRIM_RX;                     // Clear PRIM_RX
    rf_write_register(CONFIG, config);

    // Data sheet page 24: For nRF24L01+ to go from power down mode to TX or RX
    // mode it must first pass through stand-by mode. There must be a delay of
    // Tpd2stby (see Table 16.) after the nRF24L01+ leaves power down mode
    // before the CE is set high.
    // Worst case Tpd2stb is 4.5ms, it depends on the crystal inductance.
    if (!powered) {
        delay_us(4500);
    }
}


// ****************************************************************************
// Power up the nRF24 and configure it in receive mode
// ****************************************************************************
void rf_enable_receiver(void)
{
    uint8_t config;
    bool powered;

    config = rf_read_register(CONFIG);
    powered = (config & PWR_UP);

    config |= PWR_UP;                       // Set PWR_UP
    config |= PRIM_RX;                      // Set PRIM_RX
    rf_write_register(CONFIG, config);

    // Data sheet page 24: For nRF24L01+ to go from power down mode to TX or RX
    // mode it must first pass through stand-by mode. There must be a delay of
    // Tpd2stby (see Table 16.) after the nRF24L01+ leaves power down mode
    // before the CE is set high.
    // Worst case Tpd2stb is 4.5ms, it depends on the crystal inductance.
    if (!powered) {
        delay_us(4500);
    }
}


// ****************************************************************************
// Enable dynamic payload length for one or more pipes.
//
// pipes
//  DATA_PIPE_0..5, multiple values or'ed for all enabled pipes
// ****************************************************************************
void rf_set_dynpd(uint8_t pipes)
{
    rf_write_register(DYNPD, pipes);
}


// ****************************************************************************
// Enable features like dynamic ack, dynamic ack payload length, and dynamic
// payload length.
//
// feature_list
//  or'ed value comprising of EN_DPL, EN_ACK_PAY and EN_DYN_ACK as needed
// ****************************************************************************
void rf_set_feature(uint8_t feature_list)
{
    rf_write_register(FEATURE, feature_list);
}