# TCL File Generated by Component Editor 18.0
# Wed Feb 10 09:28:41 CET 2021
# DO NOT MODIFY


# 
# display "display" v1.0
#  2021.02.10.09:28:41
# 
# 

# 
# request TCL package from ACDS 16.1
# 
package require -exact qsys 16.1


# 
# module display
# 
set_module_property DESCRIPTION ""
set_module_property NAME display
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property GROUP CustomLogic
set_module_property AUTHOR ""
set_module_property DISPLAY_NAME display
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL display
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file display.vhd VHDL PATH display.vhd TOP_LEVEL_FILE


# 
# parameters
# 


# 
# display items
# 


# 
# connection point reset_sink
# 
add_interface reset_sink reset end
set_interface_property reset_sink associatedClock clock_sink_1
set_interface_property reset_sink synchronousEdges DEASSERT
set_interface_property reset_sink ENABLED true
set_interface_property reset_sink EXPORT_OF ""
set_interface_property reset_sink PORT_NAME_MAP ""
set_interface_property reset_sink CMSIS_SVD_VARIABLES ""
set_interface_property reset_sink SVD_ADDRESS_GROUP ""

add_interface_port reset_sink reset_sink_reset reset Input 1


# 
# connection point clock_sink_1
# 
add_interface clock_sink_1 clock end
set_interface_property clock_sink_1 clockRate 0
set_interface_property clock_sink_1 ENABLED true
set_interface_property clock_sink_1 EXPORT_OF ""
set_interface_property clock_sink_1 PORT_NAME_MAP ""
set_interface_property clock_sink_1 CMSIS_SVD_VARIABLES ""
set_interface_property clock_sink_1 SVD_ADDRESS_GROUP ""

add_interface_port clock_sink_1 clock_sink_clk clk Input 1


# 
# connection point display_out
# 
add_interface display_out avalon_streaming start
set_interface_property display_out associatedClock clock_sink_1
set_interface_property display_out associatedReset reset_sink
set_interface_property display_out dataBitsPerSymbol 8
set_interface_property display_out errorDescriptor ""
set_interface_property display_out firstSymbolInHighOrderBits true
set_interface_property display_out maxChannel 0
set_interface_property display_out readyLatency 0
set_interface_property display_out ENABLED true
set_interface_property display_out EXPORT_OF ""
set_interface_property display_out PORT_NAME_MAP ""
set_interface_property display_out CMSIS_SVD_VARIABLES ""
set_interface_property display_out SVD_ADDRESS_GROUP ""

add_interface_port display_out hex_data data Output 8


# 
# connection point data_in
# 
add_interface data_in avalon_streaming end
set_interface_property data_in associatedClock clock_sink_1
set_interface_property data_in associatedReset reset_sink
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

add_interface_port data_in data_in data Input 8

