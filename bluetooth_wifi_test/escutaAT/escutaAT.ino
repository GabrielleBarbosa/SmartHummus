#include <SoftwareSerial.h>

/*
 * AT+CWJAP="HKSP65 2G","40045912"
 * AT+CWJAP?
 * AT+CIPMUX=1
 * AT+CIPSTART=4,"TCP","www.google.com",80
 * AT+CIPSTART=4,"TCP","192.168.137.1",9000
 * AT+CIPSTART=4,"TCP","firestore.googleapis.com",9000
 * GET /v1beta1/projects/smarthummus/databases/(default)/documents/users? HTTP/1.1\r\nHost:firestore.googleapis.com
 * AT+CIPSEND=4,83
 * AT+CIPSEND=4,117
 * AT+CIPSEND=4,18
 * AT+CIPCLOSE=4
 * GET / HTTP/1.0
 */

SoftwareSerial ESP(8, 9); //RX | TX

void setup() { 
                      //baud rate = 9600, 57600 or 115200
  Serial.begin(9600);
  ESP.begin(9600); 
}

void loop() {
  
  if (ESP.available()) {
    char response = ESP.read();
    Serial.print(response);
  }
  
  if (Serial.available()) {  
    char command = Serial.read();
    ESP.print(command);
  }
}
