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
module ANC_Top(
    SCK,
    SDI,
    Reset,
    Clk_100M,
    SDO,
    AudioL,
    AudioR	
   );

     
// I/O control
input   SCK;                                                                   // SPI Clock from Master(PIC)
input   SDI;                                                                   // SPI data
input   Reset;                                                                 // Reset signal from Master
input   Clk_100M;                                                              // Clock Xtal
output  SDO;                                                                   // SDO data SPI. Not connected to SPI master.
output  AudioL;                                                                // PWM AudioL to stereo connector 
output  AudioR;                                                                // PWM AudioR to stereo connector 
                                                                               
                                                                               
//Variables                                                                  
wire           EN1;                                                            // Signal used to derive EN signal from it.
wire           wea_control;                                                    // Control signal used to generate wea signal
wire           wea;                                                            // Write enable bit for RAM
wire           AddrIncrement;                                                  // Clk_100M / 4 signal
wire           Clk;                                                            // Clk_100M & EN
wire           ClkInv;                                                         // Clk iinverted
wire   [10:0]  RAMDin;                                                         // 
wire           SSPIFDetected;                                                  // Detects the SSPIF signal
wire   [10:0]  SPIDataout;                                                     // Wire for SPI out. Bit 11 signa bit. Bit 10 will be stuffed 0
wire   [7 :0]  addra;                                                          // RAM address 8 bit (256 locations)
wire   [7: 0]  addragen;                                                       // RAM address intermediate variable
wire   [20:0]  WzFiltN_MulResult;                                              // Err * Signal_w;
wire   [20:0]  WzNew_w;                                                        // New calculated value for Wz. Will write to DIN at 3rd -ve edge
wire   [10:0]  Signal_w;                                                       // Contains the origina data to be processed in each clk cycle.
wire   [20:0]  FiltN_MulResult;                                                // Multiplied value Wz * Signal_wire iin each clock cycle.
wire   [20:0]  FiltSum_AddResult;                                              // Filter sum        
wire   [20:0]  ErrData_AddResult_w;                                            // Error =  Micdata + FiltSum calculted at the end of 63rd cycle
wire   [10:0]  dina;                                                           // RAM input wire
wire   [10:0]  douta;                                                          // RAM output wire
wire   [20:0]  FiltSumFinal;                                                   // Final sum signal 

reg            EN_LastClk;                                                     // EN signal status for lst clock cycle
reg            EN;                                                             // Enable signal. Start from SSPIF and end at end of 63rd cycle 
reg            EN2;                                                            // En with 1 extra pulse 
reg    [10:0]  MicData;                                                        // SPI data stored                           
reg    [20:0]  FiltSum;                                                        // Filter sum Signal_wire * Wz
reg    [10:0]  dinaReg;                                                        // Controls the DIN for RAM
reg    [20:0]  FiltNResult;                                                    // Signal_wire * Wz in each cycle
reg    [5 :0]  RamAddrGen;                                                     // Ram address generator for each cycle
reg    [10:0]  Signal;                                                         // Signal register
reg    [10:0]  Err;                                                            // Error signal calculated at the end of 63rd cycle
reg    [10:0]  Wz;                                                             // Wz value read from RAM
reg    [7 :0]  RamSigAddr;                                                     // RAM address generated for signal (0-63) address range
reg    [7 :0]  RamWzAddr;                                                      // RAM address generated for Wz (64-126) address range
reg    [1 :0]  ClkDivider4;                                                    // Divide clock by 4 to increment counter
reg    [7 :0]  ResetCount;                                                     // Counter used to reset the EN signal
reg    [9 :0]  AudioDataOut;                                                   // AudioData to be convert to PWM
reg    [1 :0]  ControlReg;                                                     // Control signal for Clk control
                                                                                  // 00 : Signal read
                                                                                  // 01 : Wz read
                                                                                  // 10 : Signal shift write
                                                                                  // 11 : Wz(new) write

// Variable initialise
initial begin
    ResetCount     <= 8'b  0;
	ClkDivider4    <= 2'b  0;
	ControlReg     <= 2'b  0;
	FiltSum        <= 20'b 0;
	FiltNResult    <= 20'b 0;
	Err            <= 11'b 0;
end

//-----------------------------------------------------------------------------//

// generic control logic

