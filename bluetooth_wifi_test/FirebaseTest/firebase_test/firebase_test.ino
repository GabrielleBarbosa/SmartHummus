#include <Arduino.h>
#include <SoftwareSerial.h> // INCLUSÃO DA BIBLIOTTECA
#include "WiFiEsp.h"
#include <ESP8266HTTPClient.h>

//#include <ESP8266WiFi.h>
//#include <ESP8266WiFiMulti.h>
#include <WiFiClientSecureBearSSL.h>


// Fingerprint for demo URL, expires on June 2, 2021, needs to be updated well before this date
const uint8_t fingerprint[20] = {0x40, 0xaf, 0x00, 0x6b, 0xec, 0x90, 0x22, 0x41, 0x8e, 0xa3, 0xad, 0xfa, 0x1a, 0xe8, 0x25, 0x41, 0x1d, 0x1a, 0x54, 0xb3};

//ESP8266WiFiMulti WiFiMulti;

SoftwareSerial wifi(8,9);
WiFiEspServer server(80);
RingBuffer buf(8);

char ssid[] = "nomeWiFi";
char pass[] = "senhaWiFi";
int status = WL_IDLE_STATUS;

void setup() {

  Serial.begin(115200);
  // Serial.setDebugOutput(true);

  Serial.println();
  Serial.println();
  Serial.println();

  for (uint8_t t = 4; t > 0; t--) {
    Serial.printf("[SETUP] WAIT %d...\n", t);
    Serial.flush();
    delay(1000);
  }

  wifi.begin(9600);
  WiFi.init(&wifi);
  //WiFi.mode(WIFI_STA);
  if (WiFi.status() == WL_NO_SHIELD)
  {
    Serial.println("Sem modulo");
    while (true); // trava a execução
  }
  while (status != WL_CONNECTED)
  {
    Serial.println("Tentando conectar...");
    status = WiFi.begin(ssid, pass);
  }
  Serial.println("Conectado...");
  IPAddress ip = WiFi.localIP();
  Serial.println(ip);
  server.begin();
}

void loop() {
  // wait for WiFi connection
  WiFiEspClient client = server.available();
  if (client){

    std::unique_ptr<BearSSL::WiFiClientSecure>client(new BearSSL::WiFiClientSecure);

//    client->setFingerprint(fingerprint);

    client->setInsecure();

    HTTPClient https;

    String url = "https://firestore.googleapis.com/v1beta1/projects/smarthummus/databases/(default)/documents/users/OMQNCYa3qltTRjDD2rX8";

    Serial.print("[HTTPS] begin...\n");
    if (https.begin(*client, url)) {  // HTTPS

      Serial.print("[HTTPS] POST...\n");
      // start connection and send HTTP header
//      int httpCode = https.GET();
      https.addHeader("Content-Type", "application/json");
 
      int httpCode = https.POST("{\"fields\":{\"name\":{\"stringValue\":\"a name\"}}}");
      // httpCode will be negative on error
      if (httpCode > 0) {
        // HTTP header has been send and Server response header has been handled
        Serial.printf("[HTTPS] GET... code: %d\n", httpCode);

        // file found at server
        if (httpCode == HTTP_CODE_OK || httpCode == HTTP_CODE_MOVED_PERMANENTLY) {
          String payload = https.getString();
          Serial.println(payload);
        } else {
          Serial.println(https.getString());
        }
      } else {
        Serial.printf("[HTTPS] GET... failed, error: %s\n", https.errorToString(httpCode).c_str());
      }

      https.end();
    } else {
      Serial.printf("[HTTPS] Unable to connect\n");
    }
  }

  Serial.println("Wait 10s before next round...");
  delay(10000);
}
