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


module ANCSaturation_V(
    Clk_100M,
	Reset,
	Err,
	Filt_In,
	MicIn,
	FiltComplete_In,
	ANCAudioOut
   );
   
// I/O control

output [10:0]  Err;
input  [10:0]  Filt_In;
input  [10:0]  MicIn;
output [10:0]  ANCAudioOut;
input          FiltComplete_In;
input          Clk_100M;
input          Reset;

// variables
reg    [9:0] ANCAudioOut_reg;
reg    [10:0] MicIn_reg;
reg    [10:0] Err_reg;
reg           FiltComplete_old;
reg           ResetOld;

wire   [20:0] ErrData_AddResult_w;
wire          Filtcmplt_detected;

// Initialise
initial begin
   ANCAudioOut_reg  = 10'b 0;
   FiltComplete_old = 1'b 0; 
end

//Control 

assign ANCAudioOut        = {ANCAudioOut_reg[9], 1'b 0, ANCAudioOut_reg[8:0]};
assign Filtcmplt_detected = (~FiltComplete_old & FiltComplete_In) || Reset;
assign Err                = Err_reg;

always @(posedge FiltComplete_In)
begin
   ANCAudioOut_reg <= Filt_In[9] ? {Filt_In[10], 9'b 111111111} : {Filt_In[10],Filt_In[8:0]};
   MicIn_reg       <= MicIn;
end


always @ (posedge Clk_100M)
begin
   FiltComplete_old <= FiltComplete_In;
   ResetOld         <= Reset;
end

always @ (negedge Filtcmplt_detected)
begin
   Err_reg <= ResetOld ? 11'b 0 : {ErrData_AddResult_w[20],ErrData_AddResult_w[9:0]};
end


//Err = MicInput - FiltSum;
SignedAdder ErrAdd (
    .a({MicIn_reg[10],10'b 0,MicIn_reg[9:0]}),                 // Extending 10 bit data to 20 bit
    .b({~ANCAudioOut_reg[9],11'b 0,ANCAudioOut_reg[8:0]}), 
    .AddOut(ErrData_AddResult_w),
	.en(1'b 1)
    );
	
endmodule