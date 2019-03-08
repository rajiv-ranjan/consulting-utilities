### CPU of all the servers used

```sh
ansible -i /home/quicklab/c1-ocp/hosts --key-file=/home/quicklab/c1-ocp/quicklab.key OSEv3 -a 'lscpu' | egrep  'node-|CPU\(s\):'
node-0.rajranjaapps.lab.pnq2.cee.redhat.com | SUCCESS | rc=0 >>
CPU(s):                4
NUMA node0 CPU(s):     0-3
node-1.rajranjamaster.lab.pnq2.cee.redhat.com | SUCCESS | rc=0 >>
CPU(s):                4
NUMA node0 CPU(s):     0-3
node-0.rajranjamaster.lab.pnq2.cee.redhat.com | SUCCESS | rc=0 >>
CPU(s):                4
NUMA node0 CPU(s):     0-3
node-2.rajranjamaster.lab.pnq2.cee.redhat.com | SUCCESS | rc=0 >>
CPU(s):                4
NUMA node0 CPU(s):     0-3
node-1.rajranjaapps.lab.pnq2.cee.redhat.com | SUCCESS | rc=0 >>
CPU(s):                4
NUMA node0 CPU(s):     0-3
node-0.rajranjainfra.lab.pnq2.cee.redhat.com | SUCCESS | rc=0 >>
CPU(s):                4
NUMA node0 CPU(s):     0-3
node-1.rajranjalb.lab.pnq2.cee.redhat.com | SUCCESS | rc=0 >>
CPU(s):                1
NUMA node0 CPU(s):     0
node-0.rajranjalb.lab.pnq2.cee.redhat.com | SUCCESS | rc=0 >>
CPU(s):                1
NUMA node0 CPU(s):     0
node-1.rajranjainfra.lab.pnq2.cee.redhat.com | SUCCESS | rc=0 >>
CPU(s):                4
NUMA node0 CPU(s):     0-3
node-2.rajranjainfra.lab.pnq2.cee.redhat.com | SUCCESS | rc=0 >>
CPU(s):                4
NUMA node0 CPU(s):     0-3
node-0.rajranjanfs.lab.pnq2.cee.redhat.com | SUCCESS | rc=0 >>
CPU(s):                2
NUMA node0 CPU(s):     0,1
```

### Disc & File system information

