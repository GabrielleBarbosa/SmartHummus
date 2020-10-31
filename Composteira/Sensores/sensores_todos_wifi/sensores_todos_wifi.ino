//Temperatura
#include <OneWire.h>
#include <DallasTemperature.h>

//WIFI
#include <AltSoftSerial.h>

AltSoftSerial esp8266;
#define DEBUG true

char resposta[170];
unsigned long starttime;
#define sampletime_ms 600000 //sample 10min ;

//Temperatura
OneWire pinTempA(3);  // transmissão de dados pro sensor
OneWire pinTempB(4);  // transmissão de dados pro sensor
DallasTemperature barramentoA(&pinTempA); // representa o barramento de
DallasTemperature barramentoB(&pinTempB); // sensores em nosso código
DeviceAddress sensorTempA;
DeviceAddress sensorTempB;
float tempA = 0;
float tempB = 0;

//MQ-2
#define pinSensorMQ2 A1 //Pino Sensor MQ-2
#define valDesarmMQ2 30 //Variável para selecionar a quantidade de Gás/Fumaça detectada
int valMQ2 = 0;

//MQ135
#define pinSensorMQ135 A2
//#define digMQ135 7
int valMQ135 = 0;
//int valDigMQ135 = 0;

//Nível
#define pinSensorNivel 10
char valNivel = 0;

//Umidade
#define pinSensorUmidA A0
#define pinSensorUmidB A3
int valUmidA = 0;
int valUmidB= 0;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  while (!Serial) ; // wait for Arduino Serial Monitor to open
  setupMQ2();
  setupMQ135();
  setupNivel();
  setupTemp();
  setupUmid();
  setupWifi();
}

void loop() {
  // put your main code here, to run repeatedly:
  loopWifi();
}

void setupWifi(){
  pinMode(2, INPUT_PULLUP);
  pinMode(3, INPUT_PULLUP);
  Serial.println("AltSoftSerial Test Begin");
  esp8266.begin(9600);

  starttime = millis() - sampletime_ms;
  // reset
  do {
    Serial.println("RST");
    sendData("AT+RST\r\n", 6000, DEBUG);
    delay(300);
  }
  while (!(StrContains(resposta, "OK")));   
 
  // Conecta a rede wireless
  delay(8000);
  do {
    Serial.println("Send At and wait OK");
    sendData("AT\r\n", 4000, DEBUG);
    delay(300);
  }
  while (!(StrContains(resposta, "OK")));    

  
  // Configura para multiplas conexoes
  do{
    Serial.println("Send AT+CWMODE=3"); 
    sendData("AT+CWMODE=3\r\n", 1000, DEBUG);
    delay(300);
  }
  while (!(StrContains(resposta, "OK"))); 


  // Tenta conectar na rede
  do{
    sendData("AT+CWJAP=\"VIVOFIBRA-0288\",\"16558F8958\"\r\n", 7000, DEBUG);
    delay(600);
  }
  while (!(StrContains(resposta, "WIFI CONNECTED"))); 

  // Mostra o endereco IP
  do{
    Serial.print("Mostra IP\r\n");
    sendData("AT+CIFSR\r\n", 1000, DEBUG);
    delay(300);   
  }
  while (!(StrContains(resposta, "OK"))); 

  //sendData("AT+CIPSERVERMAXCONN=3\r\n", 1000, DEBUG);

  // Configura multiplas conexoes
  do{
    Serial.println("Send MUX");
    sendData("AT+CIPMUX=1\r\n", 2000, DEBUG);
    delay(300);   
  }
  while (!(StrContains(resposta, "OK"))); 
  
  
  // Inicia o web server na porta 80
  do{
    sendData("AT+CIPSERVER=1,80\r\n", 1000, DEBUG);
    delay(300);
  }
  while (!(StrContains(resposta, "OK"))); 
}

