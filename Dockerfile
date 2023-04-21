FROM python:3.10-bullseye

ARG TARGETPLATFORM
RUN echo "TARGETPLATFORM : $TARGETPLATFORM"

RUN apt-get update \
  && apt-get install -y wget python3-tk \
  && rm -rf /var/lib/apt/lists/*
  
#x86      https://otgw.tclcode.com/download/otmonitor
#x86-64   https://otgw.tclcode.com/download/otmonitor-x64
#armhf    https://otgw.tclcode.com/download/otmonitor-ahf
#aarch64  https://otgw.tclcode.com/download/otmonitor-aarch64

RUN mkdir /app && mkdir /data \
  && if [ "$TARGETPLATFORM" = "linux/386" ] ; then XARCH="" ; fi \
  && if [ "$TARGETPLATFORM" = "linux/amd64" ] ; then XARCH="-x64" ; fi \
  && if [ "$TARGETPLATFORM" = "linux/arm/v5" ] ; then XARCH="-ahf" ; fi \
  && if [ "$TARGETPLATFORM" = "linux/arm/v7" ] ; then XARCH="-ahf" ; fi \
  && if [ "$TARGETPLATFORM" = "linux/arm64" ] ; then XARCH="-aarch64" ; fi \
  && /usr/bin/wget http://otgw.tclcode.com/download/otmonitor$XARCH -O /app/otmonitor \
  && chmod +x /app/otmonitor

CMD ["/app/otmonitor", "--daemon", "-f", "/data/otmonitor.conf"]
