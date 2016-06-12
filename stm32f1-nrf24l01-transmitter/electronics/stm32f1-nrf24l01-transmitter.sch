EESchema Schematic File Version 2
LIBS:power
LIBS:device
LIBS:conn
LIBS:regul
LIBS:special
LIBS:opto
LIBS:contrib
LIBS:analog_switches
LIBS:display
LIBS:graphic
LIBS:interface
LIBS:logo
LIBS:references
LIBS:rfcom
LIBS:stm32f1-nrf24l01-transmitter-cache
EELAYER 27 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title "STM32F1 NRF24L01 RC transmitter"
Date "12 jun 2016"
Rev "1"
Comp "LANE Boys RC"
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L NRF24L01P U3
U 1 1 57202BD1
P 9850 1850
F 0 "U3" H 9500 2300 60  0000 L CNN
F 1 "NRF24L01P" H 10150 1350 60  0000 C CNN
F 2 "~" H 9850 1850 60  0000 C CNN
F 3 "~" H 9850 1850 60  0000 C CNN
	1    9850 1850
	1    0    0    -1  
$EndComp
$Comp
L LIPO_CHARGER_+_PROTECTION U1
U 1 1 57202BEA
P 3000 6650
F 0 "U1" H 2000 7200 60  0000 L CNN
F 1 "LIPO_CHARGER_+_PROTECTION" H 3000 6650 60  0000 C CNN
F 2 "~" H 3000 6650 60  0000 C CNN
F 3 "~" H 3000 6650 60  0000 C CNN
	1    3000 6650
	1    0    0    -1  
$EndComp
$Comp
L BATTERY BT1
U 1 1 57202BF9
P 1300 6650
F 0 "BT1" H 1300 6850 50  0000 C CNN
F 1 "BATTERY" H 1300 6460 50  0000 C CNN
F 2 "~" H 1300 6650 60  0000 C CNN
F 3 "~" H 1300 6650 60  0000 C CNN
	1    1300 6650
	0    1    1    0   
$EndComp
$Comp
L GND #PWR01
U 1 1 57202C42
P 6450 7300
F 0 "#PWR01" H 6450 7300 30  0001 C CNN
F 1 "GND" H 6450 7230 30  0001 C CNN
F 2 "" H 6450 7300 60  0000 C CNN
F 3 "" H 6450 7300 60  0000 C CNN
	1    6450 7300
	1    0    0    -1  
$EndComp
$Comp
L VDD #PWR02
U 1 1 57202CE6
P 6450 6400
F 0 "#PWR02" H 6450 6500 30  0001 C CNN
F 1 "VDD" H 6450 6510 30  0000 C CNN
F 2 "" H 6450 6400 60  0000 C CNN
F 3 "" H 6450 6400 60  0000 C CNN
	1    6450 6400
	1    0    0    -1  
$EndComp
$Comp
L VDD #PWR03
U 1 1 57202CFF
P 5400 1150
F 0 "#PWR03" H 5400 1250 30  0001 C CNN
F 1 "VDD" H 5400 1260 30  0000 C CNN
F 2 "" H 5400 1150 60  0000 C CNN
F 3 "" H 5400 1150 60  0000 C CNN
	1    5400 1150
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR04
U 1 1 57202D18
P 6400 1150
F 0 "#PWR04" H 6400 1250 30  0001 C CNN
F 1 "VCC" H 6400 1250 30  0000 C CNN
F 2 "" H 6400 1150 60  0000 C CNN
F 3 "" H 6400 1150 60  0000 C CNN
	1    6400 1150
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR05
U 1 1 57202D59
P 5650 5050
F 0 "#PWR05" H 5650 5050 30  0001 C CNN
F 1 "GND" H 5650 4980 30  0001 C CNN
F 2 "" H 5650 5050 60  0000 C CNN
F 3 "" H 5650 5050 60  0000 C CNN
	1    5650 5050
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR06
U 1 1 57202D68
P 5850 5050
F 0 "#PWR06" H 5850 5050 30  0001 C CNN
F 1 "GND" H 5850 4980 30  0001 C CNN
F 2 "" H 5850 5050 60  0000 C CNN
F 3 "" H 5850 5050 60  0000 C CNN
	1    5850 5050
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR07
U 1 1 57202D77
P 6050 5050
F 0 "#PWR07" H 6050 5050 30  0001 C CNN
F 1 "GND" H 6050 4980 30  0001 C CNN
F 2 "" H 6050 5050 60  0000 C CNN
F 3 "" H 6050 5050 60  0000 C CNN
	1    6050 5050
	1    0    0    -1  
