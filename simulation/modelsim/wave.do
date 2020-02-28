onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /DE1_SoC_testbench/dut/lines/absx
add wave -noupdate /DE1_SoC_testbench/dut/lines/absy
add wave -noupdate /DE1_SoC_testbench/dut/lines/cleaning
add wave -noupdate /DE1_SoC_testbench/dut/lines/clk
add wave -noupdate /DE1_SoC_testbench/dut/lines/count
add wave -noupdate /DE1_SoC_testbench/dut/lines/cx
add wave -noupdate /DE1_SoC_testbench/dut/lines/cy
add wave -noupdate /DE1_SoC_testbench/dut/lines/delta_x
add wave -noupdate /DE1_SoC_testbench/dut/lines/delta_y
add wave -noupdate /DE1_SoC_testbench/dut/lines/error
add wave -noupdate /DE1_SoC_testbench/dut/lines/is_steep
add wave -noupdate /DE1_SoC_testbench/dut/lines/ns
add wave -noupdate /DE1_SoC_testbench/dut/lines/ps
add wave -noupdate /DE1_SoC_testbench/dut/lines/r2l
add wave -noupdate /DE1_SoC_testbench/dut/lines/reset
add wave -noupdate /DE1_SoC_testbench/dut/lines/rx
add wave -noupdate /DE1_SoC_testbench/dut/lines/ry
add wave -noupdate /DE1_SoC_testbench/dut/lines/tempx0
add wave -noupdate /DE1_SoC_testbench/dut/lines/tempx1
add wave -noupdate /DE1_SoC_testbench/dut/lines/tempy0
add wave -noupdate /DE1_SoC_testbench/dut/lines/tempy1
add wave -noupdate /DE1_SoC_testbench/dut/lines/x
add wave -noupdate /DE1_SoC_testbench/dut/lines/x0
add wave -noupdate /DE1_SoC_testbench/dut/lines/x1
add wave -noupdate /DE1_SoC_testbench/dut/lines/xil
add wave -noupdate /DE1_SoC_testbench/dut/lines/y
add wave -noupdate /DE1_SoC_testbench/dut/lines/y0
add wave -noupdate /DE1_SoC_testbench/dut/lines/y1
add wave -noupdate /DE1_SoC_testbench/dut/lines/y_step
add wave -noupdate /DE1_SoC_testbench/dut/lines/yil
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {287 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 50
configure wave -gridperiod 100
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {1 ns}
