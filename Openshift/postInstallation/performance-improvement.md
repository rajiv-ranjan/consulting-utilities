

### disabling dns connection tracking in firewalld
```sh
sudo -i


firewall-cmd --permanent --direct --add-rule ipv4 filter INPUT 0 -p udp -m udp --sport 53 -j ACCEPT
firewall-cmd --permanent --direct --add-rule ipv4 filter INPUT 0 -p udp -m udp --dport 53 -j ACCEPT
firewall-cmd --permanent --direct --add-rule ipv4 raw PREROUTING 0 -p udp --dport 53 -j NOTRACK
firewall-cmd --permanent --direct --add-rule ipv4 raw PREROUTING 0 -p udp --sport 53 -j NOTRACK
firewall-cmd --permanent --direct --add-rule ipv4 raw OUTPUT 0 -p udp --dport 53 -j NOTRACK
firewall-cmd --permanent --direct --add-rule ipv4 raw OUTPUT 0 -p udp --sport 53 -j NOTRACK


firewall-cmd --direct --add-rule ipv4 filter INPUT 0 -p udp -m udp --sport 53 -j ACCEPT
firewall-cmd --direct --add-rule ipv4 filter INPUT 0 -p udp -m udp --dport 53 -j ACCEPT
firewall-cmd --direct --add-rule ipv4 raw PREROUTING 0 -p udp --dport 53 -j NOTRACK
firewall-cmd --direct --add-rule ipv4 raw PREROUTING 0 -p udp --sport 53 -j NOTRACK
firewall-cmd --direct --add-rule ipv4 raw OUTPUT 0 -p udp --dport 53 -j NOTRACK
firewall-cmd --direct --add-rule ipv4 raw OUTPUT 0 -p udp --sport 53 -j NOTRACK

# single line
ansible --key quicklab.key -i hosts OSEv3 -m shell -a 'firewall-cmd --permanent --direct --add-rule ipv4 filter INPUT 0 -p udp -m udp --sport 53 -j ACCEPT; firewall-cmd --permanent --direct --add-rule ipv4 filter INPUT 0 -p udp -m udp --dport 53 -j ACCEPT; firewall-cmd --permanent --direct --add-rule ipv4 raw PREROUTING 0 -p udp --dport 53 -j NOTRACK; firewall-cmd --permanent --direct --add-rule ipv4 raw PREROUTING 0 -p udp --sport 53 -j NOTRACK; firewall-cmd --permanent --direct --add-rule ipv4 raw OUTPUT 0 -p udp --dport 53 -j NOTRACK; firewall-cmd --permanent --direct --add-rule ipv4 raw OUTPUT 0 -p udp --sport 53 -j NOTRACK; firewall-cmd --direct --add-rule ipv4 filter INPUT 0 -p udp -m udp --sport 53 -j ACCEPT; firewall-cmd --direct --add-rule ipv4 filter INPUT 0 -p udp -m udp --dport 53 -j ACCEPT; firewall-cmd --direct --add-rule ipv4 raw PREROUTING 0 -p udp --dport 53 -j NOTRACK; firewall-cmd --direct --add-rule ipv4 raw PREROUTING 0 -p udp --sport 53 -j NOTRACK; firewall-cmd --direct --add-rule ipv4 raw OUTPUT 0 -p udp --dport 53 -j NOTRACK; firewall-cmd --direct --add-rule ipv4 raw OUTPUT 0 -p udp --sport 53 -j NOTRACK'

```

* Check the firewall rules 
```sh
firewall-cmd --list-all
firewall-cmd --direct --get-all-rules
firewall-cmd --permanent --direct --get-all-rules
```

* If needed the changes to firewalld can be reverted.

```sh
sudo -i

firewall-cmd --permanent --direct --remove-rule ipv4 raw PREROUTING 0 -p udp --dport 53 -j NOTRACK
firewall-cmd --permanent --direct --remove-rule ipv4 raw PREROUTING 0 -p udp --sport 53 -j NOTRACK
firewall-cmd --permanent --direct --remove-rule ipv4 raw OUTPUT 0 -p udp --dport 53 -j NOTRACK
firewall-cmd --permanent --direct --remove-rule ipv4 raw OUTPUT 0 -p udp --sport 53 -j NOTRACK
firewall-cmd --permanent --direct --remove-rule ipv4 filter INPUT 0 -p udp -m udp --sport 53 -j ACCEPT
firewall-cmd --permanent --direct --remove-rule ipv4 filter INPUT 0 -p udp -m udp --dport 53 -j ACCEPT

firewall-cmd --direct --remove-rule ipv4 raw PREROUTING 0 -p udp --dport 53 -j NOTRACK
firewall-cmd --direct --remove-rule ipv4 raw PREROUTING 0 -p udp --sport 53 -j NOTRACK
firewall-cmd --direct --remove-rule ipv4 raw OUTPUT 0 -p udp --dport 53 -j NOTRACK
firewall-cmd --direct --remove-rule ipv4 raw OUTPUT 0 -p udp --sport 53 -j NOTRACK
firewall-cmd --direct --remove-rule ipv4 filter INPUT 0 -p udp -m udp --sport 53 -j ACCEPT
firewall-cmd --direct --remove-rule ipv4 filter INPUT 0 -p udp -m udp --dport 53 -j ACCEPT


# single line
ansible --key quicklab.key -i hosts OSEv3 -m shell -a 'firewall-cmd --permanent --direct --remove-rule ipv4 raw PREROUTING 0 -p udp --dport 53 -j NOTRACK; firewall-cmd --permanent --direct --remove-rule ipv4 raw PREROUTING 0 -p udp --sport 53 -j NOTRACK; firewall-cmd --permanent --direct --remove-rule ipv4 raw OUTPUT 0 -p udp --dport 53 -j NOTRACK; firewall-cmd --permanent --direct --remove-rule ipv4 raw OUTPUT 0 -p udp --sport 53 -j NOTRACK; firewall-cmd --permanent --direct --remove-rule ipv4 filter INPUT 0 -p udp -m udp --sport 53 -j ACCEPT; firewall-cmd --permanent --direct --remove-rule ipv4 filter INPUT 0 -p udp -m udp --dport 53 -j ACCEPT; firewall-cmd --direct --remove-rule ipv4 raw PREROUTING 0 -p udp --dport 53 -j NOTRACK; firewall-cmd --direct --remove-rule ipv4 raw PREROUTING 0 -p udp --sport 53 -j NOTRACK; firewall-cmd --direct --remove-rule ipv4 raw OUTPUT 0 -p udp --dport 53 -j NOTRACK; firewall-cmd --direct --remove-rule ipv4 raw OUTPUT 0 -p udp --sport 53 -j NOTRACK; firewall-cmd --direct --remove-rule ipv4 filter INPUT 0 -p udp -m udp --sport 53 -j ACCEPT; firewall-cmd --direct --remove-rule ipv4 filter INPUT 0 -p udp -m udp --dport 53 -j ACCEPT'

```

