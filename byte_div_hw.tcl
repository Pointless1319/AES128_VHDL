# TCL File Generated by Component Editor 18.0
# Wed Feb 10 10:53:54 CET 2021
# DO NOT MODIFY


# 
# byte_div "byte_div" v1.0
#  2021.02.10.10:53:54
# 
# 

# 
# request TCL package from ACDS 16.1
# 
package require -exact qsys 16.1


# 
# module byte_div
# 
set_module_property DESCRIPTION ""
set_module_property NAME byte_div
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property GROUP CustomLogic
set_module_property AUTHOR ""
set_module_property DISPLAY_NAME byte_div
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL byte_div
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file byte_div.vhd VHDL PATH byte_div.vhd TOP_LEVEL_FILE


# 
# parameters
# 


# 
# display items
# 


# 
# connection point clock
# 
add_interface clock clock end
set_interface_property clock clockRate 0
set_interface_property clock ENABLED true
set_interface_property clock EXPORT_OF ""
set_interface_property clock PORT_NAME_MAP ""
set_interface_property clock CMSIS_SVD_VARIABLES ""
set_interface_property clock SVD_ADDRESS_GROUP ""

add_interface_port clock clk clk Input 1


# 
# connection point reset
# 
add_interface reset reset end
set_interface_property reset associatedClock clock
set_interface_property reset synchronousEdges DEASSERT
set_interface_property reset ENABLED true
set_interface_property reset EXPORT_OF ""
set_interface_property reset PORT_NAME_MAP ""
set_interface_property reset CMSIS_SVD_VARIABLES ""
set_interface_property reset SVD_ADDRESS_GROUP ""

add_interface_port reset reset_n reset_n Input 1


# 
# connection point data_out_0
# 
add_interface data_out_0 avalon_streaming start
set_interface_property data_out_0 associatedClock clock
set_interface_property data_out_0 associatedReset reset
set_interface_property data_out_0 dataBitsPerSymbol 8
set_interface_property data_out_0 errorDescriptor ""
set_interface_property data_out_0 firstSymbolInHighOrderBits true
set_interface_property data_out_0 maxChannel 0
set_interface_property data_out_0 readyLatency 0
set_interface_property data_out_0 ENABLED true
set_interface_property data_out_0 EXPORT_OF ""
set_interface_property data_out_0 PORT_NAME_MAP ""
set_interface_property data_out_0 CMSIS_SVD_VARIABLES ""
set_interface_property data_out_0 SVD_ADDRESS_GROUP ""

add_interface_port data_out_0 out_data_1 data Output 8


# 
# connection point data_out_1
# 
add_interface data_out_1 avalon_streaming start
set_interface_property data_out_1 associatedClock clock
set_interface_property data_out_1 associatedReset reset
set_interface_property data_out_1 dataBitsPerSymbol 8
set_interface_property data_out_1 errorDescriptor ""
set_interface_property data_out_1 firstSymbolInHighOrderBits true
set_interface_property data_out_1 maxChannel 0
set_interface_property data_out_1 readyLatency 0
set_interface_property data_out_1 ENABLED true
set_interface_property data_out_1 EXPORT_OF ""
set_interface_property data_out_1 PORT_NAME_MAP ""
set_interface_property data_out_1 CMSIS_SVD_VARIABLES ""
set_interface_property data_out_1 SVD_ADDRESS_GROUP ""

add_interface_port data_out_1 out_data_2 data Output 8


# 
# connection point data_out_2
# 
add_interface data_out_2 avalon_streaming start
set_interface_property data_out_2 associatedClock clock
set_interface_property data_out_2 associatedReset reset
set_interface_property data_out_2 dataBitsPerSymbol 8
set_interface_property data_out_2 errorDescriptor ""
set_interface_property data_out_2 firstSymbolInHighOrderBits true
set_interface_property data_out_2 maxChannel 0
set_interface_property data_out_2 readyLatency 0
set_interface_property data_out_2 ENABLED true
set_interface_property data_out_2 EXPORT_OF ""
set_interface_property data_out_2 PORT_NAME_MAP ""
set_interface_property data_out_2 CMSIS_SVD_VARIABLES ""
set_interface_property data_out_2 SVD_ADDRESS_GROUP ""

add_interface_port data_out_2 out_data_3 data Output 8


# 
# connection point data_in
# 
add_interface data_in avalon_streaming end
set_interface_property data_in associatedClock clock
set_interface_property data_in associatedReset reset
set_interface_property data_in dataBitsPerSymbol 8
set_interface_property data_in errorDescriptor ""
set_interface_property data_in firstSymbolInHighOrderBits true
set_interface_property data_in maxChannel 0
set_interface_property data_in readyLatency 0
set_interface_property data_in ENABLED true
set_interface_property data_in EXPORT_OF ""
set_interface_property data_in PORT_NAME_MAP ""
set_interface_property data_in CMSIS_SVD_VARIABLES ""
set_interface_property data_in SVD_ADDRESS_GROUP ""

add_interface_port data_in in_data data Input 128

