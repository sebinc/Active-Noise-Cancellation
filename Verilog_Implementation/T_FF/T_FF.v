`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:45:01 01/05/2017 
// Design Name: 
// Module Name:    T_FF 
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
module T_FF(
    input ClkIn,
    output ClkOut
    );

reg buffer;
	
	always @(posedge ClkIn) begin
	
		buffer <= ~buffer;
	
	end
	ClkOut <= buffer;
endmodule
