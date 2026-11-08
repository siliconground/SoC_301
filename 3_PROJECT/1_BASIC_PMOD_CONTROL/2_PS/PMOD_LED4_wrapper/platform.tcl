# 
# Usage: To re-create this platform project launch xsct with below options.
# xsct C:\REPO\SoC_301\3_PROJECT\1_BASIC_PMOD_CONTROL\2_PS\PMOD_LED4_wrapper\platform.tcl
# 
# OR launch xsct and run below command.
# source C:\REPO\SoC_301\3_PROJECT\1_BASIC_PMOD_CONTROL\2_PS\PMOD_LED4_wrapper\platform.tcl
# 
# To create the platform in a different location, modify the -out option of "platform create" command.
# -out option specifies the output directory of the platform project.

platform create -name {PMOD_LED4_wrapper}\
-hw {C:\REPO\SoC_301\3_PROJECT\1_BASIC_PMOD_CONTROL\1_PL\PMOD_LED4_wrapper.xsa}\
-out {C:/REPO/SoC_301/3_PROJECT/1_BASIC_PMOD_CONTROL/2_PS}

platform write
domain create -name {standalone_ps7_cortexa9_0} -display-name {standalone_ps7_cortexa9_0} -os {standalone} -proc {ps7_cortexa9_0} -runtime {cpp} -arch {32-bit} -support-app {hello_world}
platform generate -domains 
platform active {PMOD_LED4_wrapper}
domain active {zynq_fsbl}
domain active {standalone_ps7_cortexa9_0}
platform generate -quick
platform generate