```sh
ansible -i /home/quicklab/c1-ocp/hosts --key-file=/home/quicklab/c1-ocp/quicklab.key OSEv3 -a 'df -h'
node-1.rajranjalb.lab.pnq2.cee.redhat.com | SUCCESS | rc=0 >>
Filesystem      Size  Used Avail Use% Mounted on
/dev/vda1        20G  2.1G   18G  11% /
devtmpfs        897M     0  897M   0% /dev
tmpfs           920M     0  920M   0% /dev/shm
tmpfs           920M   17M  903M   2% /run
tmpfs           920M     0  920M   0% /sys/fs/cgroup
tmpfs           184M     0  184M   0% /run/user/1000

node-1.rajranjamaster.lab.pnq2.cee.redhat.com | SUCCESS | rc=0 >>
Filesystem      Size  Used Avail Use% Mounted on
/dev/vda1        80G   23G   58G  29% /
devtmpfs        3.8G     0  3.8G   0% /dev
tmpfs           3.9G     0  3.9G   0% /dev/shm
tmpfs           3.9G  2.9M  3.9G   1% /run
tmpfs           3.9G     0  3.9G   0% /sys/fs/cgroup
/dev/dm-6        10G  270M  9.8G   3% /var/lib/docker/devicemapper/mnt/7f4b20be5cfb969400996753578450a7c464f859455f4ad4dc573b8fd41d2832
shm              64M     0   64M   0% /var/lib/docker/containers/eb0dfdfc22851d280cce6c7c6d64a109d2cbe08835c52e738ab1d10e43e46029/shm
tmpfs           3.9G   24K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/366cb727-fc89-11e8-b3ee-fa163e6bb7d1/volumes/kubernetes.io~secret/service-catalog-apiserver-token-jxm8x
tmpfs           3.9G  8.0K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/366cb727-fc89-11e8-b3ee-fa163e6bb7d1/volumes/kubernetes.io~secret/apiserver-ssl
tmpfs           3.9G   24K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/6539763c-fc89-11e8-b3ee-fa163e6bb7d1/volumes/kubernetes.io~secret/apiserver-token-swk5p
tmpfs           3.9G   24K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/4d281149-fc86-11e8-b3ee-fa163e6bb7d1/volumes/kubernetes.io~secret/sync-token-974k4
tmpfs           3.9G   24K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/3ad6ce50-fc89-11e8-b3ee-fa163e6bb7d1/volumes/kubernetes.io~secret/service-catalog-controller-token-k52fj
/dev/dm-7        10G  270M  9.8G   3% /var/lib/docker/devicemapper/mnt/bac65a9c9932455675bba564e1c1d1a3967ba103d951c7996ab865335b3886e2
shm              64M     0   64M   0% /var/lib/docker/containers/95b9598902b19c255905e90a7c7ec0325329445a7305022402014a3513727e15/shm
tmpfs           3.9G  8.0K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/6539763c-fc89-11e8-b3ee-fa163e6bb7d1/volumes/kubernetes.io~secret/serving-cert
tmpfs           3.9G   24K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/6361e705-fc86-11e8-b3ee-fa163e6bb7d1/volumes/kubernetes.io~secret/sdn-token-mfqjf
tmpfs           3.9G  8.0K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/3ad6ce50-fc89-11e8-b3ee-fa163e6bb7d1/volumes/kubernetes.io~secret/service-catalog-ssl
tmpfs           3.9G   24K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/63df2f47-fc86-11e8-b3ee-fa163e6bb7d1/volumes/kubernetes.io~secret/sdn-token-mfqjf
/dev/dm-9        10G  270M  9.8G   3% /var/lib/docker/devicemapper/mnt/856496e2ae88537a95356a959304509164fe0c3b2c64bce8069b51e768512d37
shm              64M     0   64M   0% /var/lib/docker/containers/2cffe099c30c68047c649459c6a0591958f6906ed0774122cecb2aaf1c647103/shm
/dev/dm-11       10G  270M  9.8G   3% /var/lib/docker/devicemapper/mnt/9eb83ad4fb40622540ef7db4fb6bf8b0ecf0321f970dac71fb3c48d1847617fb
shm              64M     0   64M   0% /var/lib/docker/containers/a676cf17cc0eb139ca12c633d3a0ec42341f988373e5b35dc62700085bfb7657/shm
/dev/dm-10       10G  1.2G  8.9G  12% /var/lib/docker/devicemapper/mnt/b49988708549107a656f7196f0e357f9ebe78f348a1821319821b501bdc19a45
/dev/dm-12       10G  1.2G  8.9G  12% /var/lib/docker/devicemapper/mnt/1b36f66f0f9947748eb8f92f03599a00f61c3ce7b7ab6f02b4f6406630958523
/dev/dm-16       10G  270M  9.8G   3% /var/lib/docker/devicemapper/mnt/ada6706e079e45fc8f567f7491b9c2af216b3152602bbee0646a40fb47384b8f
shm              64M     0   64M   0% /var/lib/docker/containers/3c592fc790d36606cbff60e8de81cb0f14c04b11f8bab86e53fc3db312ec010b/shm
/dev/dm-15       10G  270M  9.8G   3% /var/lib/docker/devicemapper/mnt/5003978c779a460cfcd8332297ea239b8815562926ea8ea042b2f5f39fc469ee
shm              64M     0   64M   0% /var/lib/docker/containers/72660a987a95d86f6c41260c9c961a3ca545daad4ffd0225deebe447bd79917e/shm
/dev/dm-19       10G  270M  9.8G   3% /var/lib/docker/devicemapper/mnt/b6494dd89b62012bf593677f32a53e78b292119e0c9aba57a7626bcd21e9907d
shm              64M     0   64M   0% /var/lib/docker/containers/f388552aa51f766e923222fcea99fa236aaa306fcd2f03580fb262a3e1325374/shm
/dev/dm-17       10G  341M  9.7G   4% /var/lib/docker/devicemapper/mnt/b3c486b5829a9d8cebf9750d1fd3aa08d1d15c172a588a5293c52bf58c767e76
/dev/dm-18       10G  1.2G  8.9G  12% /var/lib/docker/devicemapper/mnt/a2f04f5cc715a8a51caf9ec901d70e3a09948f7bac97e506ab5236fa21a098fe
/dev/dm-4        10G  270M  9.8G   3% /var/lib/docker/devicemapper/mnt/f6306e2fd97d62a8c3f5b78e070e60bee396750628d18fa524211eec7091f071
shm              64M     0   64M   0% /var/lib/docker/containers/09841d33c9f54767b41a2d6db017465b0586f15dfe36f811913eb49098458752/shm
/dev/dm-3        10G  270M  9.8G   3% /var/lib/docker/devicemapper/mnt/1f5d807a880985a1833494b37e6bdaf199ef9db0d8d5775398949b46290c394f
shm              64M     0   64M   0% /var/lib/docker/containers/e30a628434b6ee49c8301cd6c7e74e3dbb94037c47ed52686d12d87a9d67080d/shm
/dev/dm-8        10G  810M  9.2G   8% /var/lib/docker/devicemapper/mnt/ca4907b4be2945de50137f7bc0d70b6eec546a562db9831a22c8551d09496bbc
/dev/dm-5        10G  301M  9.7G   3% /var/lib/docker/devicemapper/mnt/5b97fe5bea21d2469cc4e5e0885a4985d109a75b5e3e99833cb35799f2d5c70c
/dev/dm-14       10G  810M  9.2G   8% /var/lib/docker/devicemapper/mnt/63c76bf22f5ad7dc970419ebdf3ab811518cfca6bfd24419ef8d850a1dd1d41b
/dev/dm-13       10G  338M  9.7G   4% /var/lib/docker/devicemapper/mnt/8e7181a552fda69e81048910a28b26eb8a05c2c1a17435527cf5a5d0eac1e55c
/dev/dm-20       10G  338M  9.7G   4% /var/lib/docker/devicemapper/mnt/cd653bfb9a4b37e2f17393014ba412d029875f26319057083fd524b6b0c951cd
tmpfs           783M     0  783M   0% /run/user/1000

node-0.rajranjaapps.lab.pnq2.cee.redhat.com | SUCCESS | rc=0 >>
Filesystem      Size  Used Avail Use% Mounted on
/dev/vda1        80G   23G   58G  28% /
devtmpfs        3.8G     0  3.8G   0% /dev
tmpfs           3.9G     0  3.9G   0% /dev/shm
tmpfs           3.9G  2.8M  3.9G   1% /run
tmpfs           3.9G     0  3.9G   0% /sys/fs/cgroup
tmpfs           3.9G   24K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/881c8dd3-fc88-11e8-b3ee-fa163e6bb7d1/volumes/kubernetes.io~secret/sdn-token-mfqjf
tmpfs           3.9G   24K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/3d7bd35c-02d5-11e9-9624-fa163e6bb7d1/volumes/kubernetes.io~secret/default-token-xtq9g
tmpfs           3.9G   24K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/8837a3af-fc88-11e8-b3ee-fa163e6bb7d1/volumes/kubernetes.io~secret/sdn-token-mfqjf
tmpfs           3.9G   24K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/366936ca-1713-11e9-a272-fa163e4feb58/volumes/kubernetes.io~secret/default-token-dz8w7
tmpfs           3.9G   24K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/40266afb-1733-11e9-a272-fa163e4feb58/volumes/kubernetes.io~secret/jenkins-token-6zjwh
tmpfs           3.9G   24K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/08317ebe-170f-11e9-a272-fa163e4feb58/volumes/kubernetes.io~secret/jenkins-token-9z9n8
tmpfs           3.9G   24K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/881c7a4f-fc88-11e8-b3ee-fa163e6bb7d1/volumes/kubernetes.io~secret/sync-token-974k4
tmpfs           3.9G   24K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/6a8206e1-1761-11e9-a272-fa163e4feb58/volumes/kubernetes.io~secret/default-token-qx98s
tmpfs           3.9G   24K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/c837c1c9-1e6a-11e9-8ffc-fa163e4feb58/volumes/kubernetes.io~secret/default-token-sv9xd
/dev/dm-3        10G  270M  9.8G   3% /var/lib/docker/devicemapper/mnt/bf2e79d6d2de04120924d114ae7c1c7e8c519c00088e62bc16555bf7d39046e8
/dev/dm-5        10G  270M  9.8G   3% /var/lib/docker/devicemapper/mnt/b1ef04e8c53655379b0f77edcaa876914e46dec11b35f915b16e4034b5da1361
shm              64M     0   64M   0% /var/lib/docker/containers/cf5158983dcac21c62850865d8f9ce6e4c411e351b64ca6b2e749629b6e22774/shm
/dev/dm-6        10G  270M  9.8G   3% /var/lib/docker/devicemapper/mnt/b3f1f25ff40327c308850f812ff0f56a4df17a836c57b111b8466558161e7006
shm              64M     0   64M   0% /var/lib/docker/containers/b80d82a48ceb7c4e30781cf44be53615a937862c29bdab3bdcc83d5267fe635f/shm
shm              64M     0   64M   0% /var/lib/docker/containers/18e30c83bfca3029b6a1b9e112679f1af9ae5976cb10ca17c42dbbad8ac59f5f/shm
/dev/dm-7        10G  1.2G  8.9G  12% /var/lib/docker/devicemapper/mnt/9bafc0c6b9dc17eaf1fb407705d4983d15a7aa785b39f8b24c685ee98e16fc71
/dev/dm-4        10G  1.2G  8.9G  12% /var/lib/docker/devicemapper/mnt/ae3309b62b6a93895ad865d7f2a55103eb0d8bb2b2c1a9cdc563844df0fd1476
/dev/dm-9        10G  1.2G  8.9G  12% /var/lib/docker/devicemapper/mnt/c8e183851f05195f5613ab9f4c3af6e71249a13f2c29fa9005b9c2caa46aacda
/dev/dm-8        10G  270M  9.8G   3% /var/lib/docker/devicemapper/mnt/cc399ca705508625d055426324d206a30cdfe17d11c914f24ca07aea658d6bf4
shm              64M     0   64M   0% /var/lib/docker/containers/e9beb40978c0e52cfffc878e9c0ae10e520c8d4d7cd55a043fecea2975719153/shm
/dev/dm-10       10G  270M  9.8G   3% /var/lib/docker/devicemapper/mnt/b7c982456e69b0cc68da13633775ab1cfb7f8cb9ae529f13067ae62251dd7f41
shm              64M     0   64M   0% /var/lib/docker/containers/dfdf61d09db9fd126593ea70941fff08e185d8280c07cd07bd68e03542fe0101/shm
/dev/dm-12       10G  270M  9.8G   3% /var/lib/docker/devicemapper/mnt/073ae36650ee9aaf2db3d67ed619d29fd305945b0fa248b435bf7ad5e31350e4
shm              64M     0   64M   0% /var/lib/docker/containers/3f959ac5cf93705c0f86f55addb9502948dea4eb3dc8dc16d6df56e3f23e054b/shm
/dev/dm-11       10G  270M  9.8G   3% /var/lib/docker/devicemapper/mnt/527be3fc3b6144a89db8ce6c2925c4fe12f1ed5a1a08224f080e0857590ac03c
shm              64M     0   64M   0% /var/lib/docker/containers/c04e055df94a581cf97fe2a4c41b7b0bd1d314d390326274e0c91b1e5abf5514/shm
/dev/dm-13       10G  270M  9.8G   3% /var/lib/docker/devicemapper/mnt/568c16c107db8e4a8632f9c24f6238e69bdf1880a44c9f82ebec3cde47a418b1
shm              64M     0   64M   0% /var/lib/docker/containers/93bda27b0d9b59248051c5ffe3217a0ecf143729d3bcbd323d45e1bb31ca8f15/shm
/dev/dm-15       10G  270M  9.8G   3% /var/lib/docker/devicemapper/mnt/13c77014b50581b66ccef3e1a42ffcb2f8ac2e583a80bccce6b8e0e29f746b45
shm              64M     0   64M   0% /var/lib/docker/containers/7d2a6cd63105d7757ed15f64dadfbb60e3afb02b7f84367e6c40624971cd2818/shm
/dev/dm-14       10G  1.4G  8.7G  14% /var/lib/docker/devicemapper/mnt/9b1f1f316f20d3794d2008f52c6d28887ee908cc8e97df115bc70c1f33b5a83c
/dev/dm-16       10G  899M  9.2G   9% /var/lib/docker/devicemapper/mnt/d6d6e1cd3c7986ffa3c855de89e718f262bc448a7619be561238b11ec948a400
/dev/dm-18       10G  1.4G  8.7G  14% /var/lib/docker/devicemapper/mnt/98fbbd33dc311f06b12e422c67caab38683937fbecc4a93e018b289a281cbb36
/dev/dm-17       10G  899M  9.2G   9% /var/lib/docker/devicemapper/mnt/9d768b97e339a22e6b6333e5b72933ebafe517ce215665763085a715181c1e06
tmpfs           3.9G   24K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/346a1212-3b4e-11e9-93a2-fa163e4feb58/volumes/kubernetes.io~secret/default-token-g94g9
tmpfs           3.9G  4.0K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/346a1212-3b4e-11e9-93a2-fa163e4feb58/volumes/kubernetes.io~secret/eap-jgroups-keystore-volume
tmpfs           3.9G   12K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/346a1212-3b4e-11e9-93a2-fa163e4feb58/volumes/kubernetes.io~secret/eap-keystore-volume
tmpfs           3.9G   12K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/346a1212-3b4e-11e9-93a2-fa163e4feb58/volumes/kubernetes.io~secret/sso-truststore-volume
/dev/dm-21       10G  270M  9.8G   3% /var/lib/docker/devicemapper/mnt/e876a68c622a7f296be21c0cf985f6bb50ab03cd8531c193c7e8f9dcbc18794b
shm              64M     0   64M   0% /var/lib/docker/containers/8ea67a58a49f9160af1a7e21e455280bc10f03d8df5f620e8a60e6094db7ba69/shm
/dev/dm-22       10G  810M  9.2G   8% /var/lib/docker/devicemapper/mnt/25cef72fac203737fa15b236f246f1b8859528095b1de00d83b50532afd71ece
tmpfs           783M     0  783M   0% /run/user/1000

node-0.rajranjamaster.lab.pnq2.cee.redhat.com | SUCCESS | rc=0 >>
Filesystem      Size  Used Avail Use% Mounted on
/dev/vda1        80G   30G   51G  38% /
devtmpfs        3.8G     0  3.8G   0% /dev
tmpfs           3.9G     0  3.9G   0% /dev/shm
tmpfs           3.9G  3.7M  3.9G   1% /run
tmpfs           3.9G     0  3.9G   0% /sys/fs/cgroup
/dev/dm-3        10G  270M  9.8G   3% /var/lib/docker/devicemapper/mnt/9dc4b3df36f9f49c8cb8887d5117f105f5243719422d14c74bb934552995b985
shm              64M     0   64M   0% /var/lib/docker/containers/90b6209983b25747be6e11f44f6bfe6dd8bbb294cae8756df87b4cadcbf77b4b/shm
tmpfs           3.9G  8.0K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/6539f96c-fc89-11e8-b3ee-fa163e6bb7d1/volumes/kubernetes.io~secret/serving-cert
tmpfs           3.9G   24K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/63592e65-fc86-11e8-b3ee-fa163e6bb7d1/volumes/kubernetes.io~secret/sdn-token-mfqjf
tmpfs           3.9G  8.0K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/1031673f-18fe-11e9-b604-fa163e3bfc06/volumes/kubernetes.io~secret/serving-cert
tmpfs           3.9G   24K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/6539f96c-fc89-11e8-b3ee-fa163e6bb7d1/volumes/kubernetes.io~secret/apiserver-token-swk5p
tmpfs           3.9G   24K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/1031673f-18fe-11e9-b604-fa163e3bfc06/volumes/kubernetes.io~secret/webconsole-token-f8j4n
tmpfs           3.9G   24K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/3acf72d3-fc89-11e8-b3ee-fa163e6bb7d1/volumes/kubernetes.io~secret/service-catalog-controller-token-k52fj
tmpfs           3.9G   24K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/63e78578-fc86-11e8-b3ee-fa163e6bb7d1/volumes/kubernetes.io~secret/sdn-token-mfqjf
tmpfs           3.9G  8.0K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/36686dfa-fc89-11e8-b3ee-fa163e6bb7d1/volumes/kubernetes.io~secret/apiserver-ssl
tmpfs           3.9G  8.0K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/3acf72d3-fc89-11e8-b3ee-fa163e6bb7d1/volumes/kubernetes.io~secret/service-catalog-ssl
tmpfs           3.9G   24K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/4d2528be-fc86-11e8-b3ee-fa163e6bb7d1/volumes/kubernetes.io~secret/sync-token-974k4
tmpfs           3.9G   24K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/36686dfa-fc89-11e8-b3ee-fa163e6bb7d1/volumes/kubernetes.io~secret/service-catalog-apiserver-token-jxm8x
/dev/dm-9        10G  270M  9.8G   3% /var/lib/docker/devicemapper/mnt/5653933765e9d8b29975e879b70d9ec0a353fb84aeb0dd8c41bca0fec53c2202
shm              64M     0   64M   0% /var/lib/docker/containers/d04b41e3c8c34b19f31288810ff6dd03d35e45355290093e227cd46d2c4b7566/shm
/dev/dm-12       10G  270M  9.8G   3% /var/lib/docker/devicemapper/mnt/07c78102a0808f27759ec39e10f72eeba44ed374751d226887cb892daecdc703
/dev/dm-14       10G  270M  9.8G   3% /var/lib/docker/devicemapper/mnt/a7c3493bb180ffafad5520dd584dab228fda03122bbcf3d4af10cad12aa3fd26
shm              64M     0   64M   0% /var/lib/docker/containers/e2f37826c7ec7f1e055c1220a3e3794e9bd2bddec7e4e42a10215ebc02b47a1c/shm
shm              64M     0   64M   0% /var/lib/docker/containers/210b384f1439311b061971fcdc50891b6e399681ac9938336d546865d4d6c323/shm
tmpfs           3.9G   24K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/1c426098-18fe-11e9-b604-fa163e3bfc06/volumes/kubernetes.io~secret/default-token-fjwh6
tmpfs           3.9G  4.0K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/11d1915c-2113-11e9-98ef-fa163e4feb58/volumes/kubernetes.io~secret/oauth-config
tmpfs           3.9G  8.0K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/11d1915c-2113-11e9-98ef-fa163e4feb58/volumes/kubernetes.io~secret/serving-cert
tmpfs           3.9G  8.0K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/1c426098-18fe-11e9-b604-fa163e3bfc06/volumes/kubernetes.io~secret/serving-cert
tmpfs           3.9G   24K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/9b9e23df-211b-11e9-a589-fa163e4feb58/volumes/kubernetes.io~secret/olm-operator-serviceaccount-token-d8cng
tmpfs           3.9G  4.0K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/1c426098-18fe-11e9-b604-fa163e3bfc06/volumes/kubernetes.io~secret/oauth-config
tmpfs           3.9G   24K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/11d1915c-2113-11e9-98ef-fa163e4feb58/volumes/kubernetes.io~secret/default-token-fjwh6
/dev/dm-13       10G  1.2G  8.9G  12% /var/lib/docker/devicemapper/mnt/653b80e35f5e255329f6215efcae787262c87d1110f588ee6c862a3c33c2770f
/dev/dm-10       10G  1.2G  8.9G  12% /var/lib/docker/devicemapper/mnt/1ddbfd82357157f5be0dddb8d0cc68eb6e8736c6ff92f0e8927b39afd8d8485d
/dev/dm-7        10G  270M  9.8G   3% /var/lib/docker/devicemapper/mnt/06026a4f97443bf97dabeb5c2eb199ff47215a58de6617cfbe401b3ab53401b5
shm              64M     0   64M   0% /var/lib/docker/containers/64a185584dff8a4d4327875529a44a539afe4cc8fd894758c86540bba70dcd30/shm
/dev/dm-17       10G  297M  9.8G   3% /var/lib/docker/devicemapper/mnt/786c32af923c26bdd086b89407c67f0aa7783be4ff5745352b9e72633fe7ebcd
/dev/dm-16       10G  270M  9.8G   3% /var/lib/docker/devicemapper/mnt/a9da97064c3073c3cf733c14cff853a16a765d77f8cef295b4c01608957e33c9
shm              64M     0   64M   0% /var/lib/docker/containers/929a232955270e6228310a48e88e803693191922e54a091b1bcb4a2b95b15032/shm
/dev/dm-18       10G  270M  9.8G   3% /var/lib/docker/devicemapper/mnt/bd527ab3e241d18948d057e4fd0c0416408d1e72428625ace70745d970828d75
shm              64M     0   64M   0% /var/lib/docker/containers/f61dd12116b6be3cb8853061c852c91b6b22f5d9b0ce5e1b66b8c3a8e89ef231/shm
/dev/dm-19       10G  270M  9.8G   3% /var/lib/docker/devicemapper/mnt/d9b5bfe0b65bb8c4ffe3ead3824b82be73e14a0ff8d50e45c280cea5c389b5b1
shm              64M     0   64M   0% /var/lib/docker/containers/11281c7ca4874e6a1b17b549aad1af3679ce27637036b1369d4489d51aefe250/shm
/dev/dm-20       10G  270M  9.8G   3% /var/lib/docker/devicemapper/mnt/0039136732bffb07d816857da35c995196aff106c36b6e1a01745fa86a68a6bf
shm              64M     0   64M   0% /var/lib/docker/containers/986cccfda2bc8d15de28be792ca4f36d229cadd40ae03736f186f3ea15268b6f/shm
/dev/dm-21       10G  270M  9.8G   3% /var/lib/docker/devicemapper/mnt/bbbfa1f510355355e09e19a1e9136b6a23b5ee22e626fe41fae0480f5d8a852a
shm              64M     0   64M   0% /var/lib/docker/containers/7b5a611c0aec2f02e53823e490ae5453c00436674b2c5e0d534e199baa06920b/shm
/dev/dm-22       10G  270M  9.8G   3% /var/lib/docker/devicemapper/mnt/1d69d61663fb7e4712c3801d465061f98c1d9571623fbe38c275a08950564fc8
shm              64M     0   64M   0% /var/lib/docker/containers/1b64e66c49f5a63eda403dc6b289717decb27c1fdb36d21b727435ebce4aff41/shm
/dev/dm-25       10G  350M  9.7G   4% /var/lib/docker/devicemapper/mnt/633eb4e173bcc5f4aa743054522b88d7db7df02a6ea6a947eb14c7b05f5ae778
/dev/dm-26       10G  297M  9.8G   3% /var/lib/docker/devicemapper/mnt/e0a40a4640e303611d0a5f65940a2226941d2e0f7ba078224bee27f18f1405d3
/dev/dm-27       10G  332M  9.7G   4% /var/lib/docker/devicemapper/mnt/4c4554a008d4d0873b885877669bc7f26632e1d0fe110ccb28b617eb95228658
/dev/dm-23       10G  341M  9.7G   4% /var/lib/docker/devicemapper/mnt/a281ee203546c22c6251bb5e1a798cff71d23e1428ff712b0966ca64d14d8036
/dev/dm-4        10G  270M  9.8G   3% /var/lib/docker/devicemapper/mnt/ca0afd0e303e8cc7b3d6f83eb0c2d0626d8d1d3d25410bdbbd61cc0b371e3b69
shm              64M     0   64M   0% /var/lib/docker/containers/a3e6d7871e80b95ddde1c39c32509d3e815256336e6b1130b9cc74ebc3e0a80d/shm
/dev/dm-5        10G  270M  9.8G   3% /var/lib/docker/devicemapper/mnt/b46f5dd08fe31ad903260cb1e89e2898ac820a207447834baeae33cb5e4b96fa
shm              64M     0   64M   0% /var/lib/docker/containers/4f2e049b44d7ae684ed5dd363727a72123b38d639931d066f2948acd5b2cc412/shm
/dev/dm-15       10G  1.2G  8.9G  12% /var/lib/docker/devicemapper/mnt/e267fe078f00d2f9ac157d4c0cbf3b946eabac45900fcb7dc002d14827503b46
/dev/dm-6        10G  810M  9.2G   8% /var/lib/docker/devicemapper/mnt/d1c34139aef10fd825ecd462770f602dc8c186b617513cd8c7464c326ffd267c
/dev/dm-24       10G  301M  9.7G   3% /var/lib/docker/devicemapper/mnt/d92cbee0497f6942945e4dd96a18c900407b8d61b1d8bbc8b6d5cec240d81abb
/dev/dm-8        10G  338M  9.7G   4% /var/lib/docker/devicemapper/mnt/9ea4cd490754e5761f01a3d6def5cdd7e1d0fd97fd7c97c7df95592055311c25
/dev/dm-28       10G  810M  9.2G   8% /var/lib/docker/devicemapper/mnt/8d87668c8cdf06fd66780b2aaec0366f78d80d80c62afea9528fb184414d0525
/dev/dm-11       10G  338M  9.7G   4% /var/lib/docker/devicemapper/mnt/41c2efac061490e530ac2bb879e9b3e4b94a3c1380695dae9602c4cccf68937b
tmpfs           783M     0  783M   0% /run/user/1000

node-2.rajranjamaster.lab.pnq2.cee.redhat.com | SUCCESS | rc=0 >>
Filesystem      Size  Used Avail Use% Mounted on
/dev/vda1        80G   33G   48G  42% /
devtmpfs        3.8G     0  3.8G   0% /dev
tmpfs           3.9G     0  3.9G   0% /dev/shm
tmpfs           3.9G  3.7M  3.9G   1% /run
tmpfs           3.9G     0  3.9G   0% /sys/fs/cgroup
/dev/dm-7        10G  270M  9.8G   3% /var/lib/docker/devicemapper/mnt/87c68eccff864b9d2060fb5aeceb41b864e9fb58a5e89ac830b82dda25a20403
shm              64M     0   64M   0% /var/lib/docker/containers/c6eb4432030478723804804aa4dfb32413e3744116a75b0905b577b074bb811f/shm
tmpfs           3.9G  4.0K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/1c653878-18fe-11e9-b604-fa163e3bfc06/volumes/kubernetes.io~secret/oauth-config
tmpfs           3.9G   24K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/11aa1ffc-2113-11e9-98ef-fa163e4feb58/volumes/kubernetes.io~secret/default-token-sspwn
tmpfs           3.9G   24K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/1c653878-18fe-11e9-b604-fa163e3bfc06/volumes/kubernetes.io~secret/default-token-fjwh6
tmpfs           3.9G   24K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/11e53e8d-2113-11e9-98ef-fa163e4feb58/volumes/kubernetes.io~secret/webconsole-token-f8j4n
tmpfs           3.9G  8.0K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/11e53e8d-2113-11e9-98ef-fa163e4feb58/volumes/kubernetes.io~secret/serving-cert
tmpfs           3.9G  8.0K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/0ee146af-18ef-11e9-ad15-fa163e4feb58/volumes/kubernetes.io~secret/apiserver-ssl
tmpfs           3.9G   24K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/0f535deb-18ef-11e9-ad15-fa163e4feb58/volumes/kubernetes.io~secret/service-catalog-controller-token-k52fj
tmpfs           3.9G   24K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/dd2efbd2-18ee-11e9-ad15-fa163e4feb58/volumes/kubernetes.io~secret/sdn-token-mfqjf
tmpfs           3.9G  8.0K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/0f8c3668-18ef-11e9-ad15-fa163e4feb58/volumes/kubernetes.io~secret/serving-cert
tmpfs           3.9G   24K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/0ee146af-18ef-11e9-ad15-fa163e4feb58/volumes/kubernetes.io~secret/service-catalog-apiserver-token-jxm8x
tmpfs           3.9G   24K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/0f8c3668-18ef-11e9-ad15-fa163e4feb58/volumes/kubernetes.io~secret/apiserver-token-swk5p
tmpfs           3.9G   24K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/101acf8c-18fe-11e9-b604-fa163e3bfc06/volumes/kubernetes.io~secret/webconsole-token-f8j4n
tmpfs           3.9G  8.0K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/101acf8c-18fe-11e9-b604-fa163e3bfc06/volumes/kubernetes.io~secret/serving-cert
tmpfs           3.9G   24K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/dcffadab-18ee-11e9-ad15-fa163e4feb58/volumes/kubernetes.io~secret/sdn-token-mfqjf
tmpfs           3.9G  8.0K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/1c653878-18fe-11e9-b604-fa163e3bfc06/volumes/kubernetes.io~secret/serving-cert
tmpfs           3.9G   24K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/dd06036d-18ee-11e9-ad15-fa163e4feb58/volumes/kubernetes.io~secret/sync-token-974k4
tmpfs           3.9G  8.0K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/0f535deb-18ef-11e9-ad15-fa163e4feb58/volumes/kubernetes.io~secret/service-catalog-ssl
/dev/dm-12       10G  270M  9.8G   3% /var/lib/docker/devicemapper/mnt/987eda7a8a8345b512ba6449bb08547a8127c9016d099821e78f59dc850a1561
shm              64M     0   64M   0% /var/lib/docker/containers/6de5fc3ff8c1b9522cc17fab648c4d771d30870acd03c06cf49bb843fc0aa035/shm
/dev/dm-10       10G  270M  9.8G   3% /var/lib/docker/devicemapper/mnt/e3e9b704f596b4d19c777395ee9718008aefa000d84dff29dc5093ab4c505dd0
/dev/dm-11       10G  270M  9.8G   3% /var/lib/docker/devicemapper/mnt/2fd6217c7f76eb8144367ecb289736ebec70d86000dc9133ad09fe6631b9844c
shm              64M     0   64M   0% /var/lib/docker/containers/0c30dfd9febc22522f2ac2c72b7f147b95608fbb23cdb32b37711b588366b11b/shm
shm              64M     0   64M   0% /var/lib/docker/containers/1017fab9d188f1792e9d9d89cad1fc4c2398219d26f7f42de86f737d392eca1b/shm
/dev/dm-14       10G  1.2G  8.9G  12% /var/lib/docker/devicemapper/mnt/e916c386658d4b073ab24aac2bacec30d697b28f54e543d5c234f3c8a0fdc506
/dev/dm-15       10G  1.2G  8.9G  12% /var/lib/docker/devicemapper/mnt/9cce83f42ddc652249aed5aceb2c04edb96455d5cbddd2d6a865ace58eece614
/dev/dm-9        10G  270M  9.8G   3% /var/lib/docker/devicemapper/mnt/16345f5ea3011e3ee2f315f70e851a71bbec3c293bce55f2ba550701e001daa5
shm              64M     0   64M   0% /var/lib/docker/containers/24a49327f608520ab5d1420f60f7bf036801610fdf86bc71867be78780eaf313/shm
/dev/dm-16       10G  270M  9.8G   3% /var/lib/docker/devicemapper/mnt/b603e508db8261b8a2c055efc3a1b1f7089ac59448669bbc4ab206991a4c6c72
shm              64M     0   64M   0% /var/lib/docker/containers/35b994355ffce049b356b5f2444fe148ea5ad0ac52ddd66b987971850912ce4f/shm
/dev/dm-17       10G  270M  9.8G   3% /var/lib/docker/devicemapper/mnt/cd9edabbb219600efb1055bebaa6ebfab3a9512ddcca4c6590c76f3da91d2afc
shm              64M     0   64M   0% /var/lib/docker/containers/077e9634c5a5e06afcd37c6bbb7bd158ebb256a249a31030c78466c18efffd65/shm
/dev/dm-19       10G  270M  9.8G   3% /var/lib/docker/devicemapper/mnt/5cd2b4354907279e7a5c9be004174e36defc2b629cc4f6f84934935946c9416a
shm              64M     0   64M   0% /var/lib/docker/containers/11ebc5049bb0cd1c9769bf8640291c3f157dcfd6c2bb5a57d3362bbe3ee73a44/shm
/dev/dm-18       10G  270M  9.8G   3% /var/lib/docker/devicemapper/mnt/fe93c4532d312a03422b9c2f5dad029b2d63204fbdc652e10e4a69cb5b7fc887
shm              64M     0   64M   0% /var/lib/docker/containers/e8b4c793e53a6e61e9088f2be46ca907553bc99145bd55364ac29af50430c205/shm
/dev/dm-20       10G  270M  9.8G   3% /var/lib/docker/devicemapper/mnt/80acb7d7fa1e728bb261a9bbb37211149ad83896b346c15478c080500aba3cbf
shm              64M     0   64M   0% /var/lib/docker/containers/7a4bfb4e57d52277cda26052e0f0da6ef8bff881b6dda44fcdfe87bd9069fe4e/shm
/dev/dm-21       10G  277M  9.8G   3% /var/lib/docker/devicemapper/mnt/3432e8c9876d8ee988e32941d57f239acc8a1174b480d912f273369ef7fab5e5
/dev/dm-22       10G  350M  9.7G   4% /var/lib/docker/devicemapper/mnt/193a8f263d81227a7af743be391ef01763e2c26701eedcc81f022c02cc388673
/dev/dm-24       10G  270M  9.8G   3% /var/lib/docker/devicemapper/mnt/5509f2fbf70c610ced77c5a9398bd0717231e2ff9202ebf6f0e046ddc9063562
shm              64M     0   64M   0% /var/lib/docker/containers/9a6337e47d244e258f6f9e31997bc12e64f19302efef695dae6d4a521ba1d567/shm
/dev/dm-25       10G  350M  9.7G   4% /var/lib/docker/devicemapper/mnt/21334dd4f586ac6cd9c68fe81068cde33ac920b2ba8464c10b05dcee338cea9d
/dev/dm-26       10G  297M  9.8G   3% /var/lib/docker/devicemapper/mnt/6eb2698e12aaaedeb2339684975e639912f0bee417964b4e9b0befe01e337e7a
/dev/dm-28       10G  341M  9.7G   4% /var/lib/docker/devicemapper/mnt/8e23be07d9c5bf5af4d8248d77d4e4d26fc7aae305b6d0f74fe2f9898f3ac54c
/dev/dm-3        10G  270M  9.8G   3% /var/lib/docker/devicemapper/mnt/aafcecb71d6a7e894e088d12b2a3760efc3ad375d46da5a6177785a1c7b4f0b7
shm              64M     0   64M   0% /var/lib/docker/containers/8d72a87a7dd9364538e94c0340ef245f98d6fbfee26b5e1683b6f03a698dce5f/shm
/dev/dm-4        10G  270M  9.8G   3% /var/lib/docker/devicemapper/mnt/50cc25c6d9882838f2645140a2e47e551f4604bb36f4c880fad695facf33da71
shm              64M     0   64M   0% /var/lib/docker/containers/55badd298c271309d6978b097cb57062a6fcd3c0d8fe5c171ad5360f69ddc211/shm
/dev/dm-8        10G  1.2G  8.9G  12% /var/lib/docker/devicemapper/mnt/bcacecd5214c33ef5a7876d7ceec46b3ad855ab1b3885a0d6b9581299e190a54
/dev/dm-13       10G  810M  9.2G   8% /var/lib/docker/devicemapper/mnt/bc3f397c0a931e0a67c06b5816e31693b2133fdd04901ade6ecf510c76621452
/dev/dm-27       10G  810M  9.2G   8% /var/lib/docker/devicemapper/mnt/5f032cfd5e343b003b8c18bb5e333b9a6d1ab44999e466c2f3f9fb7b9bced7dd
/dev/dm-6        10G  301M  9.7G   3% /var/lib/docker/devicemapper/mnt/43ec762f48e840e7fe4cb5f1d894fb1de9f47d800f33132eca8edfa2479e8e7a
/dev/dm-5        10G  338M  9.7G   4% /var/lib/docker/devicemapper/mnt/a63ccdd373b8eeaa1883d1456682db3084f85cf713e54e4d85b77d50c69cb25f
/dev/dm-23       10G  338M  9.7G   4% /var/lib/docker/devicemapper/mnt/e7b0f27edf7ea8b036e0cb5387495bc19d672643d29541c7e4abc9c0d8f5893a
tmpfs           783M     0  783M   0% /run/user/1000

node-0.rajranjanfs.lab.pnq2.cee.redhat.com | SUCCESS | rc=0 >>
Filesystem      Size  Used Avail Use% Mounted on
/dev/vda1        40G  2.1G   38G   6% /
devtmpfs        1.9G     0  1.9G   0% /dev
tmpfs           1.9G     0  1.9G   0% /dev/shm
tmpfs           1.9G   17M  1.9G   1% /run
tmpfs           1.9G     0  1.9G   0% /sys/fs/cgroup
tmpfs           379M     0  379M   0% /run/user/1000

node-0.rajranjainfra.lab.pnq2.cee.redhat.com | SUCCESS | rc=0 >>
Filesystem                                                           Size  Used Avail Use% Mounted on
/dev/vda1                                                             80G   18G   63G  22% /
devtmpfs                                                             3.8G     0  3.8G   0% /dev
tmpfs                                                                3.9G     0  3.9G   0% /dev/shm
tmpfs                                                                3.9G  1.9M  3.9G   1% /run
tmpfs                                                                3.9G     0  3.9G   0% /sys/fs/cgroup
/dev/vdc1                                                             10G   33M   10G   1% /mnt/local-storage/virtual/metric/disk1
node-0.rajranjabastion.lab.pnq2.cee.redhat.com:/exports/nfs/metrics   40G  2.7G   38G   7% /var/lib/origin/openshift.local.volumes/pods/fcdc4f00-22ef-11e9-a589-fa163e4feb58/volumes/kubernetes.io~nfs/pv0004
tmpfs                                                                3.9G   24K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/88d98c1c-fc88-11e8-b3ee-fa163e6bb7d1/volumes/kubernetes.io~secret/sync-token-974k4
tmpfs                                                                3.9G   24K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/88d543bd-fc88-11e8-b3ee-fa163e6bb7d1/volumes/kubernetes.io~secret/sdn-token-mfqjf
tmpfs                                                                3.9G   24K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/fcdc4f00-22ef-11e9-a589-fa163e4feb58/volumes/kubernetes.io~secret/cassandra-token-fs8rf
tmpfs                                                                3.9G   16K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/fcdc4f00-22ef-11e9-a589-fa163e4feb58/volumes/kubernetes.io~secret/hawkular-cassandra-certs
tmpfs                                                                3.9G   24K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/88ec6ed1-fc88-11e8-b3ee-fa163e6bb7d1/volumes/kubernetes.io~secret/sdn-token-mfqjf
/dev/dm-3                                                             10G  270M  9.8G   3% /var/lib/docker/devicemapper/mnt/8c8dc5b9693f855605566b68f399ea541c49c0a9da6d1dbd76d3271b29f787fc
shm                                                                   64M     0   64M   0% /var/lib/docker/containers/ff1ffc606b80e7198d9e165124f7691cff8604fa4275c9191bf467b30254b91c/shm
/dev/dm-5                                                             10G  270M  9.8G   3% /var/lib/docker/devicemapper/mnt/a7f24b8093cf0fbbb63e9949e5e45c48861019d9c01e4853bcffa7845ed32485
shm                                                                   64M     0   64M   0% /var/lib/docker/containers/0dbe8a4c5f650836155a258700e43a6349c49fe21f5c341bece21929ea89b150/shm
/dev/dm-8                                                             10G  270M  9.8G   3% /var/lib/docker/devicemapper/mnt/8a706e0e43cda9cdb143d0583a972098a293a83827fcf51446a7b6673b84db5f
shm                                                                   64M     0   64M   0% /var/lib/docker/containers/6c2d40ffa863313529e387680d83d77092cf6ff7d399997511c3adbcead8b619/shm
/dev/dm-7                                                             10G  1.2G  8.9G  12% /var/lib/docker/devicemapper/mnt/80283aff8a5d11f3991e44d5b7c5e6440a29d4da028895263fe7e107b2093da6
/dev/dm-4                                                             10G  1.2G  8.9G  12% /var/lib/docker/devicemapper/mnt/557e6d67487aeaab7d58b2cdadc110c00ece88f88662d5d6604cbf5a0bf834c5
tmpfs                                                                3.9G  8.0K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/1798d9a2-2113-11e9-98ef-fa163e4feb58/volumes/kubernetes.io~secret/metrics-server-certificate
tmpfs                                                                3.9G   24K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/1798d9a2-2113-11e9-98ef-fa163e4feb58/volumes/kubernetes.io~secret/router-token-s2g8v
tmpfs                                                                3.9G   12K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/1798d9a2-2113-11e9-98ef-fa163e4feb58/volumes/kubernetes.io~secret/server-certificate
/dev/dm-10                                                            10G  270M  9.8G   3% /var/lib/docker/devicemapper/mnt/c01b32e3c5226ef365e99403d8887ee1a11ee28195f47247bd05278783bba270
shm                                                                   64M     0   64M   0% /var/lib/docker/containers/0e9bdd91b9cf48130f803a16ae0a7074e3f0a68e22d43e567ac7363e4d961474/shm
/dev/dm-11                                                            10G  393M  9.7G   4% /var/lib/docker/devicemapper/mnt/6d785decc2d5bdab9229a96b9493e9ef4c06a716dbe45fc45649bd6eade05b90
/dev/dm-9                                                             10G  270M  9.8G   3% /var/lib/docker/devicemapper/mnt/baca38eea6430358c1f0f158170714eebde47806cbee38160947714dee6ccaf9
shm                                                                   64M     0   64M   0% /var/lib/docker/containers/f2600a589bc5a14d91c869df8e580f34d38f135f00d37f1c239f78d7252bc246/shm
/dev/dm-6                                                             10G  1.2G  8.9G  12% /var/lib/docker/devicemapper/mnt/e4188278a433325e518ec69588e15a53873b04fb0e33e33b065d0965aa9cb88a
tmpfs                                                                783M     0  783M   0% /run/user/1000

node-1.rajranjainfra.lab.pnq2.cee.redhat.com | SUCCESS | rc=0 >>
Filesystem                                                    Size  Used Avail Use% Mounted on
/dev/vda1                                                      80G   26G   55G  32% /
devtmpfs                                                      3.8G     0  3.8G   0% /dev
tmpfs                                                         3.9G     0  3.9G   0% /dev/shm
tmpfs                                                         3.9G  2.4M  3.9G   1% /run
tmpfs                                                         3.9G     0  3.9G   0% /sys/fs/cgroup
/dev/vdd1                                                      10G   33M   10G   1% /mnt/local-storage/virtual/metric/disk1
node-0.rajranjanfs.lab.pnq2.cee.redhat.com:/exports/registry   40G  2.1G   38G   6% /var/lib/origin/openshift.local.volumes/pods/d905fc6b-18ef-11e9-9454-fa163e4feb58/volumes/kubernetes.io~nfs/registry-volume
tmpfs                                                         3.9G   24K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/8889587a-fc88-11e8-b3ee-fa163e6bb7d1/volumes/kubernetes.io~secret/sync-token-974k4
tmpfs                                                         3.9G   24K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/88cbc33e-fc88-11e8-b3ee-fa163e6bb7d1/volumes/kubernetes.io~secret/sdn-token-mfqjf
tmpfs                                                         3.9G   24K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/88cdf532-fc88-11e8-b3ee-fa163e6bb7d1/volumes/kubernetes.io~secret/sdn-token-mfqjf
tmpfs                                                         3.9G   12K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/6198caa3-11d8-11e9-a272-fa163e4feb58/volumes/kubernetes.io~secret/hawkular-metrics-account
tmpfs                                                         3.9G   16K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/6198caa3-11d8-11e9-a272-fa163e4feb58/volumes/kubernetes.io~secret/hawkular-metrics-certs
tmpfs                                                         3.9G   24K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/6198caa3-11d8-11e9-a272-fa163e4feb58/volumes/kubernetes.io~secret/hawkular-token-fxg9s
tmpfs                                                         3.9G   12K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/17c061a8-2113-11e9-98ef-fa163e4feb58/volumes/kubernetes.io~secret/hawkular-metrics-account
tmpfs                                                         3.9G   16K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/17c061a8-2113-11e9-98ef-fa163e4feb58/volumes/kubernetes.io~secret/hawkular-metrics-certs
/dev/dm-3                                                      10G  270M  9.8G   3% /var/lib/docker/devicemapper/mnt/c4bef2b0c18ef0146aa672b47152965a04467ece592ef49734b7f7b3d3246797
shm                                                            64M     0   64M   0% /var/lib/docker/containers/0034082c0b5cda2374fb4a998ee31151ef610cc1769c593ae7bcbbe788777062/shm
/dev/dm-4                                                      10G  270M  9.8G   3% /var/lib/docker/devicemapper/mnt/63b6de02e915cfd366575d36438eafde304da7d3a8439fc00e1b35c064f769ad
/dev/dm-5                                                      10G  270M  9.8G   3% /var/lib/docker/devicemapper/mnt/01819db652e37e4e2d15c9ab75dab3e1524997a3357c49ea9b25356723849c73
shm                                                            64M     0   64M   0% /var/lib/docker/containers/8235a88090c2a2468a891cb5cf9c126d4fdb36a0071d977c7bb345ac9531e207/shm
shm                                                            64M     0   64M   0% /var/lib/docker/containers/cd759bcf5ef6df61a44a7724f7e6be1b51137e2c79b57b18af8c568eb556fc66/shm
/dev/dm-6                                                      10G  1.2G  8.9G  12% /var/lib/docker/devicemapper/mnt/2883eef7e67037bbcbc8c9fcf109a3af3df914f89cace1623fe41a08c3f96a71
/dev/dm-8                                                      10G  1.2G  8.9G  12% /var/lib/docker/devicemapper/mnt/a7a25a8e8bfbcb0ce152edede62b1e8cd8dabdc7f9285a407e11e03467a4fb1b
/dev/dm-9                                                      10G  270M  9.8G   3% /var/lib/docker/devicemapper/mnt/5661c8cd32e57888c21ac37b2f4664a65a36add98f0dfbc25cef569d14121a80
shm                                                            64M     0   64M   0% /var/lib/docker/containers/e3bb2cfce78d05200df19c0c8a473e26206545b63936721158da64c43794fc3c/shm
tmpfs                                                         3.9G   24K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/d905fc6b-18ef-11e9-9454-fa163e4feb58/volumes/kubernetes.io~secret/registry-token-lspc7
tmpfs                                                         3.9G   24K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/f083f295-18f3-11e9-87e5-fa163e4feb58/volumes/kubernetes.io~secret/router-token-s2g8v
tmpfs                                                         3.9G  8.0K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/f083f295-18f3-11e9-87e5-fa163e4feb58/volumes/kubernetes.io~secret/metrics-server-certificate
tmpfs                                                         3.9G   24K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/17c061a8-2113-11e9-98ef-fa163e4feb58/volumes/kubernetes.io~secret/heapster-token-hjn59
tmpfs                                                         3.9G  8.0K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/d905fc6b-18ef-11e9-9454-fa163e4feb58/volumes/kubernetes.io~secret/registry-certificates
tmpfs                                                         3.9G   12K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/f083f295-18f3-11e9-87e5-fa163e4feb58/volumes/kubernetes.io~secret/server-certificate
tmpfs                                                         3.9G  4.0K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/17c061a8-2113-11e9-98ef-fa163e4feb58/volumes/kubernetes.io~secret/heapster-secrets
tmpfs                                                         3.9G  8.0K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/17c061a8-2113-11e9-98ef-fa163e4feb58/volumes/kubernetes.io~secret/heapster-certs
/dev/dm-11                                                     10G  270M  9.8G   3% /var/lib/docker/devicemapper/mnt/9ced12b7ade942fdff3ab9218fa4140ace2f070b7a7669b568e21b85b9b32a51
shm                                                            64M     0   64M   0% /var/lib/docker/containers/7f95a5222184052962df986c549d7a6f90849cfb14c1292fe6a249aeee593573/shm
/dev/dm-12                                                     10G  270M  9.8G   3% /var/lib/docker/devicemapper/mnt/62d9303ab840c93fe72a501aacc020d14dce3b6744959cd99c8bfeb0ab72d9e8
shm                                                            64M     0   64M   0% /var/lib/docker/containers/15289d2c91833721f80103db809dbf3959c17e07c56d6a6798d404f25b5a7c30/shm
/dev/dm-14                                                     10G  270M  9.8G   3% /var/lib/docker/devicemapper/mnt/b49336e8c056074a82c87d2b27fba982e9c61376c2818ad38b2e8c27e5a87105
shm                                                            64M     0   64M   0% /var/lib/docker/containers/919b9a931986f77f7a4180137072360b25b1745a63cb0630e9d34ec0c8078132/shm
/dev/dm-13                                                     10G  393M  9.7G   4% /var/lib/docker/devicemapper/mnt/9a9696f3e83139ba86ddedaf189bfa53291dd53268b6ab8aa8cea2bb1febe80b
/dev/dm-16                                                     10G  318M  9.7G   4% /var/lib/docker/devicemapper/mnt/021c3fd13b7d0a636af68fb893c41e9f0a394220c88220ac2fb899cea6e0994a
/dev/dm-7                                                      10G  1.2G  8.9G  12% /var/lib/docker/devicemapper/mnt/e467923c9b5b830005b7a51f6dcc25c263062945ef3e4b6accc251c3e2eaaebe
/dev/dm-10                                                     10G  325M  9.7G   4% /var/lib/docker/devicemapper/mnt/0e794b25de545dc24b9726492896ba6fcce342f6496e3c60f2dc16193d891043
/dev/dm-15                                                     10G  867M  9.2G   9% /var/lib/docker/devicemapper/mnt/d080ccd061c7aded4ba72e87a053d0c615e4cb6db1a80aa73a9e3abb19570b5b
tmpfs                                                         783M     0  783M   0% /run/user/1000

node-2.rajranjainfra.lab.pnq2.cee.redhat.com | SUCCESS | rc=0 >>
Filesystem                                                              Size  Used Avail Use% Mounted on
/dev/vda1                                                                80G   24G   57G  30% /
devtmpfs                                                                3.8G     0  3.8G   0% /dev
tmpfs                                                                   3.9G     0  3.9G   0% /dev/shm
tmpfs                                                                   3.9G  2.7M  3.9G   1% /run
tmpfs                                                                   3.9G     0  3.9G   0% /sys/fs/cgroup
/dev/vde1                                                                10G   33M   10G   1% /mnt/local-storage/virtual/metric/disk1
node-0.rajranjabastion.lab.pnq2.cee.redhat.com:/exports/nfs/monitoring   40G  2.7G   38G   7% /var/lib/origin/openshift.local.volumes/pods/fb92bd11-211b-11e9-a589-fa163e4feb58/volumes/kubernetes.io~nfs/pv-prometheus-0002
tmpfs                                                                   3.9G  8.0K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/fb92bd11-211b-11e9-a589-fa163e4feb58/volumes/kubernetes.io~secret/secret-prometheus-k8s-tls
tmpfs                                                                   3.9G  4.0K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/9af90fc1-211b-11e9-a589-fa163e4feb58/volumes/kubernetes.io~secret/secret-grafana-proxy
tmpfs                                                                   3.9G   24K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/9af84cd3-211b-11e9-a589-fa163e4feb58/volumes/kubernetes.io~secret/cluster-monitoring-operator-token-8pjmw
tmpfs                                                                   3.9G   12K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/fb92bd11-211b-11e9-a589-fa163e4feb58/volumes/kubernetes.io~secret/config
tmpfs                                                                   3.9G  4.0K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/9af90fc1-211b-11e9-a589-fa163e4feb58/volumes/kubernetes.io~secret/grafana-config
tmpfs                                                                   3.9G   24K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/99f26e50-211b-11e9-a589-fa163e4feb58/volumes/kubernetes.io~secret/aggregated-logging-eventrouter-token-rjfqh
tmpfs                                                                   3.9G   24K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/9b5eab7b-211b-11e9-a589-fa163e4feb58/volumes/kubernetes.io~secret/prometheus-operator-token-5qstt
tmpfs                                                                   3.9G   24K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/884402e7-fc88-11e8-b3ee-fa163e6bb7d1/volumes/kubernetes.io~secret/sdn-token-mfqjf
tmpfs                                                                   3.9G  4.0K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/fb92bd11-211b-11e9-a589-fa163e4feb58/volumes/kubernetes.io~secret/secret-prometheus-k8s-proxy
tmpfs                                                                   3.9G   24K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/fb92bd11-211b-11e9-a589-fa163e4feb58/volumes/kubernetes.io~secret/prometheus-k8s-token-qgmtk
tmpfs                                                                   3.9G  4.0K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/9af90fc1-211b-11e9-a589-fa163e4feb58/volumes/kubernetes.io~secret/grafana-datasources
tmpfs                                                                   3.9G   24K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/884b8965-fc88-11e8-b3ee-fa163e6bb7d1/volumes/kubernetes.io~secret/sync-token-974k4
tmpfs                                                                   3.9G  8.0K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/9af90fc1-211b-11e9-a589-fa163e4feb58/volumes/kubernetes.io~secret/secret-grafana-tls
tmpfs                                                                   3.9G  4.0K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/fb92bd11-211b-11e9-a589-fa163e4feb58/volumes/kubernetes.io~secret/secret-prometheus-k8s-htpasswd
tmpfs                                                                   3.9G   24K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/9af90fc1-211b-11e9-a589-fa163e4feb58/volumes/kubernetes.io~secret/grafana-token-2b4dm
/dev/dm-6                                                                10G  270M  9.8G   3% /var/lib/docker/devicemapper/mnt/9d1210cfb22cc5a7afac5ba01713a8029db67c899044c76e5b80a0bb94f01bb8
shm                                                                      64M     0   64M   0% /var/lib/docker/containers/a540e6cae9cdfb1b7f95b5c6b8c83d3dfd59716441a2c57a3de6123fa8e5e973/shm
tmpfs                                                                   3.9G   24K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/8858c8c6-fc88-11e8-b3ee-fa163e6bb7d1/volumes/kubernetes.io~secret/sdn-token-mfqjf
/dev/dm-4                                                                10G  270M  9.8G   3% /var/lib/docker/devicemapper/mnt/68b617925b7f5b3dda9df8af8312b848be73139453fa1ff171a1c2a67509f754
shm                                                                      64M     0   64M   0% /var/lib/docker/containers/5cfa0e13a7d561776e05702292e65c3368a438643c589677bf39a91278dd654d/shm
/dev/dm-7                                                                10G  1.2G  8.9G  12% /var/lib/docker/devicemapper/mnt/61eab28a70527a48b77e313603e48be928d27e2c23927d356b726245cafb8773
/dev/dm-8                                                                10G  270M  9.8G   3% /var/lib/docker/devicemapper/mnt/2e034d3796b0807dbecfde501d4c5705414a87aa314c6bfb00d04cfbdeececa9
shm                                                                      64M     0   64M   0% /var/lib/docker/containers/0d315349e7e6d702a2f01bb4be6e4b15a29606d873edc82b34ccfecf56f6cb1e/shm
/dev/dm-10                                                               10G  1.2G  8.9G  12% /var/lib/docker/devicemapper/mnt/7d5a7af76f214e41214831afc1703d8d75c9f73b90c654d2b99eec147914a8e0
/dev/dm-11                                                               10G  270M  9.8G   3% /var/lib/docker/devicemapper/mnt/86441c441e17846ef4e0d291eb990d8ef5f5c0f79a1a6389e652df259ccc37bf
shm                                                                      64M     0   64M   0% /var/lib/docker/containers/171ca04d1abf2c1cb8d30e1dfdb7065e0fad538cde1c2c3ddfdee7c186656317/shm
/dev/dm-13                                                               10G  270M  9.8G   3% /var/lib/docker/devicemapper/mnt/a92c5c992dcd98469eecafa49d91b6657b806e77edaaba55b3427d10518f7260
shm                                                                      64M     0   64M   0% /var/lib/docker/containers/ec172df40423f97f5b6763778f8b064f48969e469d952d6287d96be65be20121/shm
/dev/dm-14                                                               10G  270M  9.8G   3% /var/lib/docker/devicemapper/mnt/bbb840f1a2f728d88811cbd67c5fa1abc7d8ddb0cddfeca92354a0dab3d28f87
shm                                                                      64M     0   64M   0% /var/lib/docker/containers/bed46940f96f526205402bfde0d55b69c99584188d0eb74f92cb233ef9a34966/shm
/dev/dm-12                                                               10G  270M  9.8G   3% /var/lib/docker/devicemapper/mnt/9783ea9ffd248920c3ebcd6012d69c005355d87ad9962028e34df8a04ee01182
shm                                                                      64M     0   64M   0% /var/lib/docker/containers/d8d256b38e3cc944df88e6ad9cdd4b19611445850a7cfe67ced787276afff93a/shm
/dev/dm-16                                                               10G  270M  9.8G   3% /var/lib/docker/devicemapper/mnt/5d64f53192175e6b7f471d424c7061becf52589e286426d1c26f25ac15301bd0
shm                                                                      64M     0   64M   0% /var/lib/docker/containers/3bf221456b01801d87a160343fca3e278a8da3a6905b882ae05482e9d5d7a81a/shm
/dev/dm-15                                                               10G  501M  9.6G   5% /var/lib/docker/devicemapper/mnt/4cf5f128b0d2344255d9d28a2728938c508461c64b87a829497b2f7c185381ab
/dev/dm-17                                                               10G  549M  9.5G   6% /var/lib/docker/devicemapper/mnt/dd276c63b6cba6902a2f1bfd3a57c083de55a4331c81f2b46b8c180def712059
/dev/dm-18                                                               10G  636M  9.4G   7% /var/lib/docker/devicemapper/mnt/811dd49920cee993dd9e22fcead6474107dbf7d494aa6f2cd39b4c31f820e4bc
/dev/dm-20                                                               10G  568M  9.5G   6% /var/lib/docker/devicemapper/mnt/792afcca4c6cff5ee24187e0394a0969895202f2783e042cddd5bfa243fb96f9
/dev/dm-19                                                               10G  285M  9.8G   3% /var/lib/docker/devicemapper/mnt/16fd285aa18c227fac3bce34a16a5b2e47948addcc903be75b60926d5837b2d9
/dev/dm-22                                                               10G  284M  9.8G   3% /var/lib/docker/devicemapper/mnt/69075bc58b1a960b73e5a4b4f97396e0ba5a2c04778c8a67a9333621fdb42107
/dev/dm-21                                                               10G  284M  9.8G   3% /var/lib/docker/devicemapper/mnt/89c2aa8211c949934217144ddaa851ee686dc1cbdf67c42fe1e53ef1a032ed99
/dev/dm-23                                                               10G  433M  9.6G   5% /var/lib/docker/devicemapper/mnt/0d819c37cd151a86e78073eae7edfd8ac61026cd1db0f80b48f2a2cc685bb53c
/dev/dm-3                                                                10G  1.2G  8.9G  12% /var/lib/docker/devicemapper/mnt/cc683927d84444b1f2de44bac8eec6130ea3ab17fa2429ea2dcb8a1da963a14e
tmpfs                                                                   783M     0  783M   0% /run/user/1000

node-1.rajranjaapps.lab.pnq2.cee.redhat.com | SUCCESS | rc=0 >>
Filesystem      Size  Used Avail Use% Mounted on
/dev/vda1        80G   26G   55G  32% /
devtmpfs        3.8G     0  3.8G   0% /dev
tmpfs           3.9G     0  3.9G   0% /dev/shm
tmpfs           3.9G  3.1M  3.9G   1% /run
tmpfs           3.9G     0  3.9G   0% /sys/fs/cgroup
tmpfs           3.9G   24K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/87fd6832-fc88-11e8-b3ee-fa163e6bb7d1/volumes/kubernetes.io~secret/sdn-token-mfqjf
tmpfs           3.9G   24K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/87f1bb62-fc88-11e8-b3ee-fa163e6bb7d1/volumes/kubernetes.io~secret/sdn-token-mfqjf
tmpfs           3.9G   24K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/1ad15178-170f-11e9-a272-fa163e4feb58/volumes/kubernetes.io~secret/gogs-token-v5l64
tmpfs           3.9G   24K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/87e8d9bf-fc88-11e8-b3ee-fa163e6bb7d1/volumes/kubernetes.io~secret/sync-token-974k4
tmpfs           3.9G   24K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/9a3d3d24-fc89-11e8-b3ee-fa163e6bb7d1/volumes/kubernetes.io~secret/olm-operator-serviceaccount-token-d8cng
tmpfs           3.9G   24K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/1e66c6e5-170f-11e9-a272-fa163e4feb58/volumes/kubernetes.io~secret/gogs-token-v5l64
tmpfs           3.9G   24K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/23cd37cd-170f-11e9-a272-fa163e4feb58/volumes/kubernetes.io~secret/default-token-5r8vf
tmpfs           3.9G   24K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/202f1ca0-170f-11e9-a272-fa163e4feb58/volumes/kubernetes.io~secret/default-token-5r8vf
tmpfs           3.9G   24K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/1f71879f-170f-11e9-a272-fa163e4feb58/volumes/kubernetes.io~secret/default-token-5r8vf
/dev/dm-4        10G  270M  9.8G   3% /var/lib/docker/devicemapper/mnt/fed7b548b86c544d541ec1f8bf90038badc0bf53b17780cfc49d32ebaa89ba9a
shm              64M     0   64M   0% /var/lib/docker/containers/4443d3ccf6a0a072e29551ea502b073c787e9ace4a7c125ec2a6ecf8dea9814d/shm
/dev/dm-3        10G  270M  9.8G   3% /var/lib/docker/devicemapper/mnt/252516a3aa274d5a31c3d5c6fe3bd26a3fa8fa0d1901e6ca07afeedebd635750
shm              64M     0   64M   0% /var/lib/docker/containers/a7d8de5df3cc5f7ce27cffe39487a51f64a9f1546c8cd22706ebba8f296d0573/shm
/dev/dm-6        10G  270M  9.8G   3% /var/lib/docker/devicemapper/mnt/b041e65dd5cc9eb8a3769611bc4ede0dc39f1b34ef90992eecb5dad9b59191e0
shm              64M     0   64M   0% /var/lib/docker/containers/17821731821e050ba9f2a307d2deaf76788a1a3ce6340c690407438bbe178c0b/shm
/dev/dm-7        10G  1.2G  8.9G  12% /var/lib/docker/devicemapper/mnt/dfadc2ceb4db7f3f3f8513e570ea867cb66ea20987f131832a571ed77179f5fd
/dev/dm-8        10G  1.2G  8.9G  12% /var/lib/docker/devicemapper/mnt/3fb111886a56f94ee745a024d281d970e4c8e1ae5098c3641aff537e1b589613
tmpfs           3.9G   24K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/7d7c126c-1712-11e9-a272-fa163e4feb58/volumes/kubernetes.io~secret/default-token-x8bww
/dev/dm-5        10G  1.2G  8.9G  12% /var/lib/docker/devicemapper/mnt/2fb60b4416fd5f65f7c413c8a168c18ae833f16b6677ebd9445b9b9fdccc658c
/dev/dm-9        10G  270M  9.8G   3% /var/lib/docker/devicemapper/mnt/46e1ed90bbc46c1f2c883f11a99f359e7334290802d8983d90c840736aaab220
shm              64M  4.0K   64M   1% /var/lib/docker/containers/66b5754d1dce9f03c03894a068cd6f65465202ce86d08f3343bf3a534975a877/shm
/dev/dm-11       10G  270M  9.8G   3% /var/lib/docker/devicemapper/mnt/01e188750bd4e703c03690454c4cdafee47718f5dbd31f7faa208d9abcc3b16f
shm              64M     0   64M   0% /var/lib/docker/containers/349788865cabab2ecc97e805654af749bc4ed1eed9164d4741bf0b166770f73f/shm
/dev/dm-10       10G  358M  9.7G   4% /var/lib/docker/devicemapper/mnt/c1553e1ccc7066dee9fe6e1a0267ea10fbedfa98e26c18782a0e9271586d135c
/dev/dm-12       10G  270M  9.8G   3% /var/lib/docker/devicemapper/mnt/7349b0cb71e515d7deab005b0749f2ede6e809aec409d46fe0bf1175633ecddb
shm              64M     0   64M   0% /var/lib/docker/containers/85fadcc1609af42081182444f336f26db0f3332832147820132aaaad33a7c045/shm
/dev/dm-13       10G  270M  9.8G   3% /var/lib/docker/devicemapper/mnt/49fb787ab470710e20c41c0fa5828b55cbee7afd58f466ef32612850c3bf6916
shm              64M  4.0K   64M   1% /var/lib/docker/containers/fab5133e41a2fa4200e6b98fb0a968772008b1c5909bd43d55e2c347ee579f62/shm
/dev/dm-15       10G  270M  9.8G   3% /var/lib/docker/devicemapper/mnt/c395c9e807cb7287c704af1e2f415cdea6c208328a6b0650495b32b8b2122e08
shm              64M     0   64M   0% /var/lib/docker/containers/34d0972cda8df56bdc50d6fe756f081e148b389c4277a017340dc24f8f25f151/shm
/dev/dm-14       10G  270M  9.8G   3% /var/lib/docker/devicemapper/mnt/db19a2542f3e7e749d5d95ba37f6a4a161d7c41369cde158cfdad87a86e9b30e
shm              64M     0   64M   0% /var/lib/docker/containers/c0c49b1cc340e64a9807ded07a423b233ef2fa9a2625152df9c1d50ad11a9c2a/shm
/dev/dm-17       10G  270M  9.8G   3% /var/lib/docker/devicemapper/mnt/893f2e7156389cce17a7c56f0e47dbd3c28c2e602654e297fb5060eedfceadb4
shm              64M     0   64M   0% /var/lib/docker/containers/2c08dd4e08111f040a376e1666bf7a494283073aa576d72e5d2582b997c67165/shm
/dev/dm-16       10G  357M  9.7G   4% /var/lib/docker/devicemapper/mnt/82ff5ba6aa3a40444193f4c967ba293dbd972ef6abc63403af3eb187bb419157
/dev/dm-19       10G  518M  9.5G   6% /var/lib/docker/devicemapper/mnt/3a3e7ce06365e7b3bc1f21300c7b0ab51877136af0bb5c27cd2db30bbe3cdde2
/dev/dm-20       10G  899M  9.2G   9% /var/lib/docker/devicemapper/mnt/bc6f63e3d8b71aef582b6834ff79cab241a31524d46f116c5190390ad5f363fe
/dev/dm-21       10G  334M  9.7G   4% /var/lib/docker/devicemapper/mnt/57246c6e4b87c8ecce310924fe9ba9bbf3e84f8a19ea3b04a8fac0ac34ba3380
/dev/dm-22       10G  409M  9.6G   4% /var/lib/docker/devicemapper/mnt/70c597e69c6b81692fb8fd11cdc662cc6b5d2691a7dd9d9be0adbb59c9561129
/dev/dm-18       10G  901M  9.2G   9% /var/lib/docker/devicemapper/mnt/f2c20711c1e9eb81ccbb934a5d510971702cade9230af1df33d301115bcf2438
tmpfs           783M     0  783M   0% /run/user/1000

node-0.rajranjalb.lab.pnq2.cee.redhat.com | SUCCESS | rc=0 >>
Filesystem      Size  Used Avail Use% Mounted on
/dev/vda1        20G  2.1G   18G  11% /
devtmpfs        897M     0  897M   0% /dev
tmpfs           920M     0  920M   0% /dev/shm
tmpfs           920M   17M  903M   2% /run
tmpfs           920M     0  920M   0% /sys/fs/cgroup
tmpfs           184M     0  184M   0% /run/user/1000
```

