`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:        SSD
// Engineer:       SEBIN C JOSEPH
// 
// Create Date:    23:14:40 06/11/2018 
// Design Name:    ANCCoefControl_Block
// Module Name:    ANCCoefControl_V 
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


module ANCCoefMem_V(
    FilterEN_In,
    Clk_100M,
	Reset,
	Wz_In,
	WzOut,
	FiltComplete
   );

     
// I/O fControl                                                           
input          FilterEN_In;                                                              
input          Clk_100M; 
input          Reset; 
output         FiltComplete;                                                            
input  [10:0]  Wz_In;
output [10:0]  WzOut;



// Variables
reg            FiltENOld;
reg    [ 7:0]  CoefControl;
 
wire           Clk;
wire           FiltComplete;
wire           Data_wea;
wire           RamEN;
wire           AddrOutrnge;
wire   [ 6:0]  Data_addra;
wire   [15:0]  Data_din;
wire   [15:0]  Datadin_w;
wire   [15:0]  Data_douta;


// Control logic
assign Clk            =  ((FilterEN_In &  Clk_100M) || Reset);
assign Data_wea       =  (~CoefControl[0]) & FilterEN_In;
assign FiltComplete   =  (~FiltENOld & ~FilterEN_In);
assign RamEN          =  ~AddrOutrnge & FilterEN_In;

assign Data_addra     =  FilterEN_In    ? CoefControl[7:1]    : 7'd 121;
assign WzOut          =  FilterEN_In    ? Data_douta[10:0]    : 11'b 0;
assign Data_din       =  FilterEN_In    ? Datadin_w           : 16'b 0;
assign Datadin_w      =  AddrOutrnge    ? 16'b 0              : {5'b 0, Wz_In};


// To remove the data write in the region 121-128
Greater_v  #(.SIG_WIDTH(7)) addressrangecoef (
		.x(Data_addra), 
		.y(7'd 119), 
		.x_grtr_y(AddrOutrnge)
	);

always @(negedge Clk_100M)
begin
   FiltENOld     <= FilterEN_In; 
end

always @(posedge Clk)
begin
   CoefControl  <= (FiltENOld & ~Reset) ? CoefControl - 1'b 1 : 8'd 240;
end





BlockRam CoefRam (
  .clka(Clk_100M),                 // input clka
  .ena(RamEN),                     // input ena
  .wea(Data_wea),                  // input [0 : 0] wea
  .addra(Data_addra),              // input [6 : 0] addra
  .dina(Data_din),                 // input [15 : 0] dina
  .douta(Data_douta)               // output [15 : 0] douta
);

endmodule