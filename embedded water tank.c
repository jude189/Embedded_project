// LCD module connections
sbit LCD_RS at RB4_bit;
sbit LCD_EN at RB3_bit;
sbit LCD_D4 at RB2_bit;    ///
sbit LCD_D5 at RB1_bit;   //
sbit LCD_D6 at RD7_bit;   //
sbit LCD_D7 at RD6_bit;

sbit LCD_RS_Direction at TRISB4_bit;
sbit LCD_EN_Direction at TRISB3_bit;
sbit LCD_D4_Direction at TRISB2_bit;  //
sbit LCD_D5_Direction at TRISB1_bit;  //
sbit LCD_D6_Direction at TRISD7_bit;  //
sbit LCD_D7_Direction at TRISD6_bit;
// End LCD module connections

int timer;

void myydelayms( int mds) {
     int delay = mds; // 1 overflow = 1 ms
    timer = 0;                 // Reset overflow counter
    while (timer < delay);
}


void ATD_init_A1(){
ADCON0 = 0x41; // ATD ON, Dont go, channel 0, fosc/16
ADCON1 = 0xC0;
}

int ATD_read_A1(){
ADCON0 = ADCON0 | 0x04; // GO
while(ADCON0 & 0x04);
return ((ADRESH<<8) | ADRESL);
}






void CCPPWM_init(){                  // Configure and CCP2 at 2ms period with 50% duty cycle
        T2CON = 0x07;                    // Enable Timer2 at Fosc/4 with 1:16 prescaler (8 uS percount 2000uS to count 250 counts)
        CCP2CON = 0x0C;                  // Enable PWM for CCP2
        PR2 = 250;                       // 250 counts = 8uS *250 = 2ms period
        CCPR2L = 125;                    // Buffer where we are specifying the pulse width (duty cycle)
}


void Speed(int p){
       CCPR2L = p;                  // PWM from RC1
}




char txt[5];              // General used variable while printing on LCD

unsigned int LCD_Page=0;  // page 0 or 1


int k3=0;     // genaral used while making mathmatic calculations

int angle = 100;  // using to determine the LCD shutter Servo ange

unsigned  int x=0;  // general used

 // Temperature reading used variable using NTC
int finaltemp=0;
int adc = 0;
int TX_Temp;
int TEMPERATURE =0;
int T=0 ;
int T0=1/298;     //  25°C = 298.15 Kelvin .
int  BB=1/3380 ;    //  BB is the beta constant of the NTC =3380 (SEE DATASHEET).
//End of Temperature reading used variable using NTC


//Ultrasonic Distance reading variables
int Distance=0;
long k1=0;
long j=0;
char check_sonic = 0;
char Index = 0;
//End of Ultrasonic Distance reading variables


// Level and Pump Motor variables
int Master_T_Height         = 21;
int Master_T_Pump_OFF_Level = 15;
int Master_T_Minimum        = 5;
int Master_T_Pump_ON_Level  = 10;
int Master_T_Level          = 0;

int Pump_T_Height    = 21;
int Pump_T_Maximum   = 15;
int Pump_T_ON_Level  = 8;
int Pump_T_OFF_Level = 5;
int Pump_T_Level     = 0;
//End Level and Pump Motor variables

int Humidity         = 0;

char Servo_Flag=0;

char Openning_Flag=0; // LCD Shutter ON or OFF indicater flag bit

// Fan Motor related variables
int Increased_temp=0;
int Board_min_temp=40;
int Board_max_temp=80;
int temp_percentage=0;
//End of Fan Motor related variables

int First_ON_Flag=1;



int humid=0;
unsigned short T_byte1, T_byte2, RH_byte1, RH_byte2, CheckSum ;
// End DHT11 sensor connection


void Start_Signal(void) {     // DHT11 Releated
  PORTC=PORTC & 0B11101111;   // Configure connection pin as output
  TRISC =TRISC&0B11101111;                              // Connection pin output low
  myydelayms(25);                               // Wait 25 ms
  TRISC =TRISC|0B00010000;                              // Connection pin output high
  myydelayms(25);                               // Wait 25 us
  PORTC =PORTC|0B00010000;                     // Configure connection pin as input
}

