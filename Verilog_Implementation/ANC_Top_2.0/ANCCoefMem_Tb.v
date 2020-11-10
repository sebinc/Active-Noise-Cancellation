`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:48:09 07/22/2018
// Design Name:   ANCCoefMem_V
// Module Name:   X:/0_xlinx_ISE/ANC_Top_2.0/ANCCoefMem_Tb.v
// Project Name:  ANC_Top_2.0
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ANCCoefMem_V
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ANCCoefMem_Tb;

	// Inputs
	reg FilterEN;
	reg Clk_100M;
	reg Reset;
	reg [10:0] WzIn;

	// Outputs
	wire [10:0] WzOut;
	wire FiltComplete;

	// Instantiate the Unit Under Test (UUT)
	ANCCoefMem_V uut (
		.FilterEN(FilterEN), 
		.Clk_100M(Clk_100M), 
		.Reset(Reset), 
		.WzIn(WzIn), 
		.WzOut(WzOut), 
		.FiltComplete(FiltComplete)
	);

	initial begin
		// Initialize Inputs
		FilterEN = 0;
		Clk_100M = 0;
		Reset = 0;
		WzIn = 0;

		// Wait 100 ns for global reset to finish
		#100;
        Reset = 1;
			 #300;
			 Reset = 0;
			 #400;
			 FilterEN =1;
			 
			 repeat(10)
			 begin
			 WzIn = 100;
			 #200;
			 end
			 repeat(100)
			 begin
			 WzIn = 10;
			 #200;
			 end
			 WzIn = 10;
		// Add stimulus here

	end
	
	always 
	begin
	#50;
	Clk_100M = ~Clk_100M;
	end
      
endmodule

