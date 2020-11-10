`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:31:47 06/15/2018
// Design Name:   PWM_v
// Module Name:   X:/0_xlinx_ISE/PWM_v/PWM_tb.v
// Project Name:  PWM_v
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: PWM_v
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module PWM_tb;

	// Inputs
	reg Clk_pwm;
	reg [9:0] SigVec;

	// Outputs
	wire PwmSig;

	// Instantiate the Unit Under Test (UUT)
	PWM_v uut (
		.Clk_pwm(Clk_pwm), 
		.PwmSig(PwmSig), 
		.SigVec(SigVec)
	);

	initial begin
		// Initialize Inputs
		Clk_pwm = 0;
		SigVec = 10'b 1000000000;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
	
	always begin
		#5;
		Clk_pwm = ~Clk_pwm;
		end
      
endmodule