```sh
ansible -i /home/quicklab/c1-ocp/hosts --key-file=/home/quicklab/c1-ocp/quicklab.key OSEv3 -a 'lsblk'
node-1.rajranjamaster.lab.pnq2.cee.redhat.com | SUCCESS | rc=0 >>
NAME                                                                                           MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
vda                                                                                            253:0    0   80G  0 disk
`-vda1                                                                                         253:1    0   80G  0 part /
vdb                                                                                            253:16   0   10G  0 disk
`-vdb1                                                                                         253:17   0   10G  0 part
  |-docker--vg-docker--pool_tmeta                                                              252:0    0   12M  0 lvm
  | `-docker--vg-docker--pool                                                                  252:2    0  5.7G  0 lvm
  |   |-docker-253:1-50341699-1f5d807a880985a1833494b37e6bdaf199ef9db0d8d5775398949b46290c394f 252:3    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/1f5d807a880985a1833494b37e6bdaf199ef9db0d8d5775398949b46290c394f
  |   |-docker-253:1-50341699-f6306e2fd97d62a8c3f5b78e070e60bee396750628d18fa524211eec7091f071 252:4    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/f6306e2fd97d62a8c3f5b78e070e60bee396750628d18fa524211eec7091f071
  |   |-docker-253:1-50341699-5b97fe5bea21d2469cc4e5e0885a4985d109a75b5e3e99833cb35799f2d5c70c 252:5    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/5b97fe5bea21d2469cc4e5e0885a4985d109a75b5e3e99833cb35799f2d5c70c
  |   |-docker-253:1-50341699-7f4b20be5cfb969400996753578450a7c464f859455f4ad4dc573b8fd41d2832 252:6    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/7f4b20be5cfb969400996753578450a7c464f859455f4ad4dc573b8fd41d2832
  |   |-docker-253:1-50341699-bac65a9c9932455675bba564e1c1d1a3967ba103d951c7996ab865335b3886e2 252:7    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/bac65a9c9932455675bba564e1c1d1a3967ba103d951c7996ab865335b3886e2
  |   |-docker-253:1-50341699-ca4907b4be2945de50137f7bc0d70b6eec546a562db9831a22c8551d09496bbc 252:8    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/ca4907b4be2945de50137f7bc0d70b6eec546a562db9831a22c8551d09496bbc
  |   |-docker-253:1-50341699-856496e2ae88537a95356a959304509164fe0c3b2c64bce8069b51e768512d37 252:9    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/856496e2ae88537a95356a959304509164fe0c3b2c64bce8069b51e768512d37
  |   |-docker-253:1-50341699-b49988708549107a656f7196f0e357f9ebe78f348a1821319821b501bdc19a45 252:10   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/b49988708549107a656f7196f0e357f9ebe78f348a1821319821b501bdc19a45
  |   |-docker-253:1-50341699-9eb83ad4fb40622540ef7db4fb6bf8b0ecf0321f970dac71fb3c48d1847617fb 252:11   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/9eb83ad4fb40622540ef7db4fb6bf8b0ecf0321f970dac71fb3c48d1847617fb
  |   |-docker-253:1-50341699-1b36f66f0f9947748eb8f92f03599a00f61c3ce7b7ab6f02b4f6406630958523 252:12   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/1b36f66f0f9947748eb8f92f03599a00f61c3ce7b7ab6f02b4f6406630958523
  |   |-docker-253:1-50341699-8e7181a552fda69e81048910a28b26eb8a05c2c1a17435527cf5a5d0eac1e55c 252:13   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/8e7181a552fda69e81048910a28b26eb8a05c2c1a17435527cf5a5d0eac1e55c
  |   |-docker-253:1-50341699-63c76bf22f5ad7dc970419ebdf3ab811518cfca6bfd24419ef8d850a1dd1d41b 252:14   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/63c76bf22f5ad7dc970419ebdf3ab811518cfca6bfd24419ef8d850a1dd1d41b
  |   |-docker-253:1-50341699-5003978c779a460cfcd8332297ea239b8815562926ea8ea042b2f5f39fc469ee 252:15   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/5003978c779a460cfcd8332297ea239b8815562926ea8ea042b2f5f39fc469ee
  |   |-docker-253:1-50341699-ada6706e079e45fc8f567f7491b9c2af216b3152602bbee0646a40fb47384b8f 252:16   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/ada6706e079e45fc8f567f7491b9c2af216b3152602bbee0646a40fb47384b8f
  |   |-docker-253:1-50341699-b3c486b5829a9d8cebf9750d1fd3aa08d1d15c172a588a5293c52bf58c767e76 252:17   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/b3c486b5829a9d8cebf9750d1fd3aa08d1d15c172a588a5293c52bf58c767e76
  |   |-docker-253:1-50341699-a2f04f5cc715a8a51caf9ec901d70e3a09948f7bac97e506ab5236fa21a098fe 252:18   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/a2f04f5cc715a8a51caf9ec901d70e3a09948f7bac97e506ab5236fa21a098fe
  |   |-docker-253:1-50341699-b6494dd89b62012bf593677f32a53e78b292119e0c9aba57a7626bcd21e9907d 252:19   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/b6494dd89b62012bf593677f32a53e78b292119e0c9aba57a7626bcd21e9907d
  |   `-docker-253:1-50341699-cd653bfb9a4b37e2f17393014ba412d029875f26319057083fd524b6b0c951cd 252:20   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/cd653bfb9a4b37e2f17393014ba412d029875f26319057083fd524b6b0c951cd
  `-docker--vg-docker--pool_tdata                                                              252:1    0  5.7G  0 lvm
    `-docker--vg-docker--pool                                                                  252:2    0  5.7G  0 lvm
      |-docker-253:1-50341699-1f5d807a880985a1833494b37e6bdaf199ef9db0d8d5775398949b46290c394f 252:3    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/1f5d807a880985a1833494b37e6bdaf199ef9db0d8d5775398949b46290c394f
      |-docker-253:1-50341699-f6306e2fd97d62a8c3f5b78e070e60bee396750628d18fa524211eec7091f071 252:4    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/f6306e2fd97d62a8c3f5b78e070e60bee396750628d18fa524211eec7091f071
      |-docker-253:1-50341699-5b97fe5bea21d2469cc4e5e0885a4985d109a75b5e3e99833cb35799f2d5c70c 252:5    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/5b97fe5bea21d2469cc4e5e0885a4985d109a75b5e3e99833cb35799f2d5c70c
      |-docker-253:1-50341699-7f4b20be5cfb969400996753578450a7c464f859455f4ad4dc573b8fd41d2832 252:6    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/7f4b20be5cfb969400996753578450a7c464f859455f4ad4dc573b8fd41d2832
      |-docker-253:1-50341699-bac65a9c9932455675bba564e1c1d1a3967ba103d951c7996ab865335b3886e2 252:7    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/bac65a9c9932455675bba564e1c1d1a3967ba103d951c7996ab865335b3886e2
      |-docker-253:1-50341699-ca4907b4be2945de50137f7bc0d70b6eec546a562db9831a22c8551d09496bbc 252:8    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/ca4907b4be2945de50137f7bc0d70b6eec546a562db9831a22c8551d09496bbc
      |-docker-253:1-50341699-856496e2ae88537a95356a959304509164fe0c3b2c64bce8069b51e768512d37 252:9    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/856496e2ae88537a95356a959304509164fe0c3b2c64bce8069b51e768512d37
      |-docker-253:1-50341699-b49988708549107a656f7196f0e357f9ebe78f348a1821319821b501bdc19a45 252:10   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/b49988708549107a656f7196f0e357f9ebe78f348a1821319821b501bdc19a45
      |-docker-253:1-50341699-9eb83ad4fb40622540ef7db4fb6bf8b0ecf0321f970dac71fb3c48d1847617fb 252:11   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/9eb83ad4fb40622540ef7db4fb6bf8b0ecf0321f970dac71fb3c48d1847617fb
      |-docker-253:1-50341699-1b36f66f0f9947748eb8f92f03599a00f61c3ce7b7ab6f02b4f6406630958523 252:12   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/1b36f66f0f9947748eb8f92f03599a00f61c3ce7b7ab6f02b4f6406630958523
      |-docker-253:1-50341699-8e7181a552fda69e81048910a28b26eb8a05c2c1a17435527cf5a5d0eac1e55c 252:13   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/8e7181a552fda69e81048910a28b26eb8a05c2c1a17435527cf5a5d0eac1e55c
      |-docker-253:1-50341699-63c76bf22f5ad7dc970419ebdf3ab811518cfca6bfd24419ef8d850a1dd1d41b 252:14   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/63c76bf22f5ad7dc970419ebdf3ab811518cfca6bfd24419ef8d850a1dd1d41b
      |-docker-253:1-50341699-5003978c779a460cfcd8332297ea239b8815562926ea8ea042b2f5f39fc469ee 252:15   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/5003978c779a460cfcd8332297ea239b8815562926ea8ea042b2f5f39fc469ee
      |-docker-253:1-50341699-ada6706e079e45fc8f567f7491b9c2af216b3152602bbee0646a40fb47384b8f 252:16   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/ada6706e079e45fc8f567f7491b9c2af216b3152602bbee0646a40fb47384b8f
      |-docker-253:1-50341699-b3c486b5829a9d8cebf9750d1fd3aa08d1d15c172a588a5293c52bf58c767e76 252:17   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/b3c486b5829a9d8cebf9750d1fd3aa08d1d15c172a588a5293c52bf58c767e76
      |-docker-253:1-50341699-a2f04f5cc715a8a51caf9ec901d70e3a09948f7bac97e506ab5236fa21a098fe 252:18   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/a2f04f5cc715a8a51caf9ec901d70e3a09948f7bac97e506ab5236fa21a098fe
      |-docker-253:1-50341699-b6494dd89b62012bf593677f32a53e78b292119e0c9aba57a7626bcd21e9907d 252:19   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/b6494dd89b62012bf593677f32a53e78b292119e0c9aba57a7626bcd21e9907d
      `-docker-253:1-50341699-cd653bfb9a4b37e2f17393014ba412d029875f26319057083fd524b6b0c951cd 252:20   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/cd653bfb9a4b37e2f17393014ba412d029875f26319057083fd524b6b0c951cd

