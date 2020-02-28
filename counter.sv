//a counter that loops from 0 to 31
//go through whole read address based on clock
module counter (start, clk, reset, write_done, cleared);
	output logic start;
	input logic clk, reset, write_done, cleared;
	logic [10:0] count;
	


	
	always_ff @(posedge clk) begin
		if(reset||~write_done||cleared) begin count <= 0; start <= 0; end
		else if (count == 10'b1111111) begin count <= count; start <= 1; end
		else begin count <= count + 1; start <= 0; end
	end
endmodule


