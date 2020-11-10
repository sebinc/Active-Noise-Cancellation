`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:21:17 06/10/2018 
// Design Name: 
// Module Name:    SPI_Top 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module SPI(
    output SDO,
    input SDI,
    input SCK,
    output [0:7] SPI_Byte,
	 input SS,
	 output SSPIF
    );


shift_register_v shiftregister (
    .Clk(SCK),
    .Data_In(SDI),
    .SS(SS),
    .SSPIF(SSPIF),	 
    .Data_Out(SDO), 
    .ByteOut(SPI_Byte)
    );

endmodule
