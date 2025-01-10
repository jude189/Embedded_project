// utils.c
#include "utils.h"
#include <built_in.h>

void Buzzer() {
    Sound_Init(&PORTC, 5);
    Sound_Play(2600, 100);
    Sound_Play(2400, 100);
    Sound_Play(2600, 100);
    delay_ms(500);
    Sound_Play(2600, 100);
    Sound_Play(2400, 100);
    Sound_Play(2600, 100);
}

void Servo() {
    while (1) {
        if (PORTC.F6 == 0 && angle < 224) angle++;
        if (PORTB.F0 == 0 && angle > 48) angle--;

        for (unsigned int x = 0; x <= 1900; x++) {
            PORTD.F2 = (x < angle) ? 1 : 0;
        }

        if (PORTC.F0 == 1) {
            Servo_Flag = 0;
            break;
        }
    }
}