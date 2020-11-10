`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:57:45 07/26/2018
// Design Name:   ANCSaturation_V
// Module Name:   X:/0_xlinx_ISE/ANC_Top_2.0/ANCSaturation_Tb.v
// Project Name:  ANC_Top_2.0
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ANCSaturation_V
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ANCSaturation_Tb;

	// Inputs
	reg Clk_100M;
	reg [10:0] FiltIn;
	reg [10:0] MicIn;
	reg FiltComplete;

	// Outputs
	wire [10:0] Err;
	wire [10:0] ANCAudioOut;

	// Instantiate the Unit Under Test (UUT)
	ANCSaturation_V uut (
		.Clk_100M(Clk_100M), 
		.Err(Err), 
		.FiltIn(FiltIn), 
		.MicIn(MicIn), 
		.FiltComplete(FiltComplete), 
		.ANCAudioOut(ANCAudioOut)
	);

	initial begin
		// Initialize Inputs
		Clk_100M = 0;
		FiltIn = 2000;
		MicIn = 9;
		FiltComplete = 0;

		// Wait 100 ns for global reset to finish
		#1000;
        FiltComplete = 1;
		// Add stimulus here

	end
	
	always 
	begin
	#50;
	Clk_100M = ~Clk_100M;
	end
      
endmodule

