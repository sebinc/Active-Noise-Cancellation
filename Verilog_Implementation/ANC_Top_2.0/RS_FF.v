`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:34:58 06/14/2018 
// Design Name: 
// Module Name:    RS_FF 
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
module RS_FF(
       input R,
		 input S,
		 input Clk,
		 output Q
    );

reg Q1;

initial begin
   Q1 = 1'b 0;
end

assign Q = Q1;

always @(posedge Clk)
begin
   case({S,R})
	{1'b 0, 1'b 1}: begin Q1 = 1'b 0;end
	{1'b 1, 1'b 0}: begin Q1 = 1'b 1;end
	{1'b 1, 1'b 1}: begin Q1 = 1'b 0;end
	endcase
end

endmodule
