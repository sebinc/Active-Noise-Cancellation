`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:22:34 07/21/2018
// Design Name:   ANCDataMem_V
// Module Name:   X:/0_xlinx_ISE/ANC_Top_2.0/ANCDataMem_Tb.v
// Project Name:  ANC_Top_2.0
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ANCDataMem_V
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ANCDataMem_Tb;

	// Inputs
	reg RamShiftEN;
	reg FilterEN;
	reg Clk_100M;
	reg Reset;
	reg [10:0] SPIData;

	// Outputs
	wire [10:0] DataOut;

	// Instantiate the Unit Under Test (UUT)
	ANCDataMem_V uut (
		.RamShiftEN(RamShiftEN), 
		.FilterEN(FilterEN), 
		.Clk_100M(Clk_100M),
      .Reset(Reset),		
		.SPIData(SPIData), 
		.DataOut(DataOut)
	);

	initial begin
		// Initialize Inputs
		RamShiftEN = 0;
		FilterEN = 0;
		Clk_100M = 0;
		SPIData = 0;

		// Wait 100 ns for global reset to finish
		#100;
			 Reset = 1;
			 #350;
			 Reset = 0;
			 repeat(125)
			 begin
			 #200;
          SPIData = 100;
          RamShiftEN=1;
			 FilterEN =0;
			 end
			 repeat(124)
			 begin
			 #200;
          SPIData = 200;
          RamShiftEN=0;
			 FilterEN =1;
			 end
			 repeat(121)
			 begin
			 #200;
          SPIData = 300;
          RamShiftEN=1;
			 FilterEN =0;
			 end
			 
		// Add stimulus here

	end
	
	always 
	begin
	#50;
	Clk_100M = ~Clk_100M;
	end
      
endmodule

