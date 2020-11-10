`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:42:41 06/23/2018
// Design Name:   ram_top
// Module Name:   X:/0_xlinx_ISE/BlockRam/Ram_test.v
// Project Name:  BlockRam
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ram_top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Ram_test;

	// Inputs
	reg resetAdd;
	reg clk_100M;
	reg [15:0] dina;
	reg wea;

	// Outputs
	wire [15:0] douta;

	// Instantiate the Unit Under Test (UUT)
	ram_top uut (
		.resetAdd(resetAdd), 
		.clk_100M(clk_100M), 
		.dina(dina), 
		.wea(wea), 
		.douta(douta)
	);

	initial begin
		// Initialize Inputs
		resetAdd = 0;
		clk_100M = 0;
		dina = 0;
		wea = 1;

		// Wait 100 ns for global reset to finish
		#50;
        resetAdd = 1;
		#200;
		   resetAdd =0;
			dina = 2;
			#100;
			dina = 3;
			#100;
			dina = 4;
			#100;
			dina = 5;
			#100;
			dina = 6;
			#100;
			dina = 7;
			#100;
			dina = 8;
			#100;
			dina = 9;
			#100;
			wea = 0;
			resetAdd =1;
			#200;
			resetAdd =0;
			
		// Add stimulus here

	end
	
	always begin
		#50;
		clk_100M = ~clk_100M;
	end
      
endmodule

