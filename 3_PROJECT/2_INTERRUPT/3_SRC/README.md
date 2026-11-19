# 6. Interrupt with Switch & LED (Zybo Z7-20)

스위치(SW0~SW3)를 움직이면 AXI GPIO 인터럽트 → GIC(ID 61) → ISR에서 LED(LD0~LD3)에 스위치 값을 표시.

| 파일 | 내용 |
|---|---|
| vivado/create_project.tcl | Block Design ~ XSA 자동 생성 (`vivado -mode batch -source create_project.tcl`) |
| vivado/sw_led_intr.xdc | SW: G15 P15 W13 T16 / LED: M14 M15 G14 D18 |
| vitis/sw_interrupt.c | ISR + GIC 설정 예제 (Unified/Classic 공용, `#ifdef SDT`) |

PL 요약: AXI GPIO Dual Channel (CH1 4bit All Inputs = sw, CH2 4bit All Outputs = led, Enable Interrupt),
ZYNQ7 Interrupts → Fabric Interrupts → IRQ_F2P 체크, ip2intc_irpt → IRQ_F2P[0].
