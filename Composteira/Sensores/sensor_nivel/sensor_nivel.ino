int pinSensor = 10;
int varSensor = 0;

void setup()
{
  pinMode(pinSensor, INPUT); 
  Serial.begin(9600);
}

void loop(){
  varSensor = digitalRead(pinSensor);
  //se var sensor for 0, ainda não chegou no nível do sensor e se for 1 chegou
  if(varSensor == 0){
    Serial.println("Vazio");
  }else{
    Serial.println("Cheio");
  }
  delay(1000);
}
