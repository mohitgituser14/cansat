#include <MPU9250_asukiaaa.h>

int IN1 = 3;
int IN2 = 5;

float setpoint = 0.0;  // desired setpoint
float error, last_error, error_sum, output;

float kp = 0.2;
float ki = 0.01;
float kd = 0.1;

float gZ;

#ifdef ESP32_HAL_I2C_H
#define SDA_PIN 21
#define SCL_PIN 22
#endif

MPU9250_asukiaaa mySensor;

void setup() {
  Serial.begin(115200);
  while (!Serial);

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
  mySensor.gyroUpdate(); // update gyro values
  gZ = mySensor.gyroZ();

  // Calculate error
  error = setpoint - gZ;

  // Calculate PID output
  output1 = kp * error + ki * error_sum + kd * (error - last_error);
  output = 200*sgn(error + gZ*gZ/(5))
  // Store previous error for next iteration
  last_error = error;

  // Store error sum for next iteration
  error_sum += error;

  // Check for output saturation
  if (output > 255) {
    output = 255;
  } else if (output < -255) {
    output = -255;
  }

  // Apply output to motor
  if (output > 0) {
    analogWrite(IN1, output);
    digitalWrite(IN2, LOW);
  } else if (output < 0) {
    analogWrite(IN2, abs(output));
    digitalWrite(IN1, LOW);
  } else {
    digitalWrite(IN1, LOW);
    digitalWrite(IN2, LOW);
  }

  // Delay for next iteration
  delay(10);
}
