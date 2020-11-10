`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:06:51 06/10/2018 
// Design Name: 
// Module Name:    shift_register_v 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: Data_out data is placed at the negative edge.(Not the desired, shall be at posedge)
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module shift_register_v(
             Clk,
             Data_In,
             Data_Out,
	          ByteOut,
				 SS,
				 SSPIF
    );

//Variables
input Clk;
input Data_In;
input SS;
output Data_Out;
output [0:7] ByteOut;
output SSPIF;

//shift register signals
reg [3:0] ShiftCount;
reg [7:0] bitShiftReg;

initial begin
	bitShiftReg = 'b 00000000;
	ShiftCount = 'b 0000;
end

assign Data_Out = bitShiftReg[7];
assign ByteOut = bitShiftReg;
assign SSPIF = ShiftCount[3] && ShiftCount[0];  // SSPIF will set when clk count reaches 8

//shift register
always @(negedge Clk)
begin

	//bit shift register
	// Select clock only if SS is enabled
	if (SS == 1)
		begin
			bitShiftReg <= {bitShiftReg[6:0],Data_In};
			ShiftCount <= ShiftCount + 4'b 0001;
		end
	else
		begin
			bitShiftReg <= 8'b 00000000;
			ShiftCount <= 4'b 0000;
		end
end

endmodule