node-0.rajranjamaster.lab.pnq2.cee.redhat.com | SUCCESS | rc=0 >>
NAME                                                                                           MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
vda                                                                                            253:0    0   80G  0 disk
`-vda1                                                                                         253:1    0   80G  0 part /
vdb                                                                                            253:16   0   10G  0 disk
`-vdb1                                                                                         253:17   0   10G  0 part
  |-docker--vg-docker--pool_tmeta                                                              252:0    0   12M  0 lvm
  | `-docker--vg-docker--pool                                                                  252:2    0  6.9G  0 lvm
  |   |-docker-253:1-50344928-9dc4b3df36f9f49c8cb8887d5117f105f5243719422d14c74bb934552995b985 252:3    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/9dc4b3df36f9f49c8cb8887d5117f105f5243719422d14c74bb934552995b985
  |   |-docker-253:1-50344928-ca0afd0e303e8cc7b3d6f83eb0c2d0626d8d1d3d25410bdbbd61cc0b371e3b69 252:4    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/ca0afd0e303e8cc7b3d6f83eb0c2d0626d8d1d3d25410bdbbd61cc0b371e3b69
  |   |-docker-253:1-50344928-b46f5dd08fe31ad903260cb1e89e2898ac820a207447834baeae33cb5e4b96fa 252:5    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/b46f5dd08fe31ad903260cb1e89e2898ac820a207447834baeae33cb5e4b96fa
  |   |-docker-253:1-50344928-d1c34139aef10fd825ecd462770f602dc8c186b617513cd8c7464c326ffd267c 252:6    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/d1c34139aef10fd825ecd462770f602dc8c186b617513cd8c7464c326ffd267c
  |   |-docker-253:1-50344928-06026a4f97443bf97dabeb5c2eb199ff47215a58de6617cfbe401b3ab53401b5 252:7    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/06026a4f97443bf97dabeb5c2eb199ff47215a58de6617cfbe401b3ab53401b5
  |   |-docker-253:1-50344928-9ea4cd490754e5761f01a3d6def5cdd7e1d0fd97fd7c97c7df95592055311c25 252:8    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/9ea4cd490754e5761f01a3d6def5cdd7e1d0fd97fd7c97c7df95592055311c25
  |   |-docker-253:1-50344928-5653933765e9d8b29975e879b70d9ec0a353fb84aeb0dd8c41bca0fec53c2202 252:9    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/5653933765e9d8b29975e879b70d9ec0a353fb84aeb0dd8c41bca0fec53c2202
  |   |-docker-253:1-50344928-1ddbfd82357157f5be0dddb8d0cc68eb6e8736c6ff92f0e8927b39afd8d8485d 252:10   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/1ddbfd82357157f5be0dddb8d0cc68eb6e8736c6ff92f0e8927b39afd8d8485d
  |   |-docker-253:1-50344928-41c2efac061490e530ac2bb879e9b3e4b94a3c1380695dae9602c4cccf68937b 252:11   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/41c2efac061490e530ac2bb879e9b3e4b94a3c1380695dae9602c4cccf68937b
  |   |-docker-253:1-50344928-07c78102a0808f27759ec39e10f72eeba44ed374751d226887cb892daecdc703 252:12   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/07c78102a0808f27759ec39e10f72eeba44ed374751d226887cb892daecdc703
  |   |-docker-253:1-50344928-653b80e35f5e255329f6215efcae787262c87d1110f588ee6c862a3c33c2770f 252:13   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/653b80e35f5e255329f6215efcae787262c87d1110f588ee6c862a3c33c2770f
  |   |-docker-253:1-50344928-a7c3493bb180ffafad5520dd584dab228fda03122bbcf3d4af10cad12aa3fd26 252:14   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/a7c3493bb180ffafad5520dd584dab228fda03122bbcf3d4af10cad12aa3fd26
  |   |-docker-253:1-50344928-e267fe078f00d2f9ac157d4c0cbf3b946eabac45900fcb7dc002d14827503b46 252:15   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/e267fe078f00d2f9ac157d4c0cbf3b946eabac45900fcb7dc002d14827503b46
  |   |-docker-253:1-50344928-a9da97064c3073c3cf733c14cff853a16a765d77f8cef295b4c01608957e33c9 252:16   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/a9da97064c3073c3cf733c14cff853a16a765d77f8cef295b4c01608957e33c9
  |   |-docker-253:1-50344928-786c32af923c26bdd086b89407c67f0aa7783be4ff5745352b9e72633fe7ebcd 252:17   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/786c32af923c26bdd086b89407c67f0aa7783be4ff5745352b9e72633fe7ebcd
  |   |-docker-253:1-50344928-bd527ab3e241d18948d057e4fd0c0416408d1e72428625ace70745d970828d75 252:18   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/bd527ab3e241d18948d057e4fd0c0416408d1e72428625ace70745d970828d75
  |   |-docker-253:1-50344928-d9b5bfe0b65bb8c4ffe3ead3824b82be73e14a0ff8d50e45c280cea5c389b5b1 252:19   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/d9b5bfe0b65bb8c4ffe3ead3824b82be73e14a0ff8d50e45c280cea5c389b5b1
  |   |-docker-253:1-50344928-0039136732bffb07d816857da35c995196aff106c36b6e1a01745fa86a68a6bf 252:20   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/0039136732bffb07d816857da35c995196aff106c36b6e1a01745fa86a68a6bf
  |   |-docker-253:1-50344928-bbbfa1f510355355e09e19a1e9136b6a23b5ee22e626fe41fae0480f5d8a852a 252:21   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/bbbfa1f510355355e09e19a1e9136b6a23b5ee22e626fe41fae0480f5d8a852a
  |   |-docker-253:1-50344928-1d69d61663fb7e4712c3801d465061f98c1d9571623fbe38c275a08950564fc8 252:22   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/1d69d61663fb7e4712c3801d465061f98c1d9571623fbe38c275a08950564fc8
  |   |-docker-253:1-50344928-a281ee203546c22c6251bb5e1a798cff71d23e1428ff712b0966ca64d14d8036 252:23   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/a281ee203546c22c6251bb5e1a798cff71d23e1428ff712b0966ca64d14d8036
  |   |-docker-253:1-50344928-d92cbee0497f6942945e4dd96a18c900407b8d61b1d8bbc8b6d5cec240d81abb 252:24   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/d92cbee0497f6942945e4dd96a18c900407b8d61b1d8bbc8b6d5cec240d81abb
  |   |-docker-253:1-50344928-633eb4e173bcc5f4aa743054522b88d7db7df02a6ea6a947eb14c7b05f5ae778 252:25   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/633eb4e173bcc5f4aa743054522b88d7db7df02a6ea6a947eb14c7b05f5ae778
  |   |-docker-253:1-50344928-e0a40a4640e303611d0a5f65940a2226941d2e0f7ba078224bee27f18f1405d3 252:26   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/e0a40a4640e303611d0a5f65940a2226941d2e0f7ba078224bee27f18f1405d3
  |   |-docker-253:1-50344928-4c4554a008d4d0873b885877669bc7f26632e1d0fe110ccb28b617eb95228658 252:27   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/4c4554a008d4d0873b885877669bc7f26632e1d0fe110ccb28b617eb95228658
  |   `-docker-253:1-50344928-8d87668c8cdf06fd66780b2aaec0366f78d80d80c62afea9528fb184414d0525 252:28   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/8d87668c8cdf06fd66780b2aaec0366f78d80d80c62afea9528fb184414d0525
  `-docker--vg-docker--pool_tdata                                                              252:1    0  6.9G  0 lvm
    `-docker--vg-docker--pool                                                                  252:2    0  6.9G  0 lvm
      |-docker-253:1-50344928-9dc4b3df36f9f49c8cb8887d5117f105f5243719422d14c74bb934552995b985 252:3    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/9dc4b3df36f9f49c8cb8887d5117f105f5243719422d14c74bb934552995b985
      |-docker-253:1-50344928-ca0afd0e303e8cc7b3d6f83eb0c2d0626d8d1d3d25410bdbbd61cc0b371e3b69 252:4    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/ca0afd0e303e8cc7b3d6f83eb0c2d0626d8d1d3d25410bdbbd61cc0b371e3b69
      |-docker-253:1-50344928-b46f5dd08fe31ad903260cb1e89e2898ac820a207447834baeae33cb5e4b96fa 252:5    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/b46f5dd08fe31ad903260cb1e89e2898ac820a207447834baeae33cb5e4b96fa
      |-docker-253:1-50344928-d1c34139aef10fd825ecd462770f602dc8c186b617513cd8c7464c326ffd267c 252:6    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/d1c34139aef10fd825ecd462770f602dc8c186b617513cd8c7464c326ffd267c
      |-docker-253:1-50344928-06026a4f97443bf97dabeb5c2eb199ff47215a58de6617cfbe401b3ab53401b5 252:7    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/06026a4f97443bf97dabeb5c2eb199ff47215a58de6617cfbe401b3ab53401b5
      |-docker-253:1-50344928-9ea4cd490754e5761f01a3d6def5cdd7e1d0fd97fd7c97c7df95592055311c25 252:8    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/9ea4cd490754e5761f01a3d6def5cdd7e1d0fd97fd7c97c7df95592055311c25
      |-docker-253:1-50344928-5653933765e9d8b29975e879b70d9ec0a353fb84aeb0dd8c41bca0fec53c2202 252:9    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/5653933765e9d8b29975e879b70d9ec0a353fb84aeb0dd8c41bca0fec53c2202
      |-docker-253:1-50344928-1ddbfd82357157f5be0dddb8d0cc68eb6e8736c6ff92f0e8927b39afd8d8485d 252:10   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/1ddbfd82357157f5be0dddb8d0cc68eb6e8736c6ff92f0e8927b39afd8d8485d
      |-docker-253:1-50344928-41c2efac061490e530ac2bb879e9b3e4b94a3c1380695dae9602c4cccf68937b 252:11   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/41c2efac061490e530ac2bb879e9b3e4b94a3c1380695dae9602c4cccf68937b
      |-docker-253:1-50344928-07c78102a0808f27759ec39e10f72eeba44ed374751d226887cb892daecdc703 252:12   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/07c78102a0808f27759ec39e10f72eeba44ed374751d226887cb892daecdc703
      |-docker-253:1-50344928-653b80e35f5e255329f6215efcae787262c87d1110f588ee6c862a3c33c2770f 252:13   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/653b80e35f5e255329f6215efcae787262c87d1110f588ee6c862a3c33c2770f
      |-docker-253:1-50344928-a7c3493bb180ffafad5520dd584dab228fda03122bbcf3d4af10cad12aa3fd26 252:14   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/a7c3493bb180ffafad5520dd584dab228fda03122bbcf3d4af10cad12aa3fd26
      |-docker-253:1-50344928-e267fe078f00d2f9ac157d4c0cbf3b946eabac45900fcb7dc002d14827503b46 252:15   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/e267fe078f00d2f9ac157d4c0cbf3b946eabac45900fcb7dc002d14827503b46
      |-docker-253:1-50344928-a9da97064c3073c3cf733c14cff853a16a765d77f8cef295b4c01608957e33c9 252:16   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/a9da97064c3073c3cf733c14cff853a16a765d77f8cef295b4c01608957e33c9
      |-docker-253:1-50344928-786c32af923c26bdd086b89407c67f0aa7783be4ff5745352b9e72633fe7ebcd 252:17   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/786c32af923c26bdd086b89407c67f0aa7783be4ff5745352b9e72633fe7ebcd
      |-docker-253:1-50344928-bd527ab3e241d18948d057e4fd0c0416408d1e72428625ace70745d970828d75 252:18   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/bd527ab3e241d18948d057e4fd0c0416408d1e72428625ace70745d970828d75
      |-docker-253:1-50344928-d9b5bfe0b65bb8c4ffe3ead3824b82be73e14a0ff8d50e45c280cea5c389b5b1 252:19   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/d9b5bfe0b65bb8c4ffe3ead3824b82be73e14a0ff8d50e45c280cea5c389b5b1
      |-docker-253:1-50344928-0039136732bffb07d816857da35c995196aff106c36b6e1a01745fa86a68a6bf 252:20   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/0039136732bffb07d816857da35c995196aff106c36b6e1a01745fa86a68a6bf
      |-docker-253:1-50344928-bbbfa1f510355355e09e19a1e9136b6a23b5ee22e626fe41fae0480f5d8a852a 252:21   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/bbbfa1f510355355e09e19a1e9136b6a23b5ee22e626fe41fae0480f5d8a852a
      |-docker-253:1-50344928-1d69d61663fb7e4712c3801d465061f98c1d9571623fbe38c275a08950564fc8 252:22   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/1d69d61663fb7e4712c3801d465061f98c1d9571623fbe38c275a08950564fc8
      |-docker-253:1-50344928-a281ee203546c22c6251bb5e1a798cff71d23e1428ff712b0966ca64d14d8036 252:23   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/a281ee203546c22c6251bb5e1a798cff71d23e1428ff712b0966ca64d14d8036
      |-docker-253:1-50344928-d92cbee0497f6942945e4dd96a18c900407b8d61b1d8bbc8b6d5cec240d81abb 252:24   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/d92cbee0497f6942945e4dd96a18c900407b8d61b1d8bbc8b6d5cec240d81abb
      |-docker-253:1-50344928-633eb4e173bcc5f4aa743054522b88d7db7df02a6ea6a947eb14c7b05f5ae778 252:25   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/633eb4e173bcc5f4aa743054522b88d7db7df02a6ea6a947eb14c7b05f5ae778
      |-docker-253:1-50344928-e0a40a4640e303611d0a5f65940a2226941d2e0f7ba078224bee27f18f1405d3 252:26   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/e0a40a4640e303611d0a5f65940a2226941d2e0f7ba078224bee27f18f1405d3
      |-docker-253:1-50344928-4c4554a008d4d0873b885877669bc7f26632e1d0fe110ccb28b617eb95228658 252:27   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/4c4554a008d4d0873b885877669bc7f26632e1d0fe110ccb28b617eb95228658
      `-docker-253:1-50344928-8d87668c8cdf06fd66780b2aaec0366f78d80d80c62afea9528fb184414d0525 252:28   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/8d87668c8cdf06fd66780b2aaec0366f78d80d80c62afea9528fb184414d0525

node-2.rajranjamaster.lab.pnq2.cee.redhat.com | SUCCESS | rc=0 >>
NAME                                                                                           MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
vda                                                                                            253:0    0   80G  0 disk
`-vda1                                                                                         253:1    0   80G  0 part /
vdb                                                                                            253:16   0   10G  0 disk
`-vdb1                                                                                         253:17   0   10G  0 part
  |-docker--vg-docker--pool_tmeta                                                              252:0    0   12M  0 lvm
  | `-docker--vg-docker--pool                                                                  252:2    0  5.7G  0 lvm
  |   |-docker-253:1-50344928-aafcecb71d6a7e894e088d12b2a3760efc3ad375d46da5a6177785a1c7b4f0b7 252:3    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/aafcecb71d6a7e894e088d12b2a3760efc3ad375d46da5a6177785a1c7b4f0b7
  |   |-docker-253:1-50344928-50cc25c6d9882838f2645140a2e47e551f4604bb36f4c880fad695facf33da71 252:4    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/50cc25c6d9882838f2645140a2e47e551f4604bb36f4c880fad695facf33da71
  |   |-docker-253:1-50344928-a63ccdd373b8eeaa1883d1456682db3084f85cf713e54e4d85b77d50c69cb25f 252:5    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/a63ccdd373b8eeaa1883d1456682db3084f85cf713e54e4d85b77d50c69cb25f
  |   |-docker-253:1-50344928-43ec762f48e840e7fe4cb5f1d894fb1de9f47d800f33132eca8edfa2479e8e7a 252:6    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/43ec762f48e840e7fe4cb5f1d894fb1de9f47d800f33132eca8edfa2479e8e7a
  |   |-docker-253:1-50344928-87c68eccff864b9d2060fb5aeceb41b864e9fb58a5e89ac830b82dda25a20403 252:7    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/87c68eccff864b9d2060fb5aeceb41b864e9fb58a5e89ac830b82dda25a20403
  |   |-docker-253:1-50344928-bcacecd5214c33ef5a7876d7ceec46b3ad855ab1b3885a0d6b9581299e190a54 252:8    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/bcacecd5214c33ef5a7876d7ceec46b3ad855ab1b3885a0d6b9581299e190a54
  |   |-docker-253:1-50344928-16345f5ea3011e3ee2f315f70e851a71bbec3c293bce55f2ba550701e001daa5 252:9    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/16345f5ea3011e3ee2f315f70e851a71bbec3c293bce55f2ba550701e001daa5
  |   |-docker-253:1-50344928-e3e9b704f596b4d19c777395ee9718008aefa000d84dff29dc5093ab4c505dd0 252:10   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/e3e9b704f596b4d19c777395ee9718008aefa000d84dff29dc5093ab4c505dd0
  |   |-docker-253:1-50344928-2fd6217c7f76eb8144367ecb289736ebec70d86000dc9133ad09fe6631b9844c 252:11   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/2fd6217c7f76eb8144367ecb289736ebec70d86000dc9133ad09fe6631b9844c
  |   |-docker-253:1-50344928-987eda7a8a8345b512ba6449bb08547a8127c9016d099821e78f59dc850a1561 252:12   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/987eda7a8a8345b512ba6449bb08547a8127c9016d099821e78f59dc850a1561
  |   |-docker-253:1-50344928-bc3f397c0a931e0a67c06b5816e31693b2133fdd04901ade6ecf510c76621452 252:13   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/bc3f397c0a931e0a67c06b5816e31693b2133fdd04901ade6ecf510c76621452
  |   |-docker-253:1-50344928-e916c386658d4b073ab24aac2bacec30d697b28f54e543d5c234f3c8a0fdc506 252:14   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/e916c386658d4b073ab24aac2bacec30d697b28f54e543d5c234f3c8a0fdc506
  |   |-docker-253:1-50344928-9cce83f42ddc652249aed5aceb2c04edb96455d5cbddd2d6a865ace58eece614 252:15   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/9cce83f42ddc652249aed5aceb2c04edb96455d5cbddd2d6a865ace58eece614
  |   |-docker-253:1-50344928-b603e508db8261b8a2c055efc3a1b1f7089ac59448669bbc4ab206991a4c6c72 252:16   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/b603e508db8261b8a2c055efc3a1b1f7089ac59448669bbc4ab206991a4c6c72
  |   |-docker-253:1-50344928-cd9edabbb219600efb1055bebaa6ebfab3a9512ddcca4c6590c76f3da91d2afc 252:17   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/cd9edabbb219600efb1055bebaa6ebfab3a9512ddcca4c6590c76f3da91d2afc
  |   |-docker-253:1-50344928-fe93c4532d312a03422b9c2f5dad029b2d63204fbdc652e10e4a69cb5b7fc887 252:18   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/fe93c4532d312a03422b9c2f5dad029b2d63204fbdc652e10e4a69cb5b7fc887
  |   |-docker-253:1-50344928-5cd2b4354907279e7a5c9be004174e36defc2b629cc4f6f84934935946c9416a 252:19   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/5cd2b4354907279e7a5c9be004174e36defc2b629cc4f6f84934935946c9416a
  |   |-docker-253:1-50344928-80acb7d7fa1e728bb261a9bbb37211149ad83896b346c15478c080500aba3cbf 252:20   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/80acb7d7fa1e728bb261a9bbb37211149ad83896b346c15478c080500aba3cbf
  |   |-docker-253:1-50344928-3432e8c9876d8ee988e32941d57f239acc8a1174b480d912f273369ef7fab5e5 252:21   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/3432e8c9876d8ee988e32941d57f239acc8a1174b480d912f273369ef7fab5e5
  |   |-docker-253:1-50344928-193a8f263d81227a7af743be391ef01763e2c26701eedcc81f022c02cc388673 252:22   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/193a8f263d81227a7af743be391ef01763e2c26701eedcc81f022c02cc388673
  |   |-docker-253:1-50344928-e7b0f27edf7ea8b036e0cb5387495bc19d672643d29541c7e4abc9c0d8f5893a 252:23   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/e7b0f27edf7ea8b036e0cb5387495bc19d672643d29541c7e4abc9c0d8f5893a
  |   |-docker-253:1-50344928-5509f2fbf70c610ced77c5a9398bd0717231e2ff9202ebf6f0e046ddc9063562 252:24   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/5509f2fbf70c610ced77c5a9398bd0717231e2ff9202ebf6f0e046ddc9063562
  |   |-docker-253:1-50344928-21334dd4f586ac6cd9c68fe81068cde33ac920b2ba8464c10b05dcee338cea9d 252:25   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/21334dd4f586ac6cd9c68fe81068cde33ac920b2ba8464c10b05dcee338cea9d
  |   |-docker-253:1-50344928-6eb2698e12aaaedeb2339684975e639912f0bee417964b4e9b0befe01e337e7a 252:26   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/6eb2698e12aaaedeb2339684975e639912f0bee417964b4e9b0befe01e337e7a
  |   |-docker-253:1-50344928-5f032cfd5e343b003b8c18bb5e333b9a6d1ab44999e466c2f3f9fb7b9bced7dd 252:27   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/5f032cfd5e343b003b8c18bb5e333b9a6d1ab44999e466c2f3f9fb7b9bced7dd
  |   `-docker-253:1-50344928-8e23be07d9c5bf5af4d8248d77d4e4d26fc7aae305b6d0f74fe2f9898f3ac54c 252:28   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/8e23be07d9c5bf5af4d8248d77d4e4d26fc7aae305b6d0f74fe2f9898f3ac54c
  `-docker--vg-docker--pool_tdata                                                              252:1    0  5.7G  0 lvm
    `-docker--vg-docker--pool                                                                  252:2    0  5.7G  0 lvm
      |-docker-253:1-50344928-aafcecb71d6a7e894e088d12b2a3760efc3ad375d46da5a6177785a1c7b4f0b7 252:3    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/aafcecb71d6a7e894e088d12b2a3760efc3ad375d46da5a6177785a1c7b4f0b7
      |-docker-253:1-50344928-50cc25c6d9882838f2645140a2e47e551f4604bb36f4c880fad695facf33da71 252:4    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/50cc25c6d9882838f2645140a2e47e551f4604bb36f4c880fad695facf33da71
      |-docker-253:1-50344928-a63ccdd373b8eeaa1883d1456682db3084f85cf713e54e4d85b77d50c69cb25f 252:5    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/a63ccdd373b8eeaa1883d1456682db3084f85cf713e54e4d85b77d50c69cb25f
      |-docker-253:1-50344928-43ec762f48e840e7fe4cb5f1d894fb1de9f47d800f33132eca8edfa2479e8e7a 252:6    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/43ec762f48e840e7fe4cb5f1d894fb1de9f47d800f33132eca8edfa2479e8e7a
      |-docker-253:1-50344928-87c68eccff864b9d2060fb5aeceb41b864e9fb58a5e89ac830b82dda25a20403 252:7    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/87c68eccff864b9d2060fb5aeceb41b864e9fb58a5e89ac830b82dda25a20403
      |-docker-253:1-50344928-bcacecd5214c33ef5a7876d7ceec46b3ad855ab1b3885a0d6b9581299e190a54 252:8    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/bcacecd5214c33ef5a7876d7ceec46b3ad855ab1b3885a0d6b9581299e190a54
      |-docker-253:1-50344928-16345f5ea3011e3ee2f315f70e851a71bbec3c293bce55f2ba550701e001daa5 252:9    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/16345f5ea3011e3ee2f315f70e851a71bbec3c293bce55f2ba550701e001daa5
      |-docker-253:1-50344928-e3e9b704f596b4d19c777395ee9718008aefa000d84dff29dc5093ab4c505dd0 252:10   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/e3e9b704f596b4d19c777395ee9718008aefa000d84dff29dc5093ab4c505dd0
      |-docker-253:1-50344928-2fd6217c7f76eb8144367ecb289736ebec70d86000dc9133ad09fe6631b9844c 252:11   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/2fd6217c7f76eb8144367ecb289736ebec70d86000dc9133ad09fe6631b9844c
      |-docker-253:1-50344928-987eda7a8a8345b512ba6449bb08547a8127c9016d099821e78f59dc850a1561 252:12   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/987eda7a8a8345b512ba6449bb08547a8127c9016d099821e78f59dc850a1561
      |-docker-253:1-50344928-bc3f397c0a931e0a67c06b5816e31693b2133fdd04901ade6ecf510c76621452 252:13   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/bc3f397c0a931e0a67c06b5816e31693b2133fdd04901ade6ecf510c76621452
      |-docker-253:1-50344928-e916c386658d4b073ab24aac2bacec30d697b28f54e543d5c234f3c8a0fdc506 252:14   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/e916c386658d4b073ab24aac2bacec30d697b28f54e543d5c234f3c8a0fdc506
      |-docker-253:1-50344928-9cce83f42ddc652249aed5aceb2c04edb96455d5cbddd2d6a865ace58eece614 252:15   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/9cce83f42ddc652249aed5aceb2c04edb96455d5cbddd2d6a865ace58eece614
      |-docker-253:1-50344928-b603e508db8261b8a2c055efc3a1b1f7089ac59448669bbc4ab206991a4c6c72 252:16   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/b603e508db8261b8a2c055efc3a1b1f7089ac59448669bbc4ab206991a4c6c72
      |-docker-253:1-50344928-cd9edabbb219600efb1055bebaa6ebfab3a9512ddcca4c6590c76f3da91d2afc 252:17   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/cd9edabbb219600efb1055bebaa6ebfab3a9512ddcca4c6590c76f3da91d2afc
      |-docker-253:1-50344928-fe93c4532d312a03422b9c2f5dad029b2d63204fbdc652e10e4a69cb5b7fc887 252:18   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/fe93c4532d312a03422b9c2f5dad029b2d63204fbdc652e10e4a69cb5b7fc887
      |-docker-253:1-50344928-5cd2b4354907279e7a5c9be004174e36defc2b629cc4f6f84934935946c9416a 252:19   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/5cd2b4354907279e7a5c9be004174e36defc2b629cc4f6f84934935946c9416a
      |-docker-253:1-50344928-80acb7d7fa1e728bb261a9bbb37211149ad83896b346c15478c080500aba3cbf 252:20   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/80acb7d7fa1e728bb261a9bbb37211149ad83896b346c15478c080500aba3cbf
      |-docker-253:1-50344928-3432e8c9876d8ee988e32941d57f239acc8a1174b480d912f273369ef7fab5e5 252:21   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/3432e8c9876d8ee988e32941d57f239acc8a1174b480d912f273369ef7fab5e5
      |-docker-253:1-50344928-193a8f263d81227a7af743be391ef01763e2c26701eedcc81f022c02cc388673 252:22   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/193a8f263d81227a7af743be391ef01763e2c26701eedcc81f022c02cc388673
      |-docker-253:1-50344928-e7b0f27edf7ea8b036e0cb5387495bc19d672643d29541c7e4abc9c0d8f5893a 252:23   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/e7b0f27edf7ea8b036e0cb5387495bc19d672643d29541c7e4abc9c0d8f5893a
      |-docker-253:1-50344928-5509f2fbf70c610ced77c5a9398bd0717231e2ff9202ebf6f0e046ddc9063562 252:24   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/5509f2fbf70c610ced77c5a9398bd0717231e2ff9202ebf6f0e046ddc9063562
      |-docker-253:1-50344928-21334dd4f586ac6cd9c68fe81068cde33ac920b2ba8464c10b05dcee338cea9d 252:25   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/21334dd4f586ac6cd9c68fe81068cde33ac920b2ba8464c10b05dcee338cea9d
      |-docker-253:1-50344928-6eb2698e12aaaedeb2339684975e639912f0bee417964b4e9b0befe01e337e7a 252:26   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/6eb2698e12aaaedeb2339684975e639912f0bee417964b4e9b0befe01e337e7a
      |-docker-253:1-50344928-5f032cfd5e343b003b8c18bb5e333b9a6d1ab44999e466c2f3f9fb7b9bced7dd 252:27   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/5f032cfd5e343b003b8c18bb5e333b9a6d1ab44999e466c2f3f9fb7b9bced7dd
      `-docker-253:1-50344928-8e23be07d9c5bf5af4d8248d77d4e4d26fc7aae305b6d0f74fe2f9898f3ac54c 252:28   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/8e23be07d9c5bf5af4d8248d77d4e4d26fc7aae305b6d0f74fe2f9898f3ac54c

