# create_project.tcl : Zybo Z7-20 스위치 인터럽트 예제 (Block Design ~ XSA 자동 생성)
#   사용법: cd vivado ; vivado -mode batch -source create_project.tcl
set proj_name zybo_sw_intr
set proj_dir  [file normalize ./$proj_name]
set src_dir   [file normalize [file dirname [info script]]]

create_project $proj_name $proj_dir -part xc7z020clg400-1 -force
set bp [lindex [get_board_parts -quiet -latest_file_version *zybo-z7-20*] 0]
if {$bp ne ""} { set_property board_part $bp [current_project] } \
else { puts "WARNING: Zybo Z7-20 board file not found (PS preset will not be applied)" }

# ---------- Block Design ----------
create_bd_design design_1

# 1) Zynq PS + Board Preset
create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7 processing_system7_0
apply_bd_automation -rule xilinx.com:bd_rule:processing_system7 \
    -config {make_external "FIXED_IO, DDR" apply_board_preset "1" Master "Disable" Slave "Disable"} \
    [get_bd_cells processing_system7_0]
# PL -> PS 인터럽트 포트(IRQ_F2P) 켜기
set_property -dict [list CONFIG.PCW_USE_M_AXI_GP0 {1} \
                         CONFIG.PCW_USE_FABRIC_INTERRUPT {1} \
                         CONFIG.PCW_IRQ_F2P_INTR {1}] [get_bd_cells processing_system7_0]

# 2) AXI GPIO : CH1 = 스위치 4bit 입력, CH2 = LED 4bit 출력, 인터럽트 사용
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio axi_gpio_0
set_property -dict [list CONFIG.C_GPIO_WIDTH {4}   CONFIG.C_ALL_INPUTS {1} \
                         CONFIG.C_IS_DUAL {1} \
                         CONFIG.C_GPIO2_WIDTH {4}  CONFIG.C_ALL_OUTPUTS_2 {1} \
                         CONFIG.C_INTERRUPT_PRESENT {1}] [get_bd_cells axi_gpio_0]

# 3) AXI 버스 연결 (Connection Automation, S_AXI 만)
apply_bd_automation -rule xilinx.com:bd_rule:axi4 \
    -config {Clk_master {Auto} Clk_slave {Auto} Clk_xbar {Auto} Master {/processing_system7_0/M_AXI_GP0} Slave {/axi_gpio_0/S_AXI} intc_ip {New AXI Interconnect} master_apm {0}} \
    [get_bd_intf_pins axi_gpio_0/S_AXI]

# 4) 외부 포트 : sw (CH1), led (CH2)
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 sw
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 led
connect_bd_intf_net [get_bd_intf_ports sw]  [get_bd_intf_pins axi_gpio_0/GPIO]
connect_bd_intf_net [get_bd_intf_ports led] [get_bd_intf_pins axi_gpio_0/GPIO2]

# 5) 인터럽트 연결 : ip2intc_irpt -> IRQ_F2P[0]  (GIC ID 61)
connect_bd_net [get_bd_pins axi_gpio_0/ip2intc_irpt] [get_bd_pins processing_system7_0/IRQ_F2P]

assign_bd_address
validate_bd_design
save_bd_design

# ---------- Wrapper, XDC, Bitstream, XSA ----------
set bd_file [get_files design_1.bd]
make_wrapper -files $bd_file -top
add_files -norecurse [file join [file dirname $bd_file] hdl design_1_wrapper.v]
set_property top design_1_wrapper [current_fileset]
add_files -fileset constrs_1 -norecurse [file join $src_dir sw_led_intr.xdc]

launch_runs impl_1 -to_step write_bitstream -jobs 4
wait_on_run impl_1
write_hw_platform -fixed -include_bit -force -file [file join $proj_dir design_1_wrapper.xsa]
puts "DONE: [file join $proj_dir design_1_wrapper.xsa]"