$EndComp
$Comp
L C C1
U 1 1 57202EE1
P 10550 1350
F 0 "C1" H 10550 1450 40  0000 L CNN
F 1 "1u" H 10556 1265 40  0000 L CNN
F 2 "~" H 10588 1200 30  0000 C CNN
F 3 "~" H 10550 1350 60  0000 C CNN
	1    10550 1350
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR08
U 1 1 57202EF0
P 10550 1650
F 0 "#PWR08" H 10550 1650 30  0001 C CNN
F 1 "GND" H 10550 1580 30  0001 C CNN
F 2 "" H 10550 1650 60  0000 C CNN
F 3 "" H 10550 1650 60  0000 C CNN
	1    10550 1650
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR09
U 1 1 57202F26
P 9850 950
F 0 "#PWR09" H 9850 1050 30  0001 C CNN
F 1 "VCC" H 9850 1050 30  0000 C CNN
F 2 "" H 9850 950 60  0000 C CNN
F 3 "" H 9850 950 60  0000 C CNN
	1    9850 950 
	1    0    0    -1  
$EndComp
Text Label 7550 3450 2    60   ~ 0
CSN
Text Label 7550 3600 2    60   ~ 0
SCK
Text Label 7550 3750 2    60   ~ 0
MISO
Text Label 7550 3900 2    60   ~ 0
MOSI
Text Label 8700 1700 0    60   ~ 0
IRQ
Text Label 8700 1800 0    60   ~ 0
MISO
Text Label 8700 1900 0    60   ~ 0
MOSI
Text Label 8700 2000 0    60   ~ 0
SCK
Text Label 8700 2100 0    60   ~ 0
CSN
$Comp
L R R1
U 1 1 572032A2
P 7600 6300
F 0 "R1" V 7680 6300 40  0000 C CNN
F 1 "1k" V 7607 6301 40  0000 C CNN
F 2 "~" V 7530 6300 30  0000 C CNN
F 3 "~" H 7600 6300 30  0000 C CNN
	1    7600 6300
	1    0    0    -1  
$EndComp
$Comp
L CONN_2 P2
U 1 1 572032B1
P 7250 5800
F 0 "P2" V 7200 5800 40  0000 C CNN
F 1 "LED" V 7300 5800 40  0000 C CNN
F 2 "" H 7250 5800 60  0000 C CNN
F 3 "" H 7250 5800 60  0000 C CNN
	1    7250 5800
	-1   0    0    1   
$EndComp
$Comp
L VCC #PWR010
U 1 1 572032C0
P 7600 5550
F 0 "#PWR010" H 7600 5650 30  0001 C CNN
F 1 "VCC" H 7600 5650 30  0000 C CNN
F 2 "" H 7600 5550 60  0000 C CNN
F 3 "" H 7600 5550 60  0000 C CNN
	1    7600 5550
	1    0    0    -1  
$EndComp
NoConn ~ 4550 4200
NoConn ~ 4550 4350
NoConn ~ 7100 4350
Text Label 8000 6550 2    60   ~ 0
LED
Text Label 4050 4050 0    60   ~ 0
LED
$Comp
L R R2
U 1 1 57203444
P 8800 5900
F 0 "R2" V 8880 5900 40  0000 C CNN
F 1 "R" V 8807 5901 40  0000 C CNN
F 2 "~" V 8730 5900 30  0000 C CNN
F 3 "~" H 8800 5900 30  0000 C CNN
	1    8800 5900
	1    0    0    -1  
$EndComp
$Comp
L R R3
U 1 1 57203451
P 8800 6500
F 0 "R3" V 8880 6500 40  0000 C CNN
F 1 "R" V 8807 6501 40  0000 C CNN
F 2 "~" V 8730 6500 30  0000 C CNN
F 3 "~" H 8800 6500 30  0000 C CNN
	1    8800 6500
	1    0    0    -1  
