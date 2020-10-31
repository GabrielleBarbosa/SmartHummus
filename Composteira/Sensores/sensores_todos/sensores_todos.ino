//Temperatura
#include <OneWire.h>
#include <DallasTemperature.h>
OneWire pinTempA(3);  // transmissão de dados pro sensor
OneWire pinTempB(4);  // transmissão de dados pro sensor
DallasTemperature barramentoA(&pinTempA); // representa o barramento de
DallasTemperature barramentoB(&pinTempB); // sensores em nosso código
DeviceAddress sensorTempA;
DeviceAddress sensorTempB;
float tempA = 0;
float tempB = 0;

//MQ-2
int pinSensorMQ2 = A1; //Pino Sensor MQ-2
int valDesarmMQ2 = 30; //Variável para selecionar a quantidade de Gás/Fumaça detectada
int valorMQ2 = 0;

//MQ135
#define pinSensorMQ135 A2
#define digMQ135 7
int valMQ135 = 0;
int valDigMQ135 = 0;

//Nível
int pinSensorNivel = 10;
int valNivel = 0;

//Umidade
#define pinSensorUmidA A0
#define pinSensorUmidB A3
int valUmidA = 0;
int valUmidB= 0;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  //setupMQ2();
  setupMQ135();
  //setupNivel();
  //setupTemp();
  //setupUmid();
}

void loop() {
  // put your main code here, to run repeatedly:
  //loopMQ2();
  loopMQ135();
  //loopNivel();
  //loopTemp();
  //loopUmid();
}

void setupMQ2(){
  pinMode(pinSensorMQ2, INPUT); 
}

void setupMQ135(){
  pinMode(pinSensorMQ135, INPUT); 
  pinMode(digMQ135, INPUT);
}

void loopMQ2(){
   valorMQ2 = analogRead(pinSensorMQ2); //Faz a leitura da entrada do sensor
   Serial.println(valorMQ2);
   valorMQ2 = map(valorMQ2, 0, 1023, 0, 100); //Faz a conversão da variável para porcentagem
   Serial.println(valorMQ2); //Escreve o valor na porta Serial
   if (valorMQ2>=valDesarmMQ2){ //Condição, se valor continuar maior que ValDesarm faça:
    Serial.println("aaaaaaaaaaaa");
  }
  delay(1000);
}

void loopMQ135(){
  valMQ135 = analogRead(pinSensorMQ135); 
   valDigMQ135 = digitalRead(digMQ135);  // lê o valor do sensor
   Serial.print(valMQ135);
   Serial.print(" || ");
   if(valDigMQ135 == 0)
      Serial.println("GAS DETECTADO !!!");
   else 
      Serial.println("GAS AUSENTE !!!");
   delay(500);
}

void setupNivel(){
  pinMode(pinSensorNivel, INPUT); 
}

void loopNivel(){
   valNivel = digitalRead(pinSensorNivel);
  //se var sensor for 0, ainda não chegou no nível do sensor e se for 1 chegou
  if(valNivel == 0){
    Serial.println("Vazio");
  }else{
    Serial.println("Cheio");
  }
  delay(1000);
}

void setupTemp(){
  barramentoA.begin();
   barramentoB.begin();
   barramentoA.getAddress(sensorTempA, 0); 
   barramentoB.getAddress(sensorTempB, 0); 
}

void loopTemp(){
   barramentoA.requestTemperatures(); 
   tempA = barramentoA.getTempC(sensorTempA);
   Serial.print("Sensor 1: ");
   Serial.println(tempA);
   barramentoB.requestTemperatures(); 
   tempB = barramentoB.getTempC(sensorTempB);
   Serial.print("Sensor 2: ");
   Serial.println(tempB);
   delay(500);
}

void setupUmid(){
  pinMode(pinSensorUmidA, INPUT); 
  pinMode(pinSensorUmidB, INPUT); 
}

void loopUmid(){
   // Faz a leitura do sensor
  valUmidA = analogRead(pinSensorUmidA);
  valUmidB = analogRead(pinSensorUmidB);
  // Exibe o valor lido no monitor serial
 
   Serial.print("Umid1: ");
  Serial.println(valUmidA);
  Serial.print("Umid2: ");
  Serial.println(valUmidB);
  Serial.println();
  
  valUmidA = map(valUmidA, 690, 410, 0, 100);
  valUmidB = map(valUmidB, 670, 390, 0, 100);
  
   Serial.print("Umid1: ");
  Serial.println(valUmidA);
  Serial.print("Umid2: ");
  Serial.println(valUmidB);
  Serial.println();

  //Cria um pequeno atraso entre cada medição
  delay(1400);
}
