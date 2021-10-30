#!/bin/bash

cd `dirname $0`
certFile="../keyFile.file"
if [ ! -f "$certFile" ]; then
	openssl rand -base64 756 > $certFile
	chmod -R 400 $certFile
fi

