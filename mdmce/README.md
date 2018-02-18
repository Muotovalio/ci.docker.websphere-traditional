# IBM InfoSphere Master Data Management Collaborative Edition

## What is IBM Master Data Management Collaborative Edition

IBM InfoSphere Master Data Management Collaboration Server provides a highly scalable, enterprise Product Information Management (PIM) solution. InfoSphere MDM Collaboration Server is the middleware that establishes a single, integrated, consistent view of products and services information inside and outside of an enterprise.

## How to use this image

### Build
```
docker build -t mdm-ce:11.0 .
```

### Start MDM CE in a new container

```
docker run --name mdm-ce --hostname mdmce -d -p 7507:7507 -p 9043:9043 -p 9443:9443 mdm-ce:11.0
```
<!--
xhost + 192.168.8.118
docker run --name mdm-ce --hostname mdmce -e DISPLAY=192.168.8.118:0 --rm -it -p 7507:7507 -p 9043:9043 -p 9443:9443 -v $(pwd):/share mdm-ce:11.0 bash
https://localhost:9043/ibm/console/login.do
http://localhost:7507/utils/enterLogin.jsp
# Admin
# trinitron
# test
-->
## References

1. IBM InfoSphere Master Data Management, Version 11 documentation (https://www.ibm.com/support/knowledgecenter/en/SSWSR9_11.0.0/com.ibm.pim.ovr.doc/pim_ref_overview.html?pos=2)

2. InfoSphere MDM Collaboration Server Installation Guide (https://www.ibm.com/support/knowledgecenter/SSWSR9_11.0.0/com.ibm.pim.ins.doc/Install.pdf?view=kc)

3. System requirements for InfoSphere Master Data Management (http://www-01.ibm.com/support/docview.wss?uid=swg27035486)