$EndComp
$Comp
L VDD #PWR011
U 1 1 57203459
P 8800 5550
F 0 "#PWR011" H 8800 5650 30  0001 C CNN
F 1 "VDD" H 8800 5660 30  0000 C CNN
F 2 "" H 8800 5550 60  0000 C CNN
F 3 "" H 8800 5550 60  0000 C CNN
	1    8800 5550
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR012
U 1 1 572034AB
P 8800 6850
F 0 "#PWR012" H 8800 6850 30  0001 C CNN
F 1 "GND" H 8800 6780 30  0001 C CNN
F 2 "" H 8800 6850 60  0000 C CNN
F 3 "" H 8800 6850 60  0000 C CNN
	1    8800 6850
	1    0    0    -1  
$EndComp
Text Label 9350 6200 2    60   ~ 0
ADC0
Text Notes 8800 5200 0    60   ~ 0
Battery level\nsensing
Text Label 4050 1800 0    60   ~ 0
ADC0
Text Label 4050 1950 0    60   ~ 0
ADC1
Text Label 4050 2100 0    60   ~ 0
ADC2
Text Label 4050 2250 0    60   ~ 0
ADC3
Text Label 4050 2400 0    60   ~ 0
ADC4
Text Label 4050 2550 0    60   ~ 0
ADC5
Text Label 4050 2700 0    60   ~ 0
ADC6
Text Label 4050 2850 0    60   ~ 0
ADC7
Text Label 7550 1800 2    60   ~ 0
ADC8
Text Label 7550 1950 2    60   ~ 0
ADC9
Text Label 4050 3000 0    60   ~ 0
IRQ
$Comp
L CONN_3 K1
U 1 1 57203BE7
P 1300 1250
F 0 "K1" V 1250 1250 50  0000 C CNN
F 1 "CONN_3" V 1350 1250 40  0000 C CNN
F 2 "" H 1300 1250 60  0000 C CNN
F 3 "" H 1300 1250 60  0000 C CNN
	1    1300 1250
	-1   0    0    1   
$EndComp
$Comp
L CONN_3 K2
U 1 1 57203BF4
P 1300 1650
F 0 "K2" V 1250 1650 50  0000 C CNN
F 1 "CONN_3" V 1350 1650 40  0000 C CNN
F 2 "" H 1300 1650 60  0000 C CNN
F 3 "" H 1300 1650 60  0000 C CNN
	1    1300 1650
	-1   0    0    1   
$EndComp
$Comp
L CONN_3 K3
U 1 1 57203C22
P 1300 2050
F 0 "K3" V 1250 2050 50  0000 C CNN
F 1 "CONN_3" V 1350 2050 40  0000 C CNN
F 2 "" H 1300 2050 60  0000 C CNN
F 3 "" H 1300 2050 60  0000 C CNN
	1    1300 2050
	-1   0    0    1   
$EndComp
$Comp
L CONN_3 K4
U 1 1 57203C28
P 1300 2450
F 0 "K4" V 1250 2450 50  0000 C CNN
F 1 "CONN_3" V 1350 2450 40  0000 C CNN
F 2 "" H 1300 2450 60  0000 C CNN
F 3 "" H 1300 2450 60  0000 C CNN
	1    1300 2450
	-1   0    0    1   
$EndComp
$Comp
L CONN_3 K5
U 1 1 57203C2E
P 1300 2850
F 0 "K5" V 1250 2850 50  0000 C CNN
F 1 "CONN_3" V 1350 2850 40  0000 C CNN
F 2 "" H 1300 2850 60  0000 C CNN
F 3 "" H 1300 2850 60  0000 C CNN
	1    1300 2850
	-1   0    0    1   
$EndComp
$Comp
L CONN_3 K6
U 1 1 57203C34
P 1300 3250
F 0 "K6" V 1250 3250 50  0000 C CNN
F 1 "CONN_3" V 1350 3250 40  0000 C CNN
F 2 "" H 1300 3250 60  0000 C CNN
F 3 "" H 1300 3250 60  0000 C CNN
	1    1300 3250
	-1   0    0    1   
$EndComp
$Comp
L CONN_3 K7
U 1 1 57203C3A
P 1300 3650
F 0 "K7" V 1250 3650 50  0000 C CNN
F 1 "CONN_3" V 1350 3650 40  0000 C CNN
F 2 "" H 1300 3650 60  0000 C CNN
F 3 "" H 1300 3650 60  0000 C CNN
	1    1300 3650
	-1   0    0    1   
