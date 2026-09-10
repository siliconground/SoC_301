/******************************************************************************
* Copyright (C) 2023 Advanced Micro Devices, Inc. All Rights Reserved.
* SPDX-License-Identifier: MIT
******************************************************************************/
/*
 * helloworld.c: simple test application
 *
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */

#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"


int main()
{
    init_platform();

    printf(" Size of Data Types\n\r");
    printf("Size of char: %dbyte\n\r", sizeof(char));
    printf("Size of int: %dbyte\n\r", sizeof(int));
    printf("Size of short: %dbyte\n\r", sizeof(short));
    printf("Size of long: %dbyte\n\r", sizeof(long));
    printf("Size of float: %dbyte\n\r", sizeof(float));
    printf("Size of double: %dbyte\n\r", sizeof(double));

    printf("Float Number : %f\n\r", 3.14);
    while(1){}


    cleanup_platform();
    return 0;
}
