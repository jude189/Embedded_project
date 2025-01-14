void My_DelayMs(unsigned int ms) {
    unsigned int i, j;
    for(i = 0; i < ms; i++) {
        for(j = 0; j < 167; j++) {
            asm { NOP }
        }
    }
}

void My_DelayUs(unsigned int us) {
    unsigned int i;
    for(i = 0; i < us; i++) {
        asm { NOP }
        asm { NOP }
    }
}

void My_SoundPlay(unsigned long freq, unsigned int duration_ms) {
    unsigned long i, toggleCount;
    unsigned int halfPeriod_us;
    toggleCount = (freq * duration_ms) / 1000UL;
    halfPeriod_us = (unsigned int)(500000UL / freq);
    for(i = 0; i < toggleCount; i++){
        PORTC |= (1 << 5);
        My_DelayUs(halfPeriod_us);
        PORTC &= ~(1 << 5);
        My_DelayUs(halfPeriod_us);
    }
}

void My_ADC_Init(void) {
    ADCON1 = 0x84;
    ADCON0 = 0x00;
    ADCON0 = 0b01000001;
}

unsigned int My_ADC_Read(unsigned short channel) {
    ADCON0 &= 0b11000101;
    channel <<= 3;
    ADCON0 |= channel;
    My_DelayMs(2);
    ADCON0 |= (1 << 2);
    while(ADCON0 & (1 << 2)) {}
    return ((ADRESH << 8) + ADRESL);
}

void My_PWM2_Init(void) {
    PR2     = 124;
    T2CON   = 0b00000001;
    CCP2CON = 0b00001100;
    CCPR2L  = 0x00;
    T2CON |= (1 << 2);
}

void My_PWM2_SetDuty(unsigned char duty) {
    CCPR2L      = duty >> 2;
    CCP2CON = (CCP2CON & 0xCF) | ((duty & 0x03) << 4);
}

void My_PWM2_Start(void) {
    T2CON |= (1 << 2);
}

void My_PWM2_Stop(void) {
    T2CON &= ~(1 << 2);
    PORTC &= ~(1 << 1);
}

sbit LCD_RS at RB4_bit;
sbit LCD_EN at RB3_bit;
sbit LCD_D4 at RB2_bit;
sbit LCD_D5 at RB1_bit;
sbit LCD_D6 at RD7_bit;
sbit LCD_D7 at RD6_bit;

sbit LCD_RS_Direction at TRISB4_bit;
sbit LCD_EN_Direction at TRISB3_bit;
sbit LCD_D4_Direction at TRISB2_bit;
sbit LCD_D5_Direction at TRISB1_bit;
sbit LCD_D6_Direction at TRISD7_bit;
sbit LCD_D7_Direction at TRISD6_bit;

char txt[5];
unsigned int LCD_Page = 0;
int k3 = 0;
int angle = 100;
unsigned int x = 0;
float SpeedOfSound = 0.0;
int adc = 0;
int TX_Temp;
int TEMPERATURE =0;
float T=0.0 ;
const float T0  = (float)1/298.15;
const float BB  = (float)1/3380;
unsigned int Distance=0;
long k1=0;
long j=0;
char check_sonic = 0;
char Index = 0;
int Master_T_Height = 21;
int Master_T_Pump_OFF_Level = 15;
int Master_T_Minimum = 5;
int Master_T_Pump_ON_Level = 10;
int Master_T_Level = 0;
int Pump_T_Height = 21;
int Pump_T_Maximum = 15;
int Pump_T_ON_Level = 8;
int Pump_T_OFF_Level = 5;
int Pump_T_Level = 0;
sbit DHT11_PIN at RC4_bit;
sbit DHT11_PIN_Direction at TRISC4_bit;
int humid=0;
unsigned short T_byte1, T_byte2, RH_byte1, RH_byte2, CheckSum;
char Servo_Flag=0;
char Openning_Flag=0;
int Increased_temp=0;
int Board_min_temp=40;
int Board_max_temp=80;
float temp_percentage=0.0;
int First_ON_Flag=1;

void Start_Signal(void) {
  DHT11_PIN_Direction = 0;
  DHT11_PIN = 0;
  My_DelayMs(25);
  DHT11_PIN = 1;
  My_DelayUs(25);
  DHT11_PIN_Direction = 1;
}

unsigned short Check_Response() {
  TMR1H = 0;
  TMR1L = 0;
  TMR1ON_bit = 1;
  while(!DHT11_PIN && TMR1L < 100);
  if(TMR1L > 99)
    return 0;
  else {
    TMR1H = 0;
    TMR1L = 0;
    while(DHT11_PIN && TMR1L < 100);
    if(TMR1L > 99)
      return 0;
    else
      return 1;
  }
}

