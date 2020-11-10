`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   08:29:37 08/01/2018
// Design Name:   Greater_v
// Module Name:   X:/0_xlinx_ISE/ANC_Top_2.0/Greater_Tb.v
// Project Name:  ANC_Top_2.0
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Greater_v
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Greater_Tb;

	// Inputs
	reg [6:0] x;
	reg [6:0] y;

	// Outputs
	wire x_grtr_y;

	// Instantiate the Unit Under Test (UUT)
	Greater_v uut (
		.x(x), 
		.y(y), 
		.x_grtr_y(x_grtr_y)
	);

	initial begin
		// Initialize Inputs
		x = 12;
		y = 12;

		// Wait 100 ns for global reset to finish
		#100;
        x = 1;
		 #100;
        x = 13;
		 #100;
        x = 15;
		 #100;
        x = 0;
		// Add stimulus here

	end
      
endmodule

