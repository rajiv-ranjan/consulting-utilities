### Server side
* Generate password

```sh
slappasswd -s rajiv
```

### Searching in ldap
> To point to the remote ldap server use the pattern 
> ***ldap://\<server>:\<port>***
> 
> To point to the local ldap server; use pattern
> ***ldap:///***

* Search the complete tree without any filter
```sh
ldapsearch -x -LLL -H ldap://node-0.rajranjabastion.lab.pnq2.cee.redhat.com:389 -b dc=rajranjabastion,dc=lab,dc=pnq2,dc=cee,dc=redhat,dc=com
```
Output
```sh
dn: dc=rajranjabastion,dc=lab,dc=pnq2,dc=cee,dc=redhat,dc=com
dc: rajranjabastion
objectClass: top
objectClass: domain

dn: cn=ldapadmin,dc=rajranjabastion,dc=lab,dc=pnq2,dc=cee,dc=redhat,dc=com
objectClass: organizationalRole
cn: ldapadmin
description: LDAP Manager

dn: ou=People,dc=rajranjabastion,dc=lab,dc=pnq2,dc=cee,dc=redhat,dc=com
objectClass: organizationalUnit
ou: People

dn: ou=Group,dc=rajranjabastion,dc=lab,dc=pnq2,dc=cee,dc=redhat,dc=com
objectClass: organizationalUnit
ou: Group

dn: uid=rajiv,ou=People,dc=rajranjabastion,dc=lab,dc=pnq2,dc=cee,dc=redhat,dc=
 com
objectClass: top
objectClass: account
objectClass: posixAccount
objectClass: shadowAccount
cn: rajiv
uid: rajiv
uidNumber: 9999
gidNumber: 100
homeDirectory: /home/rajiv
loginShell: /bin/bash
gecos: Rajiv [local (at) cluster]
shadowLastChange: 17058
shadowMin: 0
shadowMax: 99999
shadowWarning: 7
userPassword::
```
* Search the ldap and get list of dn (distinguished name)

```sh
ldapsearch -x -LLL -H ldap://node-0.rajranjabastion.lab.pnq2.cee.redhat.com:389 -b dc=rajranjabastion,dc=lab,dc=pnq2,dc=cee,dc=redhat,dc=com dn
```
Output
```sh
dn: dc=rajranjabastion,dc=lab,dc=pnq2,dc=cee,dc=redhat,dc=com

dn: cn=ldapadmin,dc=rajranjabastion,dc=lab,dc=pnq2,dc=cee,dc=redhat,dc=com

dn: ou=People,dc=rajranjabastion,dc=lab,dc=pnq2,dc=cee,dc=redhat,dc=com

dn: ou=Group,dc=rajranjabastion,dc=lab,dc=pnq2,dc=cee,dc=redhat,dc=com

dn: uid=rajiv,ou=People,dc=rajranjabastion,dc=lab,dc=pnq2,dc=cee,dc=redhat,dc=
 com
```
* Searching for database in base cn=config

```sh
ldapsearch -Q -LLL -Y EXTERNAL -H ldapi:/// -b cn=config "(olcSuffix=dc=rajranjabastion,dc=lab,dc=pnq2,dc=cee,dc=redhat,dc=com)"
```
Output
```sh
dn: olcDatabase={2}hdb,cn=config
objectClass: olcDatabaseConfig
objectClass: olcHdbConfig
olcDatabase: {2}hdb
olcDbDirectory: /var/lib/ldap
olcDbIndex: objectClass eq,pres
olcDbIndex: ou,cn,mail,surname,givenname eq,pres,sub
olcSuffix: dc=rajranjabastion,dc=lab,dc=pnq2,dc=cee,dc=redhat,dc=com
olcRootDN: cn=ldapadmin,dc=rajranjabastion,dc=lab,dc=pnq2,dc=cee,dc=redhat,dc=
 com
olcRootPW: 
```

### Adding a new entry
* Add via a file
users.ldif file contains the list of users to be added.
```sh
ldapadd -x -D "cn=ldapadmin,dc=rajranjabastion,dc=lab,dc=pnq2,dc=cee,dc=redhat,dc=com" -W -f users.ldif 
```

### Modify the ldap user
