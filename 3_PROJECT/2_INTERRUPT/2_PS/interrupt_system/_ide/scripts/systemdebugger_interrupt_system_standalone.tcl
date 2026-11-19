# Usage with Vitis IDE:
# In Vitis IDE create a Single Application Debug launch configuration,
# change the debug type to 'Attach to running target' and provide this 
# tcl script in 'Execute Script' option.
# Path of this script: C:\REPO\SoC_301\3_PROJECT\2_INTERRUPT\2_PS\interrupt_system\_ide\scripts\systemdebugger_interrupt_system_standalone.tcl
# 
# 
# Usage with xsct:
# To debug using xsct, launch xsct and run below command
# source C:\REPO\SoC_301\3_PROJECT\2_INTERRUPT\2_PS\interrupt_system\_ide\scripts\systemdebugger_interrupt_system_standalone.tcl
# 
connect -url tcp:127.0.0.1:3121
targets -set -nocase -filter {name =~"APU*"}
rst -system
after 3000
targets -set -filter {jtag_cable_name =~ "Digilent Zybo Z7 210351BDF8EBA" && level==0 && jtag_device_ctx=="jsn-Zybo Z7-210351BDF8EBA-23727093-0"}
fpga -file C:/REPO/SoC_301/3_PROJECT/2_INTERRUPT/2_PS/interrupt/_ide/bitstream/design_1_wrapper.bit
targets -set -nocase -filter {name =~"APU*"}
loadhw -hw C:/REPO/SoC_301/3_PROJECT/2_INTERRUPT/2_PS/design_1_wrapper/export/design_1_wrapper/hw/design_1_wrapper.xsa -mem-ranges [list {0x40000000 0xbfffffff}] -regs
configparams force-mem-access 1
targets -set -nocase -filter {name =~"APU*"}
source C:/REPO/SoC_301/3_PROJECT/2_INTERRUPT/2_PS/interrupt/_ide/psinit/ps7_init.tcl
ps7_init
ps7_post_config
targets -set -nocase -filter {name =~ "*A9*#0"}
dow C:/REPO/SoC_301/3_PROJECT/2_INTERRUPT/2_PS/interrupt/Debug/interrupt.elf
configparams force-mem-access 0
targets -set -nocase -filter {name =~ "*A9*#0"}
con
