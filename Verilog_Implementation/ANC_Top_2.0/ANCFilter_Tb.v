`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   08:29:50 07/25/2018
// Design Name:   ANCFilter_V
// Module Name:   X:/0_xlinx_ISE/ANC_Top_2.0/ANCFilter_Tb.v
// Project Name:  ANC_Top_2.0
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ANCFilter_V
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ANCFilter_Tb;

	// Inputs
	reg FilterEN;
	reg Clk_100M;
	reg Reset;
	reg [10:0] SigIn;
	reg [10:0] Wz;
	reg Synch;

	// Outputs
	wire [10:0] FiltOut;

	// Instantiate the Unit Under Test (UUT)
	ANCFilter_V uut (
		.FilterEN(FilterEN), 
		.Clk_100M(Clk_100M), 
		.Reset(Reset), 
		.SigIn(SigIn), 
		.Wz(Wz), 
		.Synch(Synch), 
		.FiltOut(FiltOut)
	);

	initial begin
		// Initialize Inputs
		FilterEN = 0;
		Clk_100M = 0;
		Reset = 0;
		SigIn = 0;
		Wz = 0;
		Synch = 0;

		// Wait 100 ns for global reset to finish
		#100;
		Reset =1;
		#200;
		Reset =0;
		#100;
		FilterEN =1;
		#100;
		FilterEN =0;
		#100;
		FilterEN =1;
      SigIn = 10;
      Wz= 20;
		repeat(120)
		begin
		  #200;
		end
		FilterEN =0;
		#100;
		FilterEN =1;
		// Add stimulus here

	end
      
		
	always 
	begin
	#50;
	Clk_100M = ~Clk_100M;
	end
	
	always 
	begin
	#100;
	Synch = ~Synch;
	end
endmodule

