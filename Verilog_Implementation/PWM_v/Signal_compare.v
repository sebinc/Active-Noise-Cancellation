`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:42:55 06/14/2018 
// Design Name: 
// Module Name:    Signal_compare 
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
module Signal_compare(
		input [10:0] R,
		input [10:0] C,
		output Result
    );

wire w0 = ~(R[0] ^ C[0]);
wire w1 = ~(R[1] ^ C[1]);
wire w2 = ~(R[2] ^ C[2]);
wire w3 = ~(R[3] ^ C[3]);
wire w4 = ~(R[4] ^ C[4]);
wire w5 = ~(R[5] ^ C[5]);
wire w6 = ~(R[6] ^ C[6]);
wire w7 = ~(R[7] ^ C[7]);
wire w8 = ~(R[8] ^ C[8]);
wire w9 = ~(R[9] ^ C[9]);
wire w10 = ~(R[10] ^ C[10]);

assign Result = w0 & w1 & w2 & w3 & w4 & w5 & w6 & w7 & w8 & w9 & w10;

endmodule