$EndComp
$Comp
L CONN_3 K8
U 1 1 57203C40
P 1300 4050
F 0 "K8" V 1250 4050 50  0000 C CNN
F 1 "CONN_3" V 1350 4050 40  0000 C CNN
F 2 "" H 1300 4050 60  0000 C CNN
F 3 "" H 1300 4050 60  0000 C CNN
	1    1300 4050
	-1   0    0    1   
$EndComp
$Comp
L CONN_3 K9
U 1 1 57203C46
P 1300 4450
F 0 "K9" V 1250 4450 50  0000 C CNN
F 1 "CONN_3" V 1350 4450 40  0000 C CNN
F 2 "" H 1300 4450 60  0000 C CNN
F 3 "" H 1300 4450 60  0000 C CNN
	1    1300 4450
	-1   0    0    1   
$EndComp
$Comp
L VCC #PWR013
U 1 1 57203C4E
P 1850 1000
F 0 "#PWR013" H 1850 1100 30  0001 C CNN
F 1 "VCC" H 1850 1100 30  0000 C CNN
F 2 "" H 1850 1000 60  0000 C CNN
F 3 "" H 1850 1000 60  0000 C CNN
	1    1850 1000
	1    0    0    -1  
$EndComp
Wire Wire Line
	4300 6350 4450 6350
Wire Wire Line
	5650 4900 5650 5050
Wire Wire Line
	5850 4900 5850 5050
Wire Wire Line
	6050 4900 6050 5050
Wire Wire Line
	5400 1150 5400 1250
Wire Wire Line
	10550 1550 10550 1650
Wire Wire Line
	9850 950  9850 1150
Wire Wire Line
	10550 1050 10550 1150
Connection ~ 9850 1050
Wire Wire Line
	7100 3450 7550 3450
Wire Wire Line
	7100 3600 7550 3600
Wire Wire Line
	7100 3750 7550 3750
Wire Wire Line
	7100 3900 7550 3900
Wire Wire Line
	8550 1600 9200 1600
Wire Wire Line
	9200 2100 8700 2100
Wire Wire Line
	9200 2000 8700 2000
Wire Wire Line
	9200 1900 8700 1900
Wire Wire Line
	9200 1800 8700 1800
Wire Wire Line
	9200 1700 8700 1700
Wire Wire Line
	7600 5550 7600 5700
Wire Wire Line
	7600 5900 7600 6050
Wire Wire Line
	7600 6550 8000 6550
Wire Wire Line
	4550 4050 4050 4050
Wire Wire Line
	8800 5550 8800 5650
Wire Wire Line
	8800 6150 8800 6250
Wire Wire Line
	8800 6750 8800 6850
Wire Wire Line
	8800 6200 9350 6200
Connection ~ 8800 6200
Wire Wire Line
	4550 1800 4050 1800
Wire Wire Line
	4050 1950 4550 1950
Wire Wire Line
	4550 2100 4050 2100
Wire Wire Line
	4050 2250 4550 2250
Wire Wire Line
	4050 2400 4550 2400
Wire Wire Line
	4050 2550 4550 2550
Wire Wire Line
	4050 2700 4550 2700
Wire Wire Line
	4050 2850 4550 2850
Wire Wire Line
	7550 1800 7100 1800
Wire Wire Line
	7550 1950 7100 1950
Wire Wire Line
	4050 3000 4550 3000
$Comp
L CONN_3 K10
U 1 1 57203E9D
P 1300 4850
F 0 "K10" V 1250 4850 50  0000 C CNN
F 1 "CONN_3" V 1350 4850 40  0000 C CNN
F 2 "" H 1300 4850 60  0000 C CNN
F 3 "" H 1300 4850 60  0000 C CNN
	1    1300 4850
	-1   0    0    1   
$EndComp
$Comp
L CONN_3 K11
U 1 1 57203EA3
P 1300 5250
F 0 "K11" V 1250 5250 50  0000 C CNN
F 1 "CONN_3" V 1350 5250 40  0000 C CNN
F 2 "" H 1300 5250 60  0000 C CNN
F 3 "" H 1300 5250 60  0000 C CNN
	1    1300 5250
	-1   0    0    1   
$EndComp
$Comp
L GND #PWR014
U 1 1 57203F33
P 1950 5500
F 0 "#PWR014" H 1950 5500 30  0001 C CNN
F 1 "GND" H 1950 5430 30  0001 C CNN
F 2 "" H 1950 5500 60  0000 C CNN
F 3 "" H 1950 5500 60  0000 C CNN
	1    1950 5500
	1    0    0    -1  
