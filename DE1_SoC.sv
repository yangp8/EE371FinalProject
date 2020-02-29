`timescale 1 ns / 1 ps

module DE1_SoC (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW, CLOCK_50, 
	VGA_R, VGA_G, VGA_B, VGA_BLANK_N, VGA_CLK, VGA_HS, VGA_SYNC_N, VGA_VS, PS2_DAT, PS2_CLK);
	
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	input logic [3:0] KEY;
	input logic [9:0] SW;
   inout logic PS2_DAT, PS2_CLK;

	input CLOCK_50;
	output [7:0] VGA_R;
	output [7:0] VGA_G;
	output [7:0] VGA_B;
	output VGA_BLANK_N;
	output VGA_CLK;
	output VGA_HS;
	output VGA_SYNC_N;
	output VGA_VS;
	
	assign HEX0 = '1;
	assign HEX1 = '1;
	assign HEX2 = '1;
	assign HEX3 = '1;
	assign HEX4 = '1;
	assign HEX5 = '1;
//	assign LEDR = SW;
	assign cleanman = ~KEY[3];
	assign reset = ~KEY[2];
	//assign cleaning  = ~KEY[1];
	logic [9:0] x0, x1, x, cx, rx;
	logic [8:0] y0, y1, y, cy, ry;
   logic [1:0] direction;
	logic frame_start;
	logic pixel_color;
	logic clean, cleaning;
	logic [31:0] clk;
	parameter whichClock = 10;
   
   

   clock_divider cdivin (.clock(CLOCK_50), .divided_clocks(clk));
	VGA_framebuffer fb(.clk(CLOCK_50), .rst(reset), .x, .y,
				.pixel_color, .pixel_write(1'b1), .frame_start,
				.VGA_R, .VGA_G, .VGA_B, .VGA_CLK, .VGA_HS, .VGA_VS,
				.VGA_BLANK_N, .VGA_SYNC_N);
	

	printOut p1 (.clk(CLOCK_50), .draw_clk(clk[whichClock]), .reset, .direction, .x, .y, .pixel_color);
   
   keyboard_data keyboard (.clk(CLOCK_50), .PS2_DAT, .PS2_CLK, .data_out(direction), .LEDR);
	//score-2 is the point to show on hex
endmodule

module DE1_SoC_testbench();
	
	logic clk;
	 logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	 logic [9:0] LEDR;
	 logic [3:0] KEY;
	 logic [9:0] SW;

	logic [7:0] VGA_R;
	logic [7:0] VGA_G;
	logic [7:0] VGA_B;
	logic VGA_BLANK_N;
	logic VGA_CLK;
	logic VGA_HS;
	logic VGA_SYNC_N;
	logic VGA_VS;
	integer i;
	DE1_SoC dut (.HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .KEY, .LEDR, .SW, .CLOCK_50(clk), 
	.VGA_R, .VGA_G, .VGA_B, .VGA_BLANK_N, .VGA_CLK, .VGA_HS, .VGA_SYNC_N, .VGA_VS);
	
	parameter CLK_Period = 5;
	
	initial begin
		clk <= 1'b0;
		forever #(CLK_Period/2) clk <= ~clk;
	end
	initial begin
		KEY[2] <= 0;SW <= 10'b0010000000; KEY[1] <= 1; KEY[3] <= 1;@(posedge clk);@(posedge clk);
		@(posedge clk); KEY[2] <= 1; @(posedge clk); @(posedge clk);
		for (i=0; i<300; i=i+1) begin
			@(posedge clk);
		end
		KEY[3] <= 0; SW <= 10'b0000000000;@(posedge clk); 
				for (i=0; i<1000; i=i+1) begin
		
			@(posedge clk);
		end
	$stop;
	end
	
endmodule 
