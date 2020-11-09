// RB4 - Reset
// RB5 - LED blink/ 20000 samples
// RA0 - ADC input
// RC5 - SDO
// RC4 - SDI/ NC
// RC3 - SCK
// RB2 - SSPIF  
// RB1 - ADC indicator (ADC signal received)
 
 
 
 #include "includes.h"
 
 // #define _XTAL_FREQ 20000000
 // #define Sample_freq 44000
 
 __CONFIG(HS & WDTDIS & LVPDIS & BORDIS );
 
 //Globals 
 unsigned char ADC_result;    // to accommodate 10 bit ADC result
 unsigned char ADC_old;    // to accommodate 10 bit ADC result
 unsigned int LEDIndicator;   // to blink after every  20,000 ADC conversions 
 bit flag;
 
 //Prototype 
 void init();
 int interrupt ISR();

 void main()
 {
	 	
	//Initialize all the registers
	init();
	
	while(1)
	{
		if (LEDIndicator > 20000)
		{
			RB5 = ~ RB5;
			LEDIndicator =0u;
			
		}
		
		// Simulating the SSPIF signal to FPGA
		if (flag == FALSE && SSPIF == 1)
		{
			RB2 = 1;
			NOP();
			NOP();
			NOP();
			NOP();
			SSPIF =0;
			RB2 = 0;
		}
	}
	 
	 
 }
 
 
 void init()
 {
	 ADC_result = 0u;
	 ADC_old = 0u;
	 flag = FALSE;
	 LEDIndicator =0u;
	 
	// PIC initialisation
	TRISA = 0XFF;   // all input
	TRISB = 0x00;   // PORTB out
	PORTB = 0x00;   // Port pin 0
	//ADC initialisation
	ADCON0 = 0X81; // Fosc/32, AN0, ADC_ON
	ADCON1 = 0X8E; // MSB right, AN0
	
	// SPI initialisation
	SSPSTAT = 0x00;
	SSPCON = 0x20; // FOsc/4;
	TRISC5 =0;     // SDO out
    TRISC3 = 0;    // SCK Out	
	//TIMER initialisation
	OPTION = 0xF; // No prescalar.
	TMR0 = 0x5A;    // 255 -165  ( 33 uS)
	
	//Interrpt register
	INTCON =0x60;     // Timer interrupt
	SSPIE = 1;        // SPI interrupt enabled
	// Start the functions after a small delay
	__delay_ms(2);
	GIE =1;           // Global interrupt enable
	__delay_ms(1);
	GODONE =1;        // Start ADC
	
	// Just generatin		g reset signal
	__delay_ms(10);
	RB4 = 1;
	RB4 = 0;
	
 }

 
 
 
int interrupt ISR()
{
	if (T0IF == 1)
	{
		T0IF = 0;
		TMR0 = 0x5A;
		
		if (GODONE == 0 && flag == FALSE)
		{
			ADC_result = ADRESL;
			flag = TRUE;
			SSPBUF = ADRESH;
			NOP();    
			NOP();
            ADIF =0;    //Simply clearing ADIF 			 
			NOP();			
			NOP();			
			NOP();
            NOP(); 			
            NOP(); 			
            NOP(); 			
            NOP(); 			
            NOP(); 			
            NOP(); 			
            NOP(); 			
            NOP(); 			
            NOP(); 			
            NOP();         
			LEDIndicator = LEDIndicator +1;        
			GODONE = 1;
		}	
    }
	
	if(SSPIF == 1)
	{
		SSPIF =0;
		
		if (flag ==TRUE)
		{
			SSPBUF = ADC_result;
			flag =FALSE;
		}
	}
		
}