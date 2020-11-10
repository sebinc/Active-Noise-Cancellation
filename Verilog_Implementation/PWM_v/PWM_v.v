`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:25:21 06/14/2018 
// Design Name: 
// Module Name:    PWM_v 
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
module PWM_v(
    input Clk_pwm,
    output PwmSig,
    input [9:0] SigVec
    );

//Internal variables
wire [10:0] SigProc;
wire pwm_on;
wire pwm_off;
reg [10:0] ClkCount;

initial begin
 ClkCount = 11'b 0;
end

always @(posedge Clk_pwm)
begin
	ClkCount <= ClkCount + 1'b 1;
end

assign SigProc = {SigVec[9:0], 1'b 0};
assign pwm_on = ClkCount[0] & ClkCount[1] & ClkCount[2] & ClkCount[3] & ClkCount[4] & ClkCount[5] & ClkCount[6] & ClkCount[7] & ClkCount[8] & ClkCount[9] & ClkCount[10];

Signal_compare PWM_sig (
    .R(SigProc), 
    .C(ClkCount), 
    .Result(pwm_off)
    );


RS_FF PWM_FF (
    .R(pwm_off), 
    .S(pwm_on), 
    .Clk(Clk_pwm), 
    .Q(PwmSig)
    ); 



endmodule
