onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /snake_testbench/w21/a
add wave -noupdate /snake_testbench/w21/b
add wave -noupdate /snake_testbench/w21/cleared
add wave -noupdate /snake_testbench/w21/direction
add wave -noupdate /snake_testbench/w21/draw_clk
add wave -noupdate /snake_testbench/w21/i
add wave -noupdate /snake_testbench/w21/j
add wave -noupdate /snake_testbench/w21/length
add wave -noupdate /snake_testbench/w21/reset
add wave -noupdate -radix decimal /snake_testbench/w21/rx
add wave -noupdate -radix decimal /snake_testbench/w21/ry
add wave -noupdate -radix decimal /snake_testbench/w21/score
add wave -noupdate /snake_testbench/w21/square_array
add wave -noupdate /snake_testbench/w21/updatex
add wave -noupdate /snake_testbench/w21/updatey
add wave -noupdate /snake_testbench/w21/write_done
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {349 ps} 0}
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
WaveRestoreZoom {0 ps} {2 ns}