node-0.rajranjaapps.lab.pnq2.cee.redhat.com | SUCCESS | rc=0 >>
NAME                                                                                           MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
vda                                                                                            253:0    0   80G  0 disk
`-vda1                                                                                         253:1    0   80G  0 part /
vdb                                                                                            253:16   0   10G  0 disk
`-vdb1                                                                                         253:17   0   10G  0 part
  |-docker--vg-docker--pool_tmeta                                                              252:0    0   12M  0 lvm
  | `-docker--vg-docker--pool                                                                  252:2    0  9.9G  0 lvm
  |   |-docker-253:1-50341699-bf2e79d6d2de04120924d114ae7c1c7e8c519c00088e62bc16555bf7d39046e8 252:3    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/bf2e79d6d2de04120924d114ae7c1c7e8c519c00088e62bc16555bf7d39046e8
  |   |-docker-253:1-50341699-ae3309b62b6a93895ad865d7f2a55103eb0d8bb2b2c1a9cdc563844df0fd1476 252:4    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/ae3309b62b6a93895ad865d7f2a55103eb0d8bb2b2c1a9cdc563844df0fd1476
  |   |-docker-253:1-50341699-b1ef04e8c53655379b0f77edcaa876914e46dec11b35f915b16e4034b5da1361 252:5    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/b1ef04e8c53655379b0f77edcaa876914e46dec11b35f915b16e4034b5da1361
  |   |-docker-253:1-50341699-b3f1f25ff40327c308850f812ff0f56a4df17a836c57b111b8466558161e7006 252:6    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/b3f1f25ff40327c308850f812ff0f56a4df17a836c57b111b8466558161e7006
  |   |-docker-253:1-50341699-9bafc0c6b9dc17eaf1fb407705d4983d15a7aa785b39f8b24c685ee98e16fc71 252:7    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/9bafc0c6b9dc17eaf1fb407705d4983d15a7aa785b39f8b24c685ee98e16fc71
  |   |-docker-253:1-50341699-cc399ca705508625d055426324d206a30cdfe17d11c914f24ca07aea658d6bf4 252:8    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/cc399ca705508625d055426324d206a30cdfe17d11c914f24ca07aea658d6bf4
  |   |-docker-253:1-50341699-c8e183851f05195f5613ab9f4c3af6e71249a13f2c29fa9005b9c2caa46aacda 252:9    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/c8e183851f05195f5613ab9f4c3af6e71249a13f2c29fa9005b9c2caa46aacda
  |   |-docker-253:1-50341699-b7c982456e69b0cc68da13633775ab1cfb7f8cb9ae529f13067ae62251dd7f41 252:10   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/b7c982456e69b0cc68da13633775ab1cfb7f8cb9ae529f13067ae62251dd7f41
  |   |-docker-253:1-50341699-527be3fc3b6144a89db8ce6c2925c4fe12f1ed5a1a08224f080e0857590ac03c 252:11   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/527be3fc3b6144a89db8ce6c2925c4fe12f1ed5a1a08224f080e0857590ac03c
  |   |-docker-253:1-50341699-073ae36650ee9aaf2db3d67ed619d29fd305945b0fa248b435bf7ad5e31350e4 252:12   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/073ae36650ee9aaf2db3d67ed619d29fd305945b0fa248b435bf7ad5e31350e4
  |   |-docker-253:1-50341699-568c16c107db8e4a8632f9c24f6238e69bdf1880a44c9f82ebec3cde47a418b1 252:13   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/568c16c107db8e4a8632f9c24f6238e69bdf1880a44c9f82ebec3cde47a418b1
  |   |-docker-253:1-50341699-9b1f1f316f20d3794d2008f52c6d28887ee908cc8e97df115bc70c1f33b5a83c 252:14   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/9b1f1f316f20d3794d2008f52c6d28887ee908cc8e97df115bc70c1f33b5a83c
  |   |-docker-253:1-50341699-13c77014b50581b66ccef3e1a42ffcb2f8ac2e583a80bccce6b8e0e29f746b45 252:15   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/13c77014b50581b66ccef3e1a42ffcb2f8ac2e583a80bccce6b8e0e29f746b45
  |   |-docker-253:1-50341699-d6d6e1cd3c7986ffa3c855de89e718f262bc448a7619be561238b11ec948a400 252:16   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/d6d6e1cd3c7986ffa3c855de89e718f262bc448a7619be561238b11ec948a400
  |   |-docker-253:1-50341699-9d768b97e339a22e6b6333e5b72933ebafe517ce215665763085a715181c1e06 252:17   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/9d768b97e339a22e6b6333e5b72933ebafe517ce215665763085a715181c1e06
  |   |-docker-253:1-50341699-98fbbd33dc311f06b12e422c67caab38683937fbecc4a93e018b289a281cbb36 252:18   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/98fbbd33dc311f06b12e422c67caab38683937fbecc4a93e018b289a281cbb36
  |   |-docker-253:1-50341699-e876a68c622a7f296be21c0cf985f6bb50ab03cd8531c193c7e8f9dcbc18794b 252:21   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/e876a68c622a7f296be21c0cf985f6bb50ab03cd8531c193c7e8f9dcbc18794b
  |   `-docker-253:1-50341699-25cef72fac203737fa15b236f246f1b8859528095b1de00d83b50532afd71ece 252:22   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/25cef72fac203737fa15b236f246f1b8859528095b1de00d83b50532afd71ece
  `-docker--vg-docker--pool_tdata                                                              252:1    0  9.9G  0 lvm
    `-docker--vg-docker--pool                                                                  252:2    0  9.9G  0 lvm
      |-docker-253:1-50341699-bf2e79d6d2de04120924d114ae7c1c7e8c519c00088e62bc16555bf7d39046e8 252:3    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/bf2e79d6d2de04120924d114ae7c1c7e8c519c00088e62bc16555bf7d39046e8
      |-docker-253:1-50341699-ae3309b62b6a93895ad865d7f2a55103eb0d8bb2b2c1a9cdc563844df0fd1476 252:4    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/ae3309b62b6a93895ad865d7f2a55103eb0d8bb2b2c1a9cdc563844df0fd1476
      |-docker-253:1-50341699-b1ef04e8c53655379b0f77edcaa876914e46dec11b35f915b16e4034b5da1361 252:5    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/b1ef04e8c53655379b0f77edcaa876914e46dec11b35f915b16e4034b5da1361
      |-docker-253:1-50341699-b3f1f25ff40327c308850f812ff0f56a4df17a836c57b111b8466558161e7006 252:6    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/b3f1f25ff40327c308850f812ff0f56a4df17a836c57b111b8466558161e7006
      |-docker-253:1-50341699-9bafc0c6b9dc17eaf1fb407705d4983d15a7aa785b39f8b24c685ee98e16fc71 252:7    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/9bafc0c6b9dc17eaf1fb407705d4983d15a7aa785b39f8b24c685ee98e16fc71
      |-docker-253:1-50341699-cc399ca705508625d055426324d206a30cdfe17d11c914f24ca07aea658d6bf4 252:8    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/cc399ca705508625d055426324d206a30cdfe17d11c914f24ca07aea658d6bf4
      |-docker-253:1-50341699-c8e183851f05195f5613ab9f4c3af6e71249a13f2c29fa9005b9c2caa46aacda 252:9    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/c8e183851f05195f5613ab9f4c3af6e71249a13f2c29fa9005b9c2caa46aacda
      |-docker-253:1-50341699-b7c982456e69b0cc68da13633775ab1cfb7f8cb9ae529f13067ae62251dd7f41 252:10   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/b7c982456e69b0cc68da13633775ab1cfb7f8cb9ae529f13067ae62251dd7f41
      |-docker-253:1-50341699-527be3fc3b6144a89db8ce6c2925c4fe12f1ed5a1a08224f080e0857590ac03c 252:11   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/527be3fc3b6144a89db8ce6c2925c4fe12f1ed5a1a08224f080e0857590ac03c
      |-docker-253:1-50341699-073ae36650ee9aaf2db3d67ed619d29fd305945b0fa248b435bf7ad5e31350e4 252:12   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/073ae36650ee9aaf2db3d67ed619d29fd305945b0fa248b435bf7ad5e31350e4
      |-docker-253:1-50341699-568c16c107db8e4a8632f9c24f6238e69bdf1880a44c9f82ebec3cde47a418b1 252:13   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/568c16c107db8e4a8632f9c24f6238e69bdf1880a44c9f82ebec3cde47a418b1
      |-docker-253:1-50341699-9b1f1f316f20d3794d2008f52c6d28887ee908cc8e97df115bc70c1f33b5a83c 252:14   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/9b1f1f316f20d3794d2008f52c6d28887ee908cc8e97df115bc70c1f33b5a83c
      |-docker-253:1-50341699-13c77014b50581b66ccef3e1a42ffcb2f8ac2e583a80bccce6b8e0e29f746b45 252:15   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/13c77014b50581b66ccef3e1a42ffcb2f8ac2e583a80bccce6b8e0e29f746b45
      |-docker-253:1-50341699-d6d6e1cd3c7986ffa3c855de89e718f262bc448a7619be561238b11ec948a400 252:16   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/d6d6e1cd3c7986ffa3c855de89e718f262bc448a7619be561238b11ec948a400
      |-docker-253:1-50341699-9d768b97e339a22e6b6333e5b72933ebafe517ce215665763085a715181c1e06 252:17   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/9d768b97e339a22e6b6333e5b72933ebafe517ce215665763085a715181c1e06
      |-docker-253:1-50341699-98fbbd33dc311f06b12e422c67caab38683937fbecc4a93e018b289a281cbb36 252:18   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/98fbbd33dc311f06b12e422c67caab38683937fbecc4a93e018b289a281cbb36
      |-docker-253:1-50341699-e876a68c622a7f296be21c0cf985f6bb50ab03cd8531c193c7e8f9dcbc18794b 252:21   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/e876a68c622a7f296be21c0cf985f6bb50ab03cd8531c193c7e8f9dcbc18794b
      `-docker-253:1-50341699-25cef72fac203737fa15b236f246f1b8859528095b1de00d83b50532afd71ece 252:22   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/25cef72fac203737fa15b236f246f1b8859528095b1de00d83b50532afd71ece
vdc                                                                                            253:32   0   10G  0 disk

node-1.rajranjaapps.lab.pnq2.cee.redhat.com | SUCCESS | rc=0 >>
NAME                                                                                           MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
vda                                                                                            253:0    0   80G  0 disk
`-vda1                                                                                         253:1    0   80G  0 part /
vdb                                                                                            253:16   0   10G  0 disk
`-vdb1                                                                                         253:17   0   10G  0 part
  `-docker--vg-docker--pool_tdata                                                              252:1    0 14.5G  0 lvm
    `-docker--vg-docker--pool                                                                  252:2    0 14.5G  0 lvm
      |-docker-253:1-50344928-252516a3aa274d5a31c3d5c6fe3bd26a3fa8fa0d1901e6ca07afeedebd635750 252:3    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/252516a3aa274d5a31c3d5c6fe3bd26a3fa8fa0d1901e6ca07afeedebd635750
      |-docker-253:1-50344928-fed7b548b86c544d541ec1f8bf90038badc0bf53b17780cfc49d32ebaa89ba9a 252:4    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/fed7b548b86c544d541ec1f8bf90038badc0bf53b17780cfc49d32ebaa89ba9a
      |-docker-253:1-50344928-2fb60b4416fd5f65f7c413c8a168c18ae833f16b6677ebd9445b9b9fdccc658c 252:5    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/2fb60b4416fd5f65f7c413c8a168c18ae833f16b6677ebd9445b9b9fdccc658c
      |-docker-253:1-50344928-b041e65dd5cc9eb8a3769611bc4ede0dc39f1b34ef90992eecb5dad9b59191e0 252:6    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/b041e65dd5cc9eb8a3769611bc4ede0dc39f1b34ef90992eecb5dad9b59191e0
      |-docker-253:1-50344928-dfadc2ceb4db7f3f3f8513e570ea867cb66ea20987f131832a571ed77179f5fd 252:7    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/dfadc2ceb4db7f3f3f8513e570ea867cb66ea20987f131832a571ed77179f5fd
      |-docker-253:1-50344928-3fb111886a56f94ee745a024d281d970e4c8e1ae5098c3641aff537e1b589613 252:8    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/3fb111886a56f94ee745a024d281d970e4c8e1ae5098c3641aff537e1b589613
      |-docker-253:1-50344928-46e1ed90bbc46c1f2c883f11a99f359e7334290802d8983d90c840736aaab220 252:9    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/46e1ed90bbc46c1f2c883f11a99f359e7334290802d8983d90c840736aaab220
      |-docker-253:1-50344928-c1553e1ccc7066dee9fe6e1a0267ea10fbedfa98e26c18782a0e9271586d135c 252:10   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/c1553e1ccc7066dee9fe6e1a0267ea10fbedfa98e26c18782a0e9271586d135c
      |-docker-253:1-50344928-01e188750bd4e703c03690454c4cdafee47718f5dbd31f7faa208d9abcc3b16f 252:11   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/01e188750bd4e703c03690454c4cdafee47718f5dbd31f7faa208d9abcc3b16f
      |-docker-253:1-50344928-7349b0cb71e515d7deab005b0749f2ede6e809aec409d46fe0bf1175633ecddb 252:12   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/7349b0cb71e515d7deab005b0749f2ede6e809aec409d46fe0bf1175633ecddb
      |-docker-253:1-50344928-49fb787ab470710e20c41c0fa5828b55cbee7afd58f466ef32612850c3bf6916 252:13   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/49fb787ab470710e20c41c0fa5828b55cbee7afd58f466ef32612850c3bf6916
      |-docker-253:1-50344928-db19a2542f3e7e749d5d95ba37f6a4a161d7c41369cde158cfdad87a86e9b30e 252:14   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/db19a2542f3e7e749d5d95ba37f6a4a161d7c41369cde158cfdad87a86e9b30e
      |-docker-253:1-50344928-c395c9e807cb7287c704af1e2f415cdea6c208328a6b0650495b32b8b2122e08 252:15   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/c395c9e807cb7287c704af1e2f415cdea6c208328a6b0650495b32b8b2122e08
      |-docker-253:1-50344928-82ff5ba6aa3a40444193f4c967ba293dbd972ef6abc63403af3eb187bb419157 252:16   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/82ff5ba6aa3a40444193f4c967ba293dbd972ef6abc63403af3eb187bb419157
      |-docker-253:1-50344928-893f2e7156389cce17a7c56f0e47dbd3c28c2e602654e297fb5060eedfceadb4 252:17   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/893f2e7156389cce17a7c56f0e47dbd3c28c2e602654e297fb5060eedfceadb4
      |-docker-253:1-50344928-f2c20711c1e9eb81ccbb934a5d510971702cade9230af1df33d301115bcf2438 252:18   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/f2c20711c1e9eb81ccbb934a5d510971702cade9230af1df33d301115bcf2438
      |-docker-253:1-50344928-3a3e7ce06365e7b3bc1f21300c7b0ab51877136af0bb5c27cd2db30bbe3cdde2 252:19   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/3a3e7ce06365e7b3bc1f21300c7b0ab51877136af0bb5c27cd2db30bbe3cdde2
      |-docker-253:1-50344928-bc6f63e3d8b71aef582b6834ff79cab241a31524d46f116c5190390ad5f363fe 252:20   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/bc6f63e3d8b71aef582b6834ff79cab241a31524d46f116c5190390ad5f363fe
      |-docker-253:1-50344928-57246c6e4b87c8ecce310924fe9ba9bbf3e84f8a19ea3b04a8fac0ac34ba3380 252:21   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/57246c6e4b87c8ecce310924fe9ba9bbf3e84f8a19ea3b04a8fac0ac34ba3380
      `-docker-253:1-50344928-70c597e69c6b81692fb8fd11cdc662cc6b5d2691a7dd9d9be0adbb59c9561129 252:22   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/70c597e69c6b81692fb8fd11cdc662cc6b5d2691a7dd9d9be0adbb59c9561129
