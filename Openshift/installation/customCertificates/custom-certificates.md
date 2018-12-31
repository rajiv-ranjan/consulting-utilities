# Create certificate chain to be used by OpenShift and LBs
1. Generate Root key and read the key details (if you are interested). 

```sh
openssl genrsa -out RootCA.key 4096
```
Please note the default is 2048 bit.
```sh
openssl rsa -in RootCA.key -text -noout
```
2. Generate Root certificate
```sh
openssl req -new -x509 -days 5475 -key RootCA.key -out RootCA.crt
```
3. Generate Intermediate Certificate Authority key
```sh
openssl genrsa -out IntermediateCA.key 4096
```
4. Create Intermediate Certificate Signing Request (CSR)
```sh
openssl req -new -key IntermediateCA.key -out IntermediateCA.csr
```
5. Generate Intermediate Certificate signed by Root CA
```sh
openssl x509 -req -days 3650 -in IntermediateCA.csr -CA RootCA.crt -CAkey RootCA.key -CAcreateserial  -out IntermediateCA.crt
```
6. Add certificates to RHEL
   This is optional step. If this step is being skipped then mark step 10 to combine the chain before verification.
```sh
cp *.crt /usr/local/share/ca-certificates/
update-ca-certificates
```
7. Generate RSA server key. Repeat step 7 to 11 for master, master internal and router certificates.
```sh
openssl genrsa -out master.key
```
8. Create server certificate signing request, to be signed by intermediate
```sh
openssl req -new -key master.key -out master.csr
```
9.  Sign CSR, by intermediate CA
```sh
openssl x509 -req -in master.csr -CA IntermediateCA.crt -CAkey IntermediateCA.key -set_serial 01 -out master.crt -days 1825
```
10.  Combine
```sh
cat IntermediateCA.crt RootCA.crt > CombinedCAChain.crt
```
11.  Verify the master certificate
```sh
openssl verify -CAfile CombinedCAChain.crt master.crt
```
output
```sh
master.crt: OK
```

### Some helpful commands
#### To get the certificat chain details 

 ```sh
 $ openssl s_client -connect stackexchange.com:443 -showcerts 

 CONNECTED(00000003)
depth=2 C = US, O = DigiCert Inc, OU = www.digicert.com, CN = DigiCert High Assurance EV Root CA
verify return:1
depth=1 C = US, O = DigiCert Inc, OU = www.digicert.com, CN = DigiCert SHA2 High Assurance Server CA
verify return:1
depth=0 C = US, ST = NY, L = New York, O = "Stack Exchange, Inc.", CN = *.stackexchange.com
verify return:1
---
Certificate chain
.....
.....
.....
```

#### To read the certificate in pem format and show the details 

```sh
$ openssl s_client -showcerts -connect stackexchange.com:443 2>/dev/null | openssl x509 -inform pem -noout -text

Certificate:
    Data:
        Version: 3 (0x2)
        Serial Number:
            07:65:c6:4e:74:e5:91:d6:80:39:ca:2a:84:75:63:f0
    Signature Algorithm: sha256WithRSAEncryption
        Issuer: C=US, O=DigiCert Inc, OU=www.digicert.com, CN=DigiCert SHA2 High Assurance Server CA
        Validity
            Not Before: Oct  5 00:00:00 2018 GMT
            Not After : Aug 14 12:00:00 2019 GMT
        Subject: C=US, ST=NY, L=New York, O=Stack Exchange, Inc., CN=*.stackexchange.com
.....
.....
.....
```
#### To create pem files with certificates 

```sh
$ openssl s_client -showcerts -verify 5 -connect stackexchange.com:443 < /dev/null | awk '/BEGIN/,/END/{ if(/BEGIN/){a++}; out="cert"a".pem"; print >out}' 

verify depth is 5
depth=2 C = US, O = DigiCert Inc, OU = www.digicert.com, CN = DigiCert High Assurance EV Root CA
verify return:1
depth=1 C = US, O = DigiCert Inc, OU = www.digicert.com, CN = DigiCert SHA2 High Assurance Server CA
verify return:1
depth=0 C = US, ST = NY, L = New York, O = "Stack Exchange, Inc.", CN = *.stackexchange.com
verify return:1
DONE
```

#### To verify the certificate on the server. (Create the stackexchange.com.RootCA.crt from the Root CA cert from /etc/ssl/certs/ca-bundle.trust.crt -> /etc/pki/ca-trust/extracted/openssl/ca-bundle.trust.crt)

```sh
$ ll stackexchange.com.*
-rw-rw-r--. 1 quicklab quicklab 3152 Dec 31 01:13 stackexchange.com.CombinedCAChain.crt
-rw-rw-r--. 1 quicklab quicklab 1464 Dec 31 01:05 stackexchange.com.RootCA.crt
-rw-rw-r--. 1 quicklab quicklab 1688 Dec 31 00:14 stackexchange.com.intermediate.crt
-rw-rw-r--. 1 quicklab quicklab 2914 Dec 31 00:13 stackexchange.com.server.crt

$ cat stackexchange.com.intermediate.crt stackexchange.com.RootCA.crt > stackexchange.com.CombinedCAChain.crt 

```

```sh
$ openssl verify -CAfile stackexchange.com.CombinedCAChain.crt  stackexchange.com.server.crt

stackexchange.com.server.crt: OK
```

#### To install a CA certificate on RHEL 7
* download the CA certificate 
* enable the dynamic CA configuration feature
* copy the CA certificate to RHEL trusted CA source folder
* extract and add the certificate
* verify

```sh
# update-ca-trust enable
# cp rapidSSL-ca.crt /etc/pki/ca-trust/source/anchors/
# update-ca-trust extract
# openssl verify rapidSSL-ca.crt
# openssl verify server.crt
```