$EndComp
Wire Wire Line
	1950 5350 1650 5350
Wire Wire Line
	1950 1350 1950 5500
Wire Wire Line
	1650 4950 1950 4950
Connection ~ 1950 5350
Wire Wire Line
	1650 4550 1950 4550
Connection ~ 1950 4950
Wire Wire Line
	1650 4150 1950 4150
Connection ~ 1950 4550
Wire Wire Line
	1650 3350 1950 3350
Connection ~ 1950 4150
Wire Wire Line
	1650 3750 1950 3750
Connection ~ 1950 3750
Wire Wire Line
	1650 1750 1950 1750
Connection ~ 1950 3350
Wire Wire Line
	1650 2950 1950 2950
Connection ~ 1950 2950
Wire Wire Line
	1650 2550 1950 2550
Connection ~ 1950 2550
Wire Wire Line
	1650 2150 1950 2150
Connection ~ 1950 2150
Wire Wire Line
	1650 1350 1950 1350
Connection ~ 1950 1750
Text Label 2450 1150 2    60   ~ 0
ADC1
Text Label 2450 1550 2    60   ~ 0
ADC2
Text Label 2450 1950 2    60   ~ 0
ADC3
Text Label 2450 2350 2    60   ~ 0
ADC4
Text Label 2450 2750 2    60   ~ 0
ADC5
Text Label 2450 3150 2    60   ~ 0
ADC6
Text Label 2450 3550 2    60   ~ 0
ADC7
Text Label 2450 3950 2    60   ~ 0
ADC8
Text Label 2450 4350 2    60   ~ 0
ADC9
Text Label 2450 4750 2    60   ~ 0
SW1
Text Label 2450 5150 2    60   ~ 0
SW2
Wire Wire Line
	7550 3300 7100 3300
Wire Wire Line
	7550 3150 7100 3150
Text Label 7550 3150 2    60   ~ 0
SW2
Text Label 7550 3300 2    60   ~ 0
SW1
$Comp
L GND #PWR015
U 1 1 57204AD8
P 10100 6550
F 0 "#PWR015" H 10100 6550 30  0001 C CNN
F 1 "GND" H 10100 6480 30  0001 C CNN
F 2 "" H 10100 6550 60  0000 C CNN
F 3 "" H 10100 6550 60  0000 C CNN
	1    10100 6550
	1    0    0    -1  
$EndComp
Wire Wire Line
	10200 6150 9750 6150
Wire Wire Line
	9750 6050 10200 6050
Text Label 9750 6050 0    60   ~ 0
RX
Text Label 9750 6150 0    60   ~ 0
TX
Text Notes 9850 5200 0    60   ~ 0
Bluetooth SPP module\nDiagnostics UART
Wire Wire Line
	4050 3150 4550 3150
Wire Wire Line
	4050 3300 4550 3300
Text Label 4050 3150 0    60   ~ 0
TX
Text Label 4050 3300 0    60   ~ 0
RX
Text Notes 7200 5200 0    60   ~ 0
Front panel LED
$Comp
L SPEAKER SP1
U 1 1 5720518F
P 10200 3650
F 0 "SP1" H 10100 3900 70  0000 C CNN
F 1 "SPEAKER" H 10100 3400 70  0001 C CNN
F 2 "~" H 10200 3650 60  0000 C CNN
F 3 "~" H 10200 3650 60  0000 C CNN
	1    10200 3650
	1    0    0    -1  
$EndComp
$Comp
L NPN Q1
U 1 1 5720519E
P 9800 4100
F 0 "Q1" H 9800 3950 50  0000 R CNN
F 1 "BC548" H 9800 4250 50  0000 R CNN
F 2 "~" H 9800 4100 60  0000 C CNN
F 3 "~" H 9800 4100 60  0000 C CNN
	1    9800 4100
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR016
U 1 1 572051AD
P 9900 4450
F 0 "#PWR016" H 9900 4450 30  0001 C CNN
F 1 "GND" H 9900 4380 30  0001 C CNN
F 2 "" H 9900 4450 60  0000 C CNN
F 3 "" H 9900 4450 60  0000 C CNN
	1    9900 4450
	1    0    0    -1  
$EndComp
Wire Wire Line
	9900 4300 9900 4450
Wire Wire Line
	9900 3750 9900 3750
Wire Wire Line
	9900 3750 9900 3900
