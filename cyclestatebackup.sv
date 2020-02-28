`timescale 1 ns / 1 ps

module cyclestatebackup(
	input logic /*[31:0]*/clk, 
	input logic reset,
	output logic [9:0] x, x0, x1,
	output logic [8:0] y, y0, y1,
	output logic pixel_color
);
	logic [9:0] cx, rx;
	logic [8:0] cy, ry;
	logic clean, cleared, write_done, start;
	enum{s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11} ns, ps;
	logic [31:0] count;
	always_comb begin
		case(ps)
			s0:	begin	
						x0 = 200;y0 = 10;x1 = 200;y1 = 200;
						if(~write_done) begin
							pixel_color = 1'b1; clean = 0; end
						else begin pixel_color = 1'b0; clean = 1; end
						if(cleared) ns = s1; else ns = ps;
					end
			s1:	begin	
						x0 = 295;y0 = 35;x1 = 200;y1 = 200;
						if(~write_done) begin
							pixel_color = 1'b1; clean = 0; end
						else begin pixel_color = 1'b0; clean = 1; end
						if(cleared) ns = s2; else ns = ps;
					end
			s2:	begin	
						x0 = 364;y0 = 105;x1 = 200;y1 = 200;
						if(~write_done) begin
							pixel_color = 1'b1; clean = 0; end
						else begin pixel_color = 1'b0; clean = 1; end
						if(cleared) ns = s3; else ns = ps;
					end
			s3:	begin	
						x0 = 200;y0 = 200;x1 = 390;y1 = 200;
						if(~write_done) begin
							pixel_color = 1'b1; clean = 0; end
						else begin pixel_color = 1'b0; clean = 1; end
						if(cleared) ns = s4; else ns = ps;
					end
			s4:	begin	
						x0 = 200;y0 = 200;x1 = 364;y1 = 295;
						if(~write_done) begin
							pixel_color = 1'b1; clean = 0; end
						else begin pixel_color = 1'b0; clean = 1; end
						if(cleared) ns = s5; else ns = ps;
					end
			s5:	begin	
						x0 = 200;y0 = 200;x1 = 295;y1 = 364;
						if(~write_done) begin
							pixel_color = 1'b1; clean = 0; end
						else begin pixel_color = 1'b0; clean = 1; end
						if(cleared) ns = s6; else ns = ps;
					end
			s6:	begin	
						x0 = 200;y0 = 200;x1 = 200;y1 = 390;
						if(~write_done) begin
							pixel_color = 1'b1; clean = 0; end
						else begin pixel_color = 1'b0; clean = 1; end
						if(cleared) ns = s7; else ns = ps;
					end		
			s7:	begin	
						x0 = 200;y0 = 200;x1 = 105;y1 = 364;
						if(~write_done) begin
							pixel_color = 1'b1; clean = 0; end
						else begin pixel_color = 1'b0; clean = 1; end
						if(cleared) ns = s8; else ns = ps;
					end
			s8:	begin	
						x0 = 200;y0 = 200;x1 = 35;y1 = 295;
						if(~write_done) begin
							pixel_color = 1'b1; clean = 0; end
						else begin pixel_color = 1'b0; clean = 1; end
						if(cleared) ns = s9; else ns = ps;
					end
			s9:	begin	
						x0 = 200;y0 = 200;x1 = 10;y1 = 200;
						if(~write_done) begin
							pixel_color = 1'b1; clean = 0; end
						else begin pixel_color = 1'b0; clean = 1; end
						if(cleared) ns = s10; else ns = ps;
					end
			s10:	begin	
						x0 = 35;y0 = 105;x1 = 200;y1 = 200;
						if(~write_done) begin
							pixel_color = 1'b1; clean = 0; end
						else begin pixel_color = 1'b0; clean = 1; end
						if(cleared) ns = s11; else ns = ps;
					end
			s11:	begin	
						x0 = 105;y0 = 35;x1 = 200;y1 = 200;
						if(~write_done) begin
							pixel_color = 1'b1; clean = 0; end
						else begin pixel_color = 1'b0; clean = 1; end
						if(cleared) ns = s0; else ns = ps;
					end

					endcase
	end
	
	state cl (.clk/*(clk[0])*/, .reset(~write_done), .x(cx), .y(cy), .cleared, .start);
	counter cr (.start, .clk, .reset, .write_done, .cleared);
	line_drawer lines (.clk/*(clk[20])*/, .reset, .cleared,
				.x0, .y0, .x1, .y1, .x(rx), .y(ry), .write_done);

	assign x = (write_done&&start) ? cx : rx;
	assign y = (write_done&&start) ? cy : ry;
	
	always_ff @(posedge clk) begin
		if(reset) begin
			ps<= s0;
		end 
		else ps <= ns;
	end
endmodule

module state(
	input logic clk, reset,
	output logic [9:0] x,
	output logic [8:0] y,
	output logic cleared,
	input logic start
);
	enum{normal, cleans} ns, ps;
	logic [31:0] count;
	always_comb begin
		case(ps)
			
			normal: begin if(start&&~reset) ns = cleans; else ns = ps;  end
			cleans: begin if(cleared) ns = normal; else ns = ps;  end
		endcase
	end
	
	always_ff @(posedge clk) begin
		if(reset||cleared||~start) begin
			x <= 0;
			y <= 0;
			ps <= normal;
			cleared <= 0;
		end 
		else	
		if( x <= 64 && y <= 48 ) begin
			x <= x+1;
			if(x == 64) begin y <= y+1; x <= 0;end
		end else begin x<= 0; y<= 0; cleared <= 1; end
	   ps <= ns;
	end
endmodule


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
