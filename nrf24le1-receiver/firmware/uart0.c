#include <stdint.h>
#include <stdbool.h>

#include <platform.h>
#include <uart0.h>

#ifdef ENABLE_UART


#define NO_LEADING_ZEROS (0)


// #define RECEIVE_BUFFER_SIZE (16)        // Must be modulo 2 for speed
// #define RECEIVE_BUFFER_INDEX_MASK (RECEIVE_BUFFER_SIZE - 1)
// static __xdata uint8_t receive_buffer[RECEIVE_BUFFER_SIZE];
// static volatile uint16_t read_index = 0;
// static volatile uint16_t write_index = 0;

/*
INT32_MIN  is -2147483648 (decimal needs 12 characters, incl. terminating '\0')
INT32_MAX  is 2147483647
UINT32_MIN is 0
UINT32_MAX is 4294967295

Worst case (base 2) we would have to write 32 characters + '\0'. However,
since we only support base 2 for uint8_t we can make due with 12 bytes,
which is the maximum needed for decimal.
*/
#define TRANSMIT_BUFFER_SIZE (12)

static __xdata char temp[TRANSMIT_BUFFER_SIZE];
static __xdata char buf[TRANSMIT_BUFFER_SIZE];

static bool uart_enabled;

// ****************************************************************************
static void uint32_to_cstring(uint32_t value, char *result,
    uint8_t radix, int8_t number_of_leading_zeros)
{
    char *tp = temp;

    // Process the digits in reverse order, i.e. fill temp[] with the least
    // significant digit first. We stop as soon as the higher most remaining
    // digits are 0 (leading zero supression).
    do {
        uint8_t digit;

        digit = value % radix;
        *tp++ = (digit < 10) ? (digit + '0') : (digit + 'a' - 10);
        value /= radix;
        --number_of_leading_zeros;
    } while (value || number_of_leading_zeros > 0);

    // We write the digits to "result" in reverse order, i.e. most significant
    // digit first.
    while (tp > temp) {
        *result++ = *--tp;
    }
    *result = '\0';

}


// ****************************************************************************
static void int32_to_cstring(int32_t value, char *result, uint8_t radix)
{
    if (radix == 10  &&  value < 0) {
        *result++ = '-';
        value = -value;
    }

    uint32_to_cstring((uint32_t)value, result, radix, NO_LEADING_ZEROS);
}


// ****************************************************************************
void init_uart0(void)
{
    S0CON = 0x50;           // 8-bit UART, Serial port enabled, flags cleared
    PCON |= 0x80;           // set SMOD bit
    ADCON_bd = 1;           // Sed BD bit

    S0RELH = 0x03;
    S0RELL = 0xf3;

    S0CON_ti0 = 1;          // Set "Tx data was sent" flag
    uart_enabled = true;
}


// ****************************************************************************
void disable_uart0(void)
{
    uart_enabled = false;
    S0CON = 0x00;
}


// ****************************************************************************
bool uart0_send_is_ready(void)
{
    if (!uart_enabled) {
        return true;
    }

    if (!S0CON_ti0) {
        return false;
    }
    return true;
}


// ****************************************************************************
void uart0_send_char(const char c)
{
    if (!uart_enabled) {
        return;
    }

    while (!uart0_send_is_ready());

    S0CON_ti0 = 0;
    S0BUF = c;
}


// ****************************************************************************
void uart0_send_cstring(const char *cstring)
{
    while (*cstring) {
        uart0_send_char(*cstring);
        ++cstring;
    }
}

// ****************************************************************************
void uart0_send_int32(int32_t number)
{
    int32_to_cstring(number, buf, 10);
    uart0_send_cstring(buf);
}

// ****************************************************************************
void uart0_send_uint32(uint32_t number)
{
    uint32_to_cstring(number, buf, 10, NO_LEADING_ZEROS);
    uart0_send_cstring(buf);
}


// ****************************************************************************
void uart0_send_uint32_hex(uint32_t number)
{
    uint32_to_cstring(number, buf, 16, 8);
    uart0_send_cstring(buf);
}


// ****************************************************************************
void uart0_send_uint16_hex(uint16_t number)
{
    uint32_to_cstring(number, buf, 16, 4);
    uart0_send_cstring(buf);
}


// ****************************************************************************
void uart0_send_uint8_hex(uint8_t number)
{
    uint32_to_cstring(number, buf, 16, 2);
    uart0_send_cstring(buf);
}


// ****************************************************************************
void uart0_send_uint8_binary(uint8_t number)
{
    uint32_to_cstring(number, buf, 2, 8);
    uart0_send_cstring(buf);
}


// ****************************************************************************
void uart0_send_linefeed(void)
{
    uart0_send_char('\n');
}



// ****************************************************************************
// ****************************************************************************
// ****************************************************************************
// Read routines are not implemented

// // ****************************************************************************
// bool uart0_read_is_byte_pending(void)
// {
//     return 1;
// }


// // ****************************************************************************
// uint8_t uart0_read_byte(void)
// {
//     while (!uart0_read_is_byte_pending());

//     return 0;
// }

#endif  // ENABLE_UART
