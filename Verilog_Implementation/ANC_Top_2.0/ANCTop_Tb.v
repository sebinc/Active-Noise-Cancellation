`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:34:43 07/28/2018
// Design Name:   ANCTop_V
// Module Name:   X:/0_xlinx_ISE/ANC_Top_2.0/ANCTop_Tb.v
// Project Name:  ANC_Top_2.0
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ANCTop_V
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ANCTop_Tb;

	// Inputs
	reg Clk_100M;
	reg ResetSwitch;
	reg SCK;
	reg SDI;

	// Outputs
	wire AudioL;
	wire AudioR;
	wire SDO;
	wire SPI_LED;

	// Instantiate the Unit Under Test (UUT)
	ANCTop_V uut (
    .Clk_100M(Clk_100M), 
    .SCK(SCK), 
    .SDI(SDI), 
    .SDO(SDO), 
    .ResetSwitch(ResetSwitch), 
    .AudioL(AudioL), 
    .AudioR(AudioR), 
    .SPI_LED(SPI_LED)
    );


	initial begin
		
		// Add stimulus here
		Clk_100M =0;
		ResetSwitch =0;
		SCK = 0;
		SDI = 0;
		
		// Send the ADC data though SPI
		//16
		#2000;
		
	   repeat (100)
	   begin
		
		#20000;
		//16
		SCK = 1;
		SDI = 0;
		#200;
		SCK = 0;
		
		//15
		#200;
		SCK = 1;
		SDI = 0;
		#200;
		SCK = 0;
		
		//14
		#200;
		SCK = 1;
		SDI = 0;
		#200;
		SCK = 0;
		
		//13
		#200;
		SCK = 1;
		SDI = 0;
		#200;
		SCK = 0;
		
		//12
		#200;
		SCK = 1;
		SDI = 0;
		#200;
		SCK = 0;
		
		//11
		#200;
		SCK = 1;
		SDI = 0;
		#200;
		SCK = 0;
		
		//10
		#200;
		SCK = 1;
		SDI = 0;
		#200;
		SCK = 0;
		
		//9
		#200;
		SCK = 1;
		SDI = 1;
		#200;
		SCK = 0;
		
		//8
		#200;
		SCK = 1;
		SDI = 1;
		#200;
		SCK = 0;
		
		//7
		#200;
		SCK = 1;
		SDI = 1;
		#200;
		SCK = 0;
		
		//6
		#200;
		SCK = 1;
		SDI = 1;
		#200;
		SCK = 0;
		
		//5
		#200;
		SCK = 1;
		SDI = 1;
		#200;
		SCK = 0;
		
		//4
		#200;
		SCK = 1;
		SDI = 0;
		#200;
		SCK = 0;
		
		//3
		#200;
		SCK = 1;
		SDI = 1;
		#200;
		SCK = 0;
		
		//2
		#200;
		SCK = 1;
		SDI = 0;
		#200;
		SCK = 0;
		
		//1
		#200;
		SCK = 1;
		SDI = 0;
		#250;
		SCK = 0;
		
	end

	end
	
   always 
	begin
	#50;
	Clk_100M = ~Clk_100M;
	end
      
endmodule