vdc                                                                                            253:32   0   10G  0 disk
`-vdc1                                                                                         253:33   0   10G  0 part
  |-docker--vg-docker--pool_tmeta                                                              252:0    0   12M  0 lvm
  | `-docker--vg-docker--pool                                                                  252:2    0 14.5G  0 lvm
  |   |-docker-253:1-50344928-252516a3aa274d5a31c3d5c6fe3bd26a3fa8fa0d1901e6ca07afeedebd635750 252:3    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/252516a3aa274d5a31c3d5c6fe3bd26a3fa8fa0d1901e6ca07afeedebd635750
  |   |-docker-253:1-50344928-fed7b548b86c544d541ec1f8bf90038badc0bf53b17780cfc49d32ebaa89ba9a 252:4    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/fed7b548b86c544d541ec1f8bf90038badc0bf53b17780cfc49d32ebaa89ba9a
  |   |-docker-253:1-50344928-2fb60b4416fd5f65f7c413c8a168c18ae833f16b6677ebd9445b9b9fdccc658c 252:5    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/2fb60b4416fd5f65f7c413c8a168c18ae833f16b6677ebd9445b9b9fdccc658c
  |   |-docker-253:1-50344928-b041e65dd5cc9eb8a3769611bc4ede0dc39f1b34ef90992eecb5dad9b59191e0 252:6    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/b041e65dd5cc9eb8a3769611bc4ede0dc39f1b34ef90992eecb5dad9b59191e0
  |   |-docker-253:1-50344928-dfadc2ceb4db7f3f3f8513e570ea867cb66ea20987f131832a571ed77179f5fd 252:7    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/dfadc2ceb4db7f3f3f8513e570ea867cb66ea20987f131832a571ed77179f5fd
  |   |-docker-253:1-50344928-3fb111886a56f94ee745a024d281d970e4c8e1ae5098c3641aff537e1b589613 252:8    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/3fb111886a56f94ee745a024d281d970e4c8e1ae5098c3641aff537e1b589613
  |   |-docker-253:1-50344928-46e1ed90bbc46c1f2c883f11a99f359e7334290802d8983d90c840736aaab220 252:9    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/46e1ed90bbc46c1f2c883f11a99f359e7334290802d8983d90c840736aaab220
  |   |-docker-253:1-50344928-c1553e1ccc7066dee9fe6e1a0267ea10fbedfa98e26c18782a0e9271586d135c 252:10   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/c1553e1ccc7066dee9fe6e1a0267ea10fbedfa98e26c18782a0e9271586d135c
  |   |-docker-253:1-50344928-01e188750bd4e703c03690454c4cdafee47718f5dbd31f7faa208d9abcc3b16f 252:11   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/01e188750bd4e703c03690454c4cdafee47718f5dbd31f7faa208d9abcc3b16f
  |   |-docker-253:1-50344928-7349b0cb71e515d7deab005b0749f2ede6e809aec409d46fe0bf1175633ecddb 252:12   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/7349b0cb71e515d7deab005b0749f2ede6e809aec409d46fe0bf1175633ecddb
  |   |-docker-253:1-50344928-49fb787ab470710e20c41c0fa5828b55cbee7afd58f466ef32612850c3bf6916 252:13   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/49fb787ab470710e20c41c0fa5828b55cbee7afd58f466ef32612850c3bf6916
  |   |-docker-253:1-50344928-db19a2542f3e7e749d5d95ba37f6a4a161d7c41369cde158cfdad87a86e9b30e 252:14   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/db19a2542f3e7e749d5d95ba37f6a4a161d7c41369cde158cfdad87a86e9b30e
  |   |-docker-253:1-50344928-c395c9e807cb7287c704af1e2f415cdea6c208328a6b0650495b32b8b2122e08 252:15   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/c395c9e807cb7287c704af1e2f415cdea6c208328a6b0650495b32b8b2122e08
  |   |-docker-253:1-50344928-82ff5ba6aa3a40444193f4c967ba293dbd972ef6abc63403af3eb187bb419157 252:16   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/82ff5ba6aa3a40444193f4c967ba293dbd972ef6abc63403af3eb187bb419157
  |   |-docker-253:1-50344928-893f2e7156389cce17a7c56f0e47dbd3c28c2e602654e297fb5060eedfceadb4 252:17   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/893f2e7156389cce17a7c56f0e47dbd3c28c2e602654e297fb5060eedfceadb4
  |   |-docker-253:1-50344928-f2c20711c1e9eb81ccbb934a5d510971702cade9230af1df33d301115bcf2438 252:18   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/f2c20711c1e9eb81ccbb934a5d510971702cade9230af1df33d301115bcf2438
  |   |-docker-253:1-50344928-3a3e7ce06365e7b3bc1f21300c7b0ab51877136af0bb5c27cd2db30bbe3cdde2 252:19   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/3a3e7ce06365e7b3bc1f21300c7b0ab51877136af0bb5c27cd2db30bbe3cdde2
  |   |-docker-253:1-50344928-bc6f63e3d8b71aef582b6834ff79cab241a31524d46f116c5190390ad5f363fe 252:20   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/bc6f63e3d8b71aef582b6834ff79cab241a31524d46f116c5190390ad5f363fe
  |   |-docker-253:1-50344928-57246c6e4b87c8ecce310924fe9ba9bbf3e84f8a19ea3b04a8fac0ac34ba3380 252:21   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/57246c6e4b87c8ecce310924fe9ba9bbf3e84f8a19ea3b04a8fac0ac34ba3380
  |   `-docker-253:1-50344928-70c597e69c6b81692fb8fd11cdc662cc6b5d2691a7dd9d9be0adbb59c9561129 252:22   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/70c597e69c6b81692fb8fd11cdc662cc6b5d2691a7dd9d9be0adbb59c9561129
  `-docker--vg-docker--pool_tdata                                                              252:1    0 14.5G  0 lvm
    `-docker--vg-docker--pool                                                                  252:2    0 14.5G  0 lvm
      |-docker-253:1-50344928-252516a3aa274d5a31c3d5c6fe3bd26a3fa8fa0d1901e6ca07afeedebd635750 252:3    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/252516a3aa274d5a31c3d5c6fe3bd26a3fa8fa0d1901e6ca07afeedebd635750
      |-docker-253:1-50344928-fed7b548b86c544d541ec1f8bf90038badc0bf53b17780cfc49d32ebaa89ba9a 252:4    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/fed7b548b86c544d541ec1f8bf90038badc0bf53b17780cfc49d32ebaa89ba9a
      |-docker-253:1-50344928-2fb60b4416fd5f65f7c413c8a168c18ae833f16b6677ebd9445b9b9fdccc658c 252:5    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/2fb60b4416fd5f65f7c413c8a168c18ae833f16b6677ebd9445b9b9fdccc658c
      |-docker-253:1-50344928-b041e65dd5cc9eb8a3769611bc4ede0dc39f1b34ef90992eecb5dad9b59191e0 252:6    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/b041e65dd5cc9eb8a3769611bc4ede0dc39f1b34ef90992eecb5dad9b59191e0
      |-docker-253:1-50344928-dfadc2ceb4db7f3f3f8513e570ea867cb66ea20987f131832a571ed77179f5fd 252:7    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/dfadc2ceb4db7f3f3f8513e570ea867cb66ea20987f131832a571ed77179f5fd
      |-docker-253:1-50344928-3fb111886a56f94ee745a024d281d970e4c8e1ae5098c3641aff537e1b589613 252:8    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/3fb111886a56f94ee745a024d281d970e4c8e1ae5098c3641aff537e1b589613
      |-docker-253:1-50344928-46e1ed90bbc46c1f2c883f11a99f359e7334290802d8983d90c840736aaab220 252:9    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/46e1ed90bbc46c1f2c883f11a99f359e7334290802d8983d90c840736aaab220
      |-docker-253:1-50344928-c1553e1ccc7066dee9fe6e1a0267ea10fbedfa98e26c18782a0e9271586d135c 252:10   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/c1553e1ccc7066dee9fe6e1a0267ea10fbedfa98e26c18782a0e9271586d135c
      |-docker-253:1-50344928-01e188750bd4e703c03690454c4cdafee47718f5dbd31f7faa208d9abcc3b16f 252:11   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/01e188750bd4e703c03690454c4cdafee47718f5dbd31f7faa208d9abcc3b16f
      |-docker-253:1-50344928-7349b0cb71e515d7deab005b0749f2ede6e809aec409d46fe0bf1175633ecddb 252:12   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/7349b0cb71e515d7deab005b0749f2ede6e809aec409d46fe0bf1175633ecddb
      |-docker-253:1-50344928-49fb787ab470710e20c41c0fa5828b55cbee7afd58f466ef32612850c3bf6916 252:13   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/49fb787ab470710e20c41c0fa5828b55cbee7afd58f466ef32612850c3bf6916
      |-docker-253:1-50344928-db19a2542f3e7e749d5d95ba37f6a4a161d7c41369cde158cfdad87a86e9b30e 252:14   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/db19a2542f3e7e749d5d95ba37f6a4a161d7c41369cde158cfdad87a86e9b30e
      |-docker-253:1-50344928-c395c9e807cb7287c704af1e2f415cdea6c208328a6b0650495b32b8b2122e08 252:15   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/c395c9e807cb7287c704af1e2f415cdea6c208328a6b0650495b32b8b2122e08
      |-docker-253:1-50344928-82ff5ba6aa3a40444193f4c967ba293dbd972ef6abc63403af3eb187bb419157 252:16   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/82ff5ba6aa3a40444193f4c967ba293dbd972ef6abc63403af3eb187bb419157
      |-docker-253:1-50344928-893f2e7156389cce17a7c56f0e47dbd3c28c2e602654e297fb5060eedfceadb4 252:17   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/893f2e7156389cce17a7c56f0e47dbd3c28c2e602654e297fb5060eedfceadb4
      |-docker-253:1-50344928-f2c20711c1e9eb81ccbb934a5d510971702cade9230af1df33d301115bcf2438 252:18   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/f2c20711c1e9eb81ccbb934a5d510971702cade9230af1df33d301115bcf2438
      |-docker-253:1-50344928-3a3e7ce06365e7b3bc1f21300c7b0ab51877136af0bb5c27cd2db30bbe3cdde2 252:19   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/3a3e7ce06365e7b3bc1f21300c7b0ab51877136af0bb5c27cd2db30bbe3cdde2
      |-docker-253:1-50344928-bc6f63e3d8b71aef582b6834ff79cab241a31524d46f116c5190390ad5f363fe 252:20   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/bc6f63e3d8b71aef582b6834ff79cab241a31524d46f116c5190390ad5f363fe
      |-docker-253:1-50344928-57246c6e4b87c8ecce310924fe9ba9bbf3e84f8a19ea3b04a8fac0ac34ba3380 252:21   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/57246c6e4b87c8ecce310924fe9ba9bbf3e84f8a19ea3b04a8fac0ac34ba3380
      `-docker-253:1-50344928-70c597e69c6b81692fb8fd11cdc662cc6b5d2691a7dd9d9be0adbb59c9561129 252:22   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/70c597e69c6b81692fb8fd11cdc662cc6b5d2691a7dd9d9be0adbb59c9561129