$Comp
L R R4
U 1 1 572052B4
P 9350 3850
F 0 "R4" V 9430 3850 40  0000 C CNN
F 1 "1k" V 9357 3851 40  0000 C CNN
F 2 "~" V 9280 3850 30  0000 C CNN
F 3 "~" H 9350 3850 30  0000 C CNN
	1    9350 3850
	1    0    0    -1  
$EndComp
Wire Wire Line
	9350 4100 9600 4100
Wire Wire Line
	9350 3600 9350 3350
Wire Wire Line
	9350 3350 8850 3350
Text Label 8850 3350 0    60   ~ 0
BUZZER
$Comp
L VDD #PWR017
U 1 1 572053AF
P 9900 3300
F 0 "#PWR017" H 9900 3400 30  0001 C CNN
F 1 "VDD" H 9900 3410 30  0000 C CNN
F 2 "" H 9900 3300 60  0000 C CNN
F 3 "" H 9900 3300 60  0000 C CNN
	1    9900 3300
	1    0    0    -1  
$EndComp
Wire Wire Line
	9900 3550 9900 3300
Wire Wire Line
	4050 3750 4550 3750
Text Label 4050 3750 0    60   ~ 0
BUZZER
$Comp
L CONN_2 P1
U 1 1 57205598
P 1300 5900
F 0 "P1" V 1250 5900 40  0000 C CNN
F 1 "Charge" V 1350 5900 40  0000 C CNN
F 2 "" H 1300 5900 60  0000 C CNN
F 3 "" H 1300 5900 60  0000 C CNN
	1    1300 5900
	-1   0    0    1   
$EndComp
Wire Wire Line
	1650 5800 3000 5800
Wire Wire Line
	3000 5750 3000 5850
Wire Wire Line
	1650 6000 1650 7450
Wire Wire Line
	1650 7450 3000 7450
Text Notes 9300 3050 0    60   ~ 0
Alarm buzzer
$Comp
L SPST SW1
U 1 1 572058EC
P 4950 5850
F 0 "SW1" H 4950 5950 70  0000 C CNN
F 1 "ON/OFF" H 4950 5750 70  0000 C CNN
F 2 "~" H 4950 5850 60  0000 C CNN
F 3 "~" H 4950 5850 60  0000 C CNN
	1    4950 5850
	1    0    0    -1  
$EndComp
$Comp
L PWR_FLAG #FLG018
U 1 1 572059A3
P 6750 6450
F 0 "#FLG018" H 6750 6545 30  0001 C CNN
F 1 "PWR_FLAG" H 6750 6630 30  0000 C CNN
F 2 "" H 6750 6450 60  0000 C CNN
F 3 "" H 6750 6450 60  0000 C CNN
	1    6750 6450
	1    0    0    -1  
$EndComp
NoConn ~ 4550 3450
NoConn ~ 4550 3600
$Comp
L PWR_FLAG #FLG019
U 1 1 572067E0
P 3000 5750
F 0 "#FLG019" H 3000 5845 30  0001 C CNN
F 1 "PWR_FLAG" H 3000 5930 30  0000 C CNN
F 2 "" H 3000 5750 60  0000 C CNN
F 3 "" H 3000 5750 60  0000 C CNN
	1    3000 5750
	1    0    0    -1  
$EndComp
$Comp
L PWR_FLAG #FLG020
U 1 1 572067EF
P 1300 6300
F 0 "#FLG020" H 1300 6395 30  0001 C CNN
F 1 "PWR_FLAG" H 1300 6480 30  0000 C CNN
F 2 "" H 1300 6300 60  0000 C CNN
F 3 "" H 1300 6300 60  0000 C CNN
	1    1300 6300
	1    0    0    -1  
$EndComp
Wire Wire Line
	1300 6950 1700 6950
Wire Wire Line
	1300 6350 1700 6350
Connection ~ 3000 5800
Wire Wire Line
	1300 6300 1300 6350
$Comp
L PWR_FLAG #FLG021
U 1 1 57206A07
P 2550 5750
F 0 "#FLG021" H 2550 5845 30  0001 C CNN
F 1 "PWR_FLAG" H 2550 5930 30  0000 C CNN
F 2 "" H 2550 5750 60  0000 C CNN
F 3 "" H 2550 5750 60  0000 C CNN
	1    2550 5750
	1    0    0    -1  
