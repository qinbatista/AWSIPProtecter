# Lightsail Server IP Protecter
Change IP every 24 hours or received inaccessible signal 5 times

## Build

```
docker build -t qinbatista/aws_ip_protecter .
```

## Run
```
docker run -itd -p 7171:7171/udp  qinbatista/aws_ip_protecter
```