int sensorPin = A1;    // select the input pin for the mic data
int sensorValue = 0;  // variable to store the value coming from the sensor

void setup() {
  Serial.begin(9600);
  // declare the ledPin as an OUTPUT:
  pinMode(sensorPin, INPUT);  
}

void loop() {
  // read the value from the sensor:
  sensorValue = analogRead(sensorPin);    
  Serial.print(sensorValue);
  // stop the program for <sensorValue> milliseconds:
  delay(1000);
  Serial.print(" \n next reading ");     
}  
