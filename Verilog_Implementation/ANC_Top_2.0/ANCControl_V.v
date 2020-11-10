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


module ANCControl_V(
    Clk_100M,
    SSPIF_In,
	RAMDataEN,
	FilterEN,
	Reset
   );

     
// I/O control                                                          
input        Clk_100M;                                                        
input        SSPIF_In;      
input        Reset;                                                     
output       FilterEN;
output       RAMDataEN;

wire         DataEN1;
wire         DataEN2;
wire         FiltEN1;
wire         FiltEN2;
wire         DataClk;
wire         FiltClk;
wire         ControlClk;
wire         EN;
wire         SSPIFDetected;

reg    [9:0] ControlReg;
reg          ResetEN;
reg          RAMDataEN_reg;
reg          FilterEN_reg;
reg          SSPIFOld_1;
reg          SSPIFOld_2;
//-----------------------------------------------------------------------------//

//Generating Reset signal

assign DataEN1       = ControlReg    == 9'd 2   ? 1'b 1 : 1'b 0;
assign DataEN2       = ControlReg    == 9'd 247 ? 1'b 1 : 1'b 0;
assign FiltEN1       = ControlReg    == 9'd 255 ? 1'b 1 : 1'b 0;
assign FiltEN2       = ControlReg    == 9'd 498 ? 1'b 1 : 1'b 0;
assign EN            = ControlReg    == 9'd 511 ? 1'b 0 : 1'b 1;
                     
assign DataClk       = DataEN1 || DataEN2 || Reset;
assign FiltClk       = FiltEN1 || FiltEN2 || Reset;
assign RAMDataEN     = RAMDataEN_reg;
assign FilterEN      = FilterEN_reg;
assign SSPIFDetected = SSPIFOld_1 & ~SSPIFOld_2;
assign ControlClk    = (EN & Clk_100M) || SSPIFDetected || Reset;

// generic control logic

always @(posedge DataClk)
begin
   RAMDataEN_reg <= (DataEN1 & ~Reset) ? 1'b 1 : 1'b 0;
end

always @(posedge FiltClk)
begin
   FilterEN_reg <= (FiltEN1 & ~Reset) ? 1'b 1 : 1'b 0;
end

always @(posedge Clk_100M)
begin
   SSPIFOld_2 <= SSPIFOld_1;
end

always @(negedge Clk_100M)
begin
   SSPIFOld_1    <= SSPIF_In;
end


always @ (posedge ControlClk)
begin
   ControlReg   <= (Reset || SSPIFDetected) ? 9'b 0 : ControlReg + 1'b 1;
end


endmodule