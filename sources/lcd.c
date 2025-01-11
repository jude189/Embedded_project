/ lcd.c
#include "lcd.h"
#include <built_in.h> // Include your platform-specific libraries

void LCD_Init() {
    Lcd_Init();
    lcd_cmd(_LCD_CURSOR_OFF);
    lcd_cmd(_LCD_CLEAR);
}

void LCD_Print(const char *line1, const char *line2) {
    lcd_cmd(_LCD_CLEAR);
    if (line1) Lcd_Out(1, 1, line1);
    if (line2) Lcd_Out(2, 1, line2);
}

void LCD_Clear() {
    lcd_cmd(_LCD_CLEAR);
}
