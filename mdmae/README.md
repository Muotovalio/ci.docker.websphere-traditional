# IBM MDM Advanced Edition

## What is IBM Master Data Management Advanced Edition

IBM InfoSphere MDM Advanced Edition enables multiple MDM styles and domains to work together to provide a comprehensive set of MDM capabilities.

Use this image for an installation of InfoSphere MDM.

## Supported tags

11.6.0.4

## How to use this image

### Build

- [ ] Download the installation image files from IBM Passport Advantage / Software Download

	* IBM InfoSphere Master Data Management Standard and Advanced Edition Mulitplatform Multilingual V11.6.0.4 Part 1 (CNPB8EN )
	* IBM InfoSphere Master Data Management Standard & Advanced Edition Mulitplatform Multilingual V11.6.0.4 Part 2 (CNPB9EN )
	* IBM InfoSphere Master Data Management Workbench Standard & Advanced Edition Mulitplatform Multilingual V11.6.0.4 (CNPC0EN )
	* IBM InfoSphere Master Data Management Standard & Advanced Edition v11.6.0.1 Base Pattern for IBM PureApplication System Multilingual (CNF46ML )
	* License Information - IBM InfoSphere Master Data Management Standard & Advanced, V11.6 .0.4 Multilingual (CNPC1EN )
	
- [ ] Extract the IBM InfoSphere MDM installation image files to the ```mdm``` folder

	* mdm_installer-11.6.0.4-mdmseae_web.tar.gz 
	* mdm_installer-11.6.0.4-at4bpm_web.tar.gz
	* mdm_installer-11.6.0.4-mdph_web.tar.gz
	
- [ ] Download IBM Data Server Driver Package from IBM Fix Central and place the file in the ```db2``` folder

	* v10.5fp9_linuxx64_client.tar.gz

- [ ] Download IBM Installation Manager from IBM Fix Central and place the file in the ```im``` folder

	* agent.installer.linux.gtk.x86_64_1.8.8000.20171130_1105.zip

- [ ] Build Master Data Management image
	
	```
	docker build -t mdm-ae:11.6.0.4 .
	```

	You can ignore the following warnings:
	* debconf: delaying package configuration, since apt-utils is not installed
	* DBT3514W  The db2prereqcheck utility failed to find the following 32-bit library file: "libstdc++.so.6". 

### Start MDM AE in a new container

```
docker run --name mdm-ae --hostname mdmae -d -p 9043:9043 -p 9443:9443 mdm-ae:11.6.0.4
```
<!--
docker run --name mdm-ae --hostname mdmae -d -p 9043:9043 -p 9443:9443 -v $(pwd):/share mdm-ae:11.6.0.4 
docker run --name mdm-ae --hostname mdmae -e DISPLAY=9.183.71.231:0 --rm -it -p 9043:9043 -p 9443:9443 -v $(pwd):/share mdm-ae:11.6.0.4 bash
--link=mdm-db
docker exec mdmae cat /tmp/PASSWORD
-->

### Open a bash shell in the running container

```
docker exec -it mdmae bash
```
<!--
/opt/IBM/WebSphere/AppServer/profiles/AppSrv01/bin/startServer.sh server1
/opt/IBM/WebSphere/AppServer/profiles/AppSrv01/bin/stopServer.sh server1 -username wsadmin -password wsadminpwd
/opt/IBM/WebSphere/AppServer/bin/wsadmin.sh -lang jython -conntype NONE -f /work/updatePassword.py wsadmin wsadminpwd > /dev/null 2>&1
-->

### WAS Administrative Console

https://localhost:9043/ibm/console/login.do?action=secure

### MDM Client Applications

You can start and stop applications using wsadmin tool and scripting 
```
/opt/IBM/WebSphere/AppServer/bin/wsadmin.sh -lang jython -user <wsadmin -password wsadminpwd -f /work/startApplication.py <name>
/opt/IBM/WebSphere/AppServer/bin/wsadmin.sh -lang jython -user wsadmin -password wsadminpwd -f /work/stopApplication.py <name>
```

where &lt;name&gt; is:
* ba-App-E001
* mdm_consentmgmt_app-E001
* inspector-E001 
* enterpriseviewer-E001
* webreports-E001

### Business Administration UI
https://localhost:9443/CustomerBusinessAdminWeb/faces/login.jsp

### Consent Management UI
https://localhost:9443/mdmconsent/

### Inspector
https://localhost:9443/inspector/common/login.ihtml

### Enterprise Viewer
https://localhost:9443/accessweb/empi/MITLogin.jsp

### Web Reports
https://localhost:9443/webreports/common/login.html

<!--
## IBM Installation Manager

Installation Manager is installed in /home/was/IBM/InstallationManager/eclipse directory

* xhost + 9.183.71.231
* docker exec -e DISPLAY=9.183.71.231:0 -it mdm-ae bash
* /home/was/IBM/InstallationManager/eclipse/IBMIM -record /share/mdmae/mdm/install_new.rsp -input /share/mdmae/mdm/install.rsp
-->

### TODO

* Use the WAS Administrative Console to create a DB2_JDBC_DRIVER_PATH WebSphere Application Server environment variable, pointing to the DB2 instance home on the local machine and targeting the node level.
  https://www.ibm.com/support/knowledgecenter/SSWSR9_11.6.0/com.ibm.swg.im.mdmhs.release.install.doc/Topics/t_preparingyourdb2databasesonseparateserver.html
* Clean up dockerfile / utilities / directories
* Fixpack
* Additional Samples and Assets for IBM InfoSphere Master Data Management V11.6.0.4 Multilingual (CNPC2EN ) 
* MQ / SIBus
* multi-step build / link containers https://stackoverflow.com/questions/26551279/how-to-link-docker-containers-on-build
* hostname / ip address
* FROM 8.5.5.12-profile https://www-01.ibm.com/support/docview.wss?uid=swg22009597
* FROM 8.5.5.9-profile

## License

The Dockerfile and associated scripts are licensed under the Apache License 2.0. 

## References

1. IBM InfoSphere Master Data Management V11.6 documentation (https://www.ibm.com/support/knowledgecenter/en/SSWSR9_11.6.0/com.ibm.mdmhs.homepage.doc/mdm11.6_welcome.html)