assign addragen       = ControlReg[0]== 1'b 1   ? RamSigAddr : RamWzAddr;
assign addra          = (ResetCount == 8'd 254) ? 1'b 0      : addragen;
assign RAMDin         = (ResetCount == 8'd 254) ? MicData    : dinaReg;
assign wea            = (ResetCount == 8'd 254) ? 1'b 1      : (~(ControlReg[1]^ControlReg[0]) && EN);
assign Signal_w       = (ResetCount == 8'd 250) ? MicData    : Signal;
assign AddrIncrement  = (~ClkDivider4[0] & ~ClkDivider4[1]) ^ (~EN1);          // logic to reset the RamAddrGen to 62 at negedge of EN
assign Clk            = Clk_100M & EN;
assign ClkEN1         = Clk_100M & EN1; 
assign dina           = RAMDin;
assign EN1            = (~ResetCount[7])||(~ResetCount[6])||(~ResetCount[5])||(~ResetCount[4])||(~ResetCount[3])||(~ResetCount[2])||(~ResetCount[1])||(ResetCount[0]); //EN dis @ 253
assign SSPIFDetected  = SSPIF ^ ClkEN1;
assign FiltSumFinal   = RamAddrGen  == 6'd 62 ? 20'b 0 : FiltSum;

always @ (posedge Clk)
begin
    RamWzAddr        <= RamAddrGen  +  8'd 64;
    Signal           <= ControlReg  == 2'b 01 ? douta : Signal;
    Wz               <= ControlReg  == 2'b 10 ? douta : Wz;
    dinaReg          <= ControlReg  == 2'b 10 ? Signal_w : { WzNew_w[20],WzNew_w[9:0]};//WzNew_w[20], &&&&&&&&&&&&&&&&&&&&&&&&&
    RamSigAddr       <= ControlReg  == 2'b 10 ? RamAddrGen + 1'b 1 : RamAddrGen;
    FiltSum          <= ControlReg  == 2'b 11 ? FiltSum_AddResult  : FiltSumFinal;
end

always @ (posedge Clk_100M)
begin
	EN_LastClk       <= EN1;
	EN2              <= EN? 1'b 1 : 1'b 0;
    ClkDivider4      <= EN? ClkDivider4 + 1'b 1  : 2'b 0;
    ControlReg       <= EN? ControlReg  + 1'b 1 : 2'b 0;
end

always @ (negedge Clk_100M)
begin
    EN               <= ResetCount != 8'd 0 ? (EN1 && 1'b 1)  : 1'b 0;
end

always @ (negedge Clk)
begin
    FiltNResult      <= ControlReg  == 2'b 11 ? FiltN_MulResult : FiltNResult;
end

always @(posedge AddrIncrement)
begin
    RamAddrGen       <= EN ? RamAddrGen - 1'b 1 : 6'd 62;
end

always @ (negedge EN)
begin
	Err             <= ErrData_AddResult_w[10:0];
	AudioDataOut    <= {~FiltSum[20],FiltSum[8:0]};                            // Inverting the sign bit help to offset the value by 512
end

always @ (posedge SSPIFDetected)
begin
	MicData          <= SPIDataout;
	ResetCount       <= EN_LastClk? ResetCount + 1'b 1 : 8'b 0;                // If EN signal was FALSE Reset count will reset to 0;
end
//-----------------------------------------------------------------------------//

// Instantiate the SPI module
SPI_v ReadNoise (
    .SCK(SCK), 
    .SDI(SDI), 
    .SDO(SDO), 
    .Reset(Reset),
    .DataOut(SPIDataout), 
    .SSPIF(SSPIF)
    );


//-----------------------------------------------------------------------------//

// instance of Memory block
BlockRam Memory (
  .clka(~Clk),                                                                 // input  clka
  .ena(EN),                                                                   // input  ena
  .wea(wea),                                                                  // input  [0 : 0] wea
  .addra(addra),                                                              // input  [7 : 0] addra
  .dina(dina),                                                                // input  [10: 0] dina
  .douta(douta)                                                               // output [10: 0] douta
);

// FiltNResult = Wz * Signal_w;
Multiplier FilterMul (
    .a(Signal_w), 
    .b(Wz), 
    .MulOut(FiltN_MulResult),
	.en(EN2)
    );
    
//     WzFiltN_MulResult = Err * Signal_w; mu (1/64) will calculte while add
Multiplier WzMul (
    .a(Signal_w), 
    .b(Err), 
    .MulOut(WzFiltN_MulResult),
	.en(EN2)
    );

//FiltSum = FiltSum + FiltNResult;
SignedAdder FilterAdd (
    .a(FiltSum), 
    .b(FiltNResult), 
    .AddOut(FiltSum_AddResult),
	.en(EN2)
    );
    
//Wz = Wz - WzFiltN_MulResult;
SignedAdder WzAdder (
    .a({Wz[10],10'b 0,Wz[9:0]}), 
    .b({~WzFiltN_MulResult[19], 6'b 0 ,WzFiltN_MulResult[19:6]}),      // 1/64     &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
    .AddOut(WzNew_w),
	.en(EN2)
    );

//Err = Micout + FiltSum;
SignedAdder ErrAdd (
    .a({MicData[10],10'b 0,MicData[9:0]}),                 // Extending 10 bit data to 20 bit
    .b(FiltSum), 
    .AddOut(ErrData_AddResult_w),
	.en(EN2)
    );
//--------------------------------------------------------------------------//
// Instance of PWM DAC for audio out     
PWM_v DAC_out (
    .Clk_pwm(Clk_100M), 
    .PwmSig(AudioL), 
    .SigVec(AudioDataOut)
    );

assign AudioR = AudioL;

endmodule
