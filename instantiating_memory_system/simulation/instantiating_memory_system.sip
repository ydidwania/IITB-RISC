set_global_assignment -entity "instantiating_memory_system" -library "lib_instantiating_memory_system" -name IP_TOOL_NAME "Qsys"
set_global_assignment -entity "instantiating_memory_system" -library "lib_instantiating_memory_system" -name IP_TOOL_VERSION "16.1"
set_global_assignment -entity "instantiating_memory_system" -library "lib_instantiating_memory_system" -name IP_TOOL_ENV "Qsys"
set_global_assignment -library "lib_instantiating_memory_system" -name SPD_FILE [file join $::quartus(sip_path) "../instantiating_memory_system.spd"]
set_global_assignment -library "lib_instantiating_memory_system" -name MISC_FILE [file join $::quartus(sip_path) "../../instantiating_memory_system.qsys"]

set_global_assignment -library "lib_instantiating_memory_system" -name MISC_FILE [file join $::quartus(sip_path) "instantiating_memory_system.v"]
set_global_assignment -library "lib_instantiating_memory_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/instantiating_memory_system_system_0.v"]
set_global_assignment -library "lib_instantiating_memory_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/instantiating_memory_system_system_0_onchip_memory_0.hex"]
set_global_assignment -library "lib_instantiating_memory_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/instantiating_memory_system_system_0_onchip_memory_0.v"]
