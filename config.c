// config.c
#include "config.h"
#include <built_in.h>

void Peripheral_Init() {
    ADCON0 = 0B01000000;
    ADCON1 = 0B01000100;

    INTCON.F7 = 1;
    INTCON.F6 = 1;
    INTCON.INTE = 1;
    INTCON.INTF = 0;
    OPTION_REG.f6 = 0;

    CCP1CON = 0B00000000;
    CCP2CON = 0B00000000;

    T1CON.F0 = 0;

    TRISA = 0B11111111;
    TRISB = 0B11111111;
    TRISC = 0B11111111;
    TRISD = 0B11111111;
    TRISE = 0B00000111;

    TRISB.F5 = 0;
    PORTB.F5 = 1;

    TRISD.F5 = 0;
    PORTD.F5 = 1;

    TRISC.F2 = 0;
    TRISC.F3 = 1;
    TRISD.F0 = 0;
    TRISD.F1 = 1;

    PORTC.F2 = 0;
    PORTD.F0 = 0;

    TRISD.F4 = 0;
    PORTD.F4 = 0;

    TRISC.F5 = 0;
    PORTC.F5 = 0;

    TRISA.F2 = 0;
    PORTA.F2 = 1;
    TRISA.F1 = 1;

    TRISB.F0 = 1;
    TRISC.F6 = 1;

    TRISD.F2 = 0;
    PORTD.F2 = 0;

    TRISC.F4 = 1;

    Lcd_Init();
    lcd_cmd(_LCD_CURSOR_OFF);
    lcd_cmd(_LCD_CLEAR);
}
