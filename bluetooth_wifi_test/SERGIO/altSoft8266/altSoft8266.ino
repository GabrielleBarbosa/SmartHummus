#include <AltSoftSerial.h>

// AltSoftSerial always uses these pins:
//
// Board          Transmit  Receive   PWM Unusable
// -----          --------  -------   ------------

// Arduino Uno        9         8         10


AltSoftSerial esp8266;
#define DEBUG true

String resposta="";

void setup() {
  pinMode(2, INPUT_PULLUP);
  pinMode(3, INPUT_PULLUP);
  Serial.begin(9600);
  while (!Serial) ; // wait for Arduino Serial Monitor to open
  Serial.println("AltSoftSerial Test Begin");
  esp8266.begin(9600);
   
  sendData("AT+RST\r\n", 6000, DEBUG); // rst
  // Conecta a rede wireless
  delay(8000);
  do {
    Serial.println("Send At and wait OK");
    resposta = sendData("AT\r\n", 4000, DEBUG);
    delay(300);
  }
  while ((resposta.equals("OK\r\n")));    

  Serial.println("Send AT+CWMODE=3"); 
  sendData("AT+CWMODE=3\r\n", 1000, DEBUG);
  delay(300);
  // Configura para multiplas conexoes
  Serial.println("Send MUX");
  sendData("AT+CIPMUX=1\r\n", 2000, DEBUG);
  delay(300);
  sendData("AT+CWJAP=\"HKSP65 2G\",\"40045912\"\r\n", 7000, DEBUG);
  
  //ESPERAR ATE RESPOSTA
  Serial.println("Conectado???");

  Serial.println("Mostra IP");    
    // Mostra o endereco IP
  sendData("AT+CIFSR\r\n", 2000, DEBUG);
  delay(2000);
  // Inicia o web server na porta 80
  sendData("AT+CIPSERVER=1,80\r\n", 1000, DEBUG);
  delay(1000);
  
}

void loop() {
  // Verifica se o ESP8266 esta enviando dados
  if (esp8266.available())
  {
    if (esp8266.find("+IPD,"))
    {
      delay(300);
      int connectionId = esp8266.read() - 48;
 
      String webpage = "<html>"; //ABRE A TAG "html"
     webpage += "<head>"; //ABRE A TAG "head"
     webpage += "<title> Modulo WiFi ESP8266 para Arduino</title>"; //ESCREVE O TEXTO NA PÁGINA
     webpage += "</head>"; //FECHA A TAG "head"
     webpage += "<body>"; //ABRE A TAG "body"

                 //"<head><meta http-equiv=""refresh"" content=""3"">";
      webpage += "<h1><u>ESP8266 - Web Server</u></h1><h2>Porta";//"</head><h1><u>ESP8266 - Web Server</u></h1><h2>Porta";
      webpage += "Digital 2: ";
      int a = digitalRead(2);
      webpage += a;
      webpage += "<h2>Porta Digital 3: ";
      int b = digitalRead(3);
      webpage += b;
      webpage += "</h2>";
      webpage += "</body>"; //FECHA A TAG "body"
      webpage += "</html>"; //FECHA A TAG "html"
      webpage += "\r\n";
      
      String cipSend = "AT+CIPSEND=";
      cipSend += connectionId;
      cipSend += ",";
      cipSend += webpage.length();
      cipSend += "\r\n";
      sendData(cipSend, 1000, DEBUG);
      delay(120);
      sendData(webpage, 1000, DEBUG);
      delay(1000);
      String closeCommand = "AT+CIPCLOSE=";
      closeCommand += connectionId; // append connection id
      closeCommand += "\r\n";
 
      sendData(closeCommand,15000, DEBUG);

      //Serial.println(cipSend);
      //Serial.println(webpage);

      delay(500);
    }
  }
}
 
String sendData(String command, const int timeout, boolean debug)
{
  // Envio dos comandos AT para o modulo
  String response = "";
  //Serial.print(command);
  esp8266.print(command);
  long int time = millis();
  while ( (time + timeout) > millis())
  {
    while (esp8266.available())
    {
      // The esp has data so display its output to the serial window
      char c = esp8266.read(); // read the next character.
      response += c;
    }
  }
  if (debug)
  {
    Serial.print("");
    Serial.println(response);
  }
  return response;
}
