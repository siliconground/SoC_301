# Usage with Vitis IDE:
# In Vitis IDE create a Single Application Debug launch configuration,
# change the debug type to 'Attach to running target' and provide this 
# tcl script in 'Execute Script' option.
# Path of this script: C:\REPO\SoC_301\3_PROJECT\1_BASIC_PMOD_CONTROL\2_PS\pmod_basic_system\_ide\scripts\debugger_pmod_basic-default.tcl
# 
# 
# Usage with xsct:
# To debug using xsct, launch xsct and run below command
# source C:\REPO\SoC_301\3_PROJECT\1_BASIC_PMOD_CONTROL\2_PS\pmod_basic_system\_ide\scripts\debugger_pmod_basic-default.tcl
# 
connect -url tcp:127.0.0.1:3121
targets -set -nocase -filter {name =~"APU*"}
rst -system
after 3000
targets -set -filter {jtag_cable_name =~ "Digilent Zybo Z7 210351BDF8EBA" && level==0 && jtag_device_ctx=="jsn-Zybo Z7-210351BDF8EBA-23727093-0"}
fpga -file C:/REPO/SoC_301/3_PROJECT/1_BASIC_PMOD_CONTROL/2_PS/pmod_basic/_ide/bitstream/PMOD_LED4_wrapper.bit
targets -set -nocase -filter {name =~"APU*"}
loadhw -hw C:/REPO/SoC_301/3_PROJECT/1_BASIC_PMOD_CONTROL/2_PS/PMOD_LED4_wrapper/export/PMOD_LED4_wrapper/hw/PMOD_LED4_wrapper.xsa -mem-ranges [list {0x40000000 0xbfffffff}] -regs
configparams force-mem-access 1
targets -set -nocase -filter {name =~"APU*"}
source C:/REPO/SoC_301/3_PROJECT/1_BASIC_PMOD_CONTROL/2_PS/pmod_basic/_ide/psinit/ps7_init.tcl
ps7_init
ps7_post_config
targets -set -nocase -filter {name =~ "*A9*#0"}
dow C:/REPO/SoC_301/3_PROJECT/1_BASIC_PMOD_CONTROL/2_PS/pmod_basic/Debug/pmod_basic.elf
configparams force-mem-access 0
targets -set -nocase -filter {name =~ "*A9*#0"}
con
