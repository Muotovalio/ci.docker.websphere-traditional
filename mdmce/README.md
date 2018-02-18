# IBM InfoSphere Master Data Management Collaborative Edition

## What is IBM Master Data Management Collaborative Edition

IBM InfoSphere Master Data Management Collaborative Edition (MDM CE) provides a highly scalable, enterprise Product Information Management (PIM) solution. MDM CE is the middleware that establishes a single, integrated, consistent view of products and services information inside and outside of an enterprise.

## Supported tags

11.0

## How to use this image

### Build

- [ ] Build and start DB2 in a new container

- [ ] Download Master Data Management Collaboration Edition from the SSW Software Downloads site / Passport Advantage

	* IBM InfoSphere Master Data Management Collaborative Edition V11.0 Multiplatform Multilingual eAssembly (CRMY3ML)

- [ ] Place the IBM InfoSphere MDM CE installation image file in the ```mdm``` folder

	* MDM_COLLAB_ED_V11.0.tar.gz

- [ ] Download [IBM Data Server Driver Package](http://www-01.ibm.com/support/docview.wss?uid=swg27016878) from IBM Fix Central and place the file in the ```db2``` folder

	* v10.5fp9_linuxx64_client.tar.gz

- [ ] Download [IBM Installation Manager](https://www-945.ibm.com/support/fixcentral/swg/selectFixes?parent=ibm%2FRational&product=ibm/Rational/IBM+Installation+Manager&release=1.8.7.1&platform=Linux&function=all) from IBM Fix Central and place the file in the ```im``` folder

	* agent.installer.linux.gtk.x86_64_1.8.8000.20171130_1105.zip

- [ ] Build the MDM CE Docker image

```
docker build -t mdm-ce:11.0 .
```

### Start MDM CE in a new container

```
docker run --name mdm-ce --hostname mdmce -d -p 7507:7507 mdm-ce:11.0
```

<!--
docker run --name mdm-ce --hostname mdmce -d -p 7507:7507 -p 9043:9043 -p 9443:9443 mdm-ce:11.0
xhost + 192.168.8.118
docker run --name mdm-ce --hostname mdmce -e DISPLAY=192.168.8.118:0 --rm -it -p 7507:7507 -p 9043:9043 -p 9443:9443 -v $(pwd):/share mdm-ce:11.0 bash
https://localhost:9043/ibm/console/login.do
-->

### Open a bash shell in the running container

```
docker exec -it mdm-ce bash
```

### WAS Administrative Console

https://localhost:9043/ibm/console/login.do?action=secure

### MDM Client Applications

You can start and stop Master Data Management Collaboration Server and all services using the scripts. By default, the container stops when MDM CE (main process inside the container) is stopped.

Start:
```
/opt/IBM/MDM/bin/go/start_local.sh
```
Stop:
```
/opt/IBM/MDM/bin/go/stop_local.sh
```

### Logging in to the product

1. Open your web browser and enter the URL
	
	http://localhost:7507/utils/enterLogin.jsp

2. Use the username, password, and company to sign in

	* username: Admin
	* password: trinitron
	* company: test

## References

1. IBM InfoSphere Master Data Management, Version 11 documentation
   https://www.ibm.com/support/knowledgecenter/en/SSWSR9_11.0.0/com.ibm.pim.ovr.doc/pim_ref_overview.html?pos=2

2. InfoSphere MDM Collaboration Server Installation Guide
   https://www.ibm.com/support/knowledgecenter/SSWSR9_11.0.0/com.ibm.pim.ins.doc/Install.pdf?view=kc

3. System requirements for InfoSphere Master Data Management
   http://www-01.ibm.com/support/docview.wss?uid=swg27035486
