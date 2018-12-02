|Command|Purpose|
|----|----|
|ssh -Vv -l rajiv remotehost.example.com| To login to the remote server as user rajiv|
|ssh -Vv -l rajiv remotehost.example.com "ls -lrt" | To run *ls* command on the remote server|
|ssh -Vv -i ~/.ssh/privateKey -t -l rajiv remotehost.example.com| To login using identity file|
|ssh -i ~/.ssh/privateKey -t -l rajiv remotehost.example.com "hostname"| To run a command on the remote server via SSH|

### How to toggle the ssh session  

1. Tilde sign followed by Control+Z
```sh
remotehost$ ~^Z
[1]+  Stopped                 ssh -l rajiv remotehost
    localhost$
```
2. Check the session running in the background
```sh
localhost$ jobs
    [1]+  Stopped                 ssh -l rajiv remotehost
```
3. Join back the remote session
```sh
localhost$ fg %1
    ssh -l rajiv remotehost
    remotehost$
```

> ssh configurations are stored in ~/.ssh/config file. Check it via `cat ~/.ssh/config`
> Read more about the ssh usage from Tatu on https://www.ssh.com/ssh/command/ or just `man ssh`