module foodGenerator(
	input logic clk, reset, write_done,
	output logic [9:0] foodx [8:0],
	output logic [8:0] foody [8:0]);
	
	logic [9:0] outx;
	logic [9:0] outy;
	genvar j;
	LFSR lfsrx(.Clock(write_down), .Reset(reset), .out(outx));
	LFSR lfsry(.Clock(write_down), .Reset(reset), .out(outy));

	generate
	for(j=0;j<9;j=j+1) begin:m
		assign foodx[j] = j%3 + outx;
		assign foody[j] = j/3 + outy[8:0];
	end
	endgenerate
	
endmodule
