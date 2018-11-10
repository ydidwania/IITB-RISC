transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {/home/apoorv/Downloads/MICRO PROJECT/Project1/mux3bit6to1.vhd}
vcom -93 -work work {/home/apoorv/Downloads/MICRO PROJECT/Project1/mux3bit2to1.vhd}
vcom -93 -work work {/home/apoorv/Downloads/MICRO PROJECT/Project1/main.vhd}
vcom -93 -work work {/home/apoorv/Downloads/MICRO PROJECT/Project1/memory.vhd}
vcom -93 -work work {/home/apoorv/Downloads/MICRO PROJECT/Project1/z9.vhd}
vcom -93 -work work {/home/apoorv/Downloads/MICRO PROJECT/Project1/datapath.vhd}
vcom -93 -work work {/home/apoorv/Downloads/MICRO PROJECT/Project1/mux2to1.vhd}
vcom -93 -work work {/home/apoorv/Downloads/MICRO PROJECT/Project1/ALU.vhd}
vcom -93 -work work {/home/apoorv/Downloads/MICRO PROJECT/Project1/mux6to1.vhd}
vcom -93 -work work {/home/apoorv/Downloads/MICRO PROJECT/Project1/mux4to1.vhd}
vcom -93 -work work {/home/apoorv/Downloads/MICRO PROJECT/Project1/se9.vhd}
vcom -93 -work work {/home/apoorv/Downloads/MICRO PROJECT/Project1/se6.vhd}
vcom -93 -work work {/home/apoorv/Downloads/MICRO PROJECT/Project1/reg_file.vhd}
vcom -93 -work work {/home/apoorv/Downloads/MICRO PROJECT/Project1/reg_16bit.vhd}
vcom -93 -work work {/home/apoorv/Downloads/MICRO PROJECT/Project1/priority_encoder.vhd}
vcom -93 -work work {/home/apoorv/Downloads/MICRO PROJECT/Project1/mux_state.vhd}
vcom -93 -work work {/home/apoorv/Downloads/MICRO PROJECT/Project1/control_path.vhd}

vcom -93 -work work {/home/apoorv/Downloads/MICRO PROJECT/Project1/Testbench.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cycloneive -L rtl_work -L work -voptargs="+acc"  Testbench

add wave *
view structure
view signals
run -all
