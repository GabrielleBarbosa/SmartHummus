#include <SoftwareSerial.h> // INCLUSÃO DA BIBLIOTTECA
#include "WiFiEsp.h"

const int pinoRX = 2; //PINO DIGITAL 2 (RX)
const int pinoTX = 3; //PINO DIGITAL 3 (TX)
const int pinoLed = 12; //PINO DIGITAL UTILIZADO PELO LED
int dadoBluetooth = 0; //VARIÁVEL QUE ARMAZENA O VALOR ENVIADO PELO BLUETOOTH
boolean loopLED = false; //VARIÁVEL BOOLEANA QUE FAZ O CONTROLE DE ATIVAÇÃO DO LOOP DO LED

//SoftwareSerial bluetooth(pinoTX, pinoRX); //PINOS QUE EMULAM A SERIAL, ONDE
//O PINO 2 É O RX E O PINO 3 É O TX

// WiFi
SoftwareSerial wifi(8,9);
char ssid[] = "cotuca";
char pass[] = "cotuca19";
int status = WL_IDLE_STATUS;

WiFiEspServer server(80);
RingBuffer buf(8);
 
void setup(){
  Serial.begin(115200); //INICIALIZA A SERIAL
  //bluetooth.begin(9600); //INICIALIZA A SERIAL DO BLUETOOTH
  //bluetooth.print("$"); //IMPRIME O CARACTERE
  //bluetooth.print("$"); //IMPRIME O CARACTERE
  //bluetooth.print("$"); //IMPRIME O CARACTERE
  delay(100); //INTERVALO DE 100 MILISSEGUNDOS
  pinMode(pinoLed, OUTPUT); //DEFINE O PINO COMO SAÍDA

  wifi.begin(9600);
  WiFi.init(&wifi);
  if (WiFi.status() == WL_NO_SHIELD)
  {
    Serial.println("Sem modulo");
    while (true); // trava a execução
  }
  while (status != WL_CONNECTED)
  {
    Serial.println("Tentando conectar...");
    status = WiFi.begin(ssid, pass);
  }
  Serial.println("Conectado...");
  IPAddress ip = WiFi.localIP();
  Serial.println(ip);
  server.begin();
}
 
void loop(){

  //Check received a byte from hardware serial
  if (Serial.available()) {
    char r = Serial.read(); //Read and save the byte
    //bluetooth.print(r);  //Send the byte to bluetooth by software serial
    Serial.print(r);  //Echo
  }
  //Check received a byte from bluetooth by software serial
  /*if (bluetooth.available()) {
    char r = bluetooth.read(); //Read and save the byte
    Serial.print(r); //Print the byte to hardware serial
    if(r == 'A'){ //SE O VALOR RECEBIDO FOR IGUAL A 1, FAZ
      Serial.println("LED LIGADO"); //IMPRIME O TEXTO NA SERIAL
      digitalWrite(pinoLed, HIGH); //LIGA O LED
    }
  }*/

  WiFiEspClient client = server.available();
  if (client)
  {
    Serial.println("Novo cliente");
    buf.init();

    while (client.connected())
    {
      if (client.available())
      {
        char c = client.read();
        buf.push(c);
        // lê a resposta do cliente e coloca no buf circular
        // analisa a resposta e retorna de acordo com o pedido
        if (buf.endsWith("\r\n\r\n"))
        {
          sendHttpResponse(client);
          break;
        }
      }
    }
    client.stop();
    Serial.println("Desconectado...");
  }
}

void sendHttpResponse(WiFiEspClient client)
{
  client.println("HTTP/1.1 200 OK");
  client.println("Content-type:text/html");
  client.println("Connection: close");
  client.println();
  client.println("<!DOCTYPE HTML><HTML>");
  client.println("<head><title>Aula de Topicos em Sistemas Embarcados");
  client.println("</title></head>");
  client.println("<body> <br><br>");
  client.println("<h1> Sistemas Embarcados </h1>");
  client.println("</body></HTML>");
  client.println();
}
