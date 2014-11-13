;
; D52 configuration file for ../firmware-images/xr3100.hex
; Generated by D52 V3.4.1 on 2014/11/12 14:00
;

! 0003 Vector: Interrupt from pin GP INT0, GP INT1 or GP INT2
! 000b Vector: Timer 0 overflow
! 0013 Vector: Power Failure
! 001b Vector: Timer 1 overflow
! 0023 Vector: Serial channel
! 002b Vector: Timer 2 overflow or External reload
! 0043 Vector: RF SPI ready
! 004b Vector: RF Interrupt
;l 0053 Vector: SPI, I2C


c 0000-000d	; Code space

c 000e-0012  ; 8-bit dat

c 0013-001d	; Code space

c 001e-0022	; 8-bit data

c 0023-002a	; Code space

c 002b-002d	; pointers

c 002e-0047	; Code space

c 0048-004d

c 004e-06b9	; Code space

b 06ba-070e ; 8-bit data

c 070f-07ab	; Code space

b 07ac-0811	; 8-bit data

c 0812-081c	; Code space

b 081d-082a	; 8-bit data

c 082b-0830	; Code space

b 0831-0835	; 8-bit data

c 0836-087c	; Code space

b 087d-0884	; pointers

c 0885-0b3d	; Code space

b 0b3e-0b90	; 8-bit data

c 0b91-0c30	; Code space

b 0c31-0c81	; 8-bit data

c 0c81-0d08	; Code space

b 0d09-0d4b	; 8-bit data

c 0d4c-0dc5	; Code space

b 0dc6-0dfc	; 8-bit data

c 0dfd-0e33	; Code space

b 0e34-0e7e	; 8-bit data

c 0e7f-0e98	; Code space

b 0e99-0ec4	; 8-bit data

c 0ec5-0eef	; Code space

c 0ef0-101f	; 8-bit data

c 1020-1056	; Code space

b 1057-1070	; 8-bit data

c 1071-10cb	; Code space

b 10cc-10e1	; 8-bit data

c 10e2-111e	; Code space


c 111f-113c
! 111f 111f-113c UNUSED CODE

c 113d-1155	; Code space

c 1156-117f
! 1156 1156-117f UNUSED CODE

c 1180-11ac	; Code space

c 11ad-11c0
! 11ad 11ad-11c0 UNUSED CODE

c 11c1-11ca	; Code space

b 11cb-11d4	; 8-bit data

c 11d5-11de	; Code space

c 11df-11fc
! 11df 11df-11fc UNUSED CODE

c 11fd-1206	; Code space

c 1207-120d
! 1207 1207-120d UNUSED CODE

c 120e-1214	; Code space

c 1215-1222
! 1215 1215-1222 UNUSED CODE

c 1223-1229	; Code space

c 122a-1235
! 122a 122a-1235 UNUSED CODE

c 1236-1249	; Code space

i 124a-1ffe	; ignore data



x 01a9 softtmr  ; X0001
x 02e9 softtmr
x 0539 softtmr
x 0bc3 softtmr
x 0bd1 softtmr

x 02e3 softtmr+1 ; X0002
x 0bbd softtmr+1

x 05c7 servo_output_state ; X0003
x 05db servo_output_state
x 05f6 servo_output_state
x 0602 servo_output_state
x 0617 servo_output_state
x 0638 servo_output_state
x 0bb2 servo_output_state

x 02bb failsafe_flag    ; X0007
x 02fc failsafe_flag

;s 0007 stick_data      ; X0007

x 00ad stick_data+1     ; X0008
x 014d stick_data+1
x 015b stick_data+1
x 0165 stick_data+1
x 01bc stick_data+1

x 01d8 stick_data+2     ; X0009
x 01e5 stick_data+2
x 01f4 stick_data+2
x 0272 stick_data+2

x 01ee stick_data+3     ; X000a

x 0200 stick_data+4     ; X000b
x 020d stick_data+4
x 021c stick_data+4
x 0281 stick_data+4

x 0216 stick_data+5     ; X000c

x 0228 stick_data+6     ; X000d
x 0235 stick_data+6
x 0244 stick_data+6

x 023e stick_data+7     ; X000e

x 024d stick_data+8     ; X000f
x 025a stick_data+8
x 0269 stick_data+8
x 029f stick_data+8

x 0263 stick_data+9     ; X0010

x 031a fs_data      ; X0011
x 02db fs_data

x 02d3 fs_data+1    ; X0012

x 02cb fs_data+2    ; X0013
x 0304 fs_data+2

x 0a83 fs_data+3    ; X0014
x 0ba0 fs_data+3
x 00f0 fs_data+3

x 02c3 fs_data+4    ; X0015
x 030b fs_data+4

