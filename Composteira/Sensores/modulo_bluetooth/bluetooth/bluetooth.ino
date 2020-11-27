#include <SoftwareSerial.h>
#include <EEPROM.h> //biblioteca de armazenamento de dados na memória estática do arduino (se mantém mesmo se tirado da tomada)
SoftwareSerial BTserial(10, 11); // RX | TX

char c = ' '; //caracter que armazena leituras do bluetooth
boolean first = true; //usado para recomeçar a colocar dados no vetor de info, caso o usuário envie os dados mais de uma vez
char info[200]; //guarda dados enviados pelo usuário, que estarão no formato nomeDaRede:senha:uid
char infoS[50]; // usado como auxiliar no armazenamento dos dados do vetor info no EEPROM 
 
void setup() 
{
    Serial.begin(9600); //inicia a serial na velocidade 9600
    Serial.print("Sketch:   ");   Serial.println(__FILE__);
    Serial.print("Uploaded: ");   Serial.println(__DATE__);
    Serial.println(" ");
 
    BTserial.begin(9600);  //inicia o BT na velocidade 9600 
    Serial.print("BTserial started at "); Serial.println(9600);
    Serial.println(" ");
}
 
void loop()
{
    /*
     //verificação de que os valores se mantiveram após tirar o arduino da tomada
      if(c == 0){
        Serial.println(getName());
        Serial.println(getPass());
        Serial.println(getUid());
        c++;
    }*/
    if (BTserial.available())
    {
        c = BTserial.read();   // Lê um bite recebido pelo BT
        if(c == '\r') //verifica se não é o fim da linha
        {
          Serial.println(info); //printa o vetor completo, apenas para debbug
          saveInfo(); //salva as informações no EEPROM

          //verificação dos valores armazenados
          Serial.println(getName()); 
          Serial.println(getPass());
          Serial.println(getUid());

          //envia de volta ao celular que foi recebido
          BTserial.write("t");

          //atualiza a variavel first para reiniciar o vetor com cpy caso receba mais valores
          first = true;
        }
        else if (c != '\n'){ //se não for o fim da linha, armazena o byte no vetor de info
          if(first){ //verifica se não é o primeiro caracter lido
            strcpy(info, &c); 
            first = false;  //atualiza a variavel, indicando que já se leu o primeiro caracter
          }
          else
            strcat(info, &c); //concatena se não for o primeiro caracter lido
        }
    }
}

//recupera o nome da rede do EEPROM (o nome começa da posição 0, que contém seu tamanho)
String getName(){
  String n = "";
  char s = EEPROM.read(0);
  char i = 1;
  char oi;
  Serial.println();
  while (i <= s){
    oi =  EEPROM.read(i);
    n += oi;
    i++;
  }
  return n;
}

//recupera a senha da rede do EEPROM (a senha começa da posição 200, que contém seu tamanho)
String getPass(){
  String pass = "";
  char s = EEPROM.read(200);
  char i = 1;
  char oi;
  Serial.println();
  while (i <= s){
    oi =  EEPROM.read(i+200);
    pass += oi;
    i++;
  }
  return pass;
}

//recupera o uid do usuário do EEPROM (o uid começa da posição 400, que contém seu tamanho)
String getUid(){
  String uid = "";
  char s = EEPROM.read(400);
  char i = 1;
  char oi;
  Serial.println();
  while (i <= s){
    oi =  EEPROM.read(i+400);
    uid += oi;
    i++;
  }
  return uid;
}

//salva as informacoes armazenadas no vetor info no EEPROM
void saveInfo(){

  char len = 0; //tamanho da variavel atual (nome, senha ou uid)
  char i = 0;   //index do vetor info
  char q = 0;   //variavel atual (0: nome, 1:senha, 2: uid)
  
  while (q < 3){ //verifica se nao guardou todas as variaveis
    c = info[i]; //recupera um byte da posicao atual
    strcpy(infoS, &c);  //guarda o byte na primeira posição de infoS
    len++;              //aumenta a variavel de tamanho
    i++;                // aumenta o index
    c = info[i]; //recupera o próximo byte
    while (c != ':' && i < strlen(info)){ //como ':' é o caracter q indica mudança de variável, verifica de c é igual a ':' ou então se acabou o vetor
        len++;  
        strcat(infoS, &c); 
        i++; 
        c = info[i];
    }
    EEPROM.write(q*200, len); //guarda o tamanho da variável antes de começar a armazená-la, nota-se que multiplica q*200, 
                              //significando que a posicao 0 é o tamanho do nome, a posição 200 é o tamanho da senha e a 400 é o tamanho do uid
    char a = 1;
    while(a <= len){ //guarda na EEPROM a variavel, byte a byte a partir de 1, 201 ou 401, dependendo da variável
      EEPROM.write((q*200)+a, infoS[a-1]);
      a++;
    }
    i++; //aumenta o index, para não ler o ':' novamente
    q++; //aumenta q para indicar a próxima variável
    len = 0; //reinicia len, para começar a contagem de tamanho da próxima variável
  }
}