$EndComp
Wire Wire Line
	2550 5750 2550 6000
Wire Wire Line
	2550 6000 1650 6000
$Comp
L PWR_FLAG #FLG022
U 1 1 57206A98
P 1550 6300
F 0 "#FLG022" H 1550 6395 30  0001 C CNN
F 1 "PWR_FLAG" H 1550 6480 30  0000 C CNN
F 2 "" H 1550 6300 60  0000 C CNN
F 3 "" H 1550 6300 60  0000 C CNN
	1    1550 6300
	1    0    0    -1  
$EndComp
Wire Wire Line
	1550 6300 1550 6950
Connection ~ 1550 6950
$Comp
L GND #PWR023
U 1 1 57206B26
P 9850 2700
F 0 "#PWR023" H 9850 2700 30  0001 C CNN
F 1 "GND" H 9850 2630 30  0001 C CNN
F 2 "" H 9850 2700 60  0000 C CNN
F 3 "" H 9850 2700 60  0000 C CNN
	1    9850 2700
	1    0    0    -1  
$EndComp
Wire Wire Line
	9850 2550 9850 2700
Wire Wire Line
	2450 1150 1650 1150
Wire Wire Line
	2450 1550 1650 1550
Wire Wire Line
	2450 1950 1650 1950
Wire Wire Line
	2450 2350 1650 2350
Wire Wire Line
	2450 2750 1650 2750
Wire Wire Line
	2450 3150 1650 3150
Wire Wire Line
	2450 3550 1650 3550
Wire Wire Line
	2450 3950 1650 3950
Wire Wire Line
	2450 4350 1650 4350
Wire Wire Line
	2450 4750 1650 4750
Wire Wire Line
	2450 5150 1650 5150
Wire Wire Line
	1850 5250 1650 5250
Wire Wire Line
	1850 1000 1850 5250
Wire Wire Line
	1650 4850 1850 4850
Connection ~ 1850 4850
Wire Wire Line
	1650 4450 1850 4450
Connection ~ 1850 4450
Wire Wire Line
	1650 3650 1850 3650
Connection ~ 1850 3650
Wire Wire Line
	1650 3250 1850 3250
Connection ~ 1850 3250
Wire Wire Line
	1650 4050 1850 4050
Connection ~ 1850 4050
Wire Wire Line
	1650 2850 1850 2850
Connection ~ 1850 2850
Wire Wire Line
	1650 2450 1850 2450
Connection ~ 1850 2450
Wire Wire Line
	1650 2050 1850 2050
Connection ~ 1850 2050
Wire Wire Line
	1650 1650 1850 1650
Connection ~ 1850 1650
Wire Wire Line
	1650 1250 1850 1250
Connection ~ 1850 1250
$Comp
L CONN_2 P4
U 1 1 572059D9
P 5950 6850
F 0 "P4" V 5900 6850 40  0000 C CNN
F 1 "CONN_2" V 6000 6850 40  0000 C CNN
F 2 "" H 5950 6850 60  0000 C CNN
F 3 "" H 5950 6850 60  0000 C CNN
	1    5950 6850
	-1   0    0    1   
$EndComp
$Comp
L CONN_2 P3
U 1 1 572059F5
P 5650 6850
F 0 "P3" V 5600 6850 40  0000 C CNN
F 1 "CONN_2" V 5700 6850 40  0000 C CNN
F 2 "" H 5650 6850 60  0000 C CNN
F 3 "" H 5650 6850 60  0000 C CNN
	1    5650 6850
	1    0    0    1   
$EndComp
Wire Wire Line
	6300 6750 6750 6750
Wire Wire Line
	6450 6750 6450 6400
Wire Wire Line
	6300 6950 6450 6950
Wire Wire Line
	6450 6950 6450 7300
Wire Wire Line
	6750 6750 6750 6450
Connection ~ 6450 6750
Wire Wire Line
	4300 6950 5300 6950
Wire Wire Line
	4450 6350 4450 5850
Wire Wire Line
	5450 5850 5450 6350
Wire Wire Line
	5450 6350 5300 6350
Wire Wire Line
	5300 6350 5300 6750