node-0.rajranjainfra.lab.pnq2.cee.redhat.com | SUCCESS | rc=0 >>
NAME                                                                                           MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
vda                                                                                            253:0    0   80G  0 disk
`-vda1                                                                                         253:1    0   80G  0 part /
vdb                                                                                            253:16   0   10G  0 disk
`-vdb1                                                                                         253:17   0   10G  0 part
  |-docker--vg-docker--pool_tmeta                                                              252:0    0   12M  0 lvm
  | `-docker--vg-docker--pool                                                                  252:2    0  9.9G  0 lvm
  |   |-docker-253:1-21594097-8c8dc5b9693f855605566b68f399ea541c49c0a9da6d1dbd76d3271b29f787fc 252:3    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/8c8dc5b9693f855605566b68f399ea541c49c0a9da6d1dbd76d3271b29f787fc
  |   |-docker-253:1-21594097-557e6d67487aeaab7d58b2cdadc110c00ece88f88662d5d6604cbf5a0bf834c5 252:4    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/557e6d67487aeaab7d58b2cdadc110c00ece88f88662d5d6604cbf5a0bf834c5
  |   |-docker-253:1-21594097-a7f24b8093cf0fbbb63e9949e5e45c48861019d9c01e4853bcffa7845ed32485 252:5    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/a7f24b8093cf0fbbb63e9949e5e45c48861019d9c01e4853bcffa7845ed32485
  |   |-docker-253:1-21594097-e4188278a433325e518ec69588e15a53873b04fb0e33e33b065d0965aa9cb88a 252:6    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/e4188278a433325e518ec69588e15a53873b04fb0e33e33b065d0965aa9cb88a
  |   |-docker-253:1-21594097-80283aff8a5d11f3991e44d5b7c5e6440a29d4da028895263fe7e107b2093da6 252:7    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/80283aff8a5d11f3991e44d5b7c5e6440a29d4da028895263fe7e107b2093da6
  |   |-docker-253:1-21594097-8a706e0e43cda9cdb143d0583a972098a293a83827fcf51446a7b6673b84db5f 252:8    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/8a706e0e43cda9cdb143d0583a972098a293a83827fcf51446a7b6673b84db5f
  |   |-docker-253:1-21594097-baca38eea6430358c1f0f158170714eebde47806cbee38160947714dee6ccaf9 252:9    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/baca38eea6430358c1f0f158170714eebde47806cbee38160947714dee6ccaf9
  |   |-docker-253:1-21594097-c01b32e3c5226ef365e99403d8887ee1a11ee28195f47247bd05278783bba270 252:10   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/c01b32e3c5226ef365e99403d8887ee1a11ee28195f47247bd05278783bba270
  |   `-docker-253:1-21594097-6d785decc2d5bdab9229a96b9493e9ef4c06a716dbe45fc45649bd6eade05b90 252:11   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/6d785decc2d5bdab9229a96b9493e9ef4c06a716dbe45fc45649bd6eade05b90
  `-docker--vg-docker--pool_tdata                                                              252:1    0  9.9G  0 lvm
    `-docker--vg-docker--pool                                                                  252:2    0  9.9G  0 lvm
      |-docker-253:1-21594097-8c8dc5b9693f855605566b68f399ea541c49c0a9da6d1dbd76d3271b29f787fc 252:3    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/8c8dc5b9693f855605566b68f399ea541c49c0a9da6d1dbd76d3271b29f787fc
      |-docker-253:1-21594097-557e6d67487aeaab7d58b2cdadc110c00ece88f88662d5d6604cbf5a0bf834c5 252:4    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/557e6d67487aeaab7d58b2cdadc110c00ece88f88662d5d6604cbf5a0bf834c5
      |-docker-253:1-21594097-a7f24b8093cf0fbbb63e9949e5e45c48861019d9c01e4853bcffa7845ed32485 252:5    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/a7f24b8093cf0fbbb63e9949e5e45c48861019d9c01e4853bcffa7845ed32485
      |-docker-253:1-21594097-e4188278a433325e518ec69588e15a53873b04fb0e33e33b065d0965aa9cb88a 252:6    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/e4188278a433325e518ec69588e15a53873b04fb0e33e33b065d0965aa9cb88a
      |-docker-253:1-21594097-80283aff8a5d11f3991e44d5b7c5e6440a29d4da028895263fe7e107b2093da6 252:7    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/80283aff8a5d11f3991e44d5b7c5e6440a29d4da028895263fe7e107b2093da6
      |-docker-253:1-21594097-8a706e0e43cda9cdb143d0583a972098a293a83827fcf51446a7b6673b84db5f 252:8    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/8a706e0e43cda9cdb143d0583a972098a293a83827fcf51446a7b6673b84db5f
      |-docker-253:1-21594097-baca38eea6430358c1f0f158170714eebde47806cbee38160947714dee6ccaf9 252:9    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/baca38eea6430358c1f0f158170714eebde47806cbee38160947714dee6ccaf9
      |-docker-253:1-21594097-c01b32e3c5226ef365e99403d8887ee1a11ee28195f47247bd05278783bba270 252:10   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/c01b32e3c5226ef365e99403d8887ee1a11ee28195f47247bd05278783bba270
      `-docker-253:1-21594097-6d785decc2d5bdab9229a96b9493e9ef4c06a716dbe45fc45649bd6eade05b90 252:11   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/6d785decc2d5bdab9229a96b9493e9ef4c06a716dbe45fc45649bd6eade05b90
vdc                                                                                            253:32   0   10G  0 disk
`-vdc1                                                                                         253:33   0   10G  0 part /mnt/local-storage/virtual/metric/disk1
vdd                                                                                            253:48   0   10G  0 disk
vde                                                                                            253:64   0   10G  0 disk

