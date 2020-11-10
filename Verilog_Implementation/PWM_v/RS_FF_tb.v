`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:54:06 06/15/2018
// Design Name:   RS_FF
// Module Name:   X:/0_xlinx_ISE/PWM_v/RS_FF_tb.v
// Project Name:  PWM_v
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: RS_FF
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module RS_FF_tb;

	// Inputs
	reg R;
	reg S;
	reg Clk;

	// Outputs
	wire Q;

	// Instantiate the Unit Under Test (UUT)
	RS_FF uut (
		.R(R), 
		.S(S), 
		.Clk(Clk), 
		.Q(Q)
	);

	initial begin
		// Initialize Inputs
		R = 0;
		S = 0;
		Clk = 0;

		// Wait 100 ns for global reset to finish
		#100;
        S =1;
		  R =0;
		  Clk =1;
		  #50;
		  Clk =0;
		  #100;
		  S =0;
		  Clk =1;
		// Add stimulus here

	end
      
endmodule

