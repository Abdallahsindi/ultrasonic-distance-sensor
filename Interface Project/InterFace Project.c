// ======================================
// Ultrasonic Distance Meter
// PIC16F877A + HC-SR04 + LCD 16x2
// Crystal: 8 MHz
// Compiler: MikroC PRO for PIC
// ======================================

// -------- LCD pin definitions ----------
sbit LCD_RS at RD2_bit;
sbit LCD_EN at RD3_bit;
sbit LCD_D4 at RD4_bit;
sbit LCD_D5 at RD5_bit;
sbit LCD_D6 at RD6_bit;
sbit LCD_D7 at RD7_bit;

sbit LCD_RS_Direction at TRISD2_bit;
sbit LCD_EN_Direction at TRISD3_bit;
sbit LCD_D4_Direction at TRISD4_bit;
sbit LCD_D5_Direction at TRISD5_bit;
sbit LCD_D6_Direction at TRISD6_bit;
sbit LCD_D7_Direction at TRISD7_bit;
// --------------------------------------

unsigned int distance;
char txt[7];

void main() {

   // -------- I/O Configuration ----------
   TRISB = 0b00010000;   // RB4 = Echo (input), RB0 = Trig (output)
   PORTB = 0x00;

   TRISD = 0x00;         // LCD on PORTD
   PORTD = 0x00;
   // ------------------------------------

   // -------- LCD Initialization --------
   Lcd_Init();
   Lcd_Cmd(_LCD_CLEAR);
   Lcd_Cmd(_LCD_CURSOR_OFF);

   Lcd_Out(1,1,"Ultrasonic");
   Lcd_Out(2,1,"Distance Meter");
   Delay_ms(2000);
   Lcd_Cmd(_LCD_CLEAR);
   // ------------------------------------

   // -------- Timer1 Configuration -------
   // Fosc = 8 MHz
   // Fosc/4 = 2 MHz
   // Prescaler = 1:2  ? Timer tick = 1 µs
   T1CON = 0x10;        // T1 prescaler 1:2, Timer1 OFF initially
   // ------------------------------------

   while(1) {

      // Clear Timer1
      TMR1H = 0;
      TMR1L = 0;

      // Send 10 us trigger pulse
      PORTB.F0 = 1;
      Delay_us(10);
      PORTB.F0 = 0;

      // Wait for echo to go high
      while(!PORTB.F4);

      // Start Timer1
      T1CON.F0 = 1;

      // Wait for echo to go low
      while(PORTB.F4);

      // Stop Timer1
      T1CON.F0 = 0;

      // Read timer value
      distance = (TMR1H << 8) | TMR1L;

      // Convert time (µs) to distance (cm)
      // distance(cm) ˜ time / 58
      distance = distance / 58;

      Lcd_Cmd(_LCD_CLEAR);

      if(distance >= 2 && distance <= 400) {

         IntToStr(distance, txt);
         Ltrim(txt);

         Lcd_Out(1,1,"Distance:");
         Lcd_Out(2,1,txt);
         Lcd_Out(2,5,"cm");
      }
      else {
         Lcd_Out(1,1,"Out of range");
      }

      Delay_ms(400);
   }
}