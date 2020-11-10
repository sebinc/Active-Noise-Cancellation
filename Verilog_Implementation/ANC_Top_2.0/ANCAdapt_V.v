`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:        SSD
// Engineer:       SEBIN C JOSEPH
// 
// Create Date:    23:14:40 06/11/2018 
// Design Name:    ANC_Top
// Module Name:    ANC_Top 
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


module ANCAdapt_V(
    FilterEN_In,
    Clk_100M,
	Err_In,
	Reset,
	Sig_In,
	Synch,
	Wz_In,
	WzOut
   );

     
// I/O fControl                                                           
input          FilterEN_In;                                                              
input          Clk_100M; 
input          Reset;
input  [10:0]  Sig_In;
input  [10:0]  Err_In;                                                             
input  [10:0]  Wz_In;
output         Synch;
output [10:0]  WzOut;



// Variables
reg            FiltENOld;
reg    [ 0:0]  AdaptControl;
reg    [10:0]  WzOld;
reg    [10:0]  WzNew_reg;
 
wire           Clk;
wire   [20:0]  WzNew_w;
wire   [20:0]  WzFiltN_MulResult;
wire           Data_write;
wire   [15:0]  Data_din;


// Control logic
assign Clk            =  ((FilterEN_In &  Clk_100M) || Reset);
assign Data_write     =  (~AdaptControl) & FilterEN_In;
assign Synch          =   AdaptControl;
assign WzOut          =  WzNew_reg;


always @(posedge Data_write)
begin
   WzNew_reg <= {WzNew_w[20],WzNew_w[9:0]};
end

always @(negedge Clk_100M)
begin
   FiltENOld     <= FilterEN_In; 
end

always @ (negedge Clk)
begin
   WzOld <=  Wz_In;
end

always @(posedge Clk)
begin
   AdaptControl  <= (FiltENOld & ~Reset) ?   ~AdaptControl   : 1'b 0;
end




    
//     WzFiltN_MulResult = Err_In * Sig_In; mu (1/128) will calculte while add
Multiplier WzMul (
    .a(Sig_In), 
    .b(Err_In), 
    .MulOut(WzFiltN_MulResult),
	.en(FilterEN_In)
    );
	
//Wz = Wz + WzFiltN_MulResult;
SignedAdder WzAdder (
    .a({WzOld[10],10'b 0,WzOld[9:0]}), 
    .b({WzFiltN_MulResult[20], 7'b 0 ,WzFiltN_MulResult[19:7]}),      // 1/128
    .AddOut(WzNew_w),
	.en(FilterEN_In)
    );
	
endmodule