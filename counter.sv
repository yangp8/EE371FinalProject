//a counter that loops from 0 to 31
//go through whole read address based on clock
module counter (
	input logic clk, reset, write_done,
	output logic waited);
	
	logic [31:0] count;
	
	enum{normal, waiting} ns, ps;
	logic [31:0] count;
	always_comb begin
		case(ps)
			
			normal: begin if(write_done) ns = waiting; else ns = ps;  end
			waiting: begin if(waited) ns = normal; else ns = ps;  end
		endcase
	end

	always_ff @(posedge clk) begin
		if(reset||~write_done) begin
			ps <= normal;
			count <= 0;
			waited <= 0;
		end 
		else	
		if( count <= 1000000 ) begin
			count <= count + 1;
		end else   waited <= 1; 
		ps <= ns;
	end
	

endmodule


