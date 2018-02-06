# IBM MDM Advanced Edition

## Supported tags

11.6.0.4

## What is IBM Master Data Management Advanced Edition

IBM InfoSphere MDM Advanced Edition enables multiple MDM styles and domains to work together to provide a comprehensive set of MDM capabilities.

## How to use this image

### Build


Acquiring and extracting the installation files

- [] Download the installation image files from IBM Passport Advantage / Software Download
	
	Extract the files into the mdm directory
	
	* IBM InfoSphere Master Data Management Standard & Advanced Edition V11.6.0.4, Multiplatform Multilingual eAssembly 
	
	* IBM InfoSphere Master Data Management Standard and Advanced Edition Mulitplatform Multilingual V11.6.0.4 Part 1 (CNPB8EN )
	* IBM InfoSphere Master Data Management Standard & Advanced Edition Mulitplatform Multilingual V11.6.0.4 Part 2 (CNPB9EN )
	* IBM InfoSphere Master Data Management Workbench Standard & Advanced Edition Mulitplatform Multilingual V11.6.0.4 (CNPC0EN )
	* IBM InfoSphere Master Data Management Standard & Advanced Edition v11.6.0.1 Base Pattern for IBM PureApplication System Multilingual (CNF46ML )
	* License Information - IBM InfoSphere Master Data Management Standard & Advanced, V11.6 .0.4 Multilingual (CNPC1EN )

- [ ] Copy IBM Data Server Driver Package (DS driver) to the "was/dsdriver" folder

* v10.5fp9_linuxx64_client.tar.gz

- [ ] Copy IBM Installation Manager file to the "was/im" folder

* agent.installer.linux.gtk.x86_64_1.8.8000.20171130_1105.zip

- [ ] Extract the IBM InfoSphere MDM  installation image files to the "was/install" folder

* mdm_installer-11.6.0.4-mdmseae_web.tar.gz 
* mdm_installer-11.6.0.4-at4bpm_web.tar.gz
* mdm_installer-11.6.0.4-mdph_web.tar.gz

- [ ] Build Master Data Management image
```
docker build -t mdm-was:11.6.0.4 .
```

You can ignore the following warnings:
* debconf: delaying package configuration, since apt-utils is not installed
* DBT3514W  The db2prereqcheck utility failed to find the following 32-bit library file: "libstdc++.so.6". 

### Start WAS in a new container

```
docker run --name mdm-was --hostname 172.17.0.3 -d -p 9043:9043 -p 9443:9443 mdm-was:11.6.0.4
```

docker run --name mdm-was --hostname 172.17.0.1 --rm -d -p 9043:9043 -p 9443:9443 -v $(pwd):/share mdm-was:11.6.0.4 tail -f /dev/null

docker run --name mdm-was --hostname 172.17.0.1 --rm -it -p 9043:9043 -p 9443:9443 -v $(pwd):/share mdm-was:11.6.0.4 bash

docker exec mdm-was cat /tmp/PASSWORD


### Open a bash shell in the running container

```
docker exec -it mdm-was bash
```

/opt/IBM/WebSphere/AppServer/profiles/AppSrv01/bin/startServer.sh server1

/opt/IBM/WebSphere/AppServer/profiles/AppSrv01/bin/stopServer.sh server1 -username wsadmin -password wsadminpwd

/opt/IBM/WebSphere/AppServer/bin/wsadmin.sh -lang jython -conntype NONE -f /work/updatePassword.py wsadmin wsadminpwd > /dev/null 2>&1

### WAS Administrative Console

https://localhost:9043/ibm/console/login.do?action=secure

### MDM Client Applications

You can start and stop applications using wsadmin tool and scripting 
```
/opt/IBM/WebSphere/AppServer/bin/wsadmin.sh -lang jython -user <wsadmin -password wsadminpwd -f /share/install/startApplication.py <name>
/opt/IBM/WebSphere/AppServer/bin/wsadmin.sh -lang jython -user wsadmin -password wsadminpwd -f /share/install/stopApplication.py <name>
```

* ba-App-E001
* mdm_consentmgmt_app-E001

Business Administration UI
https://localhost:9443/CustomerBusinessAdminWeb/faces/login.jsp

Consent Management UI
https://localhost:9443

Inspector
https://localhost:9443/inspector/common/login.ihtml

Enterprise Viewer
https://localhost:9443/accessweb/empi/MITLogin.jsp

Web Reports
https://localhost:9443/webreports/common/login.html

### IBM Installation Manager

Installation Manager is installed in /home/was/IBM/InstallationManager/eclipse directory


* xhost + 9.183.71.231
* docker exec -e DISPLAY=9.183.71.231:0 -it mdm-was bash
/home/was/IBM/InstallationManager/eclipse/IBMIM -record /share/was/install/install_mdm_new.rsp -input /share/was/install/install_mdm.rsp

root@31229fbbde71:/host/install/mdm_installer-11.6.0.4-at4bpm_web# /opt/IBM/InstallationManager/eclipse/tools/imcl 
-repositories /host/install/mdm_installer-11.6.0.4-at4bpm_web/repository.config 
-installationDirectory /opt/IBM/MDM install com.ibm.mdm.at4bpm.0.4_11.6.0.FP04IF000_20171205-0358

Shared Resources Directory: /opt/IBM/IMShared

imcl install 
        -repositories /tmp/mdm/... 
        -acceptLicense 
        -installationDirectory /opt/IBM/...
        
        
/opt/IBM/InstallationManager/eclipse/tools/imcl -showProgress \
    -acceptLicense install $packages \
    -repositories $repo \
    -installationDirectory $INSTALL_DIR \
    -secureStorageFile $SECURE_STORAGE_FILE \
    -preferences com.ibm.cic.common.core.preferences.preserveDownloadedArtifacts=false \
    $properties
    

### TODO

* Use the WAS Administrative Console to create a DB2_JDBC_DRIVER_PATH WebSphere Application Server environment variable, pointing to the DB2 instance home on the local machine and targeting the node level.
  https://www.ibm.com/support/knowledgecenter/SSWSR9_11.6.0/com.ibm.swg.im.mdmhs.release.install.doc/Topics/t_preparingyourdb2databasesonseparateserver.html

* Clean up dockerfile / utilities / directories

* Fixpack




Installing IBM InfoSphere Master Data Management Standard and Advanced Editions

	https://www.ibm.com/support/knowledgecenter/en/SSWSR9_11.6.0/com.ibm.swg.im.mdmhs.release.install.doc/Topics/installing_std_adv_editions.html


   