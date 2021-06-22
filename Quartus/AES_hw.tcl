# TCL File Generated by Component Editor 18.0
# Tue Jun 22 09:07:08 CEST 2021
# DO NOT MODIFY


# 
# AES "AES" v1.0
#  2021.06.22.09:07:08
# 
# 

# 
# request TCL package from ACDS 16.1
# 
package require -exact qsys 16.1


# 
# module AES
# 
set_module_property DESCRIPTION ""
set_module_property NAME AES
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property GROUP CustomLogic
set_module_property AUTHOR ""
set_module_property DISPLAY_NAME AES
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL interface_controller
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file interface_controller.vhd VHDL PATH ../hdl/interface_controller.vhd TOP_LEVEL_FILE
add_fileset_file add_round_key.vhd VHDL PATH ../hdl/enc/add_round_key.vhd
add_fileset_file aes_dec.vhd VHDL PATH ../hdl/dec/aes_dec.vhd
add_fileset_file column_calc.vhd VHDL PATH ../hdl/enc/column_calc.vhd
add_fileset_file dec_column_calc.vhd VHDL PATH ../hdl/dec/dec_column_calc.vhd
add_fileset_file dec_controller.vhd VHDL PATH ../hdl/dec/dec_controller.vhd
add_fileset_file dec_key_sch_round_function.vhd VHDL PATH ../hdl/dec/dec_key_sch_round_function.vhd
add_fileset_file dec_mix_column.vhd VHDL PATH ../hdl/dec/dec_mix_column.vhd
add_fileset_file dec_s_box.vhd VHDL PATH ../hdl/dec/dec_s_box.vhd
add_fileset_file dec_shift_rwos.vhd VHDL PATH ../hdl/dec/dec_shift_rwos.vhd
add_fileset_file dec_sub_byte.vhd VHDL PATH ../hdl/dec/dec_sub_byte.vhd
add_fileset_file gf_mult.vhd VHDL PATH ../hdl/enc/gf_mult.vhd
add_fileset_file inverter.vhd VHDL PATH ../hdl/enc/inverter.vhd
add_fileset_file key_schedule.vhd VHDL PATH ../hdl/enc/key_schedule.vhd
add_fileset_file mix_column.vhd VHDL PATH ../hdl/enc/mix_column.vhd
add_fileset_file reg.vhd VHDL PATH ../hdl/enc/reg.vhd
add_fileset_file aes_enc.vhd VHDL PATH ../hdl/enc/aes_enc.vhd
add_fileset_file byte_sub.vhd VHDL PATH ../hdl/enc/byte_sub.vhd
add_fileset_file controller.vhd VHDL PATH ../hdl/enc/controller.vhd
add_fileset_file interface.vhd VHDL PATH ../hdl/enc/interface.vhd
add_fileset_file key_sch_round_function.vhd VHDL PATH ../hdl/enc/key_sch_round_function.vhd
add_fileset_file s_box.vhd VHDL PATH ../hdl/enc/s_box.vhd
add_fileset_file shft_row.vhd VHDL PATH ../hdl/enc/shft_row.vhd


# 
# parameters
# 
add_parameter INTERFACE_WIDTH INTEGER 32
set_parameter_property INTERFACE_WIDTH DEFAULT_VALUE 32
set_parameter_property INTERFACE_WIDTH DISPLAY_NAME INTERFACE_WIDTH
set_parameter_property INTERFACE_WIDTH TYPE INTEGER
set_parameter_property INTERFACE_WIDTH UNITS None
set_parameter_property INTERFACE_WIDTH HDL_PARAMETER true
add_parameter INTERFACE_LENGTH NATURAL 32
set_parameter_property INTERFACE_LENGTH DEFAULT_VALUE 32
set_parameter_property INTERFACE_LENGTH DISPLAY_NAME INTERFACE_LENGTH
set_parameter_property INTERFACE_LENGTH TYPE NATURAL
set_parameter_property INTERFACE_LENGTH UNITS None
set_parameter_property INTERFACE_LENGTH HDL_PARAMETER true
add_parameter INTERFACE_ADDR_WIDTH NATURAL 5
set_parameter_property INTERFACE_ADDR_WIDTH DEFAULT_VALUE 5
set_parameter_property INTERFACE_ADDR_WIDTH DISPLAY_NAME INTERFACE_ADDR_WIDTH
set_parameter_property INTERFACE_ADDR_WIDTH TYPE NATURAL
set_parameter_property INTERFACE_ADDR_WIDTH UNITS None
set_parameter_property INTERFACE_ADDR_WIDTH HDL_PARAMETER true


