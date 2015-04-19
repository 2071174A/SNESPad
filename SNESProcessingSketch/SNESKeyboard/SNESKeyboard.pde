/*
Description:  Interfacing a SNES controller with a PC with an Arduino.
Coded by:  Prodigity
Modified by:    Ross Anderson
*/

import processing.serial.*;
import java.awt.*;
import java.awt.event.KeyEvent;

Serial arduino;
Robot VKey;

int recvout, prevout, deltaout;

void setup() {
  arduino = new Serial(this, Serial.list()[1], 9600); // ATTENTION!!!
  try
  {
    VKey = new Robot();
  }
  catch(AWTException a){}
  prevout = 0;
}

void draw() {
  serialRead();
  deltaout = (short)(recvout ^ prevout); //XOR determines which buttons have been pressed or depressed at any point.
  emulateKeyboard();
  prevout = recvout;
}

/*Pieces together the bytes in the arduino buffer to get the button state*/
void serialRead() {
  if (arduino.available() >= 2) {    
    recvout = (int)arduino.read() << 8;   
    recvout += (int)arduino.read();        
  }
}

void emulateKeyboard() { //If button's binary digit has changed, press or depress key depending on the button state.
  if ((deltaout & 1) != 0)   { if ((recvout & 1) == 0)   {VKey.keyPress(KeyEvent.VK_L);} else {VKey.keyRelease(KeyEvent.VK_L);}}
  if ((deltaout & 2) != 0)   { if ((recvout & 2) == 0)   {VKey.keyPress(KeyEvent.VK_K);} else {VKey.keyRelease(KeyEvent.VK_K);}}
  if ((deltaout & 4) != 0)   { if ((recvout & 4) == 0)   {VKey.keyPress(KeyEvent.VK_G);} else {VKey.keyRelease(KeyEvent.VK_G);}}
  if ((deltaout & 8) != 0)   { if ((recvout & 8) == 0)   {VKey.keyPress(KeyEvent.VK_H);} else {VKey.keyRelease(KeyEvent.VK_H);}}
  if ((deltaout & 16) != 0)  { if ((recvout & 16) == 0)  {VKey.keyPress(KeyEvent.VK_W);} else {VKey.keyRelease(KeyEvent.VK_W);}}
  if ((deltaout & 32) != 0)  { if ((recvout & 32) == 0)  {VKey.keyPress(KeyEvent.VK_S);} else {VKey.keyRelease(KeyEvent.VK_S);}}
  if ((deltaout & 64) != 0)  { if ((recvout & 64) == 0)  {VKey.keyPress(KeyEvent.VK_A);} else {VKey.keyRelease(KeyEvent.VK_A);}}
  if ((deltaout & 128) != 0) { if ((recvout & 128) == 0) {VKey.keyPress(KeyEvent.VK_D);} else {VKey.keyRelease(KeyEvent.VK_D);}}
  if ((deltaout & 256) != 0)  { if ((recvout & 256) == 0)  {VKey.keyPress(KeyEvent.VK_P);} else {VKey.keyRelease(KeyEvent.VK_P);}}
  if ((deltaout & 512) != 0)  { if ((recvout & 512) == 0)  {VKey.keyPress(KeyEvent.VK_O);} else {VKey.keyRelease(KeyEvent.VK_O);}}
  if ((deltaout & 1024) != 0)  { if ((recvout & 1024) == 0)  {VKey.keyPress(KeyEvent.VK_I);} else {VKey.keyRelease(KeyEvent.VK_I);}}
  if ((deltaout & 2048) != 0) { if ((recvout & 2048) == 0) {VKey.keyPress(KeyEvent.VK_U);} else {VKey.keyRelease(KeyEvent.VK_U);}}
}
