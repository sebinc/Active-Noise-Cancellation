`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:09:16 06/17/2018
// Design Name:   Multiplier
// Module Name:   X:/0_xlinx_ISE/Multiplier/Multiplier_tb.v
// Project Name:  Multiplier
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Multiplier
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Multiplier_tb;

	// Inputs
	reg [9:0] a;
	reg [9:0] b;

	// Outputs
	wire [19:0] MulOut;

	// Instantiate the Unit Under Test (UUT)
	Multiplier uut (
		.a(a), 
		.b(b), 
		.MulOut(MulOut)
	);

	initial begin
		// Initialize Inputs
		a = 0;
		b = 0;

		// Wait 100 ns for global reset to finish
		#100;
      
		a = 10'd 20;
		b =10'd 23;
		// Add stimulus here

	end
      
endmodule

