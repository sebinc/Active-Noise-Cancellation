`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:        SSD
// Engineer:       SEBIN C JOSEPH
// 
// Create Date:    23:14:40 06/11/2018 
// Design Name:    ANCControl_Block
// Module Name:    ANCControl_V 
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


module ANCDataMem_V(
    RamShiftEN_In,
    FilterEN_In,
    Clk_100M,
    SPIData_In,
	Reset,
	DataOut
   );

     
// I/O control
input          RamShiftEN_In;                                                            
input          FilterEN_In;                                                              
input          Clk_100M; 
input          Reset;                                                             
input  [10:0]  SPIData_In;
output [10:0]  DataOut;



// Variables
reg            RamShiftENOld;
reg            FiltENOld;
reg    [ 7:0]  Control;
reg    [10:0]  SPIData_reg;
//reg    [15:0]  FinalData_Reg;
 
wire           ENOld;
wire           AddZero;
wire           AddSel;
wire           Clk;
wire           Count_EN;
wire           AddrOutRange;
wire           Data_EN;
wire           Data_wea;
wire   [ 6:0]  AddSel_w;
wire   [ 6:0]  Data_addra;
wire   [15:0]  Data_dina ;
wire   [15:0]  Data_douta;
wire   [15:0]  dataout_w;


// Control logic
assign Clk            =  (Count_EN &  Clk_100M) || Reset ;
assign Count_EN       =  (RamShiftEN_In || FilterEN_In);
assign Data_EN        =  Count_EN & ~AddrOutRange;
assign Data_wea       =  (~Control[0]) & RamShiftEN_In;
assign ENOld          =  (RamShiftENOld || FiltENOld ) & ~Reset;
assign AddZero        =  Control[7:1] == 8'd 127 ? 1'b 1 : 1'b 0;
assign AddSel         =  (Control[0] || FilterEN_In || AddZero);

assign AddSel_w       =  AddZero      ? 7'b 0               : Control[7:1];
assign Data_addra     =  AddSel       ? AddSel_w            : AddSel_w + 1'b 1;
assign DataOut        =  FilterEN_In  ? Data_douta[10:0]    : 11'b 0;
assign Data_dina      =  AddZero      ? {5'b 0,SPIData_reg} : dataout_w;
assign dataout_w      =  AddrOutRange & ~FiltENOld ? 16'b 0 : Data_douta;


// To remove the data write in the region 121-128

Greater_v  #(.SIG_WIDTH(7)) addressrange (
		.x(Data_addra), 
		.y(7'd 119), 
		.x_grtr_y(AddrOutRange)
	);

always @ (posedge RamShiftEN_In)
begin
    SPIData_reg <= Reset ? 11'b 0 : SPIData_In;
end


always @(negedge Clk_100M)
begin
   RamShiftENOld <= RamShiftEN_In;
   FiltENOld     <= FilterEN_In; 
end

always @(posedge Clk)
begin
   Control  <= ENOld ? Control - 1'b 1 : 8'd 240;
end





BlockRam DataRam (
  .clka(Clk_100M),                 // input clka
  .ena(Data_EN),                   // input ena
  .wea(Data_wea),                  // input [0 : 0] wea
  .addra(Data_addra),              // input [6 : 0] addra
  .dina(Data_dina),                // input [15 : 0] dina
  .douta(Data_douta)               // output [15 : 0] douta
);

endmodule