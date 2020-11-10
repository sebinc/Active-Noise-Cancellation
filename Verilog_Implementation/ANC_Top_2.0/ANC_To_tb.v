`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:59:04 06/16/2018
// Design Name:   ANC_Top
// Module Name:   X:/0_xlinx_ISE/ANC_Top/ANC_To_tb.v
// Project Name:  ANC_Top
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ANC_Top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ANC_To_tb;

	// Inputs
	reg SCK;
	reg SDI;
	reg Clk_100M;
	reg Reset;
	reg RAM_EN;
	reg RAM_wea;
	reg [7:0] RAM_adda;
reg [10:0] RAM_dina;

	// Outputs
	wire SDO;
	wire AudioL;
	wire AudioR;
	wire [10:0] RAM_douta;
	
	// instance of Memory block
//BlockRam Memory (
//  .clka(Clk_100M),                    // input clka
//  .ena(RAM_EN),                          // input ena
//  .wea(RAM_wea),                          // input [0 : 0] wea
//  .addra(RAM_adda),                      // input [7 : 0] addra
//  .dina(RAM_dina),                        // input [10 : 0] dina
//  .douta(RAM_douta)                       // output [10 : 0] douta
//);

	// Instantiate the module
ANC_Top uut (
    .SCK(SCK), 
    .SDI(SDI), 
    .Reset(Reset), 
    .Clk_100M(Clk_100M), 
    .SDO(SDO), 
    .AudioL(AudioL), 
    .AudioR(AudioR)
    );

	initial begin
		// Initialize Inputs
		SCK = 0;
		SDI = 0;
		Clk_100M = 0;
		RAM_EN = 1;
		RAM_wea =1;
		Reset =0;
		// Wait 100 ns for global reset to finish
		#100;
        
		// Fill block ram with some value  
		#100;
		RAM_adda = 63;
		RAM_dina = 1;
		
		#100;
		RAM_adda = 62;
		RAM_dina = 2;
		
		#100;
		RAM_adda = 61;
		RAM_dina = 3;
		
		#100;
		RAM_adda = 60;
		RAM_dina = 4;
		
		#100;
		RAM_adda = 59;
		RAM_dina = 5;
		
		#100;
		RAM_adda = 58;
		RAM_dina = 6;
		
		#100;
		RAM_adda = 57;
		RAM_dina = 7;
		
		#100;
		RAM_adda = 56;
		RAM_dina = 8;
		
		#100;
		RAM_adda = 55;
		RAM_dina = 9;
		
		#100;
		RAM_adda = 54;
		RAM_dina = 10;
		
		#100;
		RAM_adda = 53;
		RAM_dina = 11;
		
		#100;
		RAM_adda = 52;
		RAM_dina = 12;
		
		#100;
		RAM_adda = 127;
		RAM_dina = 12;
			
		
		#100;
		RAM_adda = 126;
		RAM_dina = 11;
		
		#100;
		RAM_adda = 125;
		RAM_dina = 10;
		
		#100;
		RAM_adda = 124;
		RAM_dina = 9;
		
		#100;
		RAM_adda = 123;
		RAM_dina = 8;
		
		#100;
		RAM_adda = 122;
		RAM_dina = 7;
		
		#100;
		RAM_adda = 121;
		RAM_dina = 6;
	
		#100;
		RAM_adda = 120;
		RAM_dina = 5;
		
		#100;
		RAM_adda = 119;
		RAM_dina = 4;
		
		#100;
		RAM_adda = 118;
		RAM_dina = 3;
		
		#100;
		RAM_adda = 117;
		RAM_dina = 2;
		
		#100;
		RAM_adda = 116;
		RAM_dina = 1;
		
		#100
		RAM_wea =0;
		RAM_EN =0;
		
		
		
		
		

		
		// Send the ADC data though SPI
		Reset =0;
		//16
		SCK = 1;
		SDI = 0;
		#200;
		SCK = 0;
		
		Reset =1;
		#200;
		Reset =0;
		
	     repeat (10)
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
		
		
		#600;
		Reset =1;
		#50;
		Reset =0;
	end
	end
	
	always begin
		#5
		Clk_100M = ~Clk_100M;
	end
      
endmodule