unsigned short Check_Response() {  // DHT11 Releated
  TMR1H = 0;                                  // Reset Timer1
  TMR1L = 0;
  TMR1ON_bit = 1;                             // Enable Timer1 module
  while(!(PORTC&0B00010000) && TMR1L < 100);           // Wait until DHT11_PIN becomes high (cheking of 80µs low time response)
  if(TMR1L > 99)                              // If response time > 99µS  ==> Response error
    return 0;                                 // Return 0 (Device has a problem with response)
  else {    TMR1H = 0;                        // Reset Timer1
    TMR1L = 0;
    while(PORTC&0B00010000 && TMR1L < 100);          // Wait until DHT11_PIN becomes low (cheking of 80µs high time response)
    if(TMR1L > 99)                            // If response time > 99µS  ==> Response error
      return 0;                               // Return 0 (Device has a problem with response)
    else
      return 1;                               // Return 1 (response OK)
  }
}

unsigned short Read_Data(unsigned int* dht_data) {  // DHT11 Releated
  int i;
  *dht_data = 0;
  for(i = 0; i < 8; i++){
    TMR1H = 0;                                // Reset Timer1
    TMR1L = 0;
    while(!(PORTC&0B00010000))                         // Wait until DHT11_PIN becomes high
      if(TMR1L > 100) {                       // If low time > 100  ==>  Time out error (Normally it takes 50µs)
        return 1;
      }
    TMR1H = 0;                                // Reset Timer1
    TMR1L = 0;
    while(PORTC&0B00010000)                          // Wait until DHT11_PIN becomes low
      if(TMR1L > 100) {                       // If high time > 100  ==>  Time out error (Normally it takes 26-28µs for 0 and 70µs for 1)
        return 1;                             // Return 1 (timeout error)
      }
     if(TMR1L > 50)                           // If high time > 50  ==>  Sensor sent 1
       *dht_data |= (1 << (7 - i));           // Set bit (7 - i)
  }
  return 0;                                   // Return 0 (data read OK)
}


void DHT11() {     // DHT11 Releated


  T1CON = 0x10;                    // Set Timer1 clock source to internal with 1:2 prescaler (Timer1 clock = 1MHz)
  TMR1H = 0;                       // Reset Timer1
  TMR1L = 0;



    Start_Signal();                // Send start signal to the sensor

    if(Check_Response()) {         // Check if there is a response from sensor (If OK start reding humidity and temperature data)

      if(Read_Data(RH_byte1) || Read_Data(RH_byte2) || Read_Data(T_byte1) || Read_Data(T_byte2) || Read_Data(Checksum)) {

      }
      else {                                               // If there is no time out error
        if(CheckSum == ((RH_Byte1 + RH_Byte2 + T_Byte1 + T_Byte2) & 0xFF)) {

        }

      }
    }





    myydelayms(100);         // Wait 1 second


}




