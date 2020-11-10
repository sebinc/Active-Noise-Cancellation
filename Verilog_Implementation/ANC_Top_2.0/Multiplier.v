`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:25:51 06/17/2018 
// Design Name: 
// Module Name:    Multiplier 
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
module Multiplier(
		a,
	    b,
		MulOut,
		en
    );

// I/O definition
input  [10:0] a;
input  [10:0] b;
input         en;
output [20:0] MulOut;

// Variables and Nets
wire [9:0] aa;
wire [9:0] bb;
wire [19:0] a0,a1,a2,a3,a4,a5,a6,a7,a8,a9;

// Circuit
assign aa = a[9:0];
assign bb = b[9:0];

assign a0 = ( bb[0] == 1'b 1) ? {10'b 0, aa        }: 16'b 0;
assign a1 = ( bb[1] == 1'b 1) ? {9'b  0, aa, 1'b 0 }: 16'b 0;
assign a2 = ( bb[2] == 1'b 1) ? {8'b  0, aa, 2'b 0 }: 16'b 0;
assign a3 = ( bb[3] == 1'b 1) ? {7'b  0, aa, 3'b 0 }: 16'b 0;
assign a4 = ( bb[4] == 1'b 1) ? {6'b  0, aa, 4'b 0 }: 16'b 0;
assign a5 = ( bb[5] == 1'b 1) ? {5'b  0, aa, 5'b 0 }: 16'b 0;
assign a6 = ( bb[6] == 1'b 1) ? {4'b  0, aa, 6'b 0 }: 16'b 0;
assign a7 = ( bb[7] == 1'b 1) ? {3'b  0, aa, 7'b 0 }: 16'b 0;
assign a8 = ( bb[8] == 1'b 1) ? {2'b  0, aa, 8'b 0 }: 16'b 0;
assign a9 = ( bb[9] == 1'b 1) ? {1'b  0, aa, 9'b 0 }: 16'b 0;

assign MulOut[19:0] = en? a0+a1+a2+a3+a4+a5+a6+a7+a8+a9 : 20'b 0;
assign MulOut[20]   = en? (a[10] ^ b[10]) :  1'b 0;   // Sign bit calculation. or with 0 help to remove unknown state  x

endmodule
