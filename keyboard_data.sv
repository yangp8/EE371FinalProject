
module keyboard_data(clk, PS2_DAT, PS2_CLK, data_out, LEDR);
   input logic clk;
   input logic PS2_DAT, PS2_CLK;
   output logic [1:0] data_out;
   output logic [9:0] LEDR; 

   // keyboard logic
   logic reset;
	logic valid;
	logic makeBreak;
	logic [7:0] outCode;

	// Show signals on LEDRs so we can see what is happening.
	assign LEDR = {valid, makeBreak, outCode};
	
	keyboard_press_driver keytest(
		.CLOCK_50(clk), 
		.valid(valid), 
		.makeBreak(makeBreak),
		.outCode(outCode),
		.PS2_DAT(PS2_DAT), 
		.PS2_CLK(PS2_CLK), 
		.reset(1'b0)
   );
   
   always_comb begin
      case(val)
         8'h1D: data_out = 2'b00;
         
         8'h1C: data_out = 2'b11;
         
         8'h1B: data_out = 2'b10;
        
         8'h23: data_out = 2'b01;
         
         default: data_out = 2'b01;
      
      endcase
   end

   logic [7:0] val;
   
   always_ff @(posedge clk) begin
      if ((val != outCode) && ((outCode == 8'h1D) || (outCode == 8'h1C) || (outCode == 8'h1B) || (outCode == 8'h23)))
         val <= outCode;
   
   end


endmodule

module keyboard_data_testbench();
   logic clk;
   logic [9:0] LEDR; 
   logic PS2_DAT, PS2_CLK;
   logic [7:0] outCode;
   logic [1:0] data_out;

   keyboard_data dut (.*);
	
	parameter CLK_Period = 100;
	
	initial begin
		clk <= 1'b0;
		forever #(CLK_Period/2) clk <= ~clk;
	end
   
   initial begin
      outCode <= 8'h1D;       @(posedge clk)
      
      for (integer i = 0; i < 10; i++)
         @(posedge clk);
         
      outCode <= 8'h1B;       @(posedge clk)
   
      $stop;
   end

endmodule
