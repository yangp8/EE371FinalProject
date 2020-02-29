//LFSP takes Clock and reset 
//generates thousands of numbers in one cycle and output numbers as random numbers.
module LFSR (Clock, Reset, out);

	input logic Clock, Reset;
	output logic [9:0] out;
	
	always_ff @(posedge Clock) begin
		if(Reset) out <= 10'b0000000000;
		else begin
		out[9] <= ~(out[0]^out[3]);
		out[8] <= out[9];
		out[7] <= out[8];
		out[6] <= out[7];
		out[5] <= out[6];
		out[4] <= out[5];
		out[3] <= out[4];
		out[2] <= out[3];
		out[1] <= out[2];
		out[0] <= out[1];
	end
	end

endmodule
