#include <MPU9250_asukiaaa.h>
int IN1 = 3;
int IN2 = 5;
int i=0;

#ifdef ESP32_HAL_I2C_H
#define SDA_PIN 21
#define SCL_PIN 22
#endif

MPU9250_asukiaaa mySensor;
float  gZ;

void setup() {
  Serial.begin(115200);
  while(!Serial);
  pinMode(IN1, OUTPUT);
  pinMode(IN2, OUTPUT);
#ifdef _ESP32_HAL_I2C_H_ // For ESP32
    Wire.begin(SDA_PIN, SCL_PIN);
    mySensor.setWire(&Wire);
  #endif
  
    mySensor.beginAccel();
    mySensor.beginGyro();
    mySensor.beginMag();
  
 
}


void loop() {

  digitalWrite(IN1, HIGH);
  digitalWrite(IN2, LOW);
  
  

 

  
   
    gZ = mySensor.gyroZ()*50;
    
    Serial.println("gyroZ: " + String(gZ));
  


if (gZ > 1000) 
{
  i = 255 - ((gZ - 1000) / 4.0); // decrease i linearly from 255 as gZ increases
}
 else if (gZ >= -40 && gZ <= 40)
 {
  i = 0; // set i to 0 if gZ is between -40 and 40
}
  
  Serial.println(i);

 analogWrite(IN1, i);
    delay(100);
}
