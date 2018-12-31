#!/bin/bash

echo "Check a certificate"
openssl x509 -in server.crt -text -noout

echo "Check a key for consistency"
openssl rsa -in server.key -check

echo "Verify the certifiacte and key match"
openssl x509 -noout -modulus -in server.crt| openssl md5
openssl rsa -noout -modulus -in server.key| openssl md5

echo "See the certificate of a hosted web site"
openssl s_client -showcerts -connect example.com:443

echo "Check for a valid certificate hosted on the web site"
# look for Verify return code: 0 (ok) 
openssl s_client -connect example.com:443 -servername example.com

echo "check the validity of the certificates hosted by a portal"
echo | openssl s_client -connect example.com:443 -servername example.com 2>/dev/null | openssl x509 -noout -dates

https://unix.stackexchange.com/questions/16226/how-can-i-verify-ssl-certificates-on-the-command-line

https://stackoverflow.com/questions/991758/how-to-get-pem-file-from-key-and-crt-files