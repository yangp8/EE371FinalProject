
module line_drawerbackup(
	input logic clk, reset,clean,
	
	// x and y coordinates for the start and end points of the line
	input logic [9:0]	x0, x1, 
	input logic [8:0] y0, y1,

	//outputs cooresponding to the coordinate pair (x, y)
	output logic [9:0] x,
	output logic [8:0] y 
	);
	
	/*
	 * You'll need to create some registers to keep track of things
	 * such as error and direction
	 * Example: */
	logic signed [11:0] error;
	logic is_steep, r2l, cleaning;
	logic [9:0] absy, absx, tempx0, tempx1, tempy0, tempy1, xil, yil, cx, cy, rx, ry; 
	assign absy = ((y1-y0)>0) ? (y1-y0) : (y0-y1);
	assign absx = ((x1-x0)>0) ? (x1-x0) : (x0-x1);
	assign r2l = x0 >x1;
	assign is_steep = (absy > absx);
	always_comb begin
		if(is_steep) begin
			/*x0 <= {1'b0,y0};
			y0 <= x0[8:0];
			x1 <= y1;
			y1 <= x1[8:0];*/
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
	
   logic [9:0] delta_x, delta_y, y_step;
	assign delta_x = tempx1 - tempx0;
	assign delta_y = (tempy1-tempy0)>0 ? (tempy1-tempy0) : (tempy0-tempy1);
	assign y_step = (tempy0<tempy1) ? 1 : -1;
	
	
	always_ff @(posedge clk) begin
		if(cleaning|reset) begin
			yil <= tempy0[8:0];
			xil <= tempx0;
			error <= -(delta_x/2);
		end 
		else if(xil < tempx1) begin		
			if(error>0)begin
				yil<= yil+y_step;
				error <= error +delta_y-delta_x;
			end else error <= error + delta_y;
			xil <= xil+1;
		end else begin

		if(is_steep) begin
				rx <= yil;
				ry <= xil[8:0];
			end else begin
				rx <= xil;
				ry <= yil;
			end
	end
	//cleaning screen
	enum{normal,cleans } ns, ps;
	logic [31:0] count;
	always_comb begin
		case(ps)
			
			normal: begin if(clean) ns = cleans; else ns = ps; cleaning = 0; end
			cleans: begin if(count==307200) ns = normal; else ns = ps; cleaning = 1; end
		endcase
	end
	
	always_ff @(posedge clk) begin
		if(clean) begin
			cx <= 0;
			cy <= 0;
			count <= 0;
		end
		else if( cx <= 640 && cy <= 480 ) begin
			cx <= cx+1;
			if(cx == 640) begin cy <= cy+1; cx <= 0;end
		end
		count <= cx * cy;
	end
	
	assign x = cleaning ? cx : rx;
	assign y = cleaning ? cy : ry;
endmodule

module line_drawerbackup_testbench ();

	parameter ClockDelay = 1000;


	logic reset, clk, clean;
	 logic [9:0]	x0, x1;
	 logic [8:0] y0, y1;

	 logic [9:0] x;
	 logic [8:0] y;
	 integer i;
	line_drawerbackup w21 (.*);
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