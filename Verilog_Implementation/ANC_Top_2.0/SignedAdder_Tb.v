`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:21:43 07/29/2018
// Design Name:   SignedAdder
// Module Name:   X:/0_xlinx_ISE/ANC_Top_2.0/SignedAdder_Tb.v
// Project Name:  ANC_Top_2.0
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

module SignedAdder_Tb;

	// Inputs
	reg [20:0] a;
	reg [20:0] b;
	reg en;

	// Outputs
	wire [20:0] AddOut;
	wire [10:0] result;
	
	assign result = {AddOut[20], AddOut[9:0]};

	// Instantiate the Unit Under Test (UUT)
	SignedAdder uut (
		.a(a), 
		.b(b), 
		.AddOut(AddOut), 
		.en(en)
	);

	initial begin
		// Initialize Inputs
		a = 0;
		b = 0;
		en = 1;

		// Wait 100 ns for global reset to finish
		#100;
        a[20]   = 1'b 0;      // Sign
		  a[19:0] = 20'd 100;   // 100
		  b[20]   = 1'b 1;       // Sign
		  b[19:0] = 20'd 1999;    // -0
		  
		// Add stimulus here

	end
      
endmodule

