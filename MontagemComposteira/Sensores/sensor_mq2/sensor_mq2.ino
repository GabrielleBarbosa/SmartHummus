int pinSensor = A1; //Pino Sensor
int ValDesarm = 30; //Variável para selecionar a quantidade de Gás/Fumaça detectada
int valor = 0;

void setup()
{
  pinMode(pinSensor, INPUT); 
  Serial.begin(9600);
}


void loop()
{
 valor = analogRead(pinSensor); //Faz a leitura da entrada do sensor
 Serial.println(valor);
 valor = map(valor, 0, 1023, 0, 100); //Faz a conversão da variável para porcentagem
 Serial.println(valor); //Escreve o valor na porta Serial
 if (valor>=ValDesarm){ //Condição, se valor continuar maior que ValDesarm faça:
  Serial.println("aaaaaaaaaaaa");
}
delay(1000);
}
