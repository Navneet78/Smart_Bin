

#include "ESP8266WiFi.h"
#include <Ethernet.h>
#include<Servo.h>
int trigPin = 10;
int echoPin = 11;
String value1;

int irsensorpin= 3;
int servopin =9;
Servo myservo;
int pos=0;
IPAddress server(192,168,137,227); 

const char* MY_SSID = "++";
const char* MY_PWD =  "++++++++";

WiFiClient client;


void setup()
{
  Serial.begin(115200);
  Serial.print("Connecting to "+*MY_SSID);
  WiFi.begin(MY_SSID, MY_PWD);
  Serial.println("going into wl connect");

  while (WiFi.status() != WL_CONNECTED) //not connected,  ...waiting to connect
    {
      delay(1000);
      Serial.print(".");
    }
  Serial.println("wl connected");
  Serial.println("");
  Serial.println("Credentials accepted! Connected to wifi\n ");
  Serial.println("");

  // put your setup code here, to run once:NAVNEET
  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);
  Serial.begin(9600);
  pinMode(irsensorpin, INPUT);
myservo.attach(servopin);
myservo.write(0);
}

void loop() {


// put your main code here, to run repeatedly:NAVNEET
  myservo.write(90);
  int MetalsensorValue = analogRead(A0);
  float sum=0;
  int voltage;
  for (int j=0; j<100; j+=1)
  {
    MetalsensorValue = analogRead(A0);
    voltage = MetalsensorValue * (5.0 / 1023.0);
    sum=voltage+sum;
  }
  sum= sum/100;
int value= digitalRead(irsensorpin);

  Serial.println (sum);
  Serial.println(value);
  
  if (value==0 && sum<=4.5 ){              //Nonmetal condition hai yha se
     value1 = "nonmetallic";
    for (pos=90;pos<180;pos+=1)
  {
    myservo.write(pos);
    delay(15);
  }
   for (pos=180;pos>90;pos-=1)
  {
    myservo.write(pos);
    delay(15);
  }
 
  }
  else if( value==0 && sum>4.5)         //Metal condition hai ye
  {value1 = "metallic";
    for (pos=90;pos>0;pos-=1)
  {
    myservo.write(pos);
    delay(15);
  }
   for (pos=0;pos<90;pos+=1)
  {
    myservo.write(pos);
    delay(15);
  }
  }

// yha se ultrasonic ka code h

  long duration, distance;
  digitalWrite(trigPin,HIGH);
  delayMicroseconds(1000);
  digitalWrite(trigPin, LOW);
  duration=pulseIn(echoPin, HIGH);
  distance =(duration/2)/(29.1);
  Serial.print(distance);
  Serial.println("cm");
  delay(10);




  delay(2000);
  
  // Read temperature as Celsius (the default)
  int x = 20;
  // Read temperature as Fahrenheit (isFahrenheit = true)
  int y = 30;
    Serial.println("\nStarting connection to server..."); 
  // if you get a connection, report back via serial:
  Serial.print("connect value\t");
  Serial.println(client.connect(server, 80));
  if (client.connect(server, 80)) {
    Serial.println("connected to server");
    WiFi.printDiag(Serial);

    String data = "value1="
          +                        value1
          +  "&distance="  +(String) distance
          +  "&y=" +(String) y;

     //change URL below if using your Sub-Domain
     client.println("POST /smart_dustbin/dataCollector.php HTTP/1.1"); 
     //change URL below if using your Domain
     client.print("Host:  192.168.137.227\n");                 
     client.println("User-Agent: ESP8266/1.0");
     client.println("Connection: close"); 
     client.println("Content-Type: application/x-www-form-urlencoded");
     client.print("Content-Length: ");
     client.print(data.length());
     client.print("\n\n");
     client.print(data);

     // Read all the lines of the reply from server and print them to Serial
    Serial.println("Respond:");
    while(client.available()){
      String line = client.readStringUntil('\r');
      Serial.println(line);
      
    // I will neeed to filter the headers, but first I want to be able to write to TempGraph anything

    }
     client.stop(); 
     
     Serial.println("\n");
     Serial.println("My data string im POSTing looks like this: ");
     Serial.println(data);
     Serial.println("And it is this many bytes: ");
     Serial.println(data.length());       
     delay(20000);
    } 
}


void printWifiStatus() {
  // print the SSID of the network you're attached to:
  Serial.print("SSID: ");
  Serial.println(WiFi.SSID());

  // print your WiFi shield's IP address:
  IPAddress ip = WiFi.localIP();
  Serial.print("IP Address: ");
  Serial.println(ip);

  // print the received signal strength:
  long rssi = WiFi.RSSI();
  Serial.print("signal strength (RSSI):");
  Serial.print(rssi);
  Serial.println(" dBm");
}
