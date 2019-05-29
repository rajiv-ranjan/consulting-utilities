## Profiling with OCP
>TODO Complete the commands. https://access.redhat.com/articles/2802041

1. Profiling platform
2. Profiling POD

### Thread
* Collect the thread dump from the pod

#### Apprach 1
For further reading see the [article](https://access.redhat.com/solutions/3388951) [AMQ](https://access.redhat.com/solutions/3405691) specific on how to capture jvm data from pods

```sh
wget https://access.redhat.com/knowledge/sites/default/files/attachments/java-ocp-diagnostic-tools.tar.gz -O java-ocp-diagnostic-tools.tar.gz
tar -xvf java-ocp-diagnostic-tools.tar.gz

```


#### Approach 2
For further reading see the [article](https://access.redhat.com/solutions/18178) on how to get the thread dump in Linux.
```sh
export POD=<your-pod-name>; 
PID=$(oc exec $POD ps aux | grep java | awk '{print $2}'); oc exec $POD -- bash -c "for x in {1..10}; do jstack -l $PID > /tmp/jstack.out; sleep 2; done"; oc rsync $POD:/tmp/jstack.out .
```

#### Approach 3
Great [article](https://access.redhat.com/solutions/46596) on how to identify high CPU usages

```sh
# Download the tool high_cpu_linux.tar.gz from red hat
mkdir -p /tmp/script;cd /tmp/script; wget https://access.redhat.com/node/46596/40/1/12270821 -O high_cpu_linux.tar.gz;
tar -xvf high_cpu_linux.tar.gz 
# upload to the pod
export POD=<your-pod-name>;
oc rsync /tmp/script $POD:/tmp
# change the iterations and delay as per need in the .sh file and then run it.
sh /tmp/high_cpu_linux_jstack.sh 1
```

* To analyse either use [JVMPeg tool](https://access.redhat.com/labs/jvmpeg/) from red hat or tools like [TDA](https://github.com/irockel/tda) or Samurai.

* Collect the heap dump from the pod

```sh
export POD=<your-pod-name>; 
oc exec $POD -- /usr/lib/jvm/java-1.8.0-openjdk/bin/jmap -J-d64 -dump:format=b,file='/opt/eap/standalone/tmp/heap.hprof' $(oc exec $POD ps aux | grep java | awk '{print $2}'); oc rsync $POD:/opt/eap/standalone/tmp/heap.hprof .
```

### Heap
* To analyse use [GCviewer](https://github.com/chewiebug/GCViewer)