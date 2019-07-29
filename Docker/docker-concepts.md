### Docker Network


* Command: docker container port 

```sh
docker container port d78a294496bf
80/tcp -> 0.0.0.0:80
```


* Command: docker network 

```sh
# list the networks available
docker network ls
NETWORK ID          NAME                DRIVER              SCOPE
8eb3323556ae        bridge              bridge              local
75c7a34b146a        host                host                local
b47833d6b055        none                null                local
```
```sh
# inspecting the default bridge network to see the containers attached to it.
docker network inspect 8eb3323556ae | jq '.[].Containers'
{
  "b8fcb1ff116af482c059260172ace70c39b06ebbcdab92bf04a137ad0c6a8e0d": {
    "Name": "ubuntu",
    "EndpointID": "2fc71c1717157f3afb41f7427f97157bd154d7bbe44279b2d8ec288a63198e45",
    "MacAddress": "02:42:ac:11:00:04",
    "IPv4Address": "172.17.0.4/16",
    "IPv6Address": ""
  },
  "b9906530242f3394fa338437755784d19e8f68e88623bb04ddfe832ea6b2e5ef": {
    "Name": "mysql-002",
    "EndpointID": "3a3d128cc97accd3cd332e7531b2e9761659c34a39f1f299c9cab376ee6f4b94",
    "MacAddress": "02:42:ac:11:00:03",
    "IPv4Address": "172.17.0.3/16",
    "IPv6Address": ""
  },
  "d78a294496bf33f3310924fd3d9bae3dc0364e4b2e3095ab18f77f72a0dbc8e7": {
    "Name": "nginx",
    "EndpointID": "43abcfca0659730e2d2e9e53b647f7dc2c5e2e5384df8a711c3059803398a9ae",
    "MacAddress": "02:42:ac:11:00:02",
    "IPv4Address": "172.17.0.2/16",
    "IPv6Address": ""
  }
}

docker network inspect 8eb3323556ae | jq '.[].IPAM'
{
  "Driver": "default",
  "Options": null,
  "Config": [
    {
      "Subnet": "172.17.0.0/16",
      "Gateway": "172.17.0.1"
    }
  ]
}

# Inspecting nginx container's network to see which bridge it's attached
docker container inspect d78a294496bf | jq '.[].NetworkSettings.Networks'
{
  "bridge": {
    "IPAMConfig": null,
    "Links": null,
    "Aliases": null,
    "NetworkID": "8eb3323556aefe1aa4c0465a5f1be166ee157fbb08cbf818aa019fa54efcf0ef",
    "EndpointID": "43abcfca0659730e2d2e9e53b647f7dc2c5e2e5384df8a711c3059803398a9ae",
    "Gateway": "172.17.0.1",
    "IPAddress": "172.17.0.2",
    "IPPrefixLen": 16,
    "IPv6Gateway": "",
    "GlobalIPv6Address": "",
    "GlobalIPv6PrefixLen": 0,
    "MacAddress": "02:42:ac:11:00:02",
    "DriverOpts": null
  }
}
```

* Add container to a new network

```sh
docker network create --driver bridge my-app-network
86600f723c8c7690efebbcd4e532a53ad7b175d80ed4a75b18b1167ba5f1f2e3

docker container run --name proxy -d --publish 8080:80 --network my-app-network nginx
64f6a2a56254f34f7a7b6acc28d7d28a5cd473b51958d7fe44d491807ec1199e

docker container inspect 64f6a2a56254| jq '.[].NetworkSettings.Networks'
{
  "my-app-network": {
    "IPAMConfig": null,
    "Links": null,
    "Aliases": [
      "64f6a2a56254"
    ],
    "NetworkID": "86600f723c8c7690efebbcd4e532a53ad7b175d80ed4a75b18b1167ba5f1f2e3",
    "EndpointID": "cddac3feedaac68bdb3c318c6b3e0846dbdfbc38623b4518ffdf0bc8538e58de",
    "Gateway": "172.18.0.1",
    "IPAddress": "172.18.0.2",
    "IPPrefixLen": 16,
    "IPv6Gateway": "",
    "GlobalIPv6Address": "",
    "GlobalIPv6PrefixLen": 0,
    "MacAddress": "02:42:ac:12:00:02",
    "DriverOpts": null
  }
}
```

* Attach a new network to an existing container

