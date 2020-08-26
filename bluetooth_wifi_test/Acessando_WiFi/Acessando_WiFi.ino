#include "WiFiEsp.h"
#include "SoftwareSerial.h"

SoftwareSerial Serial1(8,9);      //INICIA A PORTA SERIAL

char ssid[] = "nomeDoWiFi";           //VETOR DE CHAR (STRING) GUARDANDO ID DA REDE
char pass[] = "senhaDoWiFi";         //VETOR DE CHAR (STRING) GUARDANDO SENHA DA REDE
int status = WL_IDLE_STATUS;      //VARIAVEL QUE GUARDA O STATUS DA CONEXAO DA REDE

WiFiEspServer server(80);         //INICIA O SERVIDOR NA PORTA 80
RingBuffer buf(8);                //LISTA LIGADA CIRCULAR COM TAMANHO DE 8 CARACTERES

void setup() {
  Serial.begin(115200);           //PORTA DE DEBUG (JANELINHA)
  Serial1.begin(9600);            //INICIALIZA PORTA SERIAL
  WiFi.init(&Serial1);            //INICIALIZA MODULO WIFI

  if(WiFi.status() == WL_NO_SHIELD){ //
    Serial.println("Sem módulo");
    while(true); //TRAVA A EXECUÇÃO
  }
  while(status != WL_CONNECTED){  //ENQUANTO NAO ESTIVER CONECTADO
    Serial.println("Tentando conectar...");
    status = WiFi.begin(ssid, pass); //TENTA RECONECTAR
  }
  Serial.println("Conectado!");
  IPAddress ip = WiFi.localIP();
  Serial.println(ip);
  server.begin(); //INICIA A CONEXÃO
  

}

void loop() {
  WiFiEspClient client = server.available();
  if (client){
    Serial.println("Novo cliente!");
    buf.init();

    while(client.connected()) { //ENQUANTO TEM ALGUEM CONECTADO
      if(client.available()) {  //CLIENTE PODE ESTAR CONECTADO MAS TEM QUE ESTAR DISPONIVEL, VERIFICAMOS AQUI
        char c = client.read();
        buf.push(c);
              
      //LE A RESPOSTA DO CLIENTE E COLOCCA NO BUF CIRCULAR
      //ANALISA A RESPOSTA E RETORNA DE ACORDO COM O PEDIDO
      if (buf.endsWith("\r\n\r\n")){ //SIGNIFICA "CAN RETURN LINE FEED"????
        sendHttpResponse(client);
        break;
        }
      }
    } //WHILE

    client.stop();
    Serial.println("Desconectado!");
  }
}

void sendHttpResponse(WiFiEspClient client){
  client.println("HTTP/1.1 200 OK");           //CABEÇALHO DO RETORNO PARA O BROWSER (PROTOCOLO HTTP)
  client.println("Content-type:text/html");    //AVISA O TIPO DO ARQUIVO ENVIADO
  /*client.println("Connection: close");*/
  client.println();
  
  client.println("<!DOCTYPE HTML><html>");
  client.println("<body>");
  client.println("<head><meta charset='UTF-8'><title>Aula de Topicos em Sistemas Embarcados</title></head>");
  client.println("<body>");
  client.println("<br><br> <h1>Sistemas Embarcados</h1>");
  client.println("<br><br> <h2>Prof Sérgio</h2>");
  client.println("</body>");
  client.println("</html>");
  client.println();
}
