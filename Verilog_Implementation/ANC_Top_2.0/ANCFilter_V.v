`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:        SSD
// Engineer:       SEBIN C JOSEPH
// 
// Create Date:    23:14:40 06/11/2018 
// Design Name:    ANC_Top
// Module Name:    ANCFilter 
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


module ANCFilter_V(
    FilterEN_In,
    Clk_100M,
	Reset,
	Sig_In,
	Wz_In,
	Synch_In,
	FiltOut
   );
   
//I/O Control

input          FilterEN_In;
input          Clk_100M;
input          Reset;
input          Synch_In;
input  [10:0]  Wz_In;
input  [10:0]  Sig_In; 
output [10:0]  FiltOut;


// Variables
reg           FilterENSigOld;
reg  [10:0]   FiltSum;
reg  [20:0]   FiltNResult;
reg  [20:0]   FiltNResult_loc;
 

wire [20:0]  FiltN_MulResult;
wire [20:0]  FiltSum_AddResult;


// Control
assign FiltOut = FiltSum;
// assign FiltNResult_w = Synch_In ? FiltNResult_w : FiltSum_AddResult;

//always @ (posedge Synch_In)
//begin
//   FiltNResult_w <= FiltSum_AddResult;
//end

always @(negedge FilterEN_In)
begin
   FiltSum <= {FiltNResult[20],FiltNResult[19:10]};          // divide by 1024;
end

always @(posedge Clk_100M)
begin
   FilterENSigOld  <= FilterEN_In & (~Reset);
   FiltNResult_loc <= FilterENSigOld ? FiltNResult : 21'b 0;
end

always @(negedge Clk_100M)
begin
   FiltNResult    <= FilterENSigOld & ~Synch_In  ? FiltSum_AddResult : FiltNResult_loc;
end


// FiltN_MulResult = Wz_In * Signal;
Multiplier FilterMul (
    .a(Sig_In), 
    .b(Wz_In), 
    .MulOut(FiltN_MulResult),     
	.en(FilterEN_In)
    );
	
	
//FiltNResult = FiltNResult + Wz_In * Signal;
SignedAdder FilterAdd (
    .a(FiltNResult), 
    .b(FiltN_MulResult), 
    .AddOut(FiltSum_AddResult),
	.en(FilterEN_In)
    );

endmodule