void Read_Print_Control(){

  Sound_Init(&PORTC, 5);

  Sound_Play(2600, 100);
  Sound_Play(2400, 100);
  Sound_Play(2600, 100);

  myydelayms(500);

  Sound_Play(2600, 100);
  Sound_Play(2400, 100);
  Sound_Play(2600, 100);

      Lcd_Out(1, 2, "LEVEL & PUMP");
      myydelayms(2000);

      lcd_cmd(_LCD_CLEAR);
      Lcd_Out(1, 3, "DESIGNED By");
      Lcd_Out(2, 3, "ENG Leen Bilto");
      myydelayms(2000);







                // Reading Tempereture using NTC and determining sound speed according to tempereture

                adc  = ATD_read_A1();

                T=T0+(BB*log((1023/adc)-1));     // PROBMEL IS HERE , NO ENOGH RAM TO MAKE mathmatics
                T=1/T;
                T=T-273.15;
                k3=T;

                myydelayms(20);         // time for Ultrasonic circuit stabilization .

                TX_Temp=T ;           // Tempereture with out floats

                finaltemp=(331.3+(0.606*T)); // finaltemp m/s=(331.3 + (0.606 * Tc))m/s . Tc is the temperature in Celsius .
                finaltemp= finaltemp*100 ;        // finaltemp Cm/s .
                //Reading Tempereture using NTC and determining sound speed according to tempereture


                myydelayms(100);

                DHT11();   // Reading Humidity

                // Fan motot ON/OFF control
          if(TX_Temp> 40){
                          increased_temp = TX_Temp - Board_min_temp ;
                          temp_percentage = Increased_temp / 40 ; //  Board_max_temp - Board_min_temp = 40 .

                          Speed(temp_percentage);  // Maximinm pulse width (duty cycle) = 255 = maximum fan motor speed .


                          }
          if(TX_Temp<40){ Speed(0); } //if tempereture is less than 40 digree celsious Stop Fan motor .
                //End of Fan motot ON/OFF control




       // Reading Distance for both tanks using Ultrasonic module


                  Distance=0;
                  k1=0;
                  check_sonic=0;




              TMR1H =0B00000000;                           //Sets the Initial Value of Timer1 .
              TMR1L =0B00000000;                           //Sets the Initial Value of Timer1 .

        if(Index==1){
                     PORTC=PORTC|0B00000100;           // TRIGERING
                     myydelayms(10);
                     PORTC=PORTC&0B11111011;
                    }
        if(Index==2){
                     PORTD=PORTD|0B00000001;           // TRIGERING
                     myydelayms(10);
                     PORTD=PORTD&0B11111110;
                    }


              if(Index==1){for(j=0;j<=50000;j++){if(PORTC&0X08){  break;}delay_us(1);}}  // If you increase the delay time more than j<=50000; that me effect on performance of   void External_Powered()
              if(Index==2){for(j=0;j<=50000;j++){if(PORTD&0X2){  break;}delay_us(1);}}

              T1CON=T1CON|0X01; // timer on



              if(Index==1){for(j=0;j<=50000;j++){if(!(PORTC&0x04)){ break;} delay_us(1);}}
              if(Index==2){for(j=0;j<=50000;j++){if(!(PORTD&0x02)){ break;} delay_us(1);}}

              T1CON=T1CON&0b11111110;    // stop TIMER1

              k1 = ((TMR1H<<8)|TMR1L  );  //Reads Timer1 Value

             //k1= SpeedOfSound*( (float)k1/2000000)/2;        //       000000000000




            Distance=k1/58;    // converting from (Longe k1 variable To  unsigned int Distance variable ) , Long variable may cary decimal values which cannot be transmitteted as UART .
         //End of Reading Distance for both tanks using Ultrasonic module

            // Calculating liquid  levels for both tanks
           if(Index==1){Master_T_Level = Master_T_Height - Distance ;}
           if(Index==2){Pump_T_Level   = Pump_T_Height   - Distance ;}
            //End of Calculating liquid  levels for both tanks

           Index++;



           myydelayms(100);



        // pringting all reading on LCD for both pages
     if(LCD_Page==0){   // page 0
              lcd_cmd(_LCD_CLEAR);

              IntToStr(Master_T_Level , txt);
              LTRIM(txt);
              Lcd_Out(1, 1, "Master  ");
              Lcd_Out_Cp(txt);
              Lcd_Out_Cp("cm");


              IntToStr(Pump_T_Level , txt);
              LTRIM(txt);
              Lcd_Out(2, 1, "Pump    ");
              Lcd_Out_Cp(txt);
              Lcd_Out_Cp("cm");


     if(LCD_Page==1){  // page 1

              lcd_cmd(_LCD_CLEAR);
              IntToStr(TX_Temp , txt);
              LTRIM(txt);
              Lcd_Out(1, 1, "Temp  ");
              Lcd_Out_Cp(txt);
              Lcd_Chr_Cp(223);     // Digree symbole
              Lcd_Chr_Cp('C');




              IntToStr(RH_Byte1, txt);
              LTRIM(txt);
              Lcd_Out(2, 1, "Humid ");
              Lcd_Out_Cp(txt);
              Lcd_Out_Cp("%");


                    }
            //End of pringting all reading on LCD for both pages

               // Controlling Pump motot ON/OFF according to dertemined level settingg ( see the variables )
              if(Master_T_Level <= Master_T_Pump_ON_Level & Pump_T_Level >= Pump_T_ON_Level  ){PORTD=PORTD|0X10;} // Pump ON
              if(Master_T_Level >= Master_T_Pump_OFF_Level || Pump_T_Level <= Pump_T_OFF_Level  ){PORTD=PORTD&!0X10;}
              //End Controlling Pump motot ON/OFF according to dertemined level settingg

              myydelayms(200);

      // ON/OFF LCD Shutter
      if(First_ON_Flag==1){
                           First_ON_Flag = 0;
                           Openning_Flag=1;

                           while(angle<183 ) {
                             if(angle<183){angle++;} //   was 225

                             for(x=0;x<=1900;x++){if(x<angle){PORTD=PORTD|0X04;}else{PORTD=PORTD&!0X04;} }   // 1400 had been calibrated using oscilloscope to be 20ms

                                             }

                           }


      if(Openning_Flag==0){
      while(PORTC&0X40 )
            {
              Openning_Flag=1;

             if(PORTC|0X40){if(angle<183){angle++;}} //   was 225

             for(x=0;x<=1900;x++){if(x<angle){PORTD=PORTD|0X04;}else{PORTD=PORTD& !0X04;} }   // 1400 had been calibrated using oscilloscope to be 20ms

            } }

      if(Openning_Flag==1){
      while(!(PORTC&0X40))
            {
              Openning_Flag=0;

             if(PORTC=PORTC& !0X40){if(angle>43){angle--;}} //   was 48

             for(x=0;x<=1900;x++){if(x<angle){PORTD.F2=1;}else{PORTD=PORTD& !0X04;} }   // 1400 had been calibrated using oscilloscope to be 20ms

            }  }
        //End of ON/OFF LCD Shutter




      } }



