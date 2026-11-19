/*
 * sw_interrupt.c
 * Zybo Z7-20 : 스위치(SW0~SW3)를 움직이면 인터럽트가 발생하고,
 *              ISR에서 스위치 값을 LED(LD0~LD3)에 표시한다.
 *
 *  AXI GPIO CH1 = 스위치(입력), CH2 = LED(출력)
 *  ip2intc_irpt -> IRQ_F2P[0] -> GIC 61번
 */
#include "xparameters.h"    // 주소 정의
#include "xil_io.h"         // Xil_In32, Xil_Out32
#include "xscugic.h"        // 인터럽트 컨트롤러(GIC)
#include "xil_exception.h"  // CPU 인터럽트 켜기
#include "xil_printf.h"     // xil_printf

/* AXI GPIO 레지스터 주소 (PG144) */
#define GPIO_BASE   XPAR_AXI_GPIO_0_BASEADDR
#define SW_DATA     (GPIO_BASE + 0x000)   // 채널1 : 스위치 읽기
#define LED_DATA    (GPIO_BASE + 0x008)   // 채널2 : LED 쓰기
#define GIER        (GPIO_BASE + 0x11C)   // 인터럽트 출력 전체 허용 (bit31)
#define IP_ISR      (GPIO_BASE + 0x120)   // 인터럽트 상태 (1을 쓰면 지워짐)
#define IP_IER      (GPIO_BASE + 0x128)   // 채널별 인터럽트 허용 (bit0 = CH1)

#define SW_INTR_ID  61                    // IRQ_F2P[0] 의 인터럽트 번호

#ifdef SDT   /* Vitis 버전 차이 처리 (그대로 두기) */
#define GIC_ID  XPAR_XSCUGIC_0_BASEADDR
#else
#define GIC_ID  XPAR_SCUGIC_0_DEVICE_ID
#endif

XScuGic gic;                              // 인터럽트 컨트롤러 변수

/* 인터럽트 서비스 루틴(ISR) : 스위치가 바뀌면 자동으로 호출된다 */
void sw_isr(void *ref)
{
    u32 sw = Xil_In32(SW_DATA);           // ① 스위치 읽기
    Xil_Out32(LED_DATA, sw);              // ② LED에 그대로 표시
    xil_printf("SW = 0x%x\r\n", sw);
    Xil_Out32(IP_ISR, 0x1);               // ③ 인터럽트 플래그 지우기 (필수!)
}

int main(void)
{
    // ① GIC 초기화
    XScuGic_Config *cfg = XScuGic_LookupConfig(GIC_ID);
    XScuGic_CfgInitialize(&gic, cfg, cfg->CpuBaseAddress);

    // ② 61번 인터럽트에 sw_isr 연결 후 허용 (0x3 = 상승 에지)
    XScuGic_SetPriorityTriggerType(&gic, SW_INTR_ID, 0xA0, 0x3);
    XScuGic_Connect(&gic, SW_INTR_ID, (Xil_InterruptHandler)sw_isr, NULL);
    XScuGic_Enable(&gic, SW_INTR_ID);

    // ③ CPU가 인터럽트를 받도록 설정
    Xil_ExceptionRegisterHandler(XIL_EXCEPTION_ID_INT,
        (Xil_ExceptionHandler)XScuGic_InterruptHandler, &gic);
    Xil_ExceptionEnable();

    // ④ AXI GPIO 인터럽트 허용
    Xil_Out32(IP_IER, 0x1);               // 채널1(스위치) 허용
    Xil_Out32(GIER, 0x80000000);          // 전체 출력 허용 (bit31)

    xil_printf("Ready! Move the switches.\r\n");
    while (1) {
        // main은 할 일이 없다. 스위치 처리는 모두 ISR에서!
    }
    return 0;
}
