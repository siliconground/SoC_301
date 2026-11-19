## Zybo Z7-20 : 슬라이드 스위치 -> AXI GPIO CH1 (sw), LED <- AXI GPIO CH2 (led)
## 포트 이름 = 외부 포트 이름 + _tri_i(입력) / _tri_o(출력)

## Switches (SW0~SW3)
set_property -dict { PACKAGE_PIN G15 IOSTANDARD LVCMOS33 } [get_ports { sw_tri_i[0] }]   ;# SW0
set_property -dict { PACKAGE_PIN P15 IOSTANDARD LVCMOS33 } [get_ports { sw_tri_i[1] }]   ;# SW1
set_property -dict { PACKAGE_PIN W13 IOSTANDARD LVCMOS33 } [get_ports { sw_tri_i[2] }]   ;# SW2
set_property -dict { PACKAGE_PIN T16 IOSTANDARD LVCMOS33 } [get_ports { sw_tri_i[3] }]   ;# SW3

## LEDs (LD0~LD3)
set_property -dict { PACKAGE_PIN M14 IOSTANDARD LVCMOS33 } [get_ports { led_tri_o[0] }]  ;# LD0
set_property -dict { PACKAGE_PIN M15 IOSTANDARD LVCMOS33 } [get_ports { led_tri_o[1] }]  ;# LD1
set_property -dict { PACKAGE_PIN G14 IOSTANDARD LVCMOS33 } [get_ports { led_tri_o[2] }]  ;# LD2
set_property -dict { PACKAGE_PIN D18 IOSTANDARD LVCMOS33 } [get_ports { led_tri_o[3] }]  ;# LD3
