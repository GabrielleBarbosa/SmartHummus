/*********************************
Autor: Fernando Krein Pinheiro
Data: 12/05/2012
Linguagem: C (Wiring)
========= IMPORTANTE ===========
O código esta livre para usar,
citar e compartilhar desde que
mantida sua fonte e seu autor.
Obrigado.
*********************************
*/
void setup()
{
  Serial.begin(9600);
}
 
void loop()
{
    char dados;
     if (Serial.available() > 0)
     {
       dados = Serial.read();
       mensagem();
     }
 
}
 
void mensagem()
{
    Serial.println("Recebi seus dados Cliente");
}