unsigned short Read_Data(unsigned short* dht_data) {
  short i;
  *dht_data = 0;
  for(i = 0; i < 8; i++){
    TMR1H = 0;
    TMR1L = 0;
    while(!DHT11_PIN) {
      if(TMR1L > 100) { return 1; }
    }
    TMR1H = 0;
    TMR1L = 0;
    while(DHT11_PIN) {
      if(TMR1L > 100) { return 1; }
    }
    if(TMR1L > 50)
      *dht_data |= (1 << (7 - i));
  }
  return 0;
}

void DHT11() {
  T1CON = 0x10;
  TMR1H = 0;
  TMR1L = 0;
  Start_Signal();
  if(Check_Response()) {
      if(Read_Data(&RH_byte1) || Read_Data(&RH_byte2) ||
         Read_Data(&T_byte1)  || Read_Data(&T_byte2)  ||
         Read_Data(&Checksum)) {
      } else {
         if(Checksum == ((RH_Byte1 + RH_Byte2 + T_Byte1 + T_Byte2) & 0xFF)) {
         }
      }
  }
  T1CON = 0x00;
  TMR1ON_bit = 0;
  My_DelayMs(1000);
}

void Read_Print_Control() {
  My_SoundPlay(2600, 100);
  My_SoundPlay(2400, 100);
  My_SoundPlay(2600, 100);
  My_DelayMs(500);
  My_SoundPlay(2600, 100);
  My_SoundPlay(2400, 100);
  My_SoundPlay(2600, 100);
  Lcd_Out(1, 2, "LEVEL & PUMP");
  My_DelayMs(5000);
  lcd_cmd(_LCD_CLEAR);
  Lcd_Out(1, 3, "DESIGNED By");
  Lcd_Out(2, 3, "Leen Bilto");
  My_DelayMs(5000);
Keep_Tracking:
  ADCON0 = 0b00001001;
  adc = My_ADC_Read(1);
  T = T0 + (BB * log(((float)1023 / adc) - 1));
  T = 1 / T;
  T = T - 273.15;
  k3 = T;
  My_DelayMs(20);
  TX_Temp = (int)T;
  SpeedOfSound = (float)(331.3 + (0.606 * T));
  SpeedOfSound *= 100.0;
  My_DelayMs(100);
  ADCON0 &= 0xFE;
  DHT11();
  if(TX_Temp > 40) {
    Increased_temp = TX_Temp - Board_min_temp;
    temp_percentage = (float)Increased_temp / 40.0;
    My_PWM2_SetDuty((unsigned char)(temp_percentage * 255));
    My_PWM2_Start();
  }
  if(TX_Temp < 40) {
    My_PWM2_Stop();
    PORTC &= 0xFE;
  }
  Index = 1;
All_Index:
  Distance=0; k1=0; check_sonic=0;
twin:
  TMR1H = 0x00;
  TMR1L = 0x00;
  if(Index==1) {
    PORTC |= (1 << 2);
    My_DelayUs(10);
    PORTC &= ~(1 << 2);
  }
  else if(Index==2) {
    PORTD |= (1 << 0);
    My_DelayUs(10);
    PORTD &= ~(1 << 0);
  }
  My_DelayMs(2);
  if(Index==1) {
    for(j=0;j<=50000;j++){
      if(PORTC & (1 << 3)) { break; }
      My_DelayUs(1);
    }
  }
  else {
    for(j=0;j<=50000;j++){
      if(PORTD & (1 << 1)) { break; }
      My_DelayUs(1);
    }
  }
  T1CON |= (1 << 0);
  if(check_sonic>=1 && j>=50000) { k1=0; goto cont; }
  if(j>=50000) { check_sonic++; goto twin; }
  check_sonic=0;
  if(Index==1) {
    for(j=0;j<=50000;j++){
      if(!(PORTC & (1 << 3))){ break; }
      My_DelayUs(1);
    }
  }
  else {
    for(j=0;j<=50000;j++){
      if(!(PORTD & (1 << 1))){ break; }
      My_DelayUs(1);
    }
  }
  T1CON &= ~(1 << 0);
  k1 = ((TMR1H<<8) | TMR1L);
  k1 = k1*1;
  k1 = SpeedOfSound * ((float)k1/2000000.0)/2.0;
cont:
  Distance = k1;
  if(Index==1) Master_T_Level = Master_T_Height - Distance;
  if(Index==2) Pump_T_Level   = Pump_T_Height   - Distance;
  Index++;
  if(Index<3) { goto All_Index; }
  My_DelayMs(100);
update:
  if(LCD_Page==0){
    lcd_cmd(_LCD_CLEAR);
    IntToStr(Master_T_Level, txt); Ltrim(txt);
    Lcd_Out(1,1,"Master  "); Lcd_Out_Cp(txt); Lcd_Out_Cp("cm");
    IntToStr(Pump_T_Level, txt); Ltrim(txt);
    Lcd_Out(2,1,"Pump    "); Lcd_Out_Cp(txt); Lcd_Out_Cp("cm");
    if(LCD_Page==0){ while(PORTB & (1 << 0)){} }
  }
  else {
    lcd_cmd(_LCD_CLEAR);
    IntToStr(TX_Temp, txt); Ltrim(txt);
    Lcd_Out(1,1,"Temp  "); Lcd_Out_Cp(txt);
    Lcd_Chr_Cp(223);
    Lcd_Chr_Cp('C');
    IntToStr(RH_Byte1, txt); Ltrim(txt);
    Lcd_Out(2,1,"Humid "); Lcd_Out_Cp(txt); Lcd_Out_Cp("%");
    if(LCD_Page==1){ while(PORTB & (1 << 0)){} }
  }
  if ((Master_T_Level <= Master_T_Pump_ON_Level) && (Pump_T_Level >= Pump_T_ON_Level)) {
    PORTD |= (1 << 4);
  }
  if ((Master_T_Level >= Master_T_Pump_OFF_Level) || (Pump_T_Level <= Pump_T_OFF_Level)) {
    PORTD &= ~(1 << 4);
  }
  My_DelayMs(1000);
  if (First_ON_Flag == 1) {
    First_ON_Flag = 0;
    Openning_Flag = 1;
    while (angle < 183) {
        angle++;
        for (x = 0; x <= 1900; x++) {
            if (x < angle) {
                PORTD |= (1 << 2);
            } else {
                PORTD &= ~(1 << 2);
            }
        }
    }
  }
  if (Openning_Flag == 0) {
    while (!(PORTC & (1 << 6))) {
        Openning_Flag = 1;
        if (!(PORTC & (1 << 6)) && angle < 183) {
            angle++;
        }
        for (x = 0; x <= 1900; x++) {
            PORTD = (x < angle) ? (PORTD | (1 << 2)) : (PORTD & ~(1 << 2));
        }
    }
  } else {
    while (!(PORTC & (1 << 6))) {
        Openning_Flag = 0;
        if (!(PORTC & (1 << 6)) && angle > 43) {
            angle--;
        }
        for (x = 0; x <= 1900; x++) {
            PORTD = (x < angle) ? (PORTD | (1 << 2)) : (PORTD & ~(1 << 2));
        }
    }
  }
  goto Keep_Tracking;
}

