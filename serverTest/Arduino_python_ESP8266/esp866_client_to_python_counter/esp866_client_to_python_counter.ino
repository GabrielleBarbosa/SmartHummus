#include <SoftwareSerial.h>
#define DEBUG true
SoftwareSerial esp8266(8,9);
int cont=0;
int val=0;

#define TARGET_IP "192.168.137.1"
#define TARGET_PORT "12345"     
    
#define ID "HKSP65 2G"  //name of wireless access point to connect to
#define PASS "40045912"  //wifi password


volatile int contador = 0;   // Somos de lo mas obedientes jajajajaja
int n = contador ;
long T0 = 0 ;  // Variable global para tiempo

                                                   
void setup()
{
  Serial.begin(9600);
  esp8266.begin(9600); // your esp's baud rate might be different

    sendData("AT+RST\r\n",1000,DEBUG); //      
    sendData("AT+CWMODE=1\r\n",1000,DEBUG); // 
    
      String cmd="AT+CWJAP=\"";  
      cmd+=ID;
      cmd+="\",\"";
      cmd+=PASS;
      cmd+="\"";      
     sendData( cmd+"\r\n",1000,DEBUG); //        
     sendData("AT+CIPMUX=0\r\n",1000,DEBUG); //          
}
 
void loop()
{
      
    ////////////////////////////////send to python//////////////////////////////
    String webpage = "AT+CIPSTART=0,\"TCP\",\""; 
    webpage += TARGET_IP;
    webpage += "\",12345\r\n";         
    sendData(webpage,1000,DEBUG);        
 
     //// convert int to string    -- conversion de entero a String para envio       
     cont++;
     String counter_s (cont, DEC);  
   
     val=contador;
     
      ///CONVERT  FLOAT TO CHAR  + CHAR TO STRING   conversion de Flotante a String para envio 
     
      char outstr[15];
      dtostrf(17.8,7, 3, outstr);   //float to char
      String valor = outstr;   // char to string 
      
      
      //// string sending - cadena enviada    
///      String webpage1 = counter_s +","+ val + "\r\n";
         String webpage1 = counter_s +","+ val ;
            
      String cipsend = "AT+CIPSEND=";     
             cipsend+= webpage1.length();
             cipsend+="\r\n";     
      
     sendData(cipsend,1000,DEBUG);
     sendData(webpage1,1000,DEBUG);          
                
    sendData("AT+CIPCLOSE=0\r\n",1500,DEBUG);         
     
     delay(100); 
}
 
String sendData(String command, const int timeout, boolean debug)
{
    String response = "";
    
    esp8266.print(command); // send the read character to the esp8266
    
    long int time = millis();
    
    while( (time+timeout) > millis())
    {
      while(esp8266.available())
      {
        // The esp has data so display its output to the serial window 
        char c = esp8266.read(); // read the next character.
        response+=c; 
      }  
    }
    
    if(debug)
    {
      Serial.print(response);
    }

    return response; 
}