x 01e9 payload      ; X0016
x 02bf payload
x 03a3 payload
x 0405 payload
x 044e payload
x 0498 payload
x 01d3 payload+1
x 02c7 payload+1
x 0211 payload+2
x 02cf payload+2
x 01fb payload+3
x 02d7 payload+3
x 0239 payload+4
x 0223 payload+5
x 025e payload+6
x 01c7 payload+7
x 02b2 payload+7


x 0279 ch1      ; X0022
x 0313 ch1
x 0332 ch1
x 05ce ch1

x 0288 ch2      ; X0024
x 0328 ch2
x 05e9 ch2

x 0297 ch3      ; X0026
x 060a ch3

x 02a6 ch4      ; X0028
x 062b ch4

x 0153 hop_data     ; X002A Comes from the EEPROM bind data, 20 bytes
! 0caf offset in hop_data

x 0c8c bind_data    ; X003E Comes from the EEPROM bind data 5 (or 6) bytes
x 009e bind_data



r 0b rf_status
r 0d rf_detected
r 0e save_r7
r 0f save_r5

r 10 count_l
r 11 count_h

r 1b pipe_no

r 1c adr_flag
r 1d adr_h
r 1e adr_l

r 2d rf_data_avail




! 000e OBSERVE_TX ?!
! 001e FIFO_STATUS
! 0024 Masks out TX_FULL and TX_EMPTY

l 002e i2c_eeprom_read_one_byte



k 80 LED_GREEN  ; p0.0
k 81 LED_RED    ; p0.1

k 83 BIND_BUTTON    ; p0.3

k 93 SCL    ; p1.3
k 94 SDA    ; p1.4


l 004e init
# 004e ***************************************************************************
# 004e Initialization
# 004e ***************************************************************************

! 00c3 Enable the receiver

x 00a5 0ah

l 00eb main
# 00eb ***************************************************************************
# 00eb MAIN LOOP
# 00eb ***************************************************************************

! 00dc Bind switch checked at reset?!?
! 00e6 Set channel 70 in factory mode?

l 010f not_factory

l 0140 fifo_is_empty

! 017e T2 clock = f/12, Reload Mode 0
! 019c T2 clock = f/12, Reload Mode 0



l 01d2 stick_data
# 01d2 ***************************************************************************
# 01d2 This code below sets the servo pulse durations 0x55
# 01d2 ***************************************************************************

# 02b1 ***************************************************************************
# 02b1 This code below sets failsafe 0xaa
# 02b1 ***************************************************************************

l 02e1 check_if_connected

x 02e7 28h
l 02f7 output_failsafe

l 01c6 process_rf_data
l 02de rf_data_processed

l 0541 save_bind_data


l 05b3 servo_pulse_t1_handler
;s 0003 servo_out_state
# 05b3 ***************************************************************************
# 05b3 Timer 1 interrupt handler, generates the servo pulses
# 05b3
# 05b3 Outputs the servo pulses, 3 or 4(!) channels
# 05b3 RAM 0x03 contains a state machine. Timer 1 is used
# 05b3 for timing
# 05b3 Timing values are stored in RAM 0x22, 0x24, 0x26, 0x28
# 05b3 ***************************************************************************

l 0662 get_indirect_r1_r2
# 0662 ***************************************************************************
# 0662 get_indirect_r1_r2
# 0662 r3: flag; 0 = return @r1, 1 = return @r2:r1
# 0662 ***************************************************************************

l 06a8 set_indirect_r1_r2
# 06a8 ***************************************************************************
# 06a8 set_indirect_r1_r2
# 06a8 r3: flag; 0 = store at @r1, 1 = store at @r2:r1
# 06a8 ***************************************************************************

l 083e reset
# 083e ***************************************************************************
# 083e Program start
# 083e ***************************************************************************
l 0841 _clear_ram

l 0885 init_rodata
# 0885 ***************************************************************************
# 0885 Initalize RAM with default values stored in a ROM table
# 0885 ***************************************************************************
l 0b3e ram_initialization_data
l 084a init_ljmp
l 08af init_rodata_loop
l 084d init_rodata_page0

l 08ca timer2_handler
# 08ca ***************************************************************************
# 08ca Timer 2 interrupt handler
# 08ca
# 08ca Seems to perform frequency hopping?!
# 08ca ***************************************************************************

l 0941 spi_read_rf_fifo_data
# 0941 ***************************************************************************
# 0941 spi_read_rf_fifo_data
# 0941
# 0941 r2:r1: address to store the information
# 0941 r3: flag; 0 = store at @r1, 1 = store at @r2:r1
# 0941 r7:
# 0941 ***************************************************************************

l 095a spi_read_is_0_or_1_or_5
l 096a spi_read_is_8
l 0985 spi_read_is_not_null

