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




/* Zybo Z7-20 : Pmod LED(JE) 4개를 1초 간격으로 켜고 끄기 */

#include "xparameters.h"   /* AXI GPIO 주소 (Vivado 설계에서 자동 생성) */
#include "xil_io.h"        /* Xil_Out32 : 주소에 값 쓰기 */
#include "sleep.h"         /* sleep     : 초 단위 대기   */

#define LED_ADDR  XPAR_AXI_GPIO_0_BASEADDR   /* GPIO 데이터 레지스터 주소 */

int main(void)
{
    while (1) {
        Xil_Out32(LED_ADDR, 0xF);   /* 1111 : LED 4개 켜기 */
        sleep(1);                   /* 1초 대기 */

        Xil_Out32(LED_ADDR, 0x0);   /* 0000 : LED 4개 끄기 */
        sleep(1);                   /* 1초 대기 */
    }

    return 0;
}
