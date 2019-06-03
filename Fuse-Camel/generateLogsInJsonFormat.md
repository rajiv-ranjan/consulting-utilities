* Include the dependencies for using json logback libraries. While using Spring Boot, the versions of the logback dependencies imported by Spring Boot starter need to be excluded, as they are older versions

```xml
    <properties>
        <ch.qos.logback.version>1.2.3</ch.qos.logback.version>
    </properties>

        <!-- Older versions may be imported by Spring Boot starters that haven't been tested with 4.11 -->
        
        <dependency>
            <groupId>ch.qos.logback</groupId>
            <artifactId>logback-core</artifactId>
            <version>${ch.qos.logback.version}</version>
        </dependency>
        <dependency>
            <groupId>ch.qos.logback</groupId>
            <artifactId>logback-classic</artifactId>
            <version>${ch.qos.logback.version}</version>
        </dependency>
        <dependency>
            <groupId>ch.qos.logback</groupId>
            <artifactId>logback-access</artifactId>
            <version>${ch.qos.logback.version}</version>
        </dependency>



        <dependency>
            <groupId>net.logstash.logback</groupId>
            <artifactId>logstash-logback-encoder</artifactId>
            <version>4.11</version>
        </dependency>
```

* Create a logback.xml property file in classpath (/src/main/resource)
```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xml>
<configuration scan="true" scanPeriod="30 seconds">
    <appender name="STDOUT" class="ch.qos.logback.core.ConsoleAppender">
        <encoder class="net.logstash.logback.encoder.LogstashEncoder" />
    </appender>
    <root level="info">
        <appender-ref ref="STDOUT" />
    </root>
</configuration>
```

* Change the code in Fuse Java to log the custom fields. Sample is attached below:

```java
import net.logstash.logback.marker.LogstashMarker;
import net.logstash.logback.marker.Markers;
# ------
# ------
    private String createMessage(String content,String a) {
       
       JsonObject message = new JsonObject();
       
       message.addProperty("message", content);
       String appPodIp = "";
       
        try {
            InetAddress localhost = InetAddress.getLocalHost();
            appPodIp=localhost.getHostAddress().trim();
            message.addProperty("podIp", appPodIp);
        }catch(Exception e) {
            message.addProperty("podIp", "Unknown");
        }
       
       String messageString =message.toString();
       
       LogstashMarker marker = Markers.append("appPodIp", appPodIp)
               .and(Markers.append("appGreeterName", a));
       
       logger.info(marker,messageString);
       
       return messageString;
   }
```