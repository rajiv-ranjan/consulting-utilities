https://linuxconfig.org/how-to-setup-a-named-dns-service-on-redhat-7-linux-server
https://www.itzgeek.com/how-tos/linux/centos-how-tos/configure-dns-bind-server-on-centos-7-rhel-7.html
https://www.techinformant.in/dns-server-configuration-on-rhelcentos-7/
https://www.tecmint.com/install-configure-cache-only-dns-server-in-rhel-centos-7/
https://www.digitalocean.com/community/tutorials/how-to-configure-bind-as-a-private-network-dns-server-on-centos-7
https://opensource.com/article/17/4/build-your-own-name-server


### To set a wild card domain entry
https://access.redhat.com/solutions/901793
https://serverfault.com/questions/229085/wildcard-dns-with-bind 


### forward.zone file

$TTL 1D
@	IN SOA	console.c1-ocp.morpheus.com. root.console.c1-ocp.morpheus.com. (
                    0    ; serial
                    1D    ; refresh
                    1H    ; retry
                    1W    ; expire
                    3H )    ; minimum
	IN NS	console.c1-ocp.morpheus.com.
	IN NS	console-int.c1-ocp.morpheus.com.
console	IN A	10.74.178.24
console-int	IN A	10.74.178.24
*.apps.c1-ocp.morpheus.com.	IN A	10.74.177.59

# chown root:named /var/named/{forward,reverse}.zone

to remove the errors from journald related to "unable to find...". Its related to ipv6.
https://serverfault.com/questions/639061/network-unreachable-error-in-my-server-logs