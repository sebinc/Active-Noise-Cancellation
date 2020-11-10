`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:15:46 06/11/2018
// Design Name:   SPI_v
// Module Name:   X:/0_xlinx_ISE/ANC_Top/SPI_Tb.v
// Project Name:  ANC_Top
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: SPI_v
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module SPI_Tb;

	// Inputs
	reg SCK;
	reg SDI;
	reg Reset;

	// Outputs
	wire SDO;
	wire [10:0] DataOut;
	wire SSPIF;

	// Instantiate the Unit Under Test (UUT)
	SPI_v uut (
		.SCK(SCK), 
		.SDI(SDI), 
		.SDO(SDO),
		.Reset(Reset),
		.DataOut(DataOut), 
		.SSPIF(SSPIF)
	);

	initial begin
		// Initialize Inputs
		SCK = 1;
		SDI = 0;
		Reset =0;
		// Wait 100 ns for global reset to finish
		#200;
		#50;
		SCK = 1;
		SDI = 1;
		#50;
		SCK = 0;
		
		#50;
		SCK = 1;
		SDI = 0;
		#50;
		SCK = 0;
		
		#50;
		SCK= 1;
		SDI = 0;
		#50;
		SCK = 0;
		
		#50;
		SCK = 1;
		SDI = 0;
		#50;
		SCK = 0;
		
		#50;
		SCK = 1;
		SDI = 0;
		#50;
		SCK = 0;
		
		#50;
		SCK = 1;
		SDI = 0;
		#50;
		SCK= 0;
		
		#50;
		SCK = 1;
		SDI = 0;
		#50;
		SCK = 0;
		
		#50;
		SCK = 1;
		SDI = 0;
		#50;
		SCK = 0;
		
		#50;
		SCK = 1;
		SDI = 0;
		#50;
		SCK = 0;
        
		#50;
		SCK = 1;
		SDI = 0;
		#50;
		SCK= 0;
		
		#50;
		SCK = 1;
		SDI = 0;
		#50;
		SCK = 0;
		
		#50;
		SCK = 1;
		SDI = 0;
		#50;
		SCK = 0;
		
		#50;
		SCK = 1;
		SDI = 0;
		#50;
		SCK = 0;
		
		#50;
		SCK = 1;
		SDI = 0;
		#50;
		SCK = 0;
		
		#50;
		SCK = 1;
		SDI = 0;
		#50;
		SCK = 0;
		
		#50;
		SCK = 1;
		SDI = 0;
		#50;
		SCK = 0;
		
		#50;
		SCK = 1;
		SDI = 0;
		#50;
		SCK = 0;
		
		#50;
		SCK = 1;
		SDI = 0;
		#50;
		SCK = 0;
		
		#50;
		SCK = 1;
		SDI = 0;
		#50;
		SCK = 0;
		
		#50;
		SCK = 1;
		SDI = 0;
		#50;
		SCK = 0;
		// Add stimulus here

	end
      
endmodule

