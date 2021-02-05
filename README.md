
# Docker OpenTherm Monitor
Conainer is based on basschipper/docker-otmonitor 

## Introduction
The Opentherm Monitor is a small utility that is intended to help you configure and monitor your opentherm gateway (OTGW).

## Run the image
Depending on your configuration you would start the image with something like:

```bash
docker run -d -p 8080:8080 \
  -v $(pwd)/otmonitor.conf:/data/otmonitor.conf
  mc303/otmonitor:latest
```

## More info
- [OpenTherm Monitor](http://otgw.tclcode.com/otmonitor.html)