void loopWifi(){

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

      Serial.println(cipSend);
      Serial.println(webpage);

      delay(500);
    }
  }
  
  if ((millis()-starttime) > sampletime_ms)//if the sample time == 30s
  {
    getUmid();
    getNivel();
    getMQ2();
    getMQ135();
    getTemp();

    
    char postCommand[210];
    char aux[6];
    
    {
      char server[] = "https://smarthummus.herokuapp.com";
      
      strcpy(resposta, "medidas?temp1=");
      dtostrf(tempA,5,2,aux); 
      strcat(resposta,  aux);
      
      strcat(resposta, "&temp2=");
      dtostrf(tempB,5,2,aux); 
      strcat(resposta, aux);
      
      strcat(resposta, "&umid1=");
      itoa(valUmidA, aux, 10);
      strcat(resposta, aux);
      
      strcat(resposta, "&umid2=");
      itoa(valUmidB, aux, 10);
      strcat(resposta, aux);
      
      strcat(resposta, "&nivel=");
  
      valNivel+=48;
      strncat(resposta, &valNivel, 1);
      
      strcat(resposta, "&gasMQ2=");
      itoa(valMQ2, aux, 10);
      strcat(resposta, aux);
      
      strcat(resposta, "&gasMQ135=");
      itoa(valMQ135, aux, 10);
      strcat(resposta, aux);
      
      strcat(resposta, "&uid=X2wY40NBg6VB6UMLARIiezxJmbT2");
     
      
      strcpy(postCommand, "POST ");// + server + "/" + uri +" HTTP/1.1\r\nHost: smarthummus.herokuapp.com\r\n\r\n";    
      strcat(postCommand, server);
      strcat(postCommand, "/");
      strcat(postCommand, resposta);
      strcat(postCommand, " HTTP/1.1\r\nHost: smarthummus.herokuapp.com\r\n\r\n");
      Serial.print(strlen(postCommand));
  

      char openSocketCommand[50] = "AT+CIPSTART=3,\"TCP\",\""; //+ server + "\",80\r\n";//start a TCP connection.
      strcat(openSocketCommand, server);
      strcat(openSocketCommand, "\",80\r\n");
 
     do{
      sendData(openSocketCommand,10000, DEBUG);   
      delay(300);
       
     } while(StrContains(resposta, "ERROR"));
    }
    
    if(StrContains(resposta, "OK")) {
       Serial.println("TCP connection ready");
    }
    
    delay(700);
    
    {
      itoa(strlen(postCommand), aux, 10);
      
      char sendCmd[20] = "AT+CIPSEND=3,";//determine the number of caracters to be sent.
      
      strcat(sendCmd, aux);
      strcat(sendCmd,"\r\n");
  
      
      sendData(sendCmd,2000, DEBUG);
    }
    //Serial.print("ENVIANDO AO cmd = \r\n" );
    //Serial.print(sendCmd);
    //Serial.print(resp);
    //Serial.println("\n");
    //if(resp.equals(">")) { 
    //String uri = "rest1.php";// our example is /esppost.php
    
    delay(700);

    if(StrContains(resposta, ">"))
    {
      Serial.println("Sending.."); 
      Serial.println(postCommand);
      
      sendData(postCommand, 2500, DEBUG);
  
      delay(700);
    }
      
   // }
   
    if(StrContains(resposta, "Funcionando")) { 
      Serial.println("Packet sent");
    }
    if (esp8266.available())
    {
      String tmpResp = esp8266.readString();
      Serial.println(tmpResp);
    }

    sendData("AT+CIPCLOSE=3",500, DEBUG);
    
    starttime = millis();
  }
}

