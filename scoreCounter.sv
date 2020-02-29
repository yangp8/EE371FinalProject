module scoreCounter(
	input logic clk, reset, 
	input logic [9:0] headx,
	input logic [8:0] heady,
	input logic [9:0] foodx [8:0],
	input logic [8:0] foody [8:0],
	output logic [3:0] score);
	
	integer i;
	logic eaten;
	always_ff @(posedge clk) begin
		if(reset) score <= 2;
		else begin
			for(i=0;i<9;i=i+1) begin
				if(foodx[i]==headx&&foody[i]==heady)
					score <= score + 1;
			end
			
		end
	end
endmodule
//if(eaten) score <= score + 1;