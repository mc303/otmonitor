FROM cgr.dev/chainguard/wolfi-base

ARG TARGETPLATFORM
RUN echo "TARGETPLATFORM : $TARGETPLATFORM"

RUN apk add tzdata
RUN mkdir -p /usr/local/bin; mkdir -p -m a=rwx /data /log
  
#x86      https://otgw.tclcode.com/download/otmonitor
#x86-64   https://otgw.tclcode.com/download/otmonitor-x64
#armhf    https://otgw.tclcode.com/download/otmonitor-ahf
#aarch64  https://otgw.tclcode.com/download/otmonitor-aarch64

RUN mkdir /app && mkdir /data \
  && if [ "$TARGETPLATFORM" = "linux/386" ] ; then XARCH="" ; fi \
  && if [ "$TARGETPLATFORM" = "linux/amd64" ] ; then XARCH="-x64" ; fi \
  && if [ "$TARGETPLATFORM" = "linux/arm/v5" ] ; then XARCH="-ahf" ; fi \
  && if [ "$TARGETPLATFORM" = "linux/arm/v6" ] ; then XARCH="-ahf" ; fi \
  && if [ "$TARGETPLATFORM" = "linux/arm/v7" ] ; then XARCH="-ahf" ; fi \
  && if [ "$TARGETPLATFORM" = "linux/arm64" ] ; then XARCH="-aarch64" ; fi \
  && /usr/bin/wget http://otgw.tclcode.com/download/otmonitor$XARCH -O /usr/local/bin/otmonitor \
  && chmod +x /usr/local/bin/otmonitor

EXPOSE 8080

ENTRYPOINT ["otmonitor", "--daemon", "--dbfile=/data/auth.db", "-f/data/otmonitor.conf"]
CMD ["-w8080"]
WORKDIR /log
