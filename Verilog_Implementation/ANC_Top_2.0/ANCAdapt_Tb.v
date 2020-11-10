`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:11:03 07/22/2018
// Design Name:   ANCAdapt_V
// Module Name:   X:/0_xlinx_ISE/ANC_Top_2.0/ANCAdapt_Tb.v
// Project Name:  ANC_Top_2.0
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ANCAdapt_V
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ANCAdapt_Tb;

	// Inputs
	reg FilterEN;
	reg Clk_100M;
	reg [10:0] Err;
	reg Reset;
	reg [10:0] SigIn;
	reg [10:0] WzIn;

	// Outputs
	wire [10:0] WzOut;

	// Instantiate the Unit Under Test (UUT)
	ANCAdapt_V uut (
		.FilterEN(FilterEN), 
		.Clk_100M(Clk_100M), 
		.Err(Err), 
		.Reset(Reset), 
		.SigIn(SigIn), 
		.WzIn(WzIn), 
		.WzOut(WzOut)
	);

	initial begin
		// Initialize Inputs
		FilterEN = 0;
		Clk_100M = 0;
		Err = 10;
		Reset = 0;
		SigIn = 20;
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
        
		// Add stimulus here

	end
      
		always 
	begin
	#50;
	Clk_100M = ~Clk_100M;
	end
endmodule

