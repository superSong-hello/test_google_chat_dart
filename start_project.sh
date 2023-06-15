#!/bin/bash

cd
cd /usr/sbin
./nginx

cd
cd /app
dart main.dart

while [[ true ]];do
  sleep 1
done