`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:20:13 06/17/2018
// Design Name:   SignedAdder
// Module Name:   X:/0_xlinx_ISE/SignedAdder/SignedAdder_tb.v
// Project Name:  SignedAdder
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: SignedAdder
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module SignedAdder_tb;

	// Inputs
	reg [20:0] a;
	reg [20:0] b;

	// Outputs
	wire [20:0] AddOut;

	// Instantiate the Unit Under Test (UUT)
	SignedAdder uut (
		.a(a), 
		.b(b), 
		.AddOut(AddOut)
	);

	initial begin
		// Initialize Inputs
		a = 0;
		b = 0;

		// Wait 100 ns for global reset to finish
		#100;
        a = 21'd 100;    // 100c
		  b = 21'd 1048576;    // 1048576
		// Add stimulus here
		#100;
		a = 21'd 22;    // 22
		b = 21'd 20;    // 20
		#100;
		a = 21'd 1048598;    // -22
		b = 21'd 20;    // 20
		
		#100;
		a = 21'd 22;    //22
		b = 21'd 1048596;    // -20
		
		#200
        a = 21'd 1049026;    // -450
		  b = 21'd 1048810;    // -234
		// Add stimulus here
		#100;
		a = 21'd 450;    // 450
		b = 21'd 234;    // 234
		#100;
		a = 21'd 1049026;    // -450
		b = 21'd 234;    // 234
		
		#100;
		a = 21'd 450;    //450
		b = 21'd 1048810;    // -234
	end
      
endmodule

