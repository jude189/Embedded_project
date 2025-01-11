// lcd.h
#ifndef LCD_H
#define LCD_H

#include <stdint.h>

void LCD_Init();
void LCD_Print(const char *line1, const char *line2);
void LCD_Clear();

#endif
