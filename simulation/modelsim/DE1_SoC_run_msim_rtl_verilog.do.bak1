transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/intelFPGA_lite/17.0/labs/ee371lab3 {C:/intelFPGA_lite/17.0/labs/ee371lab3/VGA_framebuffer.sv}
vlog -sv -work work +incdir+C:/intelFPGA_lite/17.0/labs/ee371lab3 {C:/intelFPGA_lite/17.0/labs/ee371lab3/line_drawerbackup.sv}
vlog -sv -work work +incdir+C:/intelFPGA_lite/17.0/labs/ee371lab3 {C:/intelFPGA_lite/17.0/labs/ee371lab3/DE1_SoC.sv}

