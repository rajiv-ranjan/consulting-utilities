
* Get the list of app pods
```sh
# oc get pods
NAME                                READY     STATUS      RESTARTS   AGE
hello-world-spring-boot-1-build     0/1       Completed   0          2d
hello-world-spring-boot-6-m7v4t     1/1       Running     0          5m
spring-petclinic-1-build            0/1       Completed   0          2d
spring-petclinic-59b7778888-cqtrs   1/1       Running     0          2d
```

* Log inside the app pod and check the TimeZone (TZ)
```sh
# oc rsh hello-world-spring-boot-6-m7v4t
sh-4.2$ date
Wed May  8 14:17:27 JST 2019
```

* Exit the pod and check logs 
```sh
$ oc logs hello-world-spring-boot-6-m7v4t --tail 5
2019-05-08 14:10:49.689  INFO 1 --- [           main] o.s.w.s.handler.SimpleUrlHandlerMapping  : Mapped URL path [/**] onto handler of type [class org.springframework.web.servlet.resource.ResourceHttpRequestHandler]
2019-05-08 14:10:49.713  INFO 1 --- [           main] o.s.w.s.handler.SimpleUrlHandlerMapping  : Mapped URL path [/**/favicon.ico] onto handler of type [class org.springframework.web.servlet.resource.ResourceHttpRequestHandler]
2019-05-08 14:10:49.784  INFO 1 --- [           main] o.s.j.e.a.AnnotationMBeanExporter        : Registering beans for JMX exposure on startup
2019-05-08 14:10:49.837  INFO 1 --- [           main] s.b.c.e.t.TomcatEmbeddedServletContainer : Tomcat started on port(s): 8080 (http)
2019-05-08 14:10:49.841  INFO 1 --- [           main] Example                                  : Started Example in 2.514 seconds (JVM running for 2.978)
```

* Change the TZ to Dhaka and make sure the dc has changed and new pods are running
```sh
$ oc set env dc/hello-world-spring-boot TZ=Asia/Dhaka
deploymentconfig.apps.openshift.io/hello-world-spring-boot updated

$ oc get pods
NAME                                READY     STATUS      RESTARTS   AGE
hello-world-spring-boot-1-build     0/1       Completed   0          2d
hello-world-spring-boot-7-pc82m     1/1       Running     0          35s
spring-petclinic-1-build            0/1       Completed   0          2d
spring-petclinic-59b7778888-cqtrs   1/1       Running     0          2d
```

* Check the TZ and logs
```sh
$ oc rsh hello-world-spring-boot-7-pc82m
sh-4.2$ date
Wed May  8 11:30:09 +06 2019
$ oc logs hello-world-spring-boot-7-pc82m --tail 5
2019-05-08 11:28:28.630  INFO 1 --- [           main] o.s.w.s.handler.SimpleUrlHandlerMapping  : Mapped URL path [/**] onto handler of type [class org.springframework.web.servlet.resource.ResourceHttpRequestHandler]
2019-05-08 11:28:28.661  INFO 1 --- [           main] o.s.w.s.handler.SimpleUrlHandlerMapping  : Mapped URL path [/**/favicon.ico] onto handler of type [class org.springframework.web.servlet.resource.ResourceHttpRequestHandler]
2019-05-08 11:28:28.745  INFO 1 --- [           main] o.s.j.e.a.AnnotationMBeanExporter        : Registering beans for JMX exposure on startup
2019-05-08 11:28:28.789  INFO 1 --- [           main] s.b.c.e.t.TomcatEmbeddedServletContainer : Tomcat started on port(s): 8080 (http)
2019-05-08 11:28:28.792  INFO 1 --- [           main] Example                                  : Started Example in 2.583 seconds (JVM running for 2.982)
```


Reference: https://access.redhat.com/solutions/2567961