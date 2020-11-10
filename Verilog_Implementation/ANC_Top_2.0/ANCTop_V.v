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
//module ANCTop_V(
//    SCK,
//    SDI,
//    Reset,
//    Clk_100M,
//    SDO,
//    AudioL,
//    AudioR	
//   );

module ANCTop_V(
   Clk_100MIn,
   SCK,
   SDI,
   SDO,
   ResetSwitch,
   AudioL,
   AudioR,
   SPI_LED,
   SPIDataLED
);

// I/O Control
input         Clk_100MIn;
input         SCK;
input         SDI;
input         ResetSwitch;
output        SDO;
output        AudioL;
output        AudioR;
output        SPI_LED;
output [5:0]  SPIDataLED;


// Variables
wire          RamShiftEN;
wire          FilterEN;
wire          Synch;
wire          FiltComplete;
wire          PwmSig;
wire          GlobalReset;
wire [10:0]   WzIn;
wire [10:0]   WzOut;
wire [10:0]   FiltOut;
wire [10:0]   DataSigIn;
wire [10:0]   Err;
wire [10:0]   ANCAudioOut;
wire [10:0]   SPIDataout;
wire          Clk_100M;
              
reg  [4: 0]   PowerOnReset;
reg  [14:0]   LED_Blink;
reg           Clk_Div;



// Initialise 
initial begin
   PowerOnReset = 5'b 0;
   LED_Blink    = 15'b 0;
end

// LED bliinks for 16,000 Samples
assign SPI_LED      = LED_Blink[14];
assign Clk_100M = Clk_Div;
// Power on reset logic
assign  GlobalReset = PowerOnReset[3];   //~ResetSwitch ||

//temp$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
assign SPIDataLED = {SPIDataout[8], SPIDataout[7],SPIDataout[6], SPIDataout[5], SPIDataout[4], SPIDataout[3]};

always @ (posedge Clk_100MIn)
begin
    Clk_Div  = ~ Clk_Div;
end

always @ (negedge Clk_100M)
begin
   PowerOnReset  <= PowerOnReset[4]== 1'b 0 ? PowerOnReset + 1'b 1 : PowerOnReset;
end

always @ (posedge SSPIF)
begin
   LED_Blink = LED_Blink + 1'b 1;
end

// SPI Block
SPI_v ReadNoise (
        .SCK(SCK), 
        .SDI(SDI), 
        .SDO(SDO), 
        .Reset(GlobalReset),
        .DataOut(SPIDataout), 
        .SSPIF(SSPIF)
    );

// Control Block
ANCControl_V ControlBlock (
        .Clk_100M(Clk_100M), 
        .SSPIF_In(SSPIF), 
        .RAMDataEN(RamShiftEN), 
        .FilterEN(FilterEN), 
        .Reset(GlobalReset)
    );

// Audio Data memory block
ANCDataMem_V DataMemBlock (
		.RamShiftEN_In(RamShiftEN), 
		.FilterEN_In(FilterEN), 
		.Clk_100M(Clk_100M),
        .Reset(GlobalReset),		
		.SPIData_In(SPIDataout), 
		.DataOut(DataSigIn)
	);
	
// Coefficient memory block
ANCCoefMem_V CoefMemBlock (
	    .FilterEN_In(FilterEN), 
	    .Clk_100M(Clk_100M), 
	    .Reset(GlobalReset), 
	    .Wz_In(WzIn), 
	    .WzOut(WzOut), 
	    .FiltComplete(FiltComplete)
   );

// Adaptation logic for LMS
ANCAdapt_V AdaptBlock (
		.FilterEN_In(FilterEN), 
		.Clk_100M(Clk_100M), 
		.Err_In(Err), 
		.Reset(GlobalReset),
        .Synch(Synch),	
		.Sig_In(DataSigIn), 
		.Wz_In(WzOut), 
		.WzOut(WzIn)
	);
	
// Filter Block
ANCFilter_V FilterBlock (
        .FilterEN_In(FilterEN), 
        .Clk_100M(Clk_100M), 
        .Reset(GlobalReset), 
        .Sig_In(DataSigIn), 
        .Wz_In(WzIn), 
        .Synch_In(Synch), 
        .FiltOut(FiltOut)
    );	
	
// Saturaton and error generation
ANCSaturation_V SaturationBlock(
        .Clk_100M(Clk_100M),
		.Reset(GlobalReset),
	    .Err(Err),
	    .Filt_In(FiltOut),
	    .MicIn(SPIDataout),
	    .FiltComplete_In(FiltComplete),
	    .ANCAudioOut(ANCAudioOut)
   );
    
// PWM driving Block   
PWM_v PWMBlock (
        .Clk_pwm(Clk_100M), 
        .PwmSig(PwmSig), 
        .SigVec(ANCAudioOut)
    );
   
 // Audio driving out
assign AudioL = ~PwmSig;
assign AudioR = ~PwmSig;
 
endmodule
