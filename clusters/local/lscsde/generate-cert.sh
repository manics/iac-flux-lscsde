#!/bin/sh

openssl req -x509 -sha256 -days 3650 -newkey rsa:2048 -keyout ca.key -out ca.crt
cat > wildcard.ext <<EOF
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
subjectAltName = @alt_names
[alt_names]
DNS.1 = *.lsc-sde.local
EOF
openssl genrsa -des3 -out wildcard.key 2048
openssl req -key wildcard.key -new -out wildcard.csr
openssl x509 -req -CA ca.crt -CAkey ca.key -in wildcard.csr -out wildcard.crt -days 3650 -CAcreateserial -extfile wildcard.ext
openssl rsa -in wildcard.key -out wildcard-decrypted.key
openssl rsa -in ca.key -out ca-decrypted.key
openssl pkcs12 -inkey wildcard.key -in wildcard.crt -export -out wildcard.pfx