void interrupt(){

     if(INTCON & 0x04){
         timer++;

         INTCON = INTCON & 0xFB;

     }



        if(INTCON & 0x02){     // Interrupt action for scrolling through the 2 LCD pages ( page 0 or 1)

                          if(!(PORTB&0X01)){
                          if(LCD_Page==0){LCD_Page = 1;}
                          if(LCD_Page==1){LCD_Page = 0;}


                          if(!(PORTC&0X01)){Servo_Flag=1;}
                                          }
                           INTCON = INTCON & 0B11111101;//Clear T0IF

                          }


                 }



void main() {


     TRISA=0B11111011;
     TRISB=0B00000001;
     TRISC=0B01001001;
     TRISD=0B00000010;
     TRISE=0X00;


     INTCON = 0b11110000; //GIE and , T0IE, TIMER0


     T1CON = 0B00000000;     //Initializing Timer Module at prescaler value of 1:1


     OPTION_REG = 0x87; // 1ms overflow
     TMR0 = 238;






      // LCDTRISB=0X01;         //ALL OUPUT , RB0 INPUT
     PORTB=0X01;   // LCD ON/OFF Port                                                                                         Q


     PORTD=0X20;   // LCD LED  ON/OFF Port
     // End of LCD

     // NTC Ports           Give 5

     PORTA=PORTA&0X04;   // Giving VDD to NTC

  // LCD initialization
     Lcd_Init();
     lcd_cmd(_LCD_CURSOR_OFF);  // Cursor off.
     lcd_cmd(_LCD_CLEAR);       // Clear display.
  // End of LCD initialization


     myydelayms(200);


     angle = 224;


     while(angle>43)   // calibrate the shutter at right angle .
            {
            angle--;
            for(x=0;x<=1900;x++){if(x<angle){PORTD=PORTD|0x04;}else{PORTD=PORTD& !0x04;} }   // 1400 had been calibrated using oscilloscope to be 20ms
            }
         while(1){
     myydelayms(100);

     Read_Print_Control();
     }
     }