```sh
docker network connect my-app-network nginx

docker container inspect nginx| jq '.[].NetworkSettings.Networks'
{
  "bridge": {
    "IPAMConfig": null,
    "Links": null,
    "Aliases": null,
    "NetworkID": "8eb3323556aefe1aa4c0465a5f1be166ee157fbb08cbf818aa019fa54efcf0ef",
    "EndpointID": "43abcfca0659730e2d2e9e53b647f7dc2c5e2e5384df8a711c3059803398a9ae",
    "Gateway": "172.17.0.1",
    "IPAddress": "172.17.0.2",
    "IPPrefixLen": 16,
    "IPv6Gateway": "",
    "GlobalIPv6Address": "",
    "GlobalIPv6PrefixLen": 0,
    "MacAddress": "02:42:ac:11:00:02",
    "DriverOpts": null
  },
  "my-app-network": {
    "IPAMConfig": {},
    "Links": null,
    "Aliases": [
      "d78a294496bf"
    ],
    "NetworkID": "86600f723c8c7690efebbcd4e532a53ad7b175d80ed4a75b18b1167ba5f1f2e3",
    "EndpointID": "1ad63b5b1692e910742b935238fa120b4c366d9eac8fe535c281429b905dfa4d",
    "Gateway": "172.18.0.1",
    "IPAddress": "172.18.0.3",
    "IPPrefixLen": 16,
    "IPv6Gateway": "",
    "GlobalIPv6Address": "",
    "GlobalIPv6PrefixLen": 0,
    "MacAddress": "02:42:ac:12:00:03",
    "DriverOpts": null
  }
}
```

### Docker DNS
* The default bridge doesn allow containers to connect with each other over container name as container name doesnot resolve to the ip. See the below example where container nginx and mysql-002 are in the default bridge.

```sh
# enable the ping on nginx container
docker container exec -it nginx apt-get update
docker container exec -it nginx apt-get install iputils-ping
docker container exec -it mysql-002 apt-get update
docker container exec -it mysql-002 apt-get install iputils-ping

docker container exec -it mysql-002 ping nginx
ping: nginx: Name or service not known

```

* Conatiners created on the new network bridge can connect with each other

```sh
docker container exec -it proxy apt-get update
docker container exec -it proxy apt-get install iputils-ping
docker container exec -it proxy2 apt-get update
docker container exec -it proxy2 apt-get install iputils-ping

docker container exec -it proxy ping proxy2
PING proxy2 (172.18.0.4) 56(84) bytes of data.
64 bytes from proxy2.my-app-network (172.18.0.4): icmp_seq=1 ttl=64 time=0.711 ms
64 bytes from proxy2.my-app-network (172.18.0.4): icmp_seq=2 ttl=64 time=0.112 ms
^C
--- proxy2 ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 1001ms
rtt min/avg/max/mdev = 0.112/0.411/0.711/0.300 ms
```

* In the new network we can create network alias for couple of pods. This will allow the alias DNS to resolve to one of the available container.

```sh
# start two elastic container on the new network with alias named as 'search'
docker container run --name elasticsearch-001 -d --network my-app-network --network-alias=search  elasticsearch:2
1b7282e4f2d3b775be52c42f93520bdca3892c6843280985982d0e017f9921b2
docker container run --name elasticsearch-002 -d --network my-app-network --network-alias=search  elasticsearch:2
0ca3613216419b3b39754a68398ff47fe449be97fd81d044a6c2733522b52c55

# check the dns
docker container run --rm --name alpine-test --network=my-app-network  -it alpine nslookup search
Name:      search
Address 1: 172.18.0.6 elasticsearch-002.my-app-network
Address 2: 172.18.0.5 elasticsearch-001.my-app-network

# curl the two instances against domain name 'search' two get redirected to one of the two containers
docker container run --rm --name alpine-test --network=my-app-network  -it centos curl search:9200
{
  "name" : "Richard Fisk",
  "cluster_name" : "elasticsearch",
  "cluster_uuid" : "ZRFFOPT2RdOmv9W1J0n4tQ",
  "version" : {
    "number" : "2.4.6",
    "build_hash" : "5376dca9f70f3abef96a77f4bb22720ace8240fd",
    "build_timestamp" : "2017-07-18T12:17:44Z",
    "build_snapshot" : false,
    "lucene_version" : "5.5.4"
  },
  "tagline" : "You Know, for Search"
}

docker container run --rm --name alpine-test --network=my-app-network  -it centos curl search:9200
{
  "name" : "Jackhammer",
  "cluster_name" : "elasticsearch",
  "cluster_uuid" : "iwuelXtJT72eG7mVXUNmcQ",
  "version" : {
    "number" : "2.4.6",
    "build_hash" : "5376dca9f70f3abef96a77f4bb22720ace8240fd",
    "build_timestamp" : "2017-07-18T12:17:44Z",
    "build_snapshot" : false,
    "lucene_version" : "5.5.4"
  },
  "tagline" : "You Know, for Search"
}
```

### Docker Images
* Image history

```sh
docker image history
docker image inspect
docker image tag
docker image push
docker image prune
docker system prune
```

* docker image building
  * keep the steps that changes frequently towards the end and least changing steps on top in the dockerfile.

### Docker Volume

```sh
docker volume prune
docker container inspect a3f0e5a4b865
docker volume ls
docker volume inspect 9951e46a5
```

