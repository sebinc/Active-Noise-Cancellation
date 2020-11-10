////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2012 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor: Xilinx
// \   \   \/     Version: P.15xf
//  \   \         Application: netgen
//  /   /         Filename: PWM_v_synthesis.v
// /___/   /\     Timestamp: Fri Jun 15 16:04:18 2018
// \   \  /  \ 
//  \___\/\___\
//             
// Command	: -intstyle ise -insert_glbl true -w -dir netgen/synthesis -ofmt verilog -sim PWM_v.ngc PWM_v_synthesis.v 
// Device	: xc6slx9-2-csg324
// Input file	: PWM_v.ngc
// Output file	: X:\0_xlinx_ISE\PWM_v\netgen\synthesis\PWM_v_synthesis.v
// # of Modules	: 1
// Design Name	: PWM_v
// Xilinx        : C:\Xilinx\14.1\ISE_DS\ISE\
//             
// Purpose:    
//     This verilog netlist is a verification model and uses simulation 
//     primitives which may not represent the true implementation of the 
//     device, however the netlist is functionally correct and should not 
//     be modified. This file cannot be synthesized and should only be used 
//     with supported simulation tools.
//             
// Reference:  
//     Command Line Tools User Guide, Chapter 23 and Synthesis and Simulation Design Guide, Chapter 6
//             
////////////////////////////////////////////////////////////////////////////////

