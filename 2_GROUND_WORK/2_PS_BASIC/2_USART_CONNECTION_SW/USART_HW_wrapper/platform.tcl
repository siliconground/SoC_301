# 
# Usage: To re-create this platform project launch xsct with below options.
# xsct C:\repo\SOC\SoC_301\2_GROUND_WORK\2_PS_BASIC\2_USART_CONNECTION_SW\USART_HW_wrapper\platform.tcl
# 
# OR launch xsct and run below command.
# source C:\repo\SOC\SoC_301\2_GROUND_WORK\2_PS_BASIC\2_USART_CONNECTION_SW\USART_HW_wrapper\platform.tcl
# 
# To create the platform in a different location, modify the -out option of "platform create" command.
# -out option specifies the output directory of the platform project.

platform create -name {USART_HW_wrapper}\
-hw {C:\repo\SOC\SoC_301\2_GROUND_WORK\2_PS_BASIC\1_USART_CONNECTION_HW\USART_HW_wrapper.xsa}\
-out {C:/repo/SOC/SoC_301/2_GROUND_WORK/2_PS_BASIC/2_USART_CONNECTION_SW}

platform write
domain create -name {standalone_ps7_cortexa9_0} -display-name {standalone_ps7_cortexa9_0} -os {standalone} -proc {ps7_cortexa9_0} -runtime {cpp} -arch {32-bit} -support-app {hello_world}
platform generate -domains 
platform active {USART_HW_wrapper}
domain active {zynq_fsbl}
domain active {standalone_ps7_cortexa9_0}
platform generate -quick
platform generate