! 097e READ_RX_PAYLOAD

l 09b3 rf_modify_config_bit
# 09b3 ***************************************************************************
# 09b3 rf_modify_config_bit
# 09b3
# 09b3 r7: bit number in the CONFIG reg.  r5: new bit value
# 09b3 ***************************************************************************
l 09e3 rf_cfg_r7_is_5
l 09fc rf_cfg_r7_is_6
l 09d3 rf_cfg_r7_is_7

! 09c2 Jump if r7 is 5
! 09c5 Jump if r7 is 6
! 09c9 Jump if r7 is NOT 8 (jump if 7?)
l 0a14 rf_modify_execute

l 0ae4 init_rf_data_pipes

! 0b2d Disable ‘Auto Acknowledgment’
! 0b28 Enable ‘Auto Acknowledgment’ on all pipes
! 0b32 EN_RXADDR
! 0b39 EN_AA


l 0b91 timer0_handler
# 0b91 ***************************************************************************
# 0b91 Timer 0 interrupt handler
# 0b91
# 0b91 Sets the servo output timer 0
# 0b91 ***************************************************************************

l 0c81 read_bind_data


l 0cc6 rf_set_crc
# 0cc6 ***************************************************************************
# 0cc6 rf_set_crc
# 0cc6 In: R7: Number of bytes of CRC to use, 0 to turn it off
# 0cc6 ***************************************************************************

! 0cc8 CONFIG
! 0cde clear EN_CRC (CRC off)
l 0ce4 set_crc_1byte
! 0ce7 set EN_CRC
! 0cee clear CRCO (1 bytes CRC)
l 0cf4 set_crc_2bytes
! 0cf7 set EN_CRC
! 0cfe set CRCO (2 bytes CRC)
l 0d02 set_crc_write_config
! 0d04 CONFIG

l 0d4c rc_configure_receiver
l 0d76 rf_set_receive_address_for_pipe
l 0d89 init_rf_set_data_rate

l 070f ic2_write_address
l 0ec5 i2c_start
l 1039 i2c_stop
l 0a1e i2c_read_byte
l 0717 i2c_write_byte
l 10e2 i2c_read_byte_from_eeprom
l 0be1 i2c_has_write_finished
l 10b6 i2c_write_byte_to_eeprom

l 0fb5 rf_set_rx
l 0fd8 rf_set_power_up

l 0ffb write_bind_data_byte

l 1071 delay
# 1071 ***************************************************************************
# 1071 delay
# 1071
# 1071 Delay value in R6/R7
# 1071 ***************************************************************************
l 107c delay_loop

l 1088 init_ports
# 1088 ***************************************************************************
# 1088 init_ports
# 1088 ***************************************************************************

l 10f7 init_rf_setup_address_width

l 1185 init_timer0
l 1242 init_timer1

l 118f spi_write
l 1191 _spi_write_loop
# 118f ***************************************************************************
# 118f SPI Write
# 118f ***************************************************************************

l 113d spi_read_register
# 113d ***************************************************************************
# 113d SPI Read Byte
# 113d In: A: command    Out: R7: read value
# 113d ***************************************************************************

l 114a spi_read_rf_status
# 114a ***************************************************************************
# 114a spi_read_rf_status
# 114a Reads and clears the RF status register. Output in R7
# 114a ***************************************************************************

l 1199 spi_get_number_of_address_bytes
x 119a 03h
! 1199 SETUP_AW
# 1199 ***************************************************************************
# 1199 SPI spi_get_number_of_address_bytes Byte
# 1199 Out: R7: Number of address bytes in the receiver
# 1199 ***************************************************************************

l 109f spi_write_register
# 109f ***************************************************************************
# 109f SPI Write to a RF register
# 109f In: R7: register number, R5: value
# 109f ***************************************************************************

l 110c spi_set_rf_channel
# 110c ***************************************************************************
# 110c spi_set_rf_channel
# 110c In: R7: channel number
# 110c ***************************************************************************
! 111a RF_CH

l 11a3 spi_is_rx_fifo_empty
# 11a3 ***************************************************************************
# 11a3 spi_is_rx_fifo_empty
# 11a3
# 11a3 R7 is 1 if the RF RX FIFO is empty, 0 if it has data pending
# 11a3 ***************************************************************************

l 11c1 is_rf_power_detected
# 11c1 ***************************************************************************
# 11c1 is_rf_power_detected
# 11c1
# 11c1 Returns the Received Power Detector (Carrier Detect) flag
# 11c1 ***************************************************************************

l 11d5 rf_read_rx_status
l 11fd spi_send_nop_command

