
module line_drawer(
	input logic clk, draw_clk, reset, nextstate, cleared,
	
	// x and y coordinates for the start and end points of the line
	input logic [9:0]	x0, x1, 
	input logic [8:0] y0, y1,

	//outputs cooresponding to the coordinate pair (x, y)
	output logic [9:0] x,
	output logic [8:0] y,
	output logic write_done
	);
	
	/*
	 * You'll need to create some registers to keep track of things
	 * such as error and direction
	 * Example: */
	logic signed [11:0] error;
	logic is_steep, r2l;
	logic [9:0] absy, absx, tempx0, tempx1, tempy0, tempy1, xil, yil, testx, st;
	logic [8:0] testy;
	assign testy = y1-y0; assign testx = x1-x0; assign st = absx - absy;
	assign absy = (~testy[8]) ? (y1-y0) : (y0-y1);
	assign absx = (~testx[9]) ? (x1-x0) : (x0-x1);
	assign r2l = testx[9];
	assign is_steep = st[9];
	always_comb begin
		if(is_steep&&r2l) begin

			tempx0 = y0;
			tempy0 = x0;
			tempx1 = y1;
			tempy1 = x1;
		end else
		if(is_steep) begin

			tempx0 = y0;
			tempy0 = x0;
			tempx1 = y1;
			tempy1 = x1;
		end else if(r2l) begin
			/*x0 <= x1;
			x1 <= x0;
			y0 <= y1;
			y1 <= y0;*/
			tempx0 = x1;
			tempx1 = x0;
			tempy0 = y1;
			tempy1 = y0;
		end else begin
			tempx0 = x0;
			tempx1 = x1;
			tempy0 = y0;
			tempy1 = y1;
		end
	end
	
   logic [9:0] delta_x, delta_y, y_step, testdy;
	assign delta_x = tempx1 - tempx0; assign testdy = tempy1-tempy0;
	assign delta_y = (~testdy[9]) ? (tempy1-tempy0) : (tempy0-tempy1);
	assign y_step = (~testdy[9]) ? 1 : -1;
	
	
	always_ff @(posedge draw_clk) begin
		if(reset||nextstate) begin
			yil <= tempy0[8:0];
			xil <= tempx0;
			error <= -(delta_x/2);
			write_done <= 0;
		end 
		else if(xil	 < tempx1) begin
		//	write_done <= 0;
			
			if(error>0)begin
				yil<= yil+y_step;
				error <= error +delta_y-delta_x;
			end else error <= error + delta_y;
			xil <= xil+1;
		end else begin if(~cleared)write_done <= 1; else write_done <= 0; end
	
		if(is_steep) begin
				x <= yil;
				y <= xil[8:0];
			end else begin
				x <= xil;
				y <= yil;
			end
	end
	//assign write_done = xil>= tempx1;
	
endmodule

module line_drawer_testbench ();

	parameter ClockDelay = 1000;


	logic reset, clk, write_done, nextstate, draw_clk, cleared;
	 logic [9:0]	x0, x1;
	 logic [8:0] y0, y1;

	 logic [9:0] x;
	 logic [8:0] y;
	 integer i;
	line_drawer w21 (.*);
	// Force %t's to print in a nice format.
	initial $timeformat(-9, 2, " ns", 10);

	initial begin // Set up the clock
		clk <= 0;
		forever #(ClockDelay/2) clk <= ~clk;
	end

	initial begin
		reset <=1; x0 <= 10; y0 <= 10; x1 <= 240; y1<= 10;
		@(posedge clk); @(posedge clk);reset <= 0;
		@(posedge clk);
		for (i=0; i<500; i=i+1) begin
		
			@(posedge clk);
			
		end
	$stop;
	end
endmodule