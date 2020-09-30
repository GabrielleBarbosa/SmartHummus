void setup() {
  // Inicia a comunicação serial
  Serial.begin(9600);
}

void loop() {
  // Faz a leitura do sensor
  int leitura = analogRead(A0);

  // Exibe o valor lido no monitor serial
  Serial.println(leitura);

  //Cria um pequeno atraso entre cada medição
  delay(1000);
}
