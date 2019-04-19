## Change the password on each master servers
### Manual 
```sh
htpasswd /etc/origin/master/htpasswd admin
htpasswd /etc/origin/master/htpasswd developer
htpasswd /etc/origin/master/htpasswd user1
```

### Via Ansible
```sh
$ ansible -i /home/quicklab/c1-ocp/hosts --key-file=/home/quicklab/c1-ocp/quicklab.key masters -a 'htpasswd -b /etc/origin/master/htpasswd user2 user2Password@123'

$ ansible -i /home/quicklab/c1-ocp/hosts --key-file=/home/quicklab/c1-ocp/quicklab.key masters -a 'cat /etc/origin/master/htpasswd'
```

> bug that master api and controllers are not added to the PATH
> https://bugzilla.redhat.com/show_bug.cgi?id=1613067

### Restart the master api and controller
/usr/local/bin/master-restart api

/usr/local/bin/master-restart controllers

```sh
ansible -i /home/quicklab/c1-ocp/hosts --key-file=/home/quicklab/c1-ocp/quicklab.key masters -a '/usr/local/bin/master-restart api api'

node-2.rajranjamaster.lab.pnq2.cee.redhat.com | SUCCESS | rc=0 >>
2
node-0.rajranjamaster.lab.pnq2.cee.redhat.com | SUCCESS | rc=0 >>
2
node-1.rajranjamaster.lab.pnq2.cee.redhat.com | SUCCESS | rc=0 >>
2
```

```sh
ansible -i /home/quicklab/c1-ocp/hosts --key-file=/home/quicklab/c1-ocp/quicklab.key masters -a '/usr/local/bin/master-restart controllers controllers'

node-0.rajranjamaster.lab.pnq2.cee.redhat.com | SUCCESS | rc=0 >>
2
node-2.rajranjamaster.lab.pnq2.cee.redhat.com | SUCCESS | rc=0 >>
2
node-1.rajranjamaster.lab.pnq2.cee.redhat.com | SUCCESS | rc=0 >>
2
```