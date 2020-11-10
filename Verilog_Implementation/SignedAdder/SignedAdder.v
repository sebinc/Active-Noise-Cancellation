`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:11:35 06/17/2018 
// Design Name: 
// Module Name:    SignedAdder 
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
// issue1 :  a- 0 will not work perfectly  ( error result while subtracting value 0)
//          Fix : Fixed
//////////////////////////////////////////////////////////////////////////////////
module SignedAdder(
      a,
	  b,
	  AddOut,
	  en
    );

// I/O definitions
input [20:0]  a;
input [20:0]  b;
input         en;
output [20:0] AddOut;


//Variables and net
wire Sign;
wire [20:0] temp_wire;
wire [19:0] a_comp;
wire [19:0] b_comp;
wire [20:0] addtemp;
wire [20:0] aa;
wire [20:0] bb;


// Circuit
// Added aa, bb to fix issue1
assign aa            = a[19:0] == 20'b 0 ? 21'b 0 : a;
assign bb            = b[19:0] == 20'b 0 ? 21'b 0 : b;
assign Sign          = aa[20] ^ bb[20];
assign temp_wire[20] = Sign ? (~addtemp[20]) : (aa[20] & bb[20]);
assign AddOut        = en ? temp_wire : 21'b 0; 
 
// 2's compliment subtraction
// If the final carry over of the sum is 1, it is dropped and the result is positive.
//(iv) If there is no carry over, the two's complement of the sum will be the result and it is negative.

assign a_comp           = (aa[20]) ? (~ aa[19:0] + 1'b 1) : (aa[19:0]);   //2's compliment
assign b_comp           = (bb[20]) ? (~ bb[19:0] + 1'b 1) : (bb[19:0]);   // 2's compliment
assign addtemp[20:0]    = Sign ? ({1'b 0,a_comp[19:0]} + {1'b 0,b_comp[19:0]}) : {1'b 0, aa[19:0]}+{1'b 0, bb[19:0]};
assign temp_wire[19:0]  = (Sign & (~addtemp[20])) ? ((~addtemp[19:0])+1'b 1) : addtemp[19:0]; // 2's compliment only if Sign s set. Otherwise normal.


endmodule
