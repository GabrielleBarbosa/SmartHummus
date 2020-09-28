
/*SmartHummus - Gabrielle Barbosa, Mateus Vicente e Vitor Ramos*/

#include <SoftwareSerial.h>

/*
 * AT+CWJAP="nomeDaRede","senhaDaRede"
 * AT+CWJAP?
 * AT+CIPMUX=1
 * AT+CIPSTART=4,"TCP","www.google.com",80
 * AT+CIPSTART=4,"TCP","TrocarPeloIPLocal",9000
 * AT+CIPSEND=4,18
 * GET / HTTP/1.0
 * AT+CIPCLOSE=4
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
