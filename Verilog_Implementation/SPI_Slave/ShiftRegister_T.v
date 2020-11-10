`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:01:03 06/10/2018
// Design Name:   shift_register_v
// Module Name:   X:/0_xlinx_ISE/SPI_Slave/ShiftRegister_T.v
// Project Name:  SPI_Slave
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: shift_register_v
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ShiftRegister_T;

	// Inputs
	reg Clk;
	reg Data_In;
	reg SS;
	
	// Outputs
	wire Data_Out;
	wire [0:7] ByteOut;
	wire SSPIF;

	// Instantiate the Unit Under Test (UUT)
	shift_register_v uut (
		.Clk(Clk),
		.SSPIF(SSPIF),
		.Data_In(Data_In), 
		.SS(SS),
		.Data_Out(Data_Out), 
		.ByteOut(ByteOut)
	);

	initial begin
		// Initialize Inputs
		Clk = 0;
		Data_In = 0;
		SS =1;
		// Wait 100 ns for global reset to finish
		#100;
		#50;
		Clk = 1;
		Data_In = 1;
		#50;
		Clk = 0;
		
		#50;
		Clk = 1;
		Data_In = 0;
		#50;
		Clk = 0;
		
		#50;
		Clk = 1;
		Data_In = 0;
		#50;
		Clk = 0;
		
		#50;
		Clk = 1;
		Data_In = 0;
		#50;
		Clk = 0;
		
		#50;
		Clk = 1;
		Data_In = 0;
		#50;
		Clk = 0;
		
		#50;
		Clk = 1;
		Data_In = 0;
		#50;
		Clk = 0;
		
		#50;
		Clk = 1;
		Data_In = 0;
		#50;
		Clk = 0;
		
		#50;
		Clk = 1;
		Data_In = 0;
		#50;
		Clk = 0;
				#50;
		Clk = 1;
		Data_In = 0;
		#50;
		Clk = 0;

		// Add stimulus here

	end
	


      
endmodule