# 
# display items
# 


# 
# connection point clock_sink
# 
add_interface clock_sink clock end
set_interface_property clock_sink clockRate 0
set_interface_property clock_sink ENABLED true
set_interface_property clock_sink EXPORT_OF ""
set_interface_property clock_sink PORT_NAME_MAP ""
set_interface_property clock_sink CMSIS_SVD_VARIABLES ""
set_interface_property clock_sink SVD_ADDRESS_GROUP ""

add_interface_port clock_sink clk_clk clk Input 1


# 
# connection point reset_sink
# 
add_interface reset_sink reset end
set_interface_property reset_sink associatedClock clock_sink
set_interface_property reset_sink synchronousEdges DEASSERT
set_interface_property reset_sink ENABLED true
set_interface_property reset_sink EXPORT_OF ""
set_interface_property reset_sink PORT_NAME_MAP ""
set_interface_property reset_sink CMSIS_SVD_VARIABLES ""
set_interface_property reset_sink SVD_ADDRESS_GROUP ""

add_interface_port reset_sink rst_t reset Input 1


# 
# connection point interface_0_avalon_slave_0
# 
add_interface interface_0_avalon_slave_0 avalon end
set_interface_property interface_0_avalon_slave_0 addressUnits WORDS
set_interface_property interface_0_avalon_slave_0 associatedClock clock_sink
set_interface_property interface_0_avalon_slave_0 associatedReset reset_sink
set_interface_property interface_0_avalon_slave_0 bitsPerSymbol 8
set_interface_property interface_0_avalon_slave_0 burstOnBurstBoundariesOnly false
set_interface_property interface_0_avalon_slave_0 burstcountUnits WORDS
set_interface_property interface_0_avalon_slave_0 explicitAddressSpan 0
set_interface_property interface_0_avalon_slave_0 holdTime 0
set_interface_property interface_0_avalon_slave_0 linewrapBursts false
set_interface_property interface_0_avalon_slave_0 maximumPendingReadTransactions 0
set_interface_property interface_0_avalon_slave_0 maximumPendingWriteTransactions 0
set_interface_property interface_0_avalon_slave_0 readLatency 0
set_interface_property interface_0_avalon_slave_0 readWaitTime 1
set_interface_property interface_0_avalon_slave_0 setupTime 0
set_interface_property interface_0_avalon_slave_0 timingUnits Cycles
set_interface_property interface_0_avalon_slave_0 writeWaitTime 0
set_interface_property interface_0_avalon_slave_0 ENABLED true
set_interface_property interface_0_avalon_slave_0 EXPORT_OF ""
set_interface_property interface_0_avalon_slave_0 PORT_NAME_MAP ""
set_interface_property interface_0_avalon_slave_0 CMSIS_SVD_VARIABLES ""
set_interface_property interface_0_avalon_slave_0 SVD_ADDRESS_GROUP ""

add_interface_port interface_0_avalon_slave_0 interface_0_avalon_slave_1_read read Input 1
add_interface_port interface_0_avalon_slave_0 interface_0_avalon_slave_1_write write Input 1
add_interface_port interface_0_avalon_slave_0 interface_0_avalon_slave_1_waitrequest waitrequest Output 1
add_interface_port interface_0_avalon_slave_0 interface_0_avalon_slave_1_address address Input interface_addr_width
add_interface_port interface_0_avalon_slave_0 interface_0_avalon_slave_1_byteenable byteenable Input 4
add_interface_port interface_0_avalon_slave_0 interface_0_avalon_slave_1_readdata readdata Output interface_width
add_interface_port interface_0_avalon_slave_0 interface_0_avalon_slave_1_writedata writedata Input interface_width
set_interface_assignment interface_0_avalon_slave_0 embeddedsw.configuration.isFlash 0
set_interface_assignment interface_0_avalon_slave_0 embeddedsw.configuration.isMemoryDevice 0
set_interface_assignment interface_0_avalon_slave_0 embeddedsw.configuration.isNonVolatileStorage 0
set_interface_assignment interface_0_avalon_slave_0 embeddedsw.configuration.isPrintableDevice 0