l 120e rf_set_payload_bytes
# 120e ***************************************************************************
# 120e rf_set_payload_bytes
# 120e
# 120e r7: data pipe number  r5: Number of payload bytes
# 120e ***************************************************************************

l 1230 rf_read_fifo_status

! 1236 R_RX_PL_WID
l 1236 spi_read_rx_fifo_payload_width
# 1236 ***************************************************************************
# 1236 spi_read_rx_fifo_payload_width
# 1236
# 1236 Returns the number of bytes of the top payload in the RX FIFO
# 1236 ***************************************************************************


l 123c spi_read_rf_fifo
# 123c ***************************************************************************
# 123c spi_read_rf_fifo
# 123c
# 123c Read data from the RF FIFO?
# 123c  r3,#1,  r2,#0  r1,#16h
# 123c r2:r1: address to store the information
# 123c r3: flag; 0 = store at @r1, 1 = store at @r2:r1
# 123c  sets r7,#8 then calls X0941
# 123c ***************************************************************************

l 1246 rf_handler
# 1246 ****************************************************
# 1246 RF interrupt handler
# 1246 ****************************************************

f 88 TCON
k 88 TCON_it0
k 89 TCON_ie0
k 8a TCON_it1
k 8b TCON_ie1
k 8c TCON_tr0
k 8d TCON_tf0
k 8e TCON_tr1
k 8f TCON_tf1

f 93 P0DIR
f 94 P1DIR

f 98 S0CON
k 98 S0CON_ri0
k 99 S0CON_ti0
k 9a S0CON_rb80
k 9b S0CON_tb80
k 9c S0CON_ren0
k 9d S0CON_sm20
k 9e S0CON_sm0
k 9f S0CON_sm1

f 99 S0BUF
f 9e P0CON
f 9f P1CON

f a1 PWMDC0
f a2 PWMDC1
f a3 CLKCTRL
f a4 PWRDWN
f a5 WUCON
f a7 MEMCON

f a8 IEN0
k a8 IEN0_ifp
k a9 IEN0_tf0
k aa IEN0_pwrfail
k ab IEN0_tf1
k ac IEN0_serial
k ad IEN0_tf2
k ae IEN0.6
k af IEN0_all

f a9 IP0
f aa S0RELL
f ab RTC2CPT01
f ac RTC2CPT10
f ad CLKLFCTRL
f ae OPMCON
f af WDSW

f b1 RSTREAS
f b2 PWMCON
f b3 RTC2CON
f b4 RTC2CMP0
f b5 RTC2CMP1
f b6 RTC2CPT00

f b8 IEN1
k b8 IEN1_rfready
k b9 IEN1_rfirq
k ba IEN1_spi_iic
k bb IEN1_wakeup
k bc IEN1_misc
k bd IEN1_tick
k be IEN1.6
k bf IEN1_exf2

f b9 IP1
f ba S0RELH
f bc SPISCON0
f be SPISSTAT
f bf SPISDAT

f c0 IRCON
k c0 IRCON_rfready
k c1 IRCON_rfiry
k c2 IRCON_spi_iic
k c3 IRCON_wakeup
k c4 IRCON_misc
k c5 IRCON_tick
k c6 IRCON_tf2
k c7 IRCON_exf2

f c1 CCEN
f c2 CCL1
f c3 CCH1
f c4 CCL2
f c5 CCH2
f c6 CCL3
f c7 CCH3

f c8 T2CON
k c8 T2CON_t2i0
k c9 T2CON_t2i1
k ca T2CON_t2cm
k cb T2CON_t2r0
k cc T2CON_t2r1
k cd T2CON_i2fr
k ce T2CON_i3fr
k cf T2CON_t2ps

f c9 MPAGE
f ca CRCL
f cb CRCH
    f ce WUOPC1
f cf WUOPC0

f d0 PSW
k d1 PSW_f1

f d1 ADCCON3
f d2 ADCCON2
f d3 ADCCON1
f d4 ADCDATH
f d5 ADCDATL
f d6 RNGCTL
f d7 RNGDAT

f d8 ADCON
k df ADCON_bd

f d9 W2SADR
f da W2DAT
f db COMPCON
f dd CCPDATIA
f de CCPDATIB
f df CCPDATO

f e1 W2CON1
f e2 W2CON0
f e4 SPIRCON0
f e5 SPIRCON1
f e6 SPIRSTAT
f e7 SPIRDAT

f e8 RFCON
k e8 RFCON_rfce
k e9 RFCON_rfcsn
k ea RFCON_rfcken

f e9 MD0
f ea MD1
f eb MD2
f ec MD3
f ed MD4
f ee MD5
f ef ARCON

f f8 FSR

f f9 FPCR
f fa FCR
f fc SPIMCON0
f fd SPIMCON1
f fe SPIMSTAT
f ff SPIMDAT






