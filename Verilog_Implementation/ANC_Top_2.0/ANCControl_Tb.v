`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:31:29 07/27/2018
// Design Name:   ANCControl_V
// Module Name:   X:/0_xlinx_ISE/ANC_Top_2.0/ANCControl_Tb.v
// Project Name:  ANC_Top_2.0
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ANCControl_V
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ANCControl_Tb;

	// Inputs
	reg Clk_100M;
	reg SSPIF;
	reg Reset;

	// Outputs
	wire RAMDataEN;
	wire FilterEN;

	// Instantiate the Unit Under Test (UUT)
	ANCControl_V uut(
    .Clk_100M(Clk_100M), 
    .SSPIF(SSPIF), 
    .RAMDataEN(RAMDataEN), 
    .FilterEN(FilterEN), 
    .Reset(Reset)
    );

	initial begin
		// Initialize Inputs
		Clk_100M = 0;
		SSPIF = 0;
		Reset = 0;

		// Wait 100 ns for global reset to finish
		#220;
		Reset =1;
		#200;
		Reset=0;
		#500;
		SSPIF =1;
		
		#500;
		SSPIF =0;
      
		#60000;
		SSPIF =1;
		#1000;
		SSPIF =0;
		
		// Add stimulus here

	end
      
		
   always 
	begin
	#50;
	Clk_100M = ~Clk_100M;
	end
	
endmodule