node-1.rajranjalb.lab.pnq2.cee.redhat.com | SUCCESS | rc=0 >>
NAME   MAJ:MIN RM SIZE RO TYPE MOUNTPOINT
vda    253:0    0  20G  0 disk
`-vda1 253:1    0  20G  0 part /

node-0.rajranjanfs.lab.pnq2.cee.redhat.com | SUCCESS | rc=0 >>
NAME                          MAJ:MIN RM SIZE RO TYPE MOUNTPOINT
vda                           253:0    0  40G  0 disk
`-vda1                        253:1    0  40G  0 part /
vdb                           253:16   0  10G  0 disk
`-vdb1                        253:17   0  10G  0 part
  `-vg--registry-lv--registry 252:1    0  10G  0 lvm
vdc                           253:32   0  10G  0 disk
`-vdc1                        253:33   0  10G  0 part
  `-vg--apps-lv--apps         252:0    0  10G  0 lvm

node-1.rajranjainfra.lab.pnq2.cee.redhat.com | SUCCESS | rc=0 >>
NAME                                                                                           MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
vda                                                                                            253:0    0   80G  0 disk
`-vda1                                                                                         253:1    0   80G  0 part /
vdb                                                                                            253:16   0   10G  0 disk
`-vdb1                                                                                         253:17   0   10G  0 part
  |-docker--vg-docker--pool_tmeta                                                              252:0    0   12M  0 lvm
  | `-docker--vg-docker--pool                                                                  252:2    0  9.9G  0 lvm
  |   |-docker-253:1-50344928-c4bef2b0c18ef0146aa672b47152965a04467ece592ef49734b7f7b3d3246797 252:3    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/c4bef2b0c18ef0146aa672b47152965a04467ece592ef49734b7f7b3d3246797
  |   |-docker-253:1-50344928-63b6de02e915cfd366575d36438eafde304da7d3a8439fc00e1b35c064f769ad 252:4    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/63b6de02e915cfd366575d36438eafde304da7d3a8439fc00e1b35c064f769ad
  |   |-docker-253:1-50344928-01819db652e37e4e2d15c9ab75dab3e1524997a3357c49ea9b25356723849c73 252:5    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/01819db652e37e4e2d15c9ab75dab3e1524997a3357c49ea9b25356723849c73
  |   |-docker-253:1-50344928-2883eef7e67037bbcbc8c9fcf109a3af3df914f89cace1623fe41a08c3f96a71 252:6    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/2883eef7e67037bbcbc8c9fcf109a3af3df914f89cace1623fe41a08c3f96a71
  |   |-docker-253:1-50344928-e467923c9b5b830005b7a51f6dcc25c263062945ef3e4b6accc251c3e2eaaebe 252:7    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/e467923c9b5b830005b7a51f6dcc25c263062945ef3e4b6accc251c3e2eaaebe
  |   |-docker-253:1-50344928-a7a25a8e8bfbcb0ce152edede62b1e8cd8dabdc7f9285a407e11e03467a4fb1b 252:8    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/a7a25a8e8bfbcb0ce152edede62b1e8cd8dabdc7f9285a407e11e03467a4fb1b
  |   |-docker-253:1-50344928-5661c8cd32e57888c21ac37b2f4664a65a36add98f0dfbc25cef569d14121a80 252:9    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/5661c8cd32e57888c21ac37b2f4664a65a36add98f0dfbc25cef569d14121a80
  |   |-docker-253:1-50344928-0e794b25de545dc24b9726492896ba6fcce342f6496e3c60f2dc16193d891043 252:10   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/0e794b25de545dc24b9726492896ba6fcce342f6496e3c60f2dc16193d891043
  |   |-docker-253:1-50344928-9ced12b7ade942fdff3ab9218fa4140ace2f070b7a7669b568e21b85b9b32a51 252:11   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/9ced12b7ade942fdff3ab9218fa4140ace2f070b7a7669b568e21b85b9b32a51
  |   |-docker-253:1-50344928-62d9303ab840c93fe72a501aacc020d14dce3b6744959cd99c8bfeb0ab72d9e8 252:12   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/62d9303ab840c93fe72a501aacc020d14dce3b6744959cd99c8bfeb0ab72d9e8
  |   |-docker-253:1-50344928-9a9696f3e83139ba86ddedaf189bfa53291dd53268b6ab8aa8cea2bb1febe80b 252:13   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/9a9696f3e83139ba86ddedaf189bfa53291dd53268b6ab8aa8cea2bb1febe80b
  |   |-docker-253:1-50344928-b49336e8c056074a82c87d2b27fba982e9c61376c2818ad38b2e8c27e5a87105 252:14   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/b49336e8c056074a82c87d2b27fba982e9c61376c2818ad38b2e8c27e5a87105
  |   |-docker-253:1-50344928-d080ccd061c7aded4ba72e87a053d0c615e4cb6db1a80aa73a9e3abb19570b5b 252:15   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/d080ccd061c7aded4ba72e87a053d0c615e4cb6db1a80aa73a9e3abb19570b5b
  |   `-docker-253:1-50344928-021c3fd13b7d0a636af68fb893c41e9f0a394220c88220ac2fb899cea6e0994a 252:16   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/021c3fd13b7d0a636af68fb893c41e9f0a394220c88220ac2fb899cea6e0994a
  `-docker--vg-docker--pool_tdata                                                              252:1    0  9.9G  0 lvm
    `-docker--vg-docker--pool                                                                  252:2    0  9.9G  0 lvm
      |-docker-253:1-50344928-c4bef2b0c18ef0146aa672b47152965a04467ece592ef49734b7f7b3d3246797 252:3    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/c4bef2b0c18ef0146aa672b47152965a04467ece592ef49734b7f7b3d3246797
      |-docker-253:1-50344928-63b6de02e915cfd366575d36438eafde304da7d3a8439fc00e1b35c064f769ad 252:4    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/63b6de02e915cfd366575d36438eafde304da7d3a8439fc00e1b35c064f769ad
      |-docker-253:1-50344928-01819db652e37e4e2d15c9ab75dab3e1524997a3357c49ea9b25356723849c73 252:5    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/01819db652e37e4e2d15c9ab75dab3e1524997a3357c49ea9b25356723849c73
      |-docker-253:1-50344928-2883eef7e67037bbcbc8c9fcf109a3af3df914f89cace1623fe41a08c3f96a71 252:6    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/2883eef7e67037bbcbc8c9fcf109a3af3df914f89cace1623fe41a08c3f96a71
      |-docker-253:1-50344928-e467923c9b5b830005b7a51f6dcc25c263062945ef3e4b6accc251c3e2eaaebe 252:7    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/e467923c9b5b830005b7a51f6dcc25c263062945ef3e4b6accc251c3e2eaaebe
      |-docker-253:1-50344928-a7a25a8e8bfbcb0ce152edede62b1e8cd8dabdc7f9285a407e11e03467a4fb1b 252:8    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/a7a25a8e8bfbcb0ce152edede62b1e8cd8dabdc7f9285a407e11e03467a4fb1b
      |-docker-253:1-50344928-5661c8cd32e57888c21ac37b2f4664a65a36add98f0dfbc25cef569d14121a80 252:9    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/5661c8cd32e57888c21ac37b2f4664a65a36add98f0dfbc25cef569d14121a80
      |-docker-253:1-50344928-0e794b25de545dc24b9726492896ba6fcce342f6496e3c60f2dc16193d891043 252:10   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/0e794b25de545dc24b9726492896ba6fcce342f6496e3c60f2dc16193d891043
      |-docker-253:1-50344928-9ced12b7ade942fdff3ab9218fa4140ace2f070b7a7669b568e21b85b9b32a51 252:11   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/9ced12b7ade942fdff3ab9218fa4140ace2f070b7a7669b568e21b85b9b32a51
      |-docker-253:1-50344928-62d9303ab840c93fe72a501aacc020d14dce3b6744959cd99c8bfeb0ab72d9e8 252:12   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/62d9303ab840c93fe72a501aacc020d14dce3b6744959cd99c8bfeb0ab72d9e8
      |-docker-253:1-50344928-9a9696f3e83139ba86ddedaf189bfa53291dd53268b6ab8aa8cea2bb1febe80b 252:13   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/9a9696f3e83139ba86ddedaf189bfa53291dd53268b6ab8aa8cea2bb1febe80b
      |-docker-253:1-50344928-b49336e8c056074a82c87d2b27fba982e9c61376c2818ad38b2e8c27e5a87105 252:14   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/b49336e8c056074a82c87d2b27fba982e9c61376c2818ad38b2e8c27e5a87105
      |-docker-253:1-50344928-d080ccd061c7aded4ba72e87a053d0c615e4cb6db1a80aa73a9e3abb19570b5b 252:15   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/d080ccd061c7aded4ba72e87a053d0c615e4cb6db1a80aa73a9e3abb19570b5b
      `-docker-253:1-50344928-021c3fd13b7d0a636af68fb893c41e9f0a394220c88220ac2fb899cea6e0994a 252:16   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/021c3fd13b7d0a636af68fb893c41e9f0a394220c88220ac2fb899cea6e0994a
vdc                                                                                            253:32   0   10G  0 disk
vdd                                                                                            253:48   0   10G  0 disk
`-vdd1                                                                                         253:49   0   10G  0 part /mnt/local-storage/virtual/metric/disk1
vde                                                                                            253:64   0   10G  0 disk

node-2.rajranjainfra.lab.pnq2.cee.redhat.com | SUCCESS | rc=0 >>
NAME                                                                                           MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
vda                                                                                            253:0    0   80G  0 disk
`-vda1                                                                                         253:1    0   80G  0 part /
vdb                                                                                            253:16   0   10G  0 disk
`-vdb1                                                                                         253:17   0   10G  0 part
vdc                                                                                            253:32   0   10G  0 disk
`-vdc1                                                                                         253:33   0   10G  0 part
  |-docker--vg-docker--pool_tmeta                                                              252:0    0   12M  0 lvm
  | `-docker--vg-docker--pool                                                                  252:2    0  9.9G  0 lvm
  |   |-docker-253:1-50344928-cc683927d84444b1f2de44bac8eec6130ea3ab17fa2429ea2dcb8a1da963a14e 252:3    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/cc683927d84444b1f2de44bac8eec6130ea3ab17fa2429ea2dcb8a1da963a14e
  |   |-docker-253:1-50344928-68b617925b7f5b3dda9df8af8312b848be73139453fa1ff171a1c2a67509f754 252:4    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/68b617925b7f5b3dda9df8af8312b848be73139453fa1ff171a1c2a67509f754
  |   |-docker-253:1-50344928-9d1210cfb22cc5a7afac5ba01713a8029db67c899044c76e5b80a0bb94f01bb8 252:6    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/9d1210cfb22cc5a7afac5ba01713a8029db67c899044c76e5b80a0bb94f01bb8
  |   |-docker-253:1-50344928-61eab28a70527a48b77e313603e48be928d27e2c23927d356b726245cafb8773 252:7    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/61eab28a70527a48b77e313603e48be928d27e2c23927d356b726245cafb8773
  |   |-docker-253:1-50344928-2e034d3796b0807dbecfde501d4c5705414a87aa314c6bfb00d04cfbdeececa9 252:8    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/2e034d3796b0807dbecfde501d4c5705414a87aa314c6bfb00d04cfbdeececa9
  |   |-docker-253:1-50344928-7d5a7af76f214e41214831afc1703d8d75c9f73b90c654d2b99eec147914a8e0 252:10   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/7d5a7af76f214e41214831afc1703d8d75c9f73b90c654d2b99eec147914a8e0
  |   |-docker-253:1-50344928-86441c441e17846ef4e0d291eb990d8ef5f5c0f79a1a6389e652df259ccc37bf 252:11   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/86441c441e17846ef4e0d291eb990d8ef5f5c0f79a1a6389e652df259ccc37bf
  |   |-docker-253:1-50344928-9783ea9ffd248920c3ebcd6012d69c005355d87ad9962028e34df8a04ee01182 252:12   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/9783ea9ffd248920c3ebcd6012d69c005355d87ad9962028e34df8a04ee01182
  |   |-docker-253:1-50344928-a92c5c992dcd98469eecafa49d91b6657b806e77edaaba55b3427d10518f7260 252:13   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/a92c5c992dcd98469eecafa49d91b6657b806e77edaaba55b3427d10518f7260
  |   |-docker-253:1-50344928-bbb840f1a2f728d88811cbd67c5fa1abc7d8ddb0cddfeca92354a0dab3d28f87 252:14   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/bbb840f1a2f728d88811cbd67c5fa1abc7d8ddb0cddfeca92354a0dab3d28f87
  |   |-docker-253:1-50344928-4cf5f128b0d2344255d9d28a2728938c508461c64b87a829497b2f7c185381ab 252:15   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/4cf5f128b0d2344255d9d28a2728938c508461c64b87a829497b2f7c185381ab
  |   |-docker-253:1-50344928-5d64f53192175e6b7f471d424c7061becf52589e286426d1c26f25ac15301bd0 252:16   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/5d64f53192175e6b7f471d424c7061becf52589e286426d1c26f25ac15301bd0
  |   |-docker-253:1-50344928-dd276c63b6cba6902a2f1bfd3a57c083de55a4331c81f2b46b8c180def712059 252:17   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/dd276c63b6cba6902a2f1bfd3a57c083de55a4331c81f2b46b8c180def712059
  |   |-docker-253:1-50344928-811dd49920cee993dd9e22fcead6474107dbf7d494aa6f2cd39b4c31f820e4bc 252:18   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/811dd49920cee993dd9e22fcead6474107dbf7d494aa6f2cd39b4c31f820e4bc
  |   |-docker-253:1-50344928-16fd285aa18c227fac3bce34a16a5b2e47948addcc903be75b60926d5837b2d9 252:19   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/16fd285aa18c227fac3bce34a16a5b2e47948addcc903be75b60926d5837b2d9
  |   |-docker-253:1-50344928-792afcca4c6cff5ee24187e0394a0969895202f2783e042cddd5bfa243fb96f9 252:20   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/792afcca4c6cff5ee24187e0394a0969895202f2783e042cddd5bfa243fb96f9
  |   |-docker-253:1-50344928-89c2aa8211c949934217144ddaa851ee686dc1cbdf67c42fe1e53ef1a032ed99 252:21   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/89c2aa8211c949934217144ddaa851ee686dc1cbdf67c42fe1e53ef1a032ed99
  |   |-docker-253:1-50344928-69075bc58b1a960b73e5a4b4f97396e0ba5a2c04778c8a67a9333621fdb42107 252:22   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/69075bc58b1a960b73e5a4b4f97396e0ba5a2c04778c8a67a9333621fdb42107
  |   `-docker-253:1-50344928-0d819c37cd151a86e78073eae7edfd8ac61026cd1db0f80b48f2a2cc685bb53c 252:23   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/0d819c37cd151a86e78073eae7edfd8ac61026cd1db0f80b48f2a2cc685bb53c
  `-docker--vg-docker--pool_tdata                                                              252:1    0  9.9G  0 lvm
    `-docker--vg-docker--pool                                                                  252:2    0  9.9G  0 lvm
      |-docker-253:1-50344928-cc683927d84444b1f2de44bac8eec6130ea3ab17fa2429ea2dcb8a1da963a14e 252:3    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/cc683927d84444b1f2de44bac8eec6130ea3ab17fa2429ea2dcb8a1da963a14e
      |-docker-253:1-50344928-68b617925b7f5b3dda9df8af8312b848be73139453fa1ff171a1c2a67509f754 252:4    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/68b617925b7f5b3dda9df8af8312b848be73139453fa1ff171a1c2a67509f754
      |-docker-253:1-50344928-9d1210cfb22cc5a7afac5ba01713a8029db67c899044c76e5b80a0bb94f01bb8 252:6    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/9d1210cfb22cc5a7afac5ba01713a8029db67c899044c76e5b80a0bb94f01bb8
      |-docker-253:1-50344928-61eab28a70527a48b77e313603e48be928d27e2c23927d356b726245cafb8773 252:7    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/61eab28a70527a48b77e313603e48be928d27e2c23927d356b726245cafb8773
      |-docker-253:1-50344928-2e034d3796b0807dbecfde501d4c5705414a87aa314c6bfb00d04cfbdeececa9 252:8    0   10G  0 dm   /var/lib/docker/devicemapper/mnt/2e034d3796b0807dbecfde501d4c5705414a87aa314c6bfb00d04cfbdeececa9
      |-docker-253:1-50344928-7d5a7af76f214e41214831afc1703d8d75c9f73b90c654d2b99eec147914a8e0 252:10   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/7d5a7af76f214e41214831afc1703d8d75c9f73b90c654d2b99eec147914a8e0
      |-docker-253:1-50344928-86441c441e17846ef4e0d291eb990d8ef5f5c0f79a1a6389e652df259ccc37bf 252:11   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/86441c441e17846ef4e0d291eb990d8ef5f5c0f79a1a6389e652df259ccc37bf
      |-docker-253:1-50344928-9783ea9ffd248920c3ebcd6012d69c005355d87ad9962028e34df8a04ee01182 252:12   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/9783ea9ffd248920c3ebcd6012d69c005355d87ad9962028e34df8a04ee01182
      |-docker-253:1-50344928-a92c5c992dcd98469eecafa49d91b6657b806e77edaaba55b3427d10518f7260 252:13   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/a92c5c992dcd98469eecafa49d91b6657b806e77edaaba55b3427d10518f7260
      |-docker-253:1-50344928-bbb840f1a2f728d88811cbd67c5fa1abc7d8ddb0cddfeca92354a0dab3d28f87 252:14   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/bbb840f1a2f728d88811cbd67c5fa1abc7d8ddb0cddfeca92354a0dab3d28f87
      |-docker-253:1-50344928-4cf5f128b0d2344255d9d28a2728938c508461c64b87a829497b2f7c185381ab 252:15   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/4cf5f128b0d2344255d9d28a2728938c508461c64b87a829497b2f7c185381ab
      |-docker-253:1-50344928-5d64f53192175e6b7f471d424c7061becf52589e286426d1c26f25ac15301bd0 252:16   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/5d64f53192175e6b7f471d424c7061becf52589e286426d1c26f25ac15301bd0
      |-docker-253:1-50344928-dd276c63b6cba6902a2f1bfd3a57c083de55a4331c81f2b46b8c180def712059 252:17   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/dd276c63b6cba6902a2f1bfd3a57c083de55a4331c81f2b46b8c180def712059
      |-docker-253:1-50344928-811dd49920cee993dd9e22fcead6474107dbf7d494aa6f2cd39b4c31f820e4bc 252:18   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/811dd49920cee993dd9e22fcead6474107dbf7d494aa6f2cd39b4c31f820e4bc
      |-docker-253:1-50344928-16fd285aa18c227fac3bce34a16a5b2e47948addcc903be75b60926d5837b2d9 252:19   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/16fd285aa18c227fac3bce34a16a5b2e47948addcc903be75b60926d5837b2d9
      |-docker-253:1-50344928-792afcca4c6cff5ee24187e0394a0969895202f2783e042cddd5bfa243fb96f9 252:20   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/792afcca4c6cff5ee24187e0394a0969895202f2783e042cddd5bfa243fb96f9
      |-docker-253:1-50344928-89c2aa8211c949934217144ddaa851ee686dc1cbdf67c42fe1e53ef1a032ed99 252:21   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/89c2aa8211c949934217144ddaa851ee686dc1cbdf67c42fe1e53ef1a032ed99
      |-docker-253:1-50344928-69075bc58b1a960b73e5a4b4f97396e0ba5a2c04778c8a67a9333621fdb42107 252:22   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/69075bc58b1a960b73e5a4b4f97396e0ba5a2c04778c8a67a9333621fdb42107
      `-docker-253:1-50344928-0d819c37cd151a86e78073eae7edfd8ac61026cd1db0f80b48f2a2cc685bb53c 252:23   0   10G  0 dm   /var/lib/docker/devicemapper/mnt/0d819c37cd151a86e78073eae7edfd8ac61026cd1db0f80b48f2a2cc685bb53c
vdd                                                                                            253:48   0   10G  0 disk
vde                                                                                            253:64   0   10G  0 disk
`-vde1                                                                                         253:65   0   10G  0 part /mnt/local-storage/virtual/metric/disk1

node-0.rajranjalb.lab.pnq2.cee.redhat.com | SUCCESS | rc=0 >>
NAME   MAJ:MIN RM SIZE RO TYPE MOUNTPOINT
vda    253:0    0  20G  0 disk
`-vda1 253:1    0  20G  0 part /
```