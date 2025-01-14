
_My_DelayMs:

;dual_water_tank.c,1 :: 		void My_DelayMs(unsigned int ms) {
;dual_water_tank.c,3 :: 		for(i = 0; i < ms; i++) {
	CLRF       R1+0
	CLRF       R1+1
L_My_DelayMs0:
	MOVF       FARG_My_DelayMs_ms+1, 0
	SUBWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__My_DelayMs138
	MOVF       FARG_My_DelayMs_ms+0, 0
	SUBWF      R1+0, 0
L__My_DelayMs138:
	BTFSC      STATUS+0, 0
	GOTO       L_My_DelayMs1
;dual_water_tank.c,4 :: 		for(j = 0; j < 167; j++) {
	CLRF       R3+0
	CLRF       R3+1
L_My_DelayMs3:
	MOVLW      0
	SUBWF      R3+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__My_DelayMs139
	MOVLW      167
	SUBWF      R3+0, 0
L__My_DelayMs139:
	BTFSC      STATUS+0, 0
	GOTO       L_My_DelayMs4
;dual_water_tank.c,5 :: 		asm { NOP }
	NOP
;dual_water_tank.c,4 :: 		for(j = 0; j < 167; j++) {
	INCF       R3+0, 1
	BTFSC      STATUS+0, 2
	INCF       R3+1, 1
;dual_water_tank.c,6 :: 		}
	GOTO       L_My_DelayMs3
L_My_DelayMs4:
;dual_water_tank.c,3 :: 		for(i = 0; i < ms; i++) {
	INCF       R1+0, 1
	BTFSC      STATUS+0, 2
	INCF       R1+1, 1
;dual_water_tank.c,7 :: 		}
	GOTO       L_My_DelayMs0
L_My_DelayMs1:
;dual_water_tank.c,8 :: 		}
L_end_My_DelayMs:
	RETURN
; end of _My_DelayMs

_My_DelayUs:

;dual_water_tank.c,10 :: 		void My_DelayUs(unsigned int us) {
;dual_water_tank.c,12 :: 		for(i = 0; i < us; i++) {
	CLRF       R1+0
	CLRF       R1+1
L_My_DelayUs6:
	MOVF       FARG_My_DelayUs_us+1, 0
	SUBWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__My_DelayUs141
	MOVF       FARG_My_DelayUs_us+0, 0
	SUBWF      R1+0, 0
L__My_DelayUs141:
	BTFSC      STATUS+0, 0
	GOTO       L_My_DelayUs7
;dual_water_tank.c,13 :: 		asm { NOP }
	NOP
;dual_water_tank.c,14 :: 		asm { NOP }
	NOP
;dual_water_tank.c,12 :: 		for(i = 0; i < us; i++) {
	INCF       R1+0, 1
	BTFSC      STATUS+0, 2
	INCF       R1+1, 1
;dual_water_tank.c,15 :: 		}
	GOTO       L_My_DelayUs6
L_My_DelayUs7:
;dual_water_tank.c,16 :: 		}
L_end_My_DelayUs:
	RETURN
; end of _My_DelayUs

_My_SoundPlay:

;dual_water_tank.c,18 :: 		void My_SoundPlay(unsigned long freq, unsigned int duration_ms) {
;dual_water_tank.c,21 :: 		toggleCount = (freq * duration_ms) / 1000UL;
	MOVF       FARG_My_SoundPlay_freq+0, 0
	MOVWF      R0+0
	MOVF       FARG_My_SoundPlay_freq+1, 0
	MOVWF      R0+1
	MOVF       FARG_My_SoundPlay_freq+2, 0
	MOVWF      R0+2
	MOVF       FARG_My_SoundPlay_freq+3, 0
	MOVWF      R0+3
	MOVF       FARG_My_SoundPlay_duration_ms+0, 0
	MOVWF      R4+0
	MOVF       FARG_My_SoundPlay_duration_ms+1, 0
	MOVWF      R4+1
	CLRF       R4+2
	CLRF       R4+3
	CALL       _Mul_32x32_U+0
	MOVLW      232
	MOVWF      R4+0
	MOVLW      3
	MOVWF      R4+1
	MOVLW      0
	MOVWF      R4+2
	MOVLW      0
	MOVWF      R4+3
	CALL       _Div_32x32_U+0
	MOVF       R0+0, 0
	MOVWF      My_SoundPlay_toggleCount_L0+0
	MOVF       R0+1, 0
	MOVWF      My_SoundPlay_toggleCount_L0+1
	MOVF       R0+2, 0
	MOVWF      My_SoundPlay_toggleCount_L0+2
	MOVF       R0+3, 0
	MOVWF      My_SoundPlay_toggleCount_L0+3
;dual_water_tank.c,22 :: 		halfPeriod_us = (unsigned int)(500000UL / freq);
	MOVF       FARG_My_SoundPlay_freq+0, 0
	MOVWF      R4+0
	MOVF       FARG_My_SoundPlay_freq+1, 0
	MOVWF      R4+1
	MOVF       FARG_My_SoundPlay_freq+2, 0
	MOVWF      R4+2
	MOVF       FARG_My_SoundPlay_freq+3, 0
	MOVWF      R4+3
	MOVLW      32
	MOVWF      R0+0
	MOVLW      161
	MOVWF      R0+1
	MOVLW      7
	MOVWF      R0+2
	MOVLW      0
	MOVWF      R0+3
	CALL       _Div_32x32_U+0
	MOVF       R0+0, 0
	MOVWF      My_SoundPlay_halfPeriod_us_L0+0
	MOVF       R0+1, 0
	MOVWF      My_SoundPlay_halfPeriod_us_L0+1
;dual_water_tank.c,23 :: 		for(i = 0; i < toggleCount; i++){
	CLRF       My_SoundPlay_i_L0+0
	CLRF       My_SoundPlay_i_L0+1
	CLRF       My_SoundPlay_i_L0+2
	CLRF       My_SoundPlay_i_L0+3
L_My_SoundPlay9:
	MOVF       My_SoundPlay_toggleCount_L0+3, 0
	SUBWF      My_SoundPlay_i_L0+3, 0
	BTFSS      STATUS+0, 2
	GOTO       L__My_SoundPlay143
	MOVF       My_SoundPlay_toggleCount_L0+2, 0
	SUBWF      My_SoundPlay_i_L0+2, 0
	BTFSS      STATUS+0, 2
	GOTO       L__My_SoundPlay143
	MOVF       My_SoundPlay_toggleCount_L0+1, 0
	SUBWF      My_SoundPlay_i_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__My_SoundPlay143
	MOVF       My_SoundPlay_toggleCount_L0+0, 0
	SUBWF      My_SoundPlay_i_L0+0, 0
L__My_SoundPlay143:
	BTFSC      STATUS+0, 0
	GOTO       L_My_SoundPlay10
;dual_water_tank.c,24 :: 		PORTC |= (1 << 5);
	BSF        PORTC+0, 5
;dual_water_tank.c,25 :: 		My_DelayUs(halfPeriod_us);
	MOVF       My_SoundPlay_halfPeriod_us_L0+0, 0
	MOVWF      FARG_My_DelayUs_us+0
	MOVF       My_SoundPlay_halfPeriod_us_L0+1, 0
	MOVWF      FARG_My_DelayUs_us+1
	CALL       _My_DelayUs+0
;dual_water_tank.c,26 :: 		PORTC &= ~(1 << 5);
	BCF        PORTC+0, 5
;dual_water_tank.c,27 :: 		My_DelayUs(halfPeriod_us);
	MOVF       My_SoundPlay_halfPeriod_us_L0+0, 0
	MOVWF      FARG_My_DelayUs_us+0
	MOVF       My_SoundPlay_halfPeriod_us_L0+1, 0
	MOVWF      FARG_My_DelayUs_us+1
	CALL       _My_DelayUs+0
;dual_water_tank.c,23 :: 		for(i = 0; i < toggleCount; i++){
	MOVF       My_SoundPlay_i_L0+0, 0
	MOVWF      R0+0
	MOVF       My_SoundPlay_i_L0+1, 0
	MOVWF      R0+1
	MOVF       My_SoundPlay_i_L0+2, 0
	MOVWF      R0+2
	MOVF       My_SoundPlay_i_L0+3, 0
	MOVWF      R0+3
	INCF       R0+0, 1
	BTFSC      STATUS+0, 2
	INCF       R0+1, 1
	BTFSC      STATUS+0, 2
	INCF       R0+2, 1
	BTFSC      STATUS+0, 2
	INCF       R0+3, 1
	MOVF       R0+0, 0
	MOVWF      My_SoundPlay_i_L0+0
	MOVF       R0+1, 0
	MOVWF      My_SoundPlay_i_L0+1
	MOVF       R0+2, 0
	MOVWF      My_SoundPlay_i_L0+2
	MOVF       R0+3, 0
	MOVWF      My_SoundPlay_i_L0+3
;dual_water_tank.c,28 :: 		}
	GOTO       L_My_SoundPlay9
L_My_SoundPlay10:
;dual_water_tank.c,29 :: 		}
L_end_My_SoundPlay:
	RETURN
; end of _My_SoundPlay

_My_ADC_Init:

;dual_water_tank.c,31 :: 		void My_ADC_Init(void) {
;dual_water_tank.c,32 :: 		ADCON1 = 0x84;
	MOVLW      132
	MOVWF      ADCON1+0
;dual_water_tank.c,33 :: 		ADCON0 = 0x00;
	CLRF       ADCON0+0
;dual_water_tank.c,34 :: 		ADCON0 = 0b01000001;
	MOVLW      65
	MOVWF      ADCON0+0
;dual_water_tank.c,35 :: 		}
L_end_My_ADC_Init:
	RETURN
; end of _My_ADC_Init

_My_ADC_Read:

;dual_water_tank.c,37 :: 		unsigned int My_ADC_Read(unsigned short channel) {
;dual_water_tank.c,38 :: 		ADCON0 &= 0b11000101;
	MOVLW      197
	ANDWF      ADCON0+0, 1
;dual_water_tank.c,39 :: 		channel <<= 3;
	MOVF       FARG_My_ADC_Read_channel+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	RLF        R0+0, 1
	BCF        R0+0, 0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	MOVWF      FARG_My_ADC_Read_channel+0
;dual_water_tank.c,40 :: 		ADCON0 |= channel;
	MOVF       R0+0, 0
	IORWF      ADCON0+0, 1
;dual_water_tank.c,41 :: 		My_DelayMs(2);
	MOVLW      2
	MOVWF      FARG_My_DelayMs_ms+0
	MOVLW      0
	MOVWF      FARG_My_DelayMs_ms+1
	CALL       _My_DelayMs+0
;dual_water_tank.c,42 :: 		ADCON0 |= (1 << 2);
	BSF        ADCON0+0, 2
;dual_water_tank.c,43 :: 		while(ADCON0 & (1 << 2)) {}
L_My_ADC_Read12:
	BTFSS      ADCON0+0, 2
	GOTO       L_My_ADC_Read13
	GOTO       L_My_ADC_Read12
L_My_ADC_Read13:
;dual_water_tank.c,44 :: 		return ((ADRESH << 8) + ADRESL);
	MOVF       ADRESH+0, 0
	MOVWF      R0+1
	CLRF       R0+0
	MOVF       ADRESL+0, 0
	ADDWF      R0+0, 1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
;dual_water_tank.c,45 :: 		}
L_end_My_ADC_Read:
	RETURN
; end of _My_ADC_Read

_My_PWM2_Init:

;dual_water_tank.c,47 :: 		void My_PWM2_Init(void) {
;dual_water_tank.c,48 :: 		PR2     = 124;
	MOVLW      124
	MOVWF      PR2+0
;dual_water_tank.c,49 :: 		T2CON   = 0b00000001;
	MOVLW      1
	MOVWF      T2CON+0
;dual_water_tank.c,50 :: 		CCP2CON = 0b00001100;
	MOVLW      12
	MOVWF      CCP2CON+0
;dual_water_tank.c,51 :: 		CCPR2L  = 0x00;
	CLRF       CCPR2L+0
;dual_water_tank.c,52 :: 		T2CON |= (1 << 2);
	BSF        T2CON+0, 2
;dual_water_tank.c,53 :: 		}
L_end_My_PWM2_Init:
	RETURN
; end of _My_PWM2_Init

_My_PWM2_SetDuty:

;dual_water_tank.c,55 :: 		void My_PWM2_SetDuty(unsigned char duty) {
;dual_water_tank.c,56 :: 		CCPR2L      = duty >> 2;
	MOVF       FARG_My_PWM2_SetDuty_duty+0, 0
	MOVWF      R0+0
	RRF        R0+0, 1
	BCF        R0+0, 7
	RRF        R0+0, 1
	BCF        R0+0, 7
	MOVF       R0+0, 0
	MOVWF      CCPR2L+0
;dual_water_tank.c,57 :: 		CCP2CON = (CCP2CON & 0xCF) | ((duty & 0x03) << 4);
	MOVLW      207
	ANDWF      CCP2CON+0, 0
	MOVWF      R3+0
	MOVLW      3
	ANDWF      FARG_My_PWM2_SetDuty_duty+0, 0
	MOVWF      R2+0
	MOVF       R2+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	RLF        R0+0, 1
	BCF        R0+0, 0
	RLF        R0+0, 1
	BCF        R0+0, 0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	IORWF      R3+0, 0
	MOVWF      CCP2CON+0
;dual_water_tank.c,58 :: 		}
L_end_My_PWM2_SetDuty:
	RETURN
; end of _My_PWM2_SetDuty

_My_PWM2_Start:

;dual_water_tank.c,60 :: 		void My_PWM2_Start(void) {
;dual_water_tank.c,61 :: 		T2CON |= (1 << 2);
	BSF        T2CON+0, 2
;dual_water_tank.c,62 :: 		}
L_end_My_PWM2_Start:
	RETURN
; end of _My_PWM2_Start

_My_PWM2_Stop:

;dual_water_tank.c,64 :: 		void My_PWM2_Stop(void) {
;dual_water_tank.c,65 :: 		T2CON &= ~(1 << 2);
	BCF        T2CON+0, 2
;dual_water_tank.c,66 :: 		PORTC &= ~(1 << 1);
	BCF        PORTC+0, 1
;dual_water_tank.c,67 :: 		}
L_end_My_PWM2_Stop:
	RETURN
; end of _My_PWM2_Stop

_Start_Signal:

;dual_water_tank.c,122 :: 		void Start_Signal(void) {
;dual_water_tank.c,123 :: 		DHT11_PIN_Direction = 0;
	BCF        TRISC4_bit+0, BitPos(TRISC4_bit+0)
;dual_water_tank.c,124 :: 		DHT11_PIN = 0;
	BCF        RC4_bit+0, BitPos(RC4_bit+0)
;dual_water_tank.c,125 :: 		My_DelayMs(25);
	MOVLW      25
	MOVWF      FARG_My_DelayMs_ms+0
	MOVLW      0
	MOVWF      FARG_My_DelayMs_ms+1
	CALL       _My_DelayMs+0
;dual_water_tank.c,126 :: 		DHT11_PIN = 1;
	BSF        RC4_bit+0, BitPos(RC4_bit+0)
;dual_water_tank.c,127 :: 		My_DelayUs(25);
	MOVLW      25
	MOVWF      FARG_My_DelayUs_us+0
	MOVLW      0
	MOVWF      FARG_My_DelayUs_us+1
	CALL       _My_DelayUs+0
;dual_water_tank.c,128 :: 		DHT11_PIN_Direction = 1;
	BSF        TRISC4_bit+0, BitPos(TRISC4_bit+0)
;dual_water_tank.c,129 :: 		}
L_end_Start_Signal:
	RETURN
; end of _Start_Signal

_Check_Response:

;dual_water_tank.c,131 :: 		unsigned short Check_Response() {
;dual_water_tank.c,132 :: 		TMR1H = 0;
	CLRF       TMR1H+0
;dual_water_tank.c,133 :: 		TMR1L = 0;
	CLRF       TMR1L+0
;dual_water_tank.c,134 :: 		TMR1ON_bit = 1;
	BSF        TMR1ON_bit+0, BitPos(TMR1ON_bit+0)
;dual_water_tank.c,135 :: 		while(!DHT11_PIN && TMR1L < 100);
L_Check_Response14:
	BTFSC      RC4_bit+0, BitPos(RC4_bit+0)
	GOTO       L_Check_Response15
	MOVLW      100
	SUBWF      TMR1L+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_Check_Response15
L__Check_Response130:
	GOTO       L_Check_Response14
L_Check_Response15:
;dual_water_tank.c,136 :: 		if(TMR1L > 99)
	MOVF       TMR1L+0, 0
	SUBLW      99
	BTFSC      STATUS+0, 0
	GOTO       L_Check_Response18
;dual_water_tank.c,137 :: 		return 0;
	CLRF       R0+0
	GOTO       L_end_Check_Response
L_Check_Response18:
;dual_water_tank.c,139 :: 		TMR1H = 0;
	CLRF       TMR1H+0
;dual_water_tank.c,140 :: 		TMR1L = 0;
	CLRF       TMR1L+0
;dual_water_tank.c,141 :: 		while(DHT11_PIN && TMR1L < 100);
L_Check_Response20:
	BTFSS      RC4_bit+0, BitPos(RC4_bit+0)
	GOTO       L_Check_Response21
	MOVLW      100
	SUBWF      TMR1L+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_Check_Response21
L__Check_Response129:
	GOTO       L_Check_Response20
L_Check_Response21:
;dual_water_tank.c,142 :: 		if(TMR1L > 99)
	MOVF       TMR1L+0, 0
	SUBLW      99
	BTFSC      STATUS+0, 0
	GOTO       L_Check_Response24
;dual_water_tank.c,143 :: 		return 0;
	CLRF       R0+0
	GOTO       L_end_Check_Response
L_Check_Response24:
;dual_water_tank.c,145 :: 		return 1;
	MOVLW      1
	MOVWF      R0+0
;dual_water_tank.c,147 :: 		}
L_end_Check_Response:
	RETURN
; end of _Check_Response

_Read_Data:

;dual_water_tank.c,149 :: 		unsigned short Read_Data(unsigned short* dht_data) {
;dual_water_tank.c,151 :: 		*dht_data = 0;
	MOVF       FARG_Read_Data_dht_data+0, 0
	MOVWF      FSR
	CLRF       INDF+0
;dual_water_tank.c,152 :: 		for(i = 0; i < 8; i++){
	CLRF       R2+0
L_Read_Data26:
	MOVLW      128
	XORWF      R2+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      8
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_Read_Data27
;dual_water_tank.c,153 :: 		TMR1H = 0;
	CLRF       TMR1H+0
;dual_water_tank.c,154 :: 		TMR1L = 0;
	CLRF       TMR1L+0
;dual_water_tank.c,155 :: 		while(!DHT11_PIN) {
L_Read_Data29:
	BTFSC      RC4_bit+0, BitPos(RC4_bit+0)
	GOTO       L_Read_Data30
;dual_water_tank.c,156 :: 		if(TMR1L > 100) { return 1; }
	MOVF       TMR1L+0, 0
	SUBLW      100
	BTFSC      STATUS+0, 0
	GOTO       L_Read_Data31
	MOVLW      1
	MOVWF      R0+0
	GOTO       L_end_Read_Data
L_Read_Data31:
;dual_water_tank.c,157 :: 		}
	GOTO       L_Read_Data29
L_Read_Data30:
;dual_water_tank.c,158 :: 		TMR1H = 0;
	CLRF       TMR1H+0
;dual_water_tank.c,159 :: 		TMR1L = 0;
	CLRF       TMR1L+0
;dual_water_tank.c,160 :: 		while(DHT11_PIN) {
L_Read_Data32:
	BTFSS      RC4_bit+0, BitPos(RC4_bit+0)
	GOTO       L_Read_Data33
;dual_water_tank.c,161 :: 		if(TMR1L > 100) { return 1; }
	MOVF       TMR1L+0, 0
	SUBLW      100
	BTFSC      STATUS+0, 0
	GOTO       L_Read_Data34
	MOVLW      1
	MOVWF      R0+0
	GOTO       L_end_Read_Data
L_Read_Data34:
;dual_water_tank.c,162 :: 		}
	GOTO       L_Read_Data32
L_Read_Data33:
;dual_water_tank.c,163 :: 		if(TMR1L > 50)
	MOVF       TMR1L+0, 0
	SUBLW      50
	BTFSC      STATUS+0, 0
	GOTO       L_Read_Data35
;dual_water_tank.c,164 :: 		*dht_data |= (1 << (7 - i));
	MOVF       R2+0, 0
	SUBLW      7
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      R1+0
	MOVLW      1
	MOVWF      R0+0
	MOVF       R1+0, 0
L__Read_Data153:
	BTFSC      STATUS+0, 2
	GOTO       L__Read_Data154
	RLF        R0+0, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__Read_Data153
L__Read_Data154:
	MOVF       FARG_Read_Data_dht_data+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	IORWF      R0+0, 1
	MOVF       FARG_Read_Data_dht_data+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
L_Read_Data35:
;dual_water_tank.c,152 :: 		for(i = 0; i < 8; i++){
	INCF       R2+0, 1
;dual_water_tank.c,165 :: 		}
	GOTO       L_Read_Data26
L_Read_Data27:
;dual_water_tank.c,166 :: 		return 0;
	CLRF       R0+0
;dual_water_tank.c,167 :: 		}
L_end_Read_Data:
	RETURN
; end of _Read_Data

_DHT11:

;dual_water_tank.c,169 :: 		void DHT11() {
;dual_water_tank.c,170 :: 		T1CON = 0x10;
	MOVLW      16
	MOVWF      T1CON+0
;dual_water_tank.c,171 :: 		TMR1H = 0;
	CLRF       TMR1H+0
;dual_water_tank.c,172 :: 		TMR1L = 0;
	CLRF       TMR1L+0
;dual_water_tank.c,173 :: 		Start_Signal();
	CALL       _Start_Signal+0
;dual_water_tank.c,174 :: 		if(Check_Response()) {
	CALL       _Check_Response+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_DHT1136
;dual_water_tank.c,175 :: 		if(Read_Data(&RH_byte1) || Read_Data(&RH_byte2) ||
	MOVLW      _RH_byte1+0
	MOVWF      FARG_Read_Data_dht_data+0
	CALL       _Read_Data+0
	MOVF       R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__DHT11131
	MOVLW      _RH_byte2+0
	MOVWF      FARG_Read_Data_dht_data+0
	CALL       _Read_Data+0
	MOVF       R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__DHT11131
;dual_water_tank.c,176 :: 		Read_Data(&T_byte1)  || Read_Data(&T_byte2)  ||
	MOVLW      _T_byte1+0
	MOVWF      FARG_Read_Data_dht_data+0
	CALL       _Read_Data+0
	MOVF       R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__DHT11131
	MOVLW      _T_byte2+0
	MOVWF      FARG_Read_Data_dht_data+0
	CALL       _Read_Data+0
	MOVF       R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__DHT11131
;dual_water_tank.c,177 :: 		Read_Data(&Checksum)) {
	MOVLW      _CheckSum+0
	MOVWF      FARG_Read_Data_dht_data+0
	CALL       _Read_Data+0
	MOVF       R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__DHT11131
	GOTO       L_DHT1139
L__DHT11131:
;dual_water_tank.c,178 :: 		} else {
	GOTO       L_DHT1140
L_DHT1139:
;dual_water_tank.c,179 :: 		if(Checksum == ((RH_Byte1 + RH_Byte2 + T_Byte1 + T_Byte2) & 0xFF)) {
	MOVF       _RH_byte2+0, 0
	ADDWF      _RH_byte1+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVF       _T_byte1+0, 0
	ADDWF      R0+0, 1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVF       _T_byte2+0, 0
	ADDWF      R0+0, 1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVLW      255
	ANDWF      R0+0, 0
	MOVWF      R2+0
	MOVF       R0+1, 0
	MOVWF      R2+1
	MOVLW      0
	ANDWF      R2+1, 1
	MOVLW      0
	XORWF      R2+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__DHT11156
	MOVF       R2+0, 0
	XORWF      _CheckSum+0, 0
L__DHT11156:
	BTFSS      STATUS+0, 2
	GOTO       L_DHT1141
;dual_water_tank.c,180 :: 		}
L_DHT1141:
;dual_water_tank.c,181 :: 		}
L_DHT1140:
;dual_water_tank.c,182 :: 		}
L_DHT1136:
;dual_water_tank.c,183 :: 		T1CON = 0x00;
	CLRF       T1CON+0
;dual_water_tank.c,184 :: 		TMR1ON_bit = 0;
	BCF        TMR1ON_bit+0, BitPos(TMR1ON_bit+0)
;dual_water_tank.c,185 :: 		My_DelayMs(1000);
	MOVLW      232
	MOVWF      FARG_My_DelayMs_ms+0
	MOVLW      3
	MOVWF      FARG_My_DelayMs_ms+1
	CALL       _My_DelayMs+0
;dual_water_tank.c,186 :: 		}
L_end_DHT11:
	RETURN
; end of _DHT11

_Read_Print_Control:

;dual_water_tank.c,188 :: 		void Read_Print_Control() {
;dual_water_tank.c,189 :: 		My_SoundPlay(2600, 100);
	MOVLW      40
	MOVWF      FARG_My_SoundPlay_freq+0
	MOVLW      10
	MOVWF      FARG_My_SoundPlay_freq+1
	CLRF       FARG_My_SoundPlay_freq+2
	CLRF       FARG_My_SoundPlay_freq+3
	MOVLW      100
	MOVWF      FARG_My_SoundPlay_duration_ms+0
	MOVLW      0
	MOVWF      FARG_My_SoundPlay_duration_ms+1
	CALL       _My_SoundPlay+0
;dual_water_tank.c,190 :: 		My_SoundPlay(2400, 100);
	MOVLW      96
	MOVWF      FARG_My_SoundPlay_freq+0
	MOVLW      9
	MOVWF      FARG_My_SoundPlay_freq+1
	CLRF       FARG_My_SoundPlay_freq+2
	CLRF       FARG_My_SoundPlay_freq+3
	MOVLW      100
	MOVWF      FARG_My_SoundPlay_duration_ms+0
	MOVLW      0
	MOVWF      FARG_My_SoundPlay_duration_ms+1
	CALL       _My_SoundPlay+0
;dual_water_tank.c,191 :: 		My_SoundPlay(2600, 100);
	MOVLW      40
	MOVWF      FARG_My_SoundPlay_freq+0
	MOVLW      10
	MOVWF      FARG_My_SoundPlay_freq+1
	CLRF       FARG_My_SoundPlay_freq+2
	CLRF       FARG_My_SoundPlay_freq+3
	MOVLW      100
	MOVWF      FARG_My_SoundPlay_duration_ms+0
	MOVLW      0
	MOVWF      FARG_My_SoundPlay_duration_ms+1
	CALL       _My_SoundPlay+0
;dual_water_tank.c,192 :: 		My_DelayMs(500);
	MOVLW      244
	MOVWF      FARG_My_DelayMs_ms+0
	MOVLW      1
	MOVWF      FARG_My_DelayMs_ms+1
	CALL       _My_DelayMs+0
;dual_water_tank.c,193 :: 		My_SoundPlay(2600, 100);
	MOVLW      40
	MOVWF      FARG_My_SoundPlay_freq+0
	MOVLW      10
	MOVWF      FARG_My_SoundPlay_freq+1
	CLRF       FARG_My_SoundPlay_freq+2
	CLRF       FARG_My_SoundPlay_freq+3
	MOVLW      100
	MOVWF      FARG_My_SoundPlay_duration_ms+0
	MOVLW      0
	MOVWF      FARG_My_SoundPlay_duration_ms+1
	CALL       _My_SoundPlay+0
;dual_water_tank.c,194 :: 		My_SoundPlay(2400, 100);
	MOVLW      96
	MOVWF      FARG_My_SoundPlay_freq+0
	MOVLW      9
	MOVWF      FARG_My_SoundPlay_freq+1
	CLRF       FARG_My_SoundPlay_freq+2
	CLRF       FARG_My_SoundPlay_freq+3
	MOVLW      100
	MOVWF      FARG_My_SoundPlay_duration_ms+0
	MOVLW      0
	MOVWF      FARG_My_SoundPlay_duration_ms+1
	CALL       _My_SoundPlay+0
;dual_water_tank.c,195 :: 		My_SoundPlay(2600, 100);
	MOVLW      40
	MOVWF      FARG_My_SoundPlay_freq+0
	MOVLW      10
	MOVWF      FARG_My_SoundPlay_freq+1
	CLRF       FARG_My_SoundPlay_freq+2
	CLRF       FARG_My_SoundPlay_freq+3
	MOVLW      100
	MOVWF      FARG_My_SoundPlay_duration_ms+0
	MOVLW      0
	MOVWF      FARG_My_SoundPlay_duration_ms+1
	CALL       _My_SoundPlay+0
;dual_water_tank.c,196 :: 		Lcd_Out(1, 2, "LEVEL & PUMP");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      2
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_dual_water_tank+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;dual_water_tank.c,197 :: 		My_DelayMs(5000);
	MOVLW      136
	MOVWF      FARG_My_DelayMs_ms+0
	MOVLW      19
	MOVWF      FARG_My_DelayMs_ms+1
	CALL       _My_DelayMs+0
;dual_water_tank.c,198 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;dual_water_tank.c,199 :: 		Lcd_Out(1, 3, "DESIGNED By");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      3
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_dual_water_tank+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;dual_water_tank.c,200 :: 		Lcd_Out(2, 3, "Leen Bilto");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      3
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr3_dual_water_tank+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;dual_water_tank.c,201 :: 		My_DelayMs(5000);
	MOVLW      136
	MOVWF      FARG_My_DelayMs_ms+0
	MOVLW      19
	MOVWF      FARG_My_DelayMs_ms+1
	CALL       _My_DelayMs+0
;dual_water_tank.c,202 :: 		Keep_Tracking:
___Read_Print_Control_Keep_Tracking:
;dual_water_tank.c,203 :: 		ADCON0 = 0b00001001;
	MOVLW      9
	MOVWF      ADCON0+0
;dual_water_tank.c,204 :: 		adc = My_ADC_Read(1);
	MOVLW      1
	MOVWF      FARG_My_ADC_Read_channel+0
	CALL       _My_ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _adc+0
	MOVF       R0+1, 0
	MOVWF      _adc+1
;dual_water_tank.c,205 :: 		T = T0 + (BB * log(((float)1023 / adc) - 1));
	CALL       _int2double+0
	MOVF       R0+0, 0
	MOVWF      R4+0
	MOVF       R0+1, 0
	MOVWF      R4+1
	MOVF       R0+2, 0
	MOVWF      R4+2
	MOVF       R0+3, 0
	MOVWF      R4+3
	MOVLW      0
	MOVWF      R0+0
	MOVLW      192
	MOVWF      R0+1
	MOVLW      127
	MOVWF      R0+2
	MOVLW      136
	MOVWF      R0+3
	CALL       _Div_32x32_FP+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      0
	MOVWF      R4+2
	MOVLW      127
	MOVWF      R4+3
	CALL       _Sub_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      FARG_log_x+0
	MOVF       R0+1, 0
	MOVWF      FARG_log_x+1
	MOVF       R0+2, 0
	MOVWF      FARG_log_x+2
	MOVF       R0+3, 0
	MOVWF      FARG_log_x+3
	CALL       _log+0
	MOVLW      99
	MOVWF      R4+0
	MOVLW      29
	MOVWF      R4+1
	MOVLW      27
	MOVWF      R4+2
	MOVLW      115
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVLW      15
	MOVWF      R4+0
	MOVLW      207
	MOVWF      R4+1
	MOVLW      91
	MOVWF      R4+2
	MOVLW      118
	MOVWF      R4+3
	CALL       _Add_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      _T+0
	MOVF       R0+1, 0
	MOVWF      _T+1
	MOVF       R0+2, 0
	MOVWF      _T+2
	MOVF       R0+3, 0
	MOVWF      _T+3
;dual_water_tank.c,206 :: 		T = 1 / T;
	MOVF       R0+0, 0
	MOVWF      R4+0
	MOVF       R0+1, 0
	MOVWF      R4+1
	MOVF       R0+2, 0
	MOVWF      R4+2
	MOVF       R0+3, 0
	MOVWF      R4+3
	MOVLW      0
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
	MOVLW      0
	MOVWF      R0+2
	MOVLW      127
	MOVWF      R0+3
	CALL       _Div_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      _T+0
	MOVF       R0+1, 0
	MOVWF      _T+1
	MOVF       R0+2, 0
	MOVWF      _T+2
	MOVF       R0+3, 0
	MOVWF      _T+3
;dual_water_tank.c,207 :: 		T = T - 273.15;
	MOVLW      51
	MOVWF      R4+0
	MOVLW      147
	MOVWF      R4+1
	MOVLW      8
	MOVWF      R4+2
	MOVLW      135
	MOVWF      R4+3
	CALL       _Sub_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      _T+0
	MOVF       R0+1, 0
	MOVWF      _T+1
	MOVF       R0+2, 0
	MOVWF      _T+2
	MOVF       R0+3, 0
	MOVWF      _T+3
;dual_water_tank.c,208 :: 		k3 = T;
	CALL       _double2int+0
	MOVF       R0+0, 0
	MOVWF      _k3+0
	MOVF       R0+1, 0
	MOVWF      _k3+1
;dual_water_tank.c,209 :: 		My_DelayMs(20);
	MOVLW      20
	MOVWF      FARG_My_DelayMs_ms+0
	MOVLW      0
	MOVWF      FARG_My_DelayMs_ms+1
	CALL       _My_DelayMs+0
;dual_water_tank.c,210 :: 		TX_Temp = (int)T;
	MOVF       _T+0, 0
	MOVWF      R0+0
	MOVF       _T+1, 0
	MOVWF      R0+1
	MOVF       _T+2, 0
	MOVWF      R0+2
	MOVF       _T+3, 0
	MOVWF      R0+3
	CALL       _double2int+0
	MOVF       R0+0, 0
	MOVWF      _TX_Temp+0
	MOVF       R0+1, 0
	MOVWF      _TX_Temp+1
;dual_water_tank.c,211 :: 		SpeedOfSound = (float)(331.3 + (0.606 * T));
	MOVLW      209
	MOVWF      R0+0
	MOVLW      34
	MOVWF      R0+1
	MOVLW      27
	MOVWF      R0+2
	MOVLW      126
	MOVWF      R0+3
	MOVF       _T+0, 0
	MOVWF      R4+0
	MOVF       _T+1, 0
	MOVWF      R4+1
	MOVF       _T+2, 0
	MOVWF      R4+2
	MOVF       _T+3, 0
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVLW      102
	MOVWF      R4+0
	MOVLW      166
	MOVWF      R4+1
	MOVLW      37
	MOVWF      R4+2
	MOVLW      135
	MOVWF      R4+3
	CALL       _Add_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      _SpeedOfSound+0
	MOVF       R0+1, 0
	MOVWF      _SpeedOfSound+1
	MOVF       R0+2, 0
	MOVWF      _SpeedOfSound+2
	MOVF       R0+3, 0
	MOVWF      _SpeedOfSound+3
;dual_water_tank.c,212 :: 		SpeedOfSound *= 100.0;
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      72
	MOVWF      R4+2
	MOVLW      133
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      _SpeedOfSound+0
	MOVF       R0+1, 0
	MOVWF      _SpeedOfSound+1
	MOVF       R0+2, 0
	MOVWF      _SpeedOfSound+2
	MOVF       R0+3, 0
	MOVWF      _SpeedOfSound+3
;dual_water_tank.c,213 :: 		My_DelayMs(100);
	MOVLW      100
	MOVWF      FARG_My_DelayMs_ms+0
	MOVLW      0
	MOVWF      FARG_My_DelayMs_ms+1
	CALL       _My_DelayMs+0
;dual_water_tank.c,214 :: 		ADCON0 &= 0xFE;
	MOVLW      254
	ANDWF      ADCON0+0, 1
;dual_water_tank.c,215 :: 		DHT11();
	CALL       _DHT11+0
;dual_water_tank.c,216 :: 		if(TX_Temp > 40) {
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _TX_Temp+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Read_Print_Control158
	MOVF       _TX_Temp+0, 0
	SUBLW      40
L__Read_Print_Control158:
	BTFSC      STATUS+0, 0
	GOTO       L_Read_Print_Control42
;dual_water_tank.c,217 :: 		Increased_temp = TX_Temp - Board_min_temp;
	MOVF       _Board_min_temp+0, 0
	SUBWF      _TX_Temp+0, 0
	MOVWF      R0+0
	MOVF       _Board_min_temp+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      _TX_Temp+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      _Increased_temp+0
	MOVF       R0+1, 0
	MOVWF      _Increased_temp+1
;dual_water_tank.c,218 :: 		temp_percentage = (float)Increased_temp / 40.0;
	CALL       _int2double+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      32
	MOVWF      R4+2
	MOVLW      132
	MOVWF      R4+3
	CALL       _Div_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      _temp_percentage+0
	MOVF       R0+1, 0
	MOVWF      _temp_percentage+1
	MOVF       R0+2, 0
	MOVWF      _temp_percentage+2
	MOVF       R0+3, 0
	MOVWF      _temp_percentage+3
;dual_water_tank.c,219 :: 		My_PWM2_SetDuty((unsigned char)(temp_percentage * 255));
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      127
	MOVWF      R4+2
	MOVLW      134
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	CALL       _double2byte+0
	MOVF       R0+0, 0
	MOVWF      FARG_My_PWM2_SetDuty_duty+0
	CALL       _My_PWM2_SetDuty+0
;dual_water_tank.c,220 :: 		My_PWM2_Start();
	CALL       _My_PWM2_Start+0
;dual_water_tank.c,221 :: 		}
L_Read_Print_Control42:
;dual_water_tank.c,222 :: 		if(TX_Temp < 40) {
	MOVLW      128
	XORWF      _TX_Temp+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Read_Print_Control159
	MOVLW      40
	SUBWF      _TX_Temp+0, 0
L__Read_Print_Control159:
	BTFSC      STATUS+0, 0
	GOTO       L_Read_Print_Control43
;dual_water_tank.c,223 :: 		My_PWM2_Stop();
	CALL       _My_PWM2_Stop+0
;dual_water_tank.c,224 :: 		PORTC &= 0xFE;
	MOVLW      254
	ANDWF      PORTC+0, 1
;dual_water_tank.c,225 :: 		}
L_Read_Print_Control43:
;dual_water_tank.c,226 :: 		Index = 1;
	MOVLW      1
	MOVWF      _Index+0
;dual_water_tank.c,227 :: 		All_Index:
___Read_Print_Control_All_Index:
;dual_water_tank.c,228 :: 		Distance=0; k1=0; check_sonic=0;
	CLRF       _Distance+0
	CLRF       _Distance+1
	CLRF       _k1+0
	CLRF       _k1+1
	CLRF       _k1+2
	CLRF       _k1+3
	CLRF       _check_sonic+0
;dual_water_tank.c,229 :: 		twin:
___Read_Print_Control_twin:
;dual_water_tank.c,230 :: 		TMR1H = 0x00;
	CLRF       TMR1H+0
;dual_water_tank.c,231 :: 		TMR1L = 0x00;
	CLRF       TMR1L+0
;dual_water_tank.c,232 :: 		if(Index==1) {
	MOVF       _Index+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_Read_Print_Control44
;dual_water_tank.c,233 :: 		PORTC |= (1 << 2);
	BSF        PORTC+0, 2
;dual_water_tank.c,234 :: 		My_DelayUs(10);
	MOVLW      10
	MOVWF      FARG_My_DelayUs_us+0
	MOVLW      0
	MOVWF      FARG_My_DelayUs_us+1
	CALL       _My_DelayUs+0
;dual_water_tank.c,235 :: 		PORTC &= ~(1 << 2);
	BCF        PORTC+0, 2
;dual_water_tank.c,236 :: 		}
	GOTO       L_Read_Print_Control45
L_Read_Print_Control44:
;dual_water_tank.c,237 :: 		else if(Index==2) {
	MOVF       _Index+0, 0
	XORLW      2
	BTFSS      STATUS+0, 2
	GOTO       L_Read_Print_Control46
;dual_water_tank.c,238 :: 		PORTD |= (1 << 0);
	BSF        PORTD+0, 0
;dual_water_tank.c,239 :: 		My_DelayUs(10);
	MOVLW      10
	MOVWF      FARG_My_DelayUs_us+0
	MOVLW      0
	MOVWF      FARG_My_DelayUs_us+1
	CALL       _My_DelayUs+0
;dual_water_tank.c,240 :: 		PORTD &= ~(1 << 0);
	BCF        PORTD+0, 0
;dual_water_tank.c,241 :: 		}
L_Read_Print_Control46:
L_Read_Print_Control45:
;dual_water_tank.c,242 :: 		My_DelayMs(2);
	MOVLW      2
	MOVWF      FARG_My_DelayMs_ms+0
	MOVLW      0
	MOVWF      FARG_My_DelayMs_ms+1
	CALL       _My_DelayMs+0
;dual_water_tank.c,243 :: 		if(Index==1) {
	MOVF       _Index+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_Read_Print_Control47
;dual_water_tank.c,244 :: 		for(j=0;j<=50000;j++){
	CLRF       _j+0
	CLRF       _j+1
	CLRF       _j+2
	CLRF       _j+3
L_Read_Print_Control48:
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _j+3, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Read_Print_Control160
	MOVF       _j+2, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__Read_Print_Control160
	MOVF       _j+1, 0
	SUBLW      195
	BTFSS      STATUS+0, 2
	GOTO       L__Read_Print_Control160
	MOVF       _j+0, 0
	SUBLW      80
L__Read_Print_Control160:
	BTFSS      STATUS+0, 0
	GOTO       L_Read_Print_Control49
;dual_water_tank.c,245 :: 		if(PORTC & (1 << 3)) { break; }
	BTFSS      PORTC+0, 3
	GOTO       L_Read_Print_Control51
	GOTO       L_Read_Print_Control49
L_Read_Print_Control51:
;dual_water_tank.c,246 :: 		My_DelayUs(1);
	MOVLW      1
	MOVWF      FARG_My_DelayUs_us+0
	MOVLW      0
	MOVWF      FARG_My_DelayUs_us+1
	CALL       _My_DelayUs+0
;dual_water_tank.c,244 :: 		for(j=0;j<=50000;j++){
	MOVF       _j+0, 0
	MOVWF      R0+0
	MOVF       _j+1, 0
	MOVWF      R0+1
	MOVF       _j+2, 0
	MOVWF      R0+2
	MOVF       _j+3, 0
	MOVWF      R0+3
	INCF       R0+0, 1
	BTFSC      STATUS+0, 2
	INCF       R0+1, 1
	BTFSC      STATUS+0, 2
	INCF       R0+2, 1
	BTFSC      STATUS+0, 2
	INCF       R0+3, 1
	MOVF       R0+0, 0
	MOVWF      _j+0
	MOVF       R0+1, 0
	MOVWF      _j+1
	MOVF       R0+2, 0
	MOVWF      _j+2
	MOVF       R0+3, 0
	MOVWF      _j+3
;dual_water_tank.c,247 :: 		}
	GOTO       L_Read_Print_Control48
L_Read_Print_Control49:
;dual_water_tank.c,248 :: 		}
	GOTO       L_Read_Print_Control52
L_Read_Print_Control47:
;dual_water_tank.c,250 :: 		for(j=0;j<=50000;j++){
	CLRF       _j+0
	CLRF       _j+1
	CLRF       _j+2
	CLRF       _j+3
L_Read_Print_Control53:
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _j+3, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Read_Print_Control161
	MOVF       _j+2, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__Read_Print_Control161
	MOVF       _j+1, 0
	SUBLW      195
	BTFSS      STATUS+0, 2
	GOTO       L__Read_Print_Control161
	MOVF       _j+0, 0
	SUBLW      80
L__Read_Print_Control161:
	BTFSS      STATUS+0, 0
	GOTO       L_Read_Print_Control54
;dual_water_tank.c,251 :: 		if(PORTD & (1 << 1)) { break; }
	BTFSS      PORTD+0, 1
	GOTO       L_Read_Print_Control56
	GOTO       L_Read_Print_Control54
L_Read_Print_Control56:
;dual_water_tank.c,252 :: 		My_DelayUs(1);
	MOVLW      1
	MOVWF      FARG_My_DelayUs_us+0
	MOVLW      0
	MOVWF      FARG_My_DelayUs_us+1
	CALL       _My_DelayUs+0
;dual_water_tank.c,250 :: 		for(j=0;j<=50000;j++){
	MOVF       _j+0, 0
	MOVWF      R0+0
	MOVF       _j+1, 0
	MOVWF      R0+1
	MOVF       _j+2, 0
	MOVWF      R0+2
	MOVF       _j+3, 0
	MOVWF      R0+3
	INCF       R0+0, 1
	BTFSC      STATUS+0, 2
	INCF       R0+1, 1
	BTFSC      STATUS+0, 2
	INCF       R0+2, 1
	BTFSC      STATUS+0, 2
	INCF       R0+3, 1
	MOVF       R0+0, 0
	MOVWF      _j+0
	MOVF       R0+1, 0
	MOVWF      _j+1
	MOVF       R0+2, 0
	MOVWF      _j+2
	MOVF       R0+3, 0
	MOVWF      _j+3
;dual_water_tank.c,253 :: 		}
	GOTO       L_Read_Print_Control53
L_Read_Print_Control54:
;dual_water_tank.c,254 :: 		}
L_Read_Print_Control52:
;dual_water_tank.c,255 :: 		T1CON |= (1 << 0);
	BSF        T1CON+0, 0
;dual_water_tank.c,256 :: 		if(check_sonic>=1 && j>=50000) { k1=0; goto cont; }
	MOVLW      1
	SUBWF      _check_sonic+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_Read_Print_Control59
	MOVLW      128
	XORWF      _j+3, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Read_Print_Control162
	MOVLW      0
	SUBWF      _j+2, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Read_Print_Control162
	MOVLW      195
	SUBWF      _j+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Read_Print_Control162
	MOVLW      80
	SUBWF      _j+0, 0
L__Read_Print_Control162:
	BTFSS      STATUS+0, 0
	GOTO       L_Read_Print_Control59
L__Read_Print_Control136:
	CLRF       _k1+0
	CLRF       _k1+1
	CLRF       _k1+2
	CLRF       _k1+3
	GOTO       ___Read_Print_Control_cont
L_Read_Print_Control59:
;dual_water_tank.c,257 :: 		if(j>=50000) { check_sonic++; goto twin; }
	MOVLW      128
	XORWF      _j+3, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Read_Print_Control163
	MOVLW      0
	SUBWF      _j+2, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Read_Print_Control163
	MOVLW      195
	SUBWF      _j+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Read_Print_Control163
	MOVLW      80
	SUBWF      _j+0, 0
L__Read_Print_Control163:
	BTFSS      STATUS+0, 0
	GOTO       L_Read_Print_Control60
	INCF       _check_sonic+0, 1
	GOTO       ___Read_Print_Control_twin
L_Read_Print_Control60:
;dual_water_tank.c,258 :: 		check_sonic=0;
	CLRF       _check_sonic+0
;dual_water_tank.c,259 :: 		if(Index==1) {
	MOVF       _Index+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_Read_Print_Control61
;dual_water_tank.c,260 :: 		for(j=0;j<=50000;j++){
	CLRF       _j+0
	CLRF       _j+1
	CLRF       _j+2
	CLRF       _j+3
L_Read_Print_Control62:
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _j+3, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Read_Print_Control164
	MOVF       _j+2, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__Read_Print_Control164
	MOVF       _j+1, 0
	SUBLW      195
	BTFSS      STATUS+0, 2
	GOTO       L__Read_Print_Control164
	MOVF       _j+0, 0
	SUBLW      80
L__Read_Print_Control164:
	BTFSS      STATUS+0, 0
	GOTO       L_Read_Print_Control63
;dual_water_tank.c,261 :: 		if(!(PORTC & (1 << 3))){ break; }
	BTFSC      PORTC+0, 3
	GOTO       L_Read_Print_Control65
	GOTO       L_Read_Print_Control63
L_Read_Print_Control65:
;dual_water_tank.c,262 :: 		My_DelayUs(1);
	MOVLW      1
	MOVWF      FARG_My_DelayUs_us+0
	MOVLW      0
	MOVWF      FARG_My_DelayUs_us+1
	CALL       _My_DelayUs+0
;dual_water_tank.c,260 :: 		for(j=0;j<=50000;j++){
	MOVF       _j+0, 0
	MOVWF      R0+0
	MOVF       _j+1, 0
	MOVWF      R0+1
	MOVF       _j+2, 0
	MOVWF      R0+2
	MOVF       _j+3, 0
	MOVWF      R0+3
	INCF       R0+0, 1
	BTFSC      STATUS+0, 2
	INCF       R0+1, 1
	BTFSC      STATUS+0, 2
	INCF       R0+2, 1
	BTFSC      STATUS+0, 2
	INCF       R0+3, 1
	MOVF       R0+0, 0
	MOVWF      _j+0
	MOVF       R0+1, 0
	MOVWF      _j+1
	MOVF       R0+2, 0
	MOVWF      _j+2
	MOVF       R0+3, 0
	MOVWF      _j+3
;dual_water_tank.c,263 :: 		}
	GOTO       L_Read_Print_Control62
L_Read_Print_Control63:
;dual_water_tank.c,264 :: 		}
	GOTO       L_Read_Print_Control66
L_Read_Print_Control61:
;dual_water_tank.c,266 :: 		for(j=0;j<=50000;j++){
	CLRF       _j+0
	CLRF       _j+1
	CLRF       _j+2
	CLRF       _j+3
L_Read_Print_Control67:
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _j+3, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Read_Print_Control165
	MOVF       _j+2, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__Read_Print_Control165
	MOVF       _j+1, 0
	SUBLW      195
	BTFSS      STATUS+0, 2
	GOTO       L__Read_Print_Control165
	MOVF       _j+0, 0
	SUBLW      80
L__Read_Print_Control165:
	BTFSS      STATUS+0, 0
	GOTO       L_Read_Print_Control68
;dual_water_tank.c,267 :: 		if(!(PORTD & (1 << 1))){ break; }
	BTFSC      PORTD+0, 1
	GOTO       L_Read_Print_Control70
	GOTO       L_Read_Print_Control68
L_Read_Print_Control70:
;dual_water_tank.c,268 :: 		My_DelayUs(1);
	MOVLW      1
	MOVWF      FARG_My_DelayUs_us+0
	MOVLW      0
	MOVWF      FARG_My_DelayUs_us+1
	CALL       _My_DelayUs+0
;dual_water_tank.c,266 :: 		for(j=0;j<=50000;j++){
	MOVF       _j+0, 0
	MOVWF      R0+0
	MOVF       _j+1, 0
	MOVWF      R0+1
	MOVF       _j+2, 0
	MOVWF      R0+2
	MOVF       _j+3, 0
	MOVWF      R0+3
	INCF       R0+0, 1
	BTFSC      STATUS+0, 2
	INCF       R0+1, 1
	BTFSC      STATUS+0, 2
	INCF       R0+2, 1
	BTFSC      STATUS+0, 2
	INCF       R0+3, 1
	MOVF       R0+0, 0
	MOVWF      _j+0
	MOVF       R0+1, 0
	MOVWF      _j+1
	MOVF       R0+2, 0
	MOVWF      _j+2
	MOVF       R0+3, 0
	MOVWF      _j+3
;dual_water_tank.c,269 :: 		}
	GOTO       L_Read_Print_Control67
L_Read_Print_Control68:
;dual_water_tank.c,270 :: 		}
L_Read_Print_Control66:
;dual_water_tank.c,271 :: 		T1CON &= ~(1 << 0);
	BCF        T1CON+0, 0
;dual_water_tank.c,272 :: 		k1 = ((TMR1H<<8) | TMR1L);
	CLRF       _k1+3
	MOVF       TMR1H+1, 0
	MOVWF      _k1+2
	MOVF       TMR1H+0, 0
	MOVWF      _k1+1
	CLRF       _k1+0
	MOVF       TMR1L+0, 0
	IORWF      _k1+0, 1
	MOVLW      0
	IORWF      _k1+1, 1
	MOVLW      0
	MOVWF      _k1+2
	MOVWF      _k1+3
;dual_water_tank.c,273 :: 		k1 = k1*1;
;dual_water_tank.c,274 :: 		k1 = SpeedOfSound * ((float)k1/2000000.0)/2.0;
	MOVF       _k1+0, 0
	MOVWF      R0+0
	MOVF       _k1+1, 0
	MOVWF      R0+1
	MOVF       _k1+2, 0
	MOVWF      R0+2
	MOVF       _k1+3, 0
	MOVWF      R0+3
	CALL       _longint2double+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      36
	MOVWF      R4+1
	MOVLW      116
	MOVWF      R4+2
	MOVLW      147
	MOVWF      R4+3
	CALL       _Div_32x32_FP+0
	MOVF       _SpeedOfSound+0, 0
	MOVWF      R4+0
	MOVF       _SpeedOfSound+1, 0
	MOVWF      R4+1
	MOVF       _SpeedOfSound+2, 0
	MOVWF      R4+2
	MOVF       _SpeedOfSound+3, 0
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      0
	MOVWF      R4+2
	MOVLW      128
	MOVWF      R4+3
	CALL       _Div_32x32_FP+0
	CALL       _double2longint+0
	MOVF       R0+0, 0
	MOVWF      _k1+0
	MOVF       R0+1, 0
	MOVWF      _k1+1
	MOVF       R0+2, 0
	MOVWF      _k1+2
	MOVF       R0+3, 0
	MOVWF      _k1+3
;dual_water_tank.c,275 :: 		cont:
___Read_Print_Control_cont:
;dual_water_tank.c,276 :: 		Distance = k1;
	MOVF       _k1+0, 0
	MOVWF      _Distance+0
	MOVF       _k1+1, 0
	MOVWF      _Distance+1
;dual_water_tank.c,277 :: 		if(Index==1) Master_T_Level = Master_T_Height - Distance;
	MOVF       _Index+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_Read_Print_Control71
	MOVF       _Distance+0, 0
	SUBWF      _Master_T_Height+0, 0
	MOVWF      _Master_T_Level+0
	MOVF       _Distance+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      _Master_T_Height+1, 0
	MOVWF      _Master_T_Level+1
L_Read_Print_Control71:
;dual_water_tank.c,278 :: 		if(Index==2) Pump_T_Level   = Pump_T_Height   - Distance;
	MOVF       _Index+0, 0
	XORLW      2
	BTFSS      STATUS+0, 2
	GOTO       L_Read_Print_Control72
	MOVF       _Distance+0, 0
	SUBWF      _Pump_T_Height+0, 0
	MOVWF      _Pump_T_Level+0
	MOVF       _Distance+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      _Pump_T_Height+1, 0
	MOVWF      _Pump_T_Level+1
L_Read_Print_Control72:
;dual_water_tank.c,279 :: 		Index++;
	INCF       _Index+0, 1
;dual_water_tank.c,280 :: 		if(Index<3) { goto All_Index; }
	MOVLW      3
	SUBWF      _Index+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_Read_Print_Control73
	GOTO       ___Read_Print_Control_All_Index
L_Read_Print_Control73:
;dual_water_tank.c,281 :: 		My_DelayMs(100);
	MOVLW      100
	MOVWF      FARG_My_DelayMs_ms+0
	MOVLW      0
	MOVWF      FARG_My_DelayMs_ms+1
	CALL       _My_DelayMs+0
;dual_water_tank.c,283 :: 		if(LCD_Page==0){
	MOVLW      0
	XORWF      _LCD_Page+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Read_Print_Control166
	MOVLW      0
	XORWF      _LCD_Page+0, 0
L__Read_Print_Control166:
	BTFSS      STATUS+0, 2
	GOTO       L_Read_Print_Control74
;dual_water_tank.c,284 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;dual_water_tank.c,285 :: 		IntToStr(Master_T_Level, txt); Ltrim(txt);
	MOVF       _Master_T_Level+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       _Master_T_Level+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _txt+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
	MOVLW      _txt+0
	MOVWF      FARG_Ltrim_string+0
	CALL       _Ltrim+0
;dual_water_tank.c,286 :: 		Lcd_Out(1,1,"Master  "); Lcd_Out_Cp(txt); Lcd_Out_Cp("cm");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr4_dual_water_tank+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
	MOVLW      _txt+0
	MOVWF      FARG_Lcd_Out_CP_text+0
	CALL       _Lcd_Out_CP+0
	MOVLW      ?lstr5_dual_water_tank+0
	MOVWF      FARG_Lcd_Out_CP_text+0
	CALL       _Lcd_Out_CP+0
;dual_water_tank.c,287 :: 		IntToStr(Pump_T_Level, txt); Ltrim(txt);
	MOVF       _Pump_T_Level+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       _Pump_T_Level+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _txt+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
	MOVLW      _txt+0
	MOVWF      FARG_Ltrim_string+0
	CALL       _Ltrim+0
;dual_water_tank.c,288 :: 		Lcd_Out(2,1,"Pump    "); Lcd_Out_Cp(txt); Lcd_Out_Cp("cm");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr6_dual_water_tank+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
	MOVLW      _txt+0
	MOVWF      FARG_Lcd_Out_CP_text+0
	CALL       _Lcd_Out_CP+0
	MOVLW      ?lstr7_dual_water_tank+0
	MOVWF      FARG_Lcd_Out_CP_text+0
	CALL       _Lcd_Out_CP+0
;dual_water_tank.c,289 :: 		if(LCD_Page==0){ while(PORTB & (1 << 0)){} }
	MOVLW      0
	XORWF      _LCD_Page+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Read_Print_Control167
	MOVLW      0
	XORWF      _LCD_Page+0, 0
L__Read_Print_Control167:
	BTFSS      STATUS+0, 2
	GOTO       L_Read_Print_Control75
L_Read_Print_Control76:
	BTFSS      PORTB+0, 0
	GOTO       L_Read_Print_Control77
	GOTO       L_Read_Print_Control76
L_Read_Print_Control77:
L_Read_Print_Control75:
;dual_water_tank.c,290 :: 		}
	GOTO       L_Read_Print_Control78
L_Read_Print_Control74:
;dual_water_tank.c,292 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;dual_water_tank.c,293 :: 		IntToStr(TX_Temp, txt); Ltrim(txt);
	MOVF       _TX_Temp+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       _TX_Temp+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _txt+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
	MOVLW      _txt+0
	MOVWF      FARG_Ltrim_string+0
	CALL       _Ltrim+0
;dual_water_tank.c,294 :: 		Lcd_Out(1,1,"Temp  "); Lcd_Out_Cp(txt);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr8_dual_water_tank+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
	MOVLW      _txt+0
	MOVWF      FARG_Lcd_Out_CP_text+0
	CALL       _Lcd_Out_CP+0
;dual_water_tank.c,295 :: 		Lcd_Chr_Cp(223);
	MOVLW      223
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;dual_water_tank.c,296 :: 		Lcd_Chr_Cp('C');
	MOVLW      67
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;dual_water_tank.c,297 :: 		IntToStr(RH_Byte1, txt); Ltrim(txt);
	MOVF       _RH_byte1+0, 0
	MOVWF      FARG_IntToStr_input+0
	CLRF       FARG_IntToStr_input+1
	MOVLW      _txt+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
	MOVLW      _txt+0
	MOVWF      FARG_Ltrim_string+0
	CALL       _Ltrim+0
;dual_water_tank.c,298 :: 		Lcd_Out(2,1,"Humid "); Lcd_Out_Cp(txt); Lcd_Out_Cp("%");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr9_dual_water_tank+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
	MOVLW      _txt+0
	MOVWF      FARG_Lcd_Out_CP_text+0
	CALL       _Lcd_Out_CP+0
	MOVLW      ?lstr10_dual_water_tank+0
	MOVWF      FARG_Lcd_Out_CP_text+0
	CALL       _Lcd_Out_CP+0
;dual_water_tank.c,299 :: 		if(LCD_Page==1){ while(PORTB & (1 << 0)){} }
	MOVLW      0
	XORWF      _LCD_Page+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Read_Print_Control168
	MOVLW      1
	XORWF      _LCD_Page+0, 0
L__Read_Print_Control168:
	BTFSS      STATUS+0, 2
	GOTO       L_Read_Print_Control79
L_Read_Print_Control80:
	BTFSS      PORTB+0, 0
	GOTO       L_Read_Print_Control81
	GOTO       L_Read_Print_Control80
L_Read_Print_Control81:
L_Read_Print_Control79:
;dual_water_tank.c,300 :: 		}
L_Read_Print_Control78:
;dual_water_tank.c,301 :: 		if ((Master_T_Level <= Master_T_Pump_ON_Level) && (Pump_T_Level >= Pump_T_ON_Level)) {
	MOVLW      128
	XORWF      _Master_T_Pump_ON_Level+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      _Master_T_Level+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Read_Print_Control169
	MOVF       _Master_T_Level+0, 0
	SUBWF      _Master_T_Pump_ON_Level+0, 0
L__Read_Print_Control169:
	BTFSS      STATUS+0, 0
	GOTO       L_Read_Print_Control84
	MOVLW      128
	XORWF      _Pump_T_Level+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      _Pump_T_ON_Level+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Read_Print_Control170
	MOVF       _Pump_T_ON_Level+0, 0
	SUBWF      _Pump_T_Level+0, 0
L__Read_Print_Control170:
	BTFSS      STATUS+0, 0
	GOTO       L_Read_Print_Control84
L__Read_Print_Control135:
;dual_water_tank.c,302 :: 		PORTD |= (1 << 4);
	BSF        PORTD+0, 4
;dual_water_tank.c,303 :: 		}
L_Read_Print_Control84:
;dual_water_tank.c,304 :: 		if ((Master_T_Level >= Master_T_Pump_OFF_Level) || (Pump_T_Level <= Pump_T_OFF_Level)) {
	MOVLW      128
	XORWF      _Master_T_Level+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      _Master_T_Pump_OFF_Level+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Read_Print_Control171
	MOVF       _Master_T_Pump_OFF_Level+0, 0
	SUBWF      _Master_T_Level+0, 0
L__Read_Print_Control171:
	BTFSC      STATUS+0, 0
	GOTO       L__Read_Print_Control134
	MOVLW      128
	XORWF      _Pump_T_OFF_Level+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      _Pump_T_Level+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Read_Print_Control172
	MOVF       _Pump_T_Level+0, 0
	SUBWF      _Pump_T_OFF_Level+0, 0
L__Read_Print_Control172:
	BTFSC      STATUS+0, 0
	GOTO       L__Read_Print_Control134
	GOTO       L_Read_Print_Control87
L__Read_Print_Control134:
;dual_water_tank.c,305 :: 		PORTD &= ~(1 << 4);
	BCF        PORTD+0, 4
;dual_water_tank.c,306 :: 		}
L_Read_Print_Control87:
;dual_water_tank.c,307 :: 		My_DelayMs(1000);
	MOVLW      232
	MOVWF      FARG_My_DelayMs_ms+0
	MOVLW      3
	MOVWF      FARG_My_DelayMs_ms+1
	CALL       _My_DelayMs+0
;dual_water_tank.c,308 :: 		if (First_ON_Flag == 1) {
	MOVLW      0
	XORWF      _First_ON_Flag+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Read_Print_Control173
	MOVLW      1
	XORWF      _First_ON_Flag+0, 0
L__Read_Print_Control173:
	BTFSS      STATUS+0, 2
	GOTO       L_Read_Print_Control88
;dual_water_tank.c,309 :: 		First_ON_Flag = 0;
	CLRF       _First_ON_Flag+0
	CLRF       _First_ON_Flag+1
;dual_water_tank.c,310 :: 		Openning_Flag = 1;
	MOVLW      1
	MOVWF      _Openning_Flag+0
;dual_water_tank.c,311 :: 		while (angle < 183) {
L_Read_Print_Control89:
	MOVLW      128
	XORWF      _angle+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Read_Print_Control174
	MOVLW      183
	SUBWF      _angle+0, 0
L__Read_Print_Control174:
	BTFSC      STATUS+0, 0
	GOTO       L_Read_Print_Control90
;dual_water_tank.c,312 :: 		angle++;
	INCF       _angle+0, 1
	BTFSC      STATUS+0, 2
	INCF       _angle+1, 1
;dual_water_tank.c,313 :: 		for (x = 0; x <= 1900; x++) {
	CLRF       _x+0
	CLRF       _x+1
L_Read_Print_Control91:
	MOVF       _x+1, 0
	SUBLW      7
	BTFSS      STATUS+0, 2
	GOTO       L__Read_Print_Control175
	MOVF       _x+0, 0
	SUBLW      108
L__Read_Print_Control175:
	BTFSS      STATUS+0, 0
	GOTO       L_Read_Print_Control92
;dual_water_tank.c,314 :: 		if (x < angle) {
	MOVF       _angle+1, 0
	SUBWF      _x+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Read_Print_Control176
	MOVF       _angle+0, 0
	SUBWF      _x+0, 0
L__Read_Print_Control176:
	BTFSC      STATUS+0, 0
	GOTO       L_Read_Print_Control94
;dual_water_tank.c,315 :: 		PORTD |= (1 << 2);
	BSF        PORTD+0, 2
;dual_water_tank.c,316 :: 		} else {
	GOTO       L_Read_Print_Control95
L_Read_Print_Control94:
;dual_water_tank.c,317 :: 		PORTD &= ~(1 << 2);
	BCF        PORTD+0, 2
;dual_water_tank.c,318 :: 		}
L_Read_Print_Control95:
;dual_water_tank.c,313 :: 		for (x = 0; x <= 1900; x++) {
	INCF       _x+0, 1
	BTFSC      STATUS+0, 2
	INCF       _x+1, 1
;dual_water_tank.c,319 :: 		}
	GOTO       L_Read_Print_Control91
L_Read_Print_Control92:
;dual_water_tank.c,320 :: 		}
	GOTO       L_Read_Print_Control89
L_Read_Print_Control90:
;dual_water_tank.c,321 :: 		}
L_Read_Print_Control88:
;dual_water_tank.c,322 :: 		if (Openning_Flag == 0) {
	MOVF       _Openning_Flag+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_Read_Print_Control96
;dual_water_tank.c,323 :: 		while (!(PORTC & (1 << 6))) {
L_Read_Print_Control97:
	BTFSC      PORTC+0, 6
	GOTO       L_Read_Print_Control98
;dual_water_tank.c,324 :: 		Openning_Flag = 1;
	MOVLW      1
	MOVWF      _Openning_Flag+0
;dual_water_tank.c,325 :: 		if (!(PORTC & (1 << 6)) && angle < 183) {
	BTFSC      PORTC+0, 6
	GOTO       L_Read_Print_Control101
	MOVLW      128
	XORWF      _angle+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Read_Print_Control177
	MOVLW      183
	SUBWF      _angle+0, 0
L__Read_Print_Control177:
	BTFSC      STATUS+0, 0
	GOTO       L_Read_Print_Control101
L__Read_Print_Control133:
;dual_water_tank.c,326 :: 		angle++;
	INCF       _angle+0, 1
	BTFSC      STATUS+0, 2
	INCF       _angle+1, 1
;dual_water_tank.c,327 :: 		}
L_Read_Print_Control101:
;dual_water_tank.c,328 :: 		for (x = 0; x <= 1900; x++) {
	CLRF       _x+0
	CLRF       _x+1
L_Read_Print_Control102:
	MOVF       _x+1, 0
	SUBLW      7
	BTFSS      STATUS+0, 2
	GOTO       L__Read_Print_Control178
	MOVF       _x+0, 0
	SUBLW      108
L__Read_Print_Control178:
	BTFSS      STATUS+0, 0
	GOTO       L_Read_Print_Control103
;dual_water_tank.c,329 :: 		PORTD = (x < angle) ? (PORTD | (1 << 2)) : (PORTD & ~(1 << 2));
	MOVF       _angle+1, 0
	SUBWF      _x+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Read_Print_Control179
	MOVF       _angle+0, 0
	SUBWF      _x+0, 0
L__Read_Print_Control179:
	BTFSC      STATUS+0, 0
	GOTO       L_Read_Print_Control105
	MOVLW      4
	IORWF      PORTD+0, 0
	MOVWF      ?FLOC___Read_Print_ControlT193+0
	MOVLW      0
	MOVWF      ?FLOC___Read_Print_ControlT193+1
	GOTO       L_Read_Print_Control106
L_Read_Print_Control105:
	MOVLW      251
	ANDWF      PORTD+0, 0
	MOVWF      ?FLOC___Read_Print_ControlT193+0
	MOVLW      0
	MOVWF      ?FLOC___Read_Print_ControlT193+1
L_Read_Print_Control106:
	MOVF       ?FLOC___Read_Print_ControlT193+0, 0
	MOVWF      PORTD+0
;dual_water_tank.c,328 :: 		for (x = 0; x <= 1900; x++) {
	INCF       _x+0, 1
	BTFSC      STATUS+0, 2
	INCF       _x+1, 1
;dual_water_tank.c,330 :: 		}
	GOTO       L_Read_Print_Control102
L_Read_Print_Control103:
;dual_water_tank.c,331 :: 		}
	GOTO       L_Read_Print_Control97
L_Read_Print_Control98:
;dual_water_tank.c,332 :: 		} else {
	GOTO       L_Read_Print_Control107
L_Read_Print_Control96:
;dual_water_tank.c,333 :: 		while (!(PORTC & (1 << 6))) {
L_Read_Print_Control108:
	BTFSC      PORTC+0, 6
	GOTO       L_Read_Print_Control109
;dual_water_tank.c,334 :: 		Openning_Flag = 0;
	CLRF       _Openning_Flag+0
;dual_water_tank.c,335 :: 		if (!(PORTC & (1 << 6)) && angle > 43) {
	BTFSC      PORTC+0, 6
	GOTO       L_Read_Print_Control112
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _angle+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Read_Print_Control180
	MOVF       _angle+0, 0
	SUBLW      43
L__Read_Print_Control180:
	BTFSC      STATUS+0, 0
	GOTO       L_Read_Print_Control112
L__Read_Print_Control132:
;dual_water_tank.c,336 :: 		angle--;
	MOVLW      1
	SUBWF      _angle+0, 1
	BTFSS      STATUS+0, 0
	DECF       _angle+1, 1
;dual_water_tank.c,337 :: 		}
L_Read_Print_Control112:
;dual_water_tank.c,338 :: 		for (x = 0; x <= 1900; x++) {
	CLRF       _x+0
	CLRF       _x+1
L_Read_Print_Control113:
	MOVF       _x+1, 0
	SUBLW      7
	BTFSS      STATUS+0, 2
	GOTO       L__Read_Print_Control181
	MOVF       _x+0, 0
	SUBLW      108
L__Read_Print_Control181:
	BTFSS      STATUS+0, 0
	GOTO       L_Read_Print_Control114
;dual_water_tank.c,339 :: 		PORTD = (x < angle) ? (PORTD | (1 << 2)) : (PORTD & ~(1 << 2));
	MOVF       _angle+1, 0
	SUBWF      _x+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Read_Print_Control182
	MOVF       _angle+0, 0
	SUBWF      _x+0, 0
L__Read_Print_Control182:
	BTFSC      STATUS+0, 0
	GOTO       L_Read_Print_Control116
	MOVLW      4
	IORWF      PORTD+0, 0
	MOVWF      ?FLOC___Read_Print_ControlT207+0
	MOVLW      0
	MOVWF      ?FLOC___Read_Print_ControlT207+1
	GOTO       L_Read_Print_Control117
L_Read_Print_Control116:
	MOVLW      251
	ANDWF      PORTD+0, 0
	MOVWF      ?FLOC___Read_Print_ControlT207+0
	MOVLW      0
	MOVWF      ?FLOC___Read_Print_ControlT207+1
L_Read_Print_Control117:
	MOVF       ?FLOC___Read_Print_ControlT207+0, 0
	MOVWF      PORTD+0
;dual_water_tank.c,338 :: 		for (x = 0; x <= 1900; x++) {
	INCF       _x+0, 1
	BTFSC      STATUS+0, 2
	INCF       _x+1, 1
;dual_water_tank.c,340 :: 		}
	GOTO       L_Read_Print_Control113
L_Read_Print_Control114:
;dual_water_tank.c,341 :: 		}
	GOTO       L_Read_Print_Control108
L_Read_Print_Control109:
;dual_water_tank.c,342 :: 		}
L_Read_Print_Control107:
;dual_water_tank.c,343 :: 		goto Keep_Tracking;
	GOTO       ___Read_Print_Control_Keep_Tracking
;dual_water_tank.c,344 :: 		}
L_end_Read_Print_Control:
	RETURN
; end of _Read_Print_Control

_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;dual_water_tank.c,346 :: 		void interrupt(){
;dual_water_tank.c,347 :: 		if(INTCON & (1 << 1)){
	BTFSS      INTCON+0, 1
	GOTO       L_interrupt118
;dual_water_tank.c,348 :: 		if(!(PORTB & (1 << 0))){
	BTFSC      PORTB+0, 0
	GOTO       L_interrupt119
;dual_water_tank.c,349 :: 		if(LCD_Page==0) { LCD_Page = 1; }
	MOVLW      0
	XORWF      _LCD_Page+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt185
	MOVLW      0
	XORWF      _LCD_Page+0, 0
L__interrupt185:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt120
	MOVLW      1
	MOVWF      _LCD_Page+0
	MOVLW      0
	MOVWF      _LCD_Page+1
	GOTO       L_interrupt121
L_interrupt120:
;dual_water_tank.c,350 :: 		else            { LCD_Page = 0; }
	CLRF       _LCD_Page+0
	CLRF       _LCD_Page+1
L_interrupt121:
;dual_water_tank.c,351 :: 		}
L_interrupt119:
;dual_water_tank.c,352 :: 		INTCON &= ~(1 << 1);
	BCF        INTCON+0, 1
;dual_water_tank.c,353 :: 		}
L_interrupt118:
;dual_water_tank.c,354 :: 		}
L_end_interrupt:
L__interrupt184:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;dual_water_tank.c,356 :: 		void main() {
;dual_water_tank.c,357 :: 		TRISA = 0x00;
	CLRF       TRISA+0
;dual_water_tank.c,358 :: 		TRISA |= (1 << 0);
	BSF        TRISA+0, 0
;dual_water_tank.c,359 :: 		TRISA |= (1 << 1);
	BSF        TRISA+0, 1
;dual_water_tank.c,360 :: 		TRISA |= (1 << 2);
	BSF        TRISA+0, 2
;dual_water_tank.c,361 :: 		TRISA |= (1 << 3);
	BSF        TRISA+0, 3
;dual_water_tank.c,362 :: 		TRISA |= (1 << 4);
	BSF        TRISA+0, 4
;dual_water_tank.c,363 :: 		TRISA |= (1 << 5);
	BSF        TRISA+0, 5
;dual_water_tank.c,364 :: 		TRISA |= (1 << 6);
	BSF        TRISA+0, 6
;dual_water_tank.c,365 :: 		TRISA |= (1 << 7);
	BSF        TRISA+0, 7
;dual_water_tank.c,366 :: 		TRISB = 0x00;
	CLRF       TRISB+0
;dual_water_tank.c,367 :: 		TRISB |= (1 << 0);
	BSF        TRISB+0, 0
;dual_water_tank.c,368 :: 		TRISB |= (1 << 1);
	BSF        TRISB+0, 1
;dual_water_tank.c,369 :: 		TRISB |= (1 << 2);
	BSF        TRISB+0, 2
;dual_water_tank.c,370 :: 		TRISB |= (1 << 3);
	BSF        TRISB+0, 3
;dual_water_tank.c,371 :: 		TRISB |= (1 << 4);
	BSF        TRISB+0, 4
;dual_water_tank.c,372 :: 		TRISB |= (1 << 5);
	BSF        TRISB+0, 5
;dual_water_tank.c,373 :: 		TRISB |= (1 << 6);
	BSF        TRISB+0, 6
;dual_water_tank.c,374 :: 		TRISB |= (1 << 7);
	BSF        TRISB+0, 7
;dual_water_tank.c,375 :: 		TRISC = 0x00;
	CLRF       TRISC+0
;dual_water_tank.c,376 :: 		TRISC |= (1 << 3);
	BSF        TRISC+0, 3
;dual_water_tank.c,377 :: 		TRISC |= (1 << 4);
	BSF        TRISC+0, 4
;dual_water_tank.c,378 :: 		TRISD = 0x00;
	CLRF       TRISD+0
;dual_water_tank.c,379 :: 		TRISD |= (1 << 1);
	BSF        TRISD+0, 1
;dual_water_tank.c,380 :: 		TRISE = 0x07;
	MOVLW      7
	MOVWF      TRISE+0
;dual_water_tank.c,381 :: 		My_ADC_Init();
	CALL       _My_ADC_Init+0
;dual_water_tank.c,382 :: 		INTCON |= (1 << 7);
	BSF        INTCON+0, 7
;dual_water_tank.c,383 :: 		INTCON |= (1 << 6);
	BSF        INTCON+0, 6
;dual_water_tank.c,384 :: 		T1CON = 0b00000000;
	CLRF       T1CON+0
;dual_water_tank.c,385 :: 		INTCON |= (1 << 4);
	BSF        INTCON+0, 4
;dual_water_tank.c,386 :: 		INTCON &= ~(1 << 1);
	BCF        INTCON+0, 1
;dual_water_tank.c,387 :: 		OPTION_REG &= ~(1 << 6);
	BCF        OPTION_REG+0, 6
;dual_water_tank.c,388 :: 		CCP1CON = 0x00;
	CLRF       CCP1CON+0
;dual_water_tank.c,389 :: 		CCP2CON = 0x00;
	CLRF       CCP2CON+0
;dual_water_tank.c,390 :: 		PORTB |= (1 << 5);
	BSF        PORTB+0, 5
;dual_water_tank.c,391 :: 		PORTD |= (1 << 5);
	BSF        PORTD+0, 5
;dual_water_tank.c,392 :: 		PORTC &= ~(1 << 2);
	BCF        PORTC+0, 2
;dual_water_tank.c,393 :: 		PORTD &= ~(1 << 0);
	BCF        PORTD+0, 0
;dual_water_tank.c,394 :: 		PORTD &= ~(1 << 4);
	BCF        PORTD+0, 4
;dual_water_tank.c,395 :: 		PORTC &= ~(1 << 5);
	BCF        PORTC+0, 5
;dual_water_tank.c,396 :: 		PORTA |= (1 << 2);
	BSF        PORTA+0, 2
;dual_water_tank.c,397 :: 		PORTD &= ~(1 << 2);
	BCF        PORTD+0, 2
;dual_water_tank.c,398 :: 		PORTC &= ~(1 << 1);
	BCF        PORTC+0, 1
;dual_water_tank.c,399 :: 		PORTC &= ~(1 << 7);
	BCF        PORTC+0, 7
;dual_water_tank.c,400 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;dual_water_tank.c,401 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;dual_water_tank.c,402 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;dual_water_tank.c,403 :: 		My_PWM2_Init();
	CALL       _My_PWM2_Init+0
;dual_water_tank.c,404 :: 		My_PWM2_Stop();
	CALL       _My_PWM2_Stop+0
;dual_water_tank.c,405 :: 		angle = 224;
	MOVLW      224
	MOVWF      _angle+0
	CLRF       _angle+1
;dual_water_tank.c,406 :: 		while(angle > 43) {
L_main122:
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _angle+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main187
	MOVF       _angle+0, 0
	SUBLW      43
L__main187:
	BTFSC      STATUS+0, 0
	GOTO       L_main123
;dual_water_tank.c,407 :: 		angle--;
	MOVLW      1
	SUBWF      _angle+0, 1
	BTFSS      STATUS+0, 0
	DECF       _angle+1, 1
;dual_water_tank.c,408 :: 		for(x = 0; x <= 1900; x++) {
	CLRF       _x+0
	CLRF       _x+1
L_main124:
	MOVF       _x+1, 0
	SUBLW      7
	BTFSS      STATUS+0, 2
	GOTO       L__main188
	MOVF       _x+0, 0
	SUBLW      108
L__main188:
	BTFSS      STATUS+0, 0
	GOTO       L_main125
;dual_water_tank.c,409 :: 		if(x < angle) PORTD |= 0x04;
	MOVF       _angle+1, 0
	SUBWF      _x+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main189
	MOVF       _angle+0, 0
	SUBWF      _x+0, 0
L__main189:
	BTFSC      STATUS+0, 0
	GOTO       L_main127
	BSF        PORTD+0, 2
	GOTO       L_main128
L_main127:
;dual_water_tank.c,410 :: 		else          PORTD &= 0xFB;
	MOVLW      251
	ANDWF      PORTD+0, 1
L_main128:
;dual_water_tank.c,408 :: 		for(x = 0; x <= 1900; x++) {
	INCF       _x+0, 1
	BTFSC      STATUS+0, 2
	INCF       _x+1, 1
;dual_water_tank.c,413 :: 		}
	GOTO       L_main124
L_main125:
;dual_water_tank.c,414 :: 		}
	GOTO       L_main122
L_main123:
;dual_water_tank.c,415 :: 		My_DelayMs(100);
	MOVLW      100
	MOVWF      FARG_My_DelayMs_ms+0
	MOVLW      0
	MOVWF      FARG_My_DelayMs_ms+1
	CALL       _My_DelayMs+0
;dual_water_tank.c,420 :: 		Read_Print_Control();
	CALL       _Read_Print_Control+0
;dual_water_tank.c,421 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
