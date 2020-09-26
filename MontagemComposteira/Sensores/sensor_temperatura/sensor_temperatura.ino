#include <OneWire.h>
#include <DallasTemperature.h>

OneWire pinoA(3);  // transmissão de dados pro sensor
OneWire pinoB(4);  // transmissão de dados pro sensor
DallasTemperature barramentoA(&pinoA); // representa o barramento de
                                     // sensores em nosso código
DallasTemperature barramentoB(&pinoB);
DeviceAddress sensorA;
DeviceAddress sensorB;

void setup(void)
{
   Serial.begin(9600);
   barramentoA.begin();
   barramentoB.begin();
   barramentoA.getAddress(sensorA, 0); 
   barramentoB.getAddress(sensorB, 0); 
}

void loop()
{
   barramentoA.requestTemperatures(); 
   float temperatura = barramentoA.getTempC(sensorA);
   Serial.print("Sensor 1: ");
   Serial.println(temperatura);
   barramentoB.requestTemperatures(); 
   temperatura = barramentoB.getTempC(sensorB);
   Serial.print("Sensor 2: ");
   Serial.println(temperatura);
   delay(500);
} 