void sendData(const char *command, const int timeout, boolean debug)
{
  // Envio dos comandos AT para o modulo
  strcpy(resposta, "");
  //Serial.print(command);
  esp8266.print(command);
  long int time = millis();
  while ( (time + timeout) > millis())
  {
    int i = 0;
    while (esp8266.available())
    {
      // The esp has data so display its output to the serial window
      
        char c = esp8266.read(); // read the next character.
  
        if(strlen(resposta)>168)
          strcpy(resposta, "");
          
        strncat(resposta,&c,1);
        
    }
  }
  if (debug)
  {
    Serial.print("");
    Serial.println(resposta);
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

char StrContains(const char *str, const char *sfind)
{
    char found = 0;
    char index = 0;
    int lenStr;
    int lenSFind; 

    lenStr = strlen(str);
    lenSFind = strlen(sfind);
    
    if (lenSFind > lenStr) {
        return 0;
    }
    while (index < lenStr) {
        if (str[index] == sfind[found]) {
            found++;
            if (lenSFind == found) {
                return 1;
            }
        }
        else {
            found = 0;
        }
        index++;
    }

    return 0;
}

void setupMQ2(){
  pinMode(pinSensorMQ2, INPUT); 
}

void setupMQ135(){
  pinMode(pinSensorMQ135, INPUT); 
  //pinMode(digMQ135, INPUT);
}

void getMQ2(){
   valMQ2 = analogRead(pinSensorMQ2); //Faz a leitura da entrada do sensor
   //Serial.println(valMQ2);
   //valMQ2 = map(valMQ2, 0, 1023, 0, 100); //Faz a conversão da variável para porcentagem
  // Serial.println(valMQ2); //Escreve o valor na porta Serial
   //if (valMQ2>=valDesarmMQ2){ //Condição, se valor continuar maior que ValDesarm faça:
    //Serial.println("aaaaaaaaaaaa");
  //}
  delay(400);
}

void getMQ135(){
  valMQ135 = analogRead(pinSensorMQ135); 
   //valDigMQ135 = digitalRead(digMQ135);  // lê o valor do sensor
   //Serial.print(valMQ135);
   //Serial.print(" || ");
   //if(valDigMQ135 == 0)
      //Serial.println("GAS DETECTADO !!!");
   //else 
      //Serial.println("GAS AUSENTE !!!");
   delay(400);
}

void setupNivel(){
  pinMode(pinSensorNivel, INPUT); 
}

void getNivel(){
   valNivel = digitalRead(pinSensorNivel);
  //se var sensor for 0, ainda não chegou no nível do sensor e se for 1 chegou
  //if(valNivel == 0){
    //Serial.println("Vazio");
  //}else{
    //Serial.println("Cheio");
  //}
  delay(400);
}

void setupTemp(){
  barramentoA.begin();
   barramentoB.begin();
   barramentoA.getAddress(sensorTempA, 0); 
   barramentoB.getAddress(sensorTempB, 0); 
}

void getTemp(){
   barramentoA.requestTemperatures(); 
   tempA = barramentoA.getTempC(sensorTempA);
   //Serial.print("Sensor 1: ");
   //Serial.print(tempA);
   //Serial.print("\r\n\r\n");
   barramentoB.requestTemperatures(); 
   tempB = barramentoB.getTempC(sensorTempB);
   //Serial.print("Sensor 2: ");
   //Serial.print(tempB);
   //Serial.print("\r\n\r\n");
   delay(400);
}

void setupUmid(){
  pinMode(pinSensorUmidA, INPUT); 
  pinMode(pinSensorUmidB, INPUT); 
}

void getUmid(){
   // Faz a leitura do sensor
  valUmidA = analogRead(pinSensorUmidA);
  valUmidB = analogRead(pinSensorUmidB);


  //de acordo com os menores (+ úmido) e maiores valores (- úmido) constatados com testes dos sensores, 
  //fazemos um map para transformar em percentuais
  valUmidA = map(valUmidA, 770, 410, 0, 100);
  valUmidB = map(valUmidB, 750, 390, 0, 100);
  

  //Cria um pequeno atraso entre cada medição
  delay(400);
}
