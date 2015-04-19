
/*Snes controller sketch
 Writes a 16 bit representation of controller input to serial port
 Author Ross Anderson*/

#include <SNESpaduino.h>
#include <Arduino.h>

SNESpaduino pad(5, 3, 8); // See SNESPaduino, numbers are latch, clock and data pins on your arduino.

uint16_t btns, oldbtns = 0;
void setup()
{
	Serial.begin(9600);
}

void loop()
{
        oldbtns = btns;
	btns = pad.getButtons(false);
        if (oldbtns != btns) {
          oldbtns = btns;
          Serial.flush(); //Clear the buffer
          Serial.write(btns >> 8);   //Write 8 LSBs to buffer
          Serial.write(btns & 0xff); //Write 8 MSBs to buffer

        }
}