void interrupt(){
  if(INTCON & (1 << 1)){
    if(!(PORTB & (1 << 0))){
      if(LCD_Page==0) { LCD_Page = 1; }
      else            { LCD_Page = 0; }
    }
    INTCON &= ~(1 << 1);
  }
}

void main() {
    TRISA = 0x00;
    TRISA |= (1 << 0);
    TRISA |= (1 << 1);
    TRISA |= (1 << 2);
    TRISA |= (1 << 3);
    TRISA |= (1 << 4);
    TRISA |= (1 << 5);
    TRISA |= (1 << 6);
    TRISA |= (1 << 7);
    TRISB = 0x00;
    TRISB |= (1 << 0);
    TRISB |= (1 << 1);
    TRISB |= (1 << 2);
    TRISB |= (1 << 3);
    TRISB |= (1 << 4);
    TRISB |= (1 << 5);
    TRISB |= (1 << 6);
    TRISB |= (1 << 7);
    TRISC = 0x00;
    TRISC |= (1 << 3);
    TRISC |= (1 << 4);
    TRISD = 0x00;
    TRISD |= (1 << 1);
    TRISE = 0x07;
    My_ADC_Init();
    INTCON |= (1 << 7);
    INTCON |= (1 << 6);
    T1CON = 0b00000000;
    INTCON |= (1 << 4);
    INTCON &= ~(1 << 1);
    OPTION_REG &= ~(1 << 6);
    CCP1CON = 0x00;
    CCP2CON = 0x00;
    PORTB |= (1 << 5);
    PORTD |= (1 << 5);
    PORTC &= ~(1 << 2);
    PORTD &= ~(1 << 0);
    PORTD &= ~(1 << 4);
    PORTC &= ~(1 << 5);
    PORTA |= (1 << 2);
    PORTD &= ~(1 << 2);
    PORTC &= ~(1 << 1);
    PORTC &= ~(1 << 7);
    Lcd_Init();
    Lcd_Cmd(_LCD_CURSOR_OFF);
    Lcd_Cmd(_LCD_CLEAR);
    My_PWM2_Init();
    My_PWM2_Stop();
    angle = 224;
    while(angle > 43) {
        angle--;
        for(x = 0; x <= 1900; x++) {
            if(x < angle) PORTD |= 0x04;
            else          PORTD &= 0xFB;


        }
    }
    My_DelayMs(100);

    //--------------------------------------------------------------------------
    // 6) Start your main application
    //--------------------------------------------------------------------------
    Read_Print_Control();
}