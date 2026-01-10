#!/bin/bash
read -p "Enter Project name: " name
mkdir ./$name

cd "$name" || exit 1

python3 -m venv venv

source venv/bin/activate

pip install platformio
pio project init --board esp32dev

cat >> platformio.ini <<EOF

upload_port = /dev/ttyUSB0
monitor_port = /dev/ttyUSB0
; monitor_port = COM3
; upload_port = COM3

upload_speed = 921600
monitor_speed = 115200
EOF

cat >> src/main.cpp <<EOF
#include <Arduino.h>

const int pinNum = 2;

void setup(){
  Serial.begin(115200);
  pinMode(pinNum, OUTPUT);
}

void loop(){
  digitalWrite(pinNum, HIGH);
  Serial.println("ON");
  delay(500);

  digitalWrite(pinNum, LOW);
  Serial.println("OFF");
  delay(500);
}
EOF

deactivate
