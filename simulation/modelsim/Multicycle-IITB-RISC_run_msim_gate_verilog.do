transcript on
if {[file exists gate_work]} {
	vdel -lib gate_work -all
}
vlib gate_work
vmap work gate_work

vlog -vlog01compat -work work +incdir+. {Multicycle-IITB-RISC_6_1200mv_85c_slow.vo}

vcom -93 -work work {/home/jukebox/Desktop/Acads/5-Sem/EE 309/Project1/Testbench.vhd}

vsim -t 1ps +transport_int_delays +transport_path_delays -L altera_ver -L cycloneive_ver -L gate_work -L work -voptargs="+acc"  Testbench

add wave *
view structure
view signals
run -all
