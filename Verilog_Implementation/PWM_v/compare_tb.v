`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:51:27 06/15/2018
// Design Name:   Signal_compare
// Module Name:   X:/0_xlinx_ISE/PWM_v/compare_tb.v
// Project Name:  PWM_v
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Signal_compare
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module compare_tb;

	// Inputs
	reg [10:0] R;
	reg [10:0] C;

	// Outputs
	wire Result;

	// Instantiate the Unit Under Test (UUT)
	Signal_compare uut (
		.R(R), 
		.C(C), 
		.Result(Result)
	);

	initial begin
		// Initialize Inputs
		R = 0;
		C = 0;

		// Wait 100 ns for global reset to finish
		#100;
        R = 12;
		  C =13;
		  #100;
		  R =14;
		  C =14;
		// Add stimulus here

	end
      
endmodule

