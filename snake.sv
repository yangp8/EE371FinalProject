module snake #(parameter length=15)(
	input logic draw_clk, reset, cleared, 
	input logic [31:0]score, 
	input logic [1:0] direction,
	output logic write_done, 
	output logic [9:0]rx, output logic [8:0]ry);

	//logic signed [length:0] reg_x[9:0];
	//logic signed [length:0] reg_y[8:0];
	integer i, j, a, b;

	logic signed [9:0] updatex;
	logic signed [8:0] updatey;
	
	typedef struct{
		logic signed  [9:0]square_x[99:0];
		logic signed  [8:0]square_y[99:0];
	}square;
	
	 square  square_array[length:0];

	always_comb begin
		case(direction)
			2'b00: begin updatey=-10; updatex=0; end
			2'b01: begin updatey=0; updatex=10; end
			2'b10: begin updatey=10; updatex=0; end
			2'b11: begin updatey=0; updatex=-10;end
		endcase
	
	end
	

	always_ff @(posedge write_done,posedge reset) begin
		if(reset) begin
			for(i =0; i<score;i=i+1) begin
				for(j=0;j<100;j=j+1) begin
					square_array[i].square_x[j] <= j%10;
					square_array[i].square_y[j] <= j/10;
				end
			end
		end
		else begin
			//reg_x[0] <= reg_x[0]+updatex;
			//reg_y[0] <= reg_y[0]+updatey;
			for(j=0;j<100;j=j+1) begin
				square_array[0].square_x[j] <= square_array[0].square_x[j]+updatex;
				square_array[0].square_y[j] <= square_array[0].square_y[j]+updatey;
			end
			for(i=1; i<score;i=i+1) begin
				//reg_x[i] <= reg_x[i-1];
				//reg_y[i] <= reg_y[i-1];
				for(j=0;j<100;j=j+1) begin
					square_array[i].square_x[j] <= square_array[i-1].square_x[j];
					square_array[i].square_y[j] <= square_array[i-1].square_y[j];
				end
			end
		end
	
	end
	
	
	always_ff @(posedge draw_clk) begin
		if(reset||cleared) begin
			if(a>=score||reset)a <= 0;
			if(b>=99||reset)b <= 0;
			write_done <= 0;
	
		end 
		else if(a<score) begin
				rx <= square_array[a].square_x[b];
				ry <= square_array[a].square_y[b];
				
			if(b<99) begin	
				b <= b+1;
			end else begin
				a <= a+1;
				b <= 0;
			end
		end 
		else write_done <= 1;
	end
	
endmodule


module snake_testbench ();

	parameter ClockDelay = 50;


	 logic draw_clk, reset, cleared;
	 logic [31:0] score;
	 logic [1:0] direction;
	 logic write_done;
	 logic [9:0]rx;  logic [8:0]ry;
	 integer i;
	 snake w21 (.*);
	// Force %t's to print in a nice format.
	initial $timeformat(-9, 2, " ns", 10);

	initial begin // Set up the clock
		draw_clk <= 0;
		forever #(ClockDelay/2) draw_clk <= ~draw_clk;
	end

	initial begin
		reset <=1; score <= 5; direction <= 2'b01; cleared <= 0;
		@(posedge draw_clk); reset <= 0;
		for (i=0; i<700; i=i+1) begin
		
			@(posedge draw_clk);
			
		end
		cleared <= 1;// score <= 6;
		@(posedge draw_clk);cleared <= 0;
		for (i=0; i<700; i=i+1) begin
		
			@(posedge draw_clk);
			
		end
				cleared <= 1; score <= 8;
		@(posedge draw_clk);cleared <= 0;
		for (i=0; i<700; i=i+1) begin
		
			@(posedge draw_clk);
			
		end
	$stop;
	end
endmodule

	