`timescale 1 ns/1 ps

module PWM_v (
  Clk_pwm, PwmSig, SigVec
);
  input Clk_pwm;
  output PwmSig;
  input [9 : 0] SigVec;
  wire Clk_pwm_BUFGP_0;
  wire \PWM_FF/Q1_1 ;
  wire N0;
  wire N1;
  wire \PWM_FF/R_INV_1_o_15 ;
  wire N3;
  wire \Mcount_ClkCount_cy<1>_rt_41 ;
  wire \Mcount_ClkCount_cy<2>_rt_42 ;
  wire \Mcount_ClkCount_cy<3>_rt_43 ;
  wire \Mcount_ClkCount_cy<4>_rt_44 ;
  wire \Mcount_ClkCount_cy<5>_rt_45 ;
  wire \Mcount_ClkCount_cy<6>_rt_46 ;
  wire \Mcount_ClkCount_cy<7>_rt_47 ;
  wire \Mcount_ClkCount_cy<8>_rt_48 ;
  wire \Mcount_ClkCount_cy<9>_rt_49 ;
  wire \Mcount_ClkCount_xor<10>_rt_50 ;
  wire [10 : 0] ClkCount;
  wire [10 : 0] Result;
  wire [0 : 0] Mcount_ClkCount_lut;
  wire [9 : 0] Mcount_ClkCount_cy;
  VCC   XST_VCC (
    .P(N0)
  );
  GND   XST_GND (
    .G(N1)
  );
  FD #(
    .INIT ( 1'b0 ))
  \PWM_FF/Q1  (
    .C(Clk_pwm_BUFGP_0),
    .D(\PWM_FF/R_INV_1_o_15 ),
    .Q(\PWM_FF/Q1_1 )
  );
  FD #(
    .INIT ( 1'b0 ))
  ClkCount_0 (
    .C(Clk_pwm_BUFGP_0),
    .D(Result[0]),
    .Q(ClkCount[0])
  );
  FD #(
    .INIT ( 1'b0 ))
  ClkCount_1 (
    .C(Clk_pwm_BUFGP_0),
    .D(Result[1]),
    .Q(ClkCount[1])
  );
  FD #(
    .INIT ( 1'b0 ))
  ClkCount_2 (
    .C(Clk_pwm_BUFGP_0),
    .D(Result[2]),
    .Q(ClkCount[2])
  );
  FD #(
    .INIT ( 1'b0 ))
  ClkCount_3 (
    .C(Clk_pwm_BUFGP_0),
    .D(Result[3]),
    .Q(ClkCount[3])
  );
  FD #(
    .INIT ( 1'b0 ))
  ClkCount_4 (
    .C(Clk_pwm_BUFGP_0),
    .D(Result[4]),
    .Q(ClkCount[4])
  );
  FD #(
    .INIT ( 1'b0 ))
  ClkCount_5 (
    .C(Clk_pwm_BUFGP_0),
    .D(Result[5]),
    .Q(ClkCount[5])
  );
  FD #(
    .INIT ( 1'b0 ))
  ClkCount_6 (
    .C(Clk_pwm_BUFGP_0),
    .D(Result[6]),
    .Q(ClkCount[6])
  );
  FD #(
    .INIT ( 1'b0 ))
  ClkCount_7 (
    .C(Clk_pwm_BUFGP_0),
    .D(Result[7]),
    .Q(ClkCount[7])
  );
  FD #(
    .INIT ( 1'b0 ))
  ClkCount_8 (
    .C(Clk_pwm_BUFGP_0),
    .D(Result[8]),
    .Q(ClkCount[8])
  );
  FD #(
    .INIT ( 1'b0 ))
  ClkCount_9 (
    .C(Clk_pwm_BUFGP_0),
    .D(Result[9]),
    .Q(ClkCount[9])
  );
  FD #(
    .INIT ( 1'b0 ))
  ClkCount_10 (
    .C(Clk_pwm_BUFGP_0),
    .D(Result[10]),
    .Q(ClkCount[10])
  );
  MUXCY   \Mcount_ClkCount_cy<0>  (
    .CI(N1),
    .DI(N0),
    .S(Mcount_ClkCount_lut[0]),
    .O(Mcount_ClkCount_cy[0])
  );
  XORCY   \Mcount_ClkCount_xor<0>  (
    .CI(N1),
    .LI(Mcount_ClkCount_lut[0]),
    .O(Result[0])
  );
  MUXCY   \Mcount_ClkCount_cy<1>  (
    .CI(Mcount_ClkCount_cy[0]),
    .DI(N1),
    .S(\Mcount_ClkCount_cy<1>_rt_41 ),
    .O(Mcount_ClkCount_cy[1])
  );
  XORCY   \Mcount_ClkCount_xor<1>  (
    .CI(Mcount_ClkCount_cy[0]),
    .LI(\Mcount_ClkCount_cy<1>_rt_41 ),
    .O(Result[1])
  );
  MUXCY   \Mcount_ClkCount_cy<2>  (
    .CI(Mcount_ClkCount_cy[1]),
    .DI(N1),
    .S(\Mcount_ClkCount_cy<2>_rt_42 ),
    .O(Mcount_ClkCount_cy[2])
  );
  XORCY   \Mcount_ClkCount_xor<2>  (
    .CI(Mcount_ClkCount_cy[1]),
    .LI(\Mcount_ClkCount_cy<2>_rt_42 ),
    .O(Result[2])
  );
  MUXCY   \Mcount_ClkCount_cy<3>  (
    .CI(Mcount_ClkCount_cy[2]),
    .DI(N1),
    .S(\Mcount_ClkCount_cy<3>_rt_43 ),
    .O(Mcount_ClkCount_cy[3])
  );
  XORCY   \Mcount_ClkCount_xor<3>  (
    .CI(Mcount_ClkCount_cy[2]),
    .LI(\Mcount_ClkCount_cy<3>_rt_43 ),
    .O(Result[3])
  );
  MUXCY   \Mcount_ClkCount_cy<4>  (
    .CI(Mcount_ClkCount_cy[3]),
    .DI(N1),
    .S(\Mcount_ClkCount_cy<4>_rt_44 ),
    .O(Mcount_ClkCount_cy[4])
  );
  XORCY   \Mcount_ClkCount_xor<4>  (
    .CI(Mcount_ClkCount_cy[3]),
    .LI(\Mcount_ClkCount_cy<4>_rt_44 ),
    .O(Result[4])
  );
  MUXCY   \Mcount_ClkCount_cy<5>  (
    .CI(Mcount_ClkCount_cy[4]),
    .DI(N1),
    .S(\Mcount_ClkCount_cy<5>_rt_45 ),
    .O(Mcount_ClkCount_cy[5])
  );
  XORCY   \Mcount_ClkCount_xor<5>  (
    .CI(Mcount_ClkCount_cy[4]),
    .LI(\Mcount_ClkCount_cy<5>_rt_45 ),
    .O(Result[5])
  );
  MUXCY   \Mcount_ClkCount_cy<6>  (
    .CI(Mcount_ClkCount_cy[5]),
    .DI(N1),
    .S(\Mcount_ClkCount_cy<6>_rt_46 ),
    .O(Mcount_ClkCount_cy[6])
  );
  XORCY   \Mcount_ClkCount_xor<6>  (
    .CI(Mcount_ClkCount_cy[5]),
    .LI(\Mcount_ClkCount_cy<6>_rt_46 ),
    .O(Result[6])
  );
  MUXCY   \Mcount_ClkCount_cy<7>  (
    .CI(Mcount_ClkCount_cy[6]),
    .DI(N1),
    .S(\Mcount_ClkCount_cy<7>_rt_47 ),
    .O(Mcount_ClkCount_cy[7])
  );
  XORCY   \Mcount_ClkCount_xor<7>  (
    .CI(Mcount_ClkCount_cy[6]),
    .LI(\Mcount_ClkCount_cy<7>_rt_47 ),
    .O(Result[7])
  );
  MUXCY   \Mcount_ClkCount_cy<8>  (
    .CI(Mcount_ClkCount_cy[7]),
    .DI(N1),
    .S(\Mcount_ClkCount_cy<8>_rt_48 ),
    .O(Mcount_ClkCount_cy[8])
  );
  XORCY   \Mcount_ClkCount_xor<8>  (
    .CI(Mcount_ClkCount_cy[7]),
    .LI(\Mcount_ClkCount_cy<8>_rt_48 ),
    .O(Result[8])
  );
  MUXCY   \Mcount_ClkCount_cy<9>  (
    .CI(Mcount_ClkCount_cy[8]),
    .DI(N1),
    .S(\Mcount_ClkCount_cy<9>_rt_49 ),
    .O(Mcount_ClkCount_cy[9])
  );
  XORCY   \Mcount_ClkCount_xor<9>  (
    .CI(Mcount_ClkCount_cy[8]),
    .LI(\Mcount_ClkCount_cy<9>_rt_49 ),
    .O(Result[9])
  );
  XORCY   \Mcount_ClkCount_xor<10>  (
    .CI(Mcount_ClkCount_cy[9]),
    .LI(\Mcount_ClkCount_xor<10>_rt_50 ),
    .O(Result[10])
  );
  LUT6 #(
    .INIT ( 64'h8000000000000000 ))
  \PWM_FF/R_INV_1_o_SW0  (
    .I0(ClkCount[10]),
    .I1(ClkCount[5]),
    .I2(ClkCount[9]),
    .I3(ClkCount[4]),
    .I4(ClkCount[3]),
    .I5(ClkCount[8]),
    .O(N3)
  );
  LUT6 #(
    .INIT ( 64'h7FFFFFFFFFFFFFFF ))
  \PWM_FF/R_INV_1_o  (
    .I0(ClkCount[2]),
    .I1(ClkCount[1]),
    .I2(ClkCount[0]),
    .I3(ClkCount[7]),
    .I4(ClkCount[6]),
    .I5(N3),
    .O(\PWM_FF/R_INV_1_o_15 )
  );
  OBUF   PwmSig_OBUF (
    .I(\PWM_FF/Q1_1 ),
    .O(PwmSig)
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Mcount_ClkCount_cy<1>_rt  (
    .I0(ClkCount[1]),
    .O(\Mcount_ClkCount_cy<1>_rt_41 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Mcount_ClkCount_cy<2>_rt  (
    .I0(ClkCount[2]),
    .O(\Mcount_ClkCount_cy<2>_rt_42 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Mcount_ClkCount_cy<3>_rt  (
    .I0(ClkCount[3]),
    .O(\Mcount_ClkCount_cy<3>_rt_43 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Mcount_ClkCount_cy<4>_rt  (
    .I0(ClkCount[4]),
    .O(\Mcount_ClkCount_cy<4>_rt_44 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Mcount_ClkCount_cy<5>_rt  (
    .I0(ClkCount[5]),
    .O(\Mcount_ClkCount_cy<5>_rt_45 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Mcount_ClkCount_cy<6>_rt  (
    .I0(ClkCount[6]),
    .O(\Mcount_ClkCount_cy<6>_rt_46 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Mcount_ClkCount_cy<7>_rt  (
    .I0(ClkCount[7]),
    .O(\Mcount_ClkCount_cy<7>_rt_47 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Mcount_ClkCount_cy<8>_rt  (
    .I0(ClkCount[8]),
    .O(\Mcount_ClkCount_cy<8>_rt_48 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Mcount_ClkCount_cy<9>_rt  (
    .I0(ClkCount[9]),
    .O(\Mcount_ClkCount_cy<9>_rt_49 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Mcount_ClkCount_xor<10>_rt  (
    .I0(ClkCount[10]),
    .O(\Mcount_ClkCount_xor<10>_rt_50 )
  );
  BUFGP   Clk_pwm_BUFGP (
    .I(Clk_pwm),
    .O(Clk_pwm_BUFGP_0)
  );
  INV   \Mcount_ClkCount_lut<0>_INV_0  (
    .I(ClkCount[0]),
    .O(Mcount_ClkCount_lut[0])
  );
endmodule


`ifndef GLBL
`define GLBL

`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;

    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (weak1, weak0) GSR = GSR_int;
    assign (weak1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule

`endif

