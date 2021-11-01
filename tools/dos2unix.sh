#!/bin/bash

cd `dirname $0`
cd ../


find . -name "*.js" -exec dos2unix {} \;
find . -name "*.env" -exec dos2unix {} \;
find . -name "*.yml" -exec dos2unix {} \;
find . -name "*.sh" -exec dos2unix {} \;
find . -name "*.conf" -exec dos2unix {} \;