$Comp
L PWR_FLAG #FLG024
U 1 1 57205F50
P 6750 7150
F 0 "#FLG024" H 6750 7245 30  0001 C CNN
F 1 "PWR_FLAG" H 6750 7330 30  0000 C CNN
F 2 "" H 6750 7150 60  0000 C CNN
F 3 "" H 6750 7150 60  0000 C CNN
	1    6750 7150
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR025
U 1 1 57205F56
P 6750 7300
F 0 "#PWR025" H 6750 7300 30  0001 C CNN
F 1 "GND" H 6750 7230 30  0001 C CNN
F 2 "" H 6750 7300 60  0000 C CNN
F 3 "" H 6750 7300 60  0000 C CNN
	1    6750 7300
	1    0    0    -1  
$EndComp
Wire Wire Line
	6750 7150 6750 7300
Wire Wire Line
	6400 1150 6400 1250
Text Notes 4050 3850 0    60   ~ 0
TIM2_CH1
$Comp
L STM32F103C8T6_DEV_BOARD U2
U 1 1 57202BC2
P 5850 3000
F 0 "U2" H 4850 4500 60  0000 L CNN
F 1 "STM32F103C8T6_DEV_BOARD" H 6800 1300 60  0000 C CNN
F 2 "~" H 6000 3400 60  0000 C CNN
F 3 "~" H 6000 3400 60  0000 C CNN
	1    5850 3000
	1    0    0    -1  
$EndComp
Wire Wire Line
	5850 1250 5850 1100
Wire Wire Line
	5850 1100 6200 1100
Wire Wire Line
	6200 1100 6200 1250
Text Label 8700 1600 0    60   ~ 0
CE
Wire Wire Line
	8550 1050 10550 1050
Wire Wire Line
	8550 1050 8550 1600
$Comp
L C C2
U 1 1 5747F7DC
P 9100 6500
F 0 "C2" H 9100 6600 40  0000 L CNN
F 1 "100nF" H 9106 6415 40  0000 L CNN
F 2 "~" H 9138 6350 30  0000 C CNN
F 3 "~" H 9100 6500 60  0000 C CNN
	1    9100 6500
	1    0    0    -1  
$EndComp
Wire Wire Line
	9100 6300 9100 6200
Connection ~ 9100 6200
$Comp
L GND #PWR026
U 1 1 5747F906
P 9100 6850
F 0 "#PWR026" H 9100 6850 30  0001 C CNN
F 1 "GND" H 9100 6780 30  0001 C CNN
F 2 "" H 9100 6850 60  0000 C CNN
F 3 "" H 9100 6850 60  0000 C CNN
	1    9100 6850
	1    0    0    -1  
$EndComp
Wire Wire Line
	9100 6700 9100 6850
$Comp
L CONN_4 P5
U 1 1 5747FB60
P 10550 6200
F 0 "P5" V 10500 6200 50  0000 C CNN
F 1 "CONN_4" V 10600 6200 50  0000 C CNN
F 2 "" H 10550 6200 60  0000 C CNN
F 3 "" H 10550 6200 60  0000 C CNN
	1    10550 6200
	1    0    0    1   
$EndComp
Wire Wire Line
	10200 6350 10100 6350
Wire Wire Line
	10100 6350 10100 6550
$Comp
L VCC #PWR027
U 1 1 5747FC1F
P 10100 5750
F 0 "#PWR027" H 10100 5850 30  0001 C CNN
F 1 "VCC" H 10100 5850 30  0000 C CNN
F 2 "" H 10100 5750 60  0000 C CNN
F 3 "" H 10100 5750 60  0000 C CNN
	1    10100 5750
	1    0    0    -1  
$EndComp
Wire Wire Line
	10200 6250 10100 6250
Wire Wire Line
	10100 6250 10100 5750
Wire Wire Line
	7550 2100 7100 2100
Wire Wire Line
	7550 2250 7100 2250
Wire Wire Line
	7550 2400 7100 2400
Wire Wire Line
	7550 2550 7100 2550
Wire Wire Line
	7550 2700 7100 2700
Wire Wire Line
	7550 2850 7100 2850
Wire Wire Line
	7550 3000 7100 3000
Text Label 7550 2100 2    60   ~ 0
SW3
Text Label 7550 2250 2    60   ~ 0
SW4
Text Label 7550 2400 2    60   ~ 0
SW5
Text Label 7550 2550 2    60   ~ 0
SW6
Text Label 7550 2700 2    60   ~ 0
SW7
Text Label 7550 2850 2    60   ~ 0
SW8
Text Label 7550 3000 2    60   ~ 0
SW9
$EndSCHEMATC
