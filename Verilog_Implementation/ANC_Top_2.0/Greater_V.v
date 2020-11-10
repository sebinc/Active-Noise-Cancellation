`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:25:21 06/14/2018 
// Design Name: 
// Module Name:    Greater_v 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: Will return 'out' 1 if a>b;
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Greater_v #(parameter SIG_WIDTH = 7)(
    x,
    y,
	x_grtr_y
    );

// I/O definition
input  [SIG_WIDTH-1 : 0] x;
input  [SIG_WIDTH-1 : 0] y;
output                   x_grtr_y;


// Circuit

assign x_grtr_y = (x>y) ? 1'b 1 : 1'b 0;  
	
endmodule
	
