transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {/home/jukebox/Desktop/Acads/5-Sem/EE 309/Project1/reg_file.vhd}
vcom -93 -work work {/home/jukebox/Desktop/Acads/5-Sem/EE 309/Project1/reg_16bit.vhd}

