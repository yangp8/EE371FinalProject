module printOut(
	input logic clk, draw_clk, reset,
   input logic [1:0] direction,
	output logic [9:0] x,
	output logic [8:0] y,
	output logic pixel_color
);
	logic [9:0] cx, rx;
	logic [8:0] cy, ry;
	logic write_done;
   logic [31:0]score;
	logic dead, cleared;
	assign score=5;
	
	assign dead=0;
	always_comb begin
		if(~write_done||dead) pixel_color = 1'b1;
		else pixel_color = 1'b0;
	end
	
	state cl (.clk, .draw_clk, .reset, .write_done, .x(cx), .y(cy), .cleared);
	snake blocks (.draw_clk, .reset, .cleared, .score, .direction,
				      .write_done, .rx, .ry,);

	
	assign x = (write_done) ? cx : rx;
	assign y = (write_done) ? cy : ry;
	
   
	
	

endmodule

/*module cyclestate(
	input logic [31:0]clk, draw_clk, cleanman,
	input logic reset,
	output logic [9:0] x, x0, x1,
	output logic [8:0] y, y0, y1,
	output logic pixel_color
);
	logic [9:0] cx, rx;
	logic [8:0] cy, ry;
	logic clean, cleared, write_done, nextstate;
	enum{s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11} ns, ps;
	always_comb begin
		case(ps)
			s0:	begin	
						x0 = 200;y0 = 10;x1 = 200;y1 = 200;
						if(~write_done&&~cleanman) begin
							pixel_color = 1'b1; clean = 0; end
						else begin pixel_color = 1'b0; clean = 1; end
						if(cleared&&~nextstate&&~cleanman) ns = s1; else ns = ps;
					end
			s1:	begin	
						x0 =295 ;y0 = 35;x1 = 200;y1 = 200;//x0=35, y0 =295, x1=200, y1=200
						if(~write_done) begin
							pixel_color = 1'b1; clean = 0; end
						else begin pixel_color = 1'b0; clean = 1; end
						if(cleared&&~nextstate) ns = s2; else ns = ps;
					end
			s2:	begin	
						x0 = 364;y0 = 105;x1 = 200;y1 = 200;
						if(~write_done) begin
							pixel_color = 1'b1; clean = 0; end
						else begin pixel_color = 1'b0; clean = 1; end
						if(cleared&&~nextstate) ns = s3; else ns = ps;
					end
			s3:	begin	
						x0 = 200;y0 = 200;x1 = 390;y1 = 200;
						if(~write_done) begin
							pixel_color = 1'b1; clean = 0; end
						else begin pixel_color = 1'b0; clean = 1; end
						if(cleared&&~nextstate) ns = s4; else ns = ps;
					end
			s4:	begin	
						x0 = 200;y0 = 200;x1 = 364;y1 = 295;
						if(~write_done) begin
							pixel_color = 1'b1; clean = 0; end
						else begin pixel_color = 1'b0; clean = 1; end
						if(cleared&&~nextstate) ns = s5; else ns = ps;
					end
			s5:	begin	
						x0 = 200;y0 = 200;x1 = 295;y1 = 364;
						if(~write_done) begin
							pixel_color = 1'b1; clean = 0; end
						else begin pixel_color = 1'b0; clean = 1; end
						if(cleared&&~nextstate) ns = s6; else ns = ps;
					end
			s6:	begin	
						x0 = 200;y0 = 200;x1 = 200;y1 = 390;
						if(~write_done) begin
							pixel_color = 1'b1; clean = 0; end
						else begin pixel_color = 1'b0; clean = 1; end
						if(cleared&&~nextstate) ns = s7; else ns = ps;
					end		
			s7:	begin	
						x0 = 200;y0 = 200;x1 = 105;y1 = 364;
						if(~write_done) begin
							pixel_color = 1'b1; clean = 0; end
						else begin pixel_color = 1'b0; clean = 1; end
						if(cleared&&~nextstate) ns = s8; else ns = ps;
					end
			s8:	begin	
						x0 = 200;y0 = 200;x1 = 35;y1 = 295;
						if(~write_done) begin
							pixel_color = 1'b1; clean = 0; end
						else begin pixel_color = 1'b0; clean = 1; end
						if(cleared&&~nextstate) ns = s9; else ns = ps;
					end
			s9:	begin	
						x0 = 200;y0 = 200;x1 = 10;y1 = 200;
						if(~write_done) begin
							pixel_color = 1'b1; clean = 0; end
						else begin pixel_color = 1'b0; clean = 1; end
						if(cleared&&~nextstate) ns = s10; else ns = ps;
					end
			s10:	begin	
						x0 = 35;y0 = 105;x1 = 200;y1 = 200;
						if(~write_done) begin
							pixel_color = 1'b1; clean = 0; end
						else begin pixel_color = 1'b0; clean = 1; end
						if(cleared&&~nextstate) ns = s11; else ns = ps;
					end
			s11:	begin	
						x0 = 105;y0 = 35;x1 = 200;y1 = 200;
						if(~write_done) begin
							pixel_color = 1'b1; clean = 0; end
						else begin pixel_color = 1'b0; clean = 1; end
						if(cleared&&~nextstate) ns = s0; else ns = ps;
					end

					endcase
	end
	
	state cl (.clk, .draw_clk, .reset, .write_done, .nextstate, .cleanman, .x(cx), .y(cy), .cleared);
	line_drawer lines (.clk, .draw_clk, .reset, .nextstate, .cleared,
				.x0, .y0, .x1, .y1, .x(rx), .y(ry), .write_done);
	assign x = (write_done||cleanman) ? cx : rx;
	assign y = (write_done||cleanman) ? cy : ry;
	
	always_ff @(posedge clk) begin
		if(reset||cleanman) begin
			ps<= s0;
			nextstate <= 0;
		end 
		else begin
	if( ps != ns ) nextstate <= 1;
			ps <= ns;
		if(ps==ns && ~write_done) nextstate <=0;
 		end
	end
endmodule*/
