#include <SD.h>
const int chipSelect = BUILTIN_SDCARD; // Use Teensy's built-in SD card slot

const int analogPin = A1;  // Analog input pin A1 (pin 15)
const unsigned long numSamples = 1000000;  // Number of samples to collect (1 million)
const unsigned long sampleIntervalMicros = 40; // Time interval between samples in microseconds

void setup() {
  Serial.begin(9600);
  while (!Serial) {}  // Wait for Serial to initialize
  Serial.println("Teensy Data Collection");

  analogReadResolution(12); // Set analog read resolution to 12 bits (0 to 4095)
  pinMode(analogPin, INPUT); // Set analog pin as input

  // Initialize the SD card
  if (!SD.begin(chipSelect)) {
    Serial.println("SD card initialization failed!");
    while (1);
  }
  Serial.println("SD card initialized successfully!");
}

void loop() {
  unsigned long currentTime;
  unsigned long elapsedTime;

  // Open the data file for writing
  File dataFile = SD.open("data46.txt", FILE_WRITE);
  if (!dataFile) {
    Serial.println("Error opening data.txt");
    while (1);
  }

  for (unsigned long sampleCount = 0; sampleCount < numSamples; sampleCount++) {
    currentTime = micros(); // Get the current time in microseconds
    int sensorValue = analogRead(analogPin);  // Read analog value from A1 (aka Pin 15)

    // Write the data and timestamp directly to the SD card
    dataFile.print(sensorValue); // voltage in teensy units
    dataFile.print(",");
    dataFile.println(currentTime);

    // Wait until the next sample interval
    do {
      elapsedTime = micros() - currentTime;
    } while (elapsedTime < sampleIntervalMicros);
  }

  // Close the data file
  dataFile.close();

  Serial.println("Data written to SD card successfully!");
  while (true) {}  // Stop execution after data collection is complete
}