* Useful commands to keep it handy.
```sh


```


for node in $(oc get nodes | grep node | awk '{print $1}' ); do echo $node; ssh $node "systemctl status dnsmasq | grep Active"; done






















Hi Mohit
Customer has deployed the firewall rule without accepting source port udp/53. So below two commands should help to solve.

Run below commands from from bastion and folder /home/ocpadmin/installation as this folder contain the host inventory.
~~~~~~~~~
ansible  -i hosts OSEv3 -m shell -a 'firewall-cmd --permanent --direct --remove-rule ipv4 raw PREROUTING 0 -p udp --dport 53 -j NOTRACK; firewall-cmd --permanent --direct --remove-rule ipv4 raw PREROUTING 0 -p udp --sport 53 -j NOTRACK; firewall-cmd --permanent --direct --remove-rule ipv4 raw OUTPUT 0 -p udp --dport 53 -j NOTRACK; firewall-cmd --permanent --direct --remove-rule ipv4 raw OUTPUT 0 -p udp --sport 53 -j NOTRACK; firewall-cmd --permanent --direct --remove-rule ipv4 filter INPUT 0 -p udp -m udp --sport 53 -j ACCEPT; firewall-cmd --permanent --direct --remove-rule ipv4 filter INPUT 0 -p udp -m udp --dport 53 -j ACCEPT; firewall-cmd --direct --remove-rule ipv4 raw PREROUTING 0 -p udp --dport 53 -j NOTRACK; firewall-cmd --direct --remove-rule ipv4 raw PREROUTING 0 -p udp --sport 53 -j NOTRACK; firewall-cmd --direct --remove-rule ipv4 raw OUTPUT 0 -p udp --dport 53 -j NOTRACK; firewall-cmd --direct --remove-rule ipv4 raw OUTPUT 0 -p udp --sport 53 -j NOTRACK; firewall-cmd --direct --remove-rule ipv4 filter INPUT 0 -p udp -m udp --sport 53 -j ACCEPT; firewall-cmd --direct --remove-rule ipv4 filter INPUT 0 -p udp -m udp --dport 53 -j ACCEPT'
~~~~~~~~~

~~~~~~~~~
ansible --key quicklab.key -i hosts OSEv3 -m shell -a 'firewall-cmd --permanent --direct --add-rule ipv4 filter INPUT 0 -p udp -m udp --sport 53 -j ACCEPT; firewall-cmd --permanent --direct --add-rule ipv4 filter INPUT 0 -p udp -m udp --dport 53 -j ACCEPT; firewall-cmd --permanent --direct --add-rule ipv4 raw PREROUTING 0 -p udp --dport 53 -j NOTRACK; firewall-cmd --permanent --direct --add-rule ipv4 raw PREROUTING 0 -p udp --sport 53 -j NOTRACK; firewall-cmd --permanent --direct --add-rule ipv4 raw OUTPUT 0 -p udp --dport 53 -j NOTRACK; firewall-cmd --permanent --direct --add-rule ipv4 raw OUTPUT 0 -p udp --sport 53 -j NOTRACK; firewall-cmd --direct --add-rule ipv4 filter INPUT 0 -p udp -m udp --sport 53 -j ACCEPT; firewall-cmd --direct --add-rule ipv4 filter INPUT 0 -p udp -m udp --dport 53 -j ACCEPT; firewall-cmd --direct --add-rule ipv4 raw PREROUTING 0 -p udp --dport 53 -j NOTRACK; firewall-cmd --direct --add-rule ipv4 raw PREROUTING 0 -p udp --sport 53 -j NOTRACK; firewall-cmd --direct --add-rule ipv4 raw OUTPUT 0 -p udp --dport 53 -j NOTRACK; firewall-cmd --direct --add-rule ipv4 raw OUTPUT 0 -p udp --sport 53 -j NOTRACK'
~~~~~~~~~

I have tested the above in quicklab and its working as expected. Please validate.

Do we need a restart of docker and atomic-openshift-node services? If yes then we need to give the exact commands to run for NODE RESTART process (i.e. mark unschedulable, drain the pods and restart the service and put the node back schedulable). This is there production.