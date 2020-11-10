`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       SEBIN C JOSEPH
// 
// Create Date:    22:06:51 06/10/2018 
// Design Name:
// Module Name:    SPI_v.v
// Project Name:   ANC
// Target Devices: 
// Tool versions: 
// Description:    SPI - Need to set Reset once the data is read, Then it will clear all buffer, and ready to receive next byte. SSPIF will clear once next byte is receive
//                 SDO data is placed at the negative edge.(Not the desired, shall be at posedge, Since SDO is not connected in project,not an issue.
//                  SPI will retun 11 bit result with bit 10 stuffed with 0 and 11th bit as sign
// Dependencies: 
module SPI_v(
             SCK,
             SDI,
             SDO,
             Reset,
             DataOut,
             SSPIF );

//Variables
input SCK;
input SDI;
input Reset;
output SDO;
output [10:0] DataOut;
output SSPIF;

// Variabes
wire ShiftClk;
wire SSPTx;
wire ResetEN;
//shift register signals
reg        ResetOld;
reg [3:0]  ShiftCount;
reg [15:0] bitShiftReg;
reg [10:0] DataOut_reg;

initial begin
	bitShiftReg <= 16'b 0;
	//ShiftCount  <= 4'b 0000;
end

assign ShiftClk  = SCK;
assign ResetEN   = (Reset || ShiftClk);
assign SDO       = bitShiftReg[15];
assign DataOut   = DataOut_reg;                                 
assign SSPIF     = (~ShiftCount[3]) && (~ShiftCount[2]) &&(~ShiftCount[1]) &&(~ShiftCount[0]);  // SSPIF will set when clk count reaches 16. and reset in each clk neg edge
assign SSPTx     = (SSPIF|| Reset);

always @ (posedge SSPTx)
begin
    DataOut_reg <= Reset ? 11'b 0 : { ~bitShiftReg[9],bitShiftReg[8:0],1'b 0 };                 // Making the data 11 bit
end


// Rest logic

always @ (posedge ResetEN)
begin
   ResetOld <= Reset; 
end
//shift register
always @(negedge ResetEN)
begin

	//bit shift register
	// Select clock only if SS is enabled
	if (Reset == 1'b 0)
	begin
	    bitShiftReg <= {bitShiftReg[14:0],SDI};
	end
	ShiftCount <=  ResetOld ? 4'b 0 :(ShiftCount + 4'b 0001);
	
end 

endmodule 