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

    xil_printf("\x1B[2J\x1B[H"); // clear the terminal screen

    float r1, r2, r3, r4;
    r1 = 3 / 2;
    r2 = 3.0 / 2;
    r3 = 3 / 2.0;
    r4 = 3.0 / 2.0;

    /* 1. Division of floating point vars*/
    xil_printf("------ Divide two floating point nums ------\n\r");
    printf("Result 1: %f\n\r", r1);
    printf("Result 2: %f\n\r", r2);
    printf("Result 3: %f\n\r", r3);
    printf("Result 4: %f\n\r", r4);
    xil_printf("------ Divide two floating point nums ------\n\r");


    /*2. Logical Operator(1) */
    int n1 = 3, n2 = 5;
    xil_printf("------ Logical Operator(1) ------\n\r");
    if (n1 == n2)
    {
    	xil_printf("N1 is equal to N2!!\n\r");
    }
    else
    {
    	xil_printf("N1 is not equal to N2!!\n\r");
    }
    xil_printf("------ Logical Operator(1) ------\n\r");
    /*3. Logical Operator(2)*/
    n1 = 4, n2 = 6;
    xil_printf("------ Logical Operator(2) ------\n\r");
    xil_printf("Equal : %d\n\r", n1 == n2);
    xil_printf("Not Equal : %d\n\r", n1 != n2);
    xil_printf("Assignment : %d\n\r", n1 = n2);
    xil_printf("------ Logical Operator(2) ------\n\r");

    while(1){}

    cleanup_platform();
    return 0;
}