* docker named volume can be created from the docker container run command. E.g.

```sh
docker container run --rm -d -e MYSQL_ALLOW_EMPTY_PASSWORD=True --name mysql3 -v mysqldb3:/var/lib/mysql mysql
```
* docker bind mount is used to map a local volume into the container directly

```sh
docker container run -d --rm -p 80:80 -v $(pwd):/usr/share/nginx/html --name nginx-1 nginx
```

```sh
# how two instances of postgres db share the same volume. This is helpful to upgrade the database's minor patches
docker container run --rm -v pgsqldb:/var/lib/postgresql/data postgres:9.6.1
docker container run --rm -v pgsqldb:/var/lib/postgresql/data postgres:9.6.2
```

### Docker Compose
* Sample docker compose file

```yaml
version: '3'

services:
  proxy:
    image: nginx:1.13 # this will use the latest version of 1.13.x
    ports:
      - '80:80' # expose 80 on host and sent to 80 in container
    volumes:
      - ./nginx.conf:/etc/nginx/conf.d/default.conf:ro
  web:
    image: httpd  # this will use httpd:latest
```

```sh
docker compose up -d # option -d will run the containers in detached mode

```

```sh
docker-compose logs

Attaching to compose-sample-2_web_2, compose-sample-2_proxy_1, compose-sample-2_web_1
proxy_1  | 172.21.0.1 - - [29/Jul/2019:09:46:22 +0000] "GET / HTTP/1.1" 200 45 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.142 Safari/537.36" "-"
proxy_1  | 172.21.0.1 - - [29/Jul/2019:09:46:27 +0000] "GET / HTTP/1.1" 304 0 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.142 Safari/537.36" "-"
proxy_1  | 172.21.0.1 - - [29/Jul/2019:09:46:28 +0000] "GET / HTTP/1.1" 304 0 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.142 Safari/537.36" "-"


docker-compose logs web

Attaching to compose-sample-2_web_2, compose-sample-2_web_1
web_1    | AH00558: httpd: Could not reliably determine the server's fully qualified domain name, using 172.21.0.2. Set the 'ServerName' directive globally to suppress this message
web_1    | AH00558: httpd: Could not reliably determine the server's fully qualified domain name, using 172.21.0.2. Set the 'ServerName' directive globally to suppress this message
```

```sh
# preferred command is docker-compose up --scale web=2
docker-compose scale web=2 


WARNING: The scale command is deprecated. Use the up command with the --scale flag instead.
Starting compose-sample-2_web_1 ... done
Creating compose-sample-2_web_2 ... done
```

```sh
docker compose down
Stopping compose-sample-2_web_2   ... done
Stopping compose-sample-2_proxy_1 ... done
Stopping compose-sample-2_web_1   ... done
Removing compose-sample-2_web_2   ... done
Removing compose-sample-2_proxy_1 ... done
Removing compose-sample-2_web_1   ... done
Removing network compose-sample-2_default
```

### Docker swarm

* by default the swarm is not active on the local docker instance

```sh
docker info | grep -i swarm
Swarm: inactive
```

* start a single node swarm

```sh
docker swarm init

Swarm initialized: current node (hw2jk28tdwd7o8ofn1r8nf6p4) is now a manager.

To add a worker to this swarm, run the following command:

    docker swarm join --token XXXXXXXXXXXXXXX 192.168.65.3:2377

To add a manager to this swarm, run 'docker swarm join-token manager' and follow the instructions.
```

* list swarm nodes

```sh
docker node ls

ID                            HOSTNAME                STATUS              AVAILABILITY        MANAGER STATUS      ENGINE VERSION
hw2jk28tdwd7o8ofn1r8nf6p4 *   linuxkit-025000000001   Ready               Active              Leader              18.09.2

```

* Docker services

```sh
docker service create alpine ping 8.8.8.8

3u2eoni6v7dwalw5ixizwoud0
overall progress: 1 out of 1 tasks
1/1: running   [==================================================>]
verify: Service converged
```
```sh
# list of docker services
docker service ls

ID                  NAME                MODE                REPLICAS            IMAGE               PORTS
3u2eoni6v7dw        amazing_easley      replicated          1/1                 alpine:latest
```
```sh
# list of services against the service
docker service ps amazing_easley

ID                  NAME                IMAGE               NODE                    DESIRED STATE       CURRENT STATE                ERROR               PORTS
9cami0dm9ar6        amazing_easley.1    alpine:latest       linuxkit-025000000001   Running             Running about a minute ago
```

```sh
# scale the service to 3
docker service scale amazing_easley=3

amazing_easley scaled to 3
overall progress: 3 out of 3 tasks
1/3: running   [==================================================>]
2/3: running   [==================================================>]
3/3: running   [==================================================>]
verify: Service converged
```