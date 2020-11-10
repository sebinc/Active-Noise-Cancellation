`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:16:15 06/21/2018 
// Design Name: 
// Module Name:    ram_top 
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
module ram_top(
   input resetAdd, 
	input clk_100M,
	input [15:0] dina,
	input wea,
	output [15:0] douta
    );

reg [7:0] counter;
wire [8:0] addra;

initial begin
	counter <= 7'd 64;
end


always @(posedge clk_100M)
begin
	counter <= resetAdd? 7'd 64 : counter - 7'b 1;
end

assign addra = {1'b 0, counter};

BlockRAM  BRAM(
  .clka(clk_100M), // input clka
  .wea(wea), // input [0 : 0] wea
  .addra(addra), // input [8 : 0] addra
  .dina(dina), // input [15 : 0] dina
  .douta(douta) // output [15 : 0] douta
);

endmodule
