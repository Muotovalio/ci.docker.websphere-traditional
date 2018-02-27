# IBM Stewardship Center

## What is IBM Master Data Management Advanced Edition

IBM InfoSphere MDM Advanced Edition enables multiple MDM styles and domains to work together to provide a comprehensive set of MDM capabilities.

# What is IBM Stewardship Center

## Supported tags

11.6.0.4

## How to use this image

### Build

- [ ] Build and start DB2 in a new container

- [ ] Build and start MDM AE in a new container

- [ ] Download the installation image files from the SSW Software Downloads site / Passport Advantage and place the files in the ```bpm``` folder

	* IBM Business Process Manager Server Express Version 8.6 Linux 64bit (1 of 3) Multilingual (CNM6HML ) 
	* IBM Business Process Manager Server Express Version 8.6 Linux 64bit (2 of 3) Multilingual (CNM6IML )
	* IBM Business Process Manager Server Express Version 8.6 Linux 64bit (3 of 3) Multilingual (CNM6JML ) 
	* IBM Business Process Manager Express Server Version 8.6 Multiplatform Multilingual Quick Start Guide (CNM32ML )
	
- [ ] IBM Business Process Manager V8.6 Cumulative Fix 2017.12 and place the file in the ```bpm``` folder
	
	* TODO!!!!!
	* bpm.8600.cf2017.12.delta.repository.zip
	
- [ ] Download IBM WebSphere SDK Java Technology Edition Version 8.0 from the IBM IBM Fix Central

	* 8.0.5.6-WS-IBMWASJAVA-Linux.zip
		
- [ ] Build the Stewardship Center image
	
```
docker build -t mdm-sc:11.6.0.4 .
```

### Start Stewardship Center in a new container

```
docker run --name mdm-sc --hostname mdmsc -d -p 8043:9043 -p 8443:9443 mdm-sc:11.6.0.4
```

<!--
xhost + 9.183.71.231
docker run --name mdm-sc -it -p 9043:9043 -p 9443:9443 -e DISPLAY=9.183.71.231:0 -v $(pwd):/share mdm-sc:11.6.0.4 bash

https://developer.ibm.com/recipes/tutorials/bluemix-container-for-ibm-bpm-express/

Installing and configuring IBM Stewardship Center
https://www.ibm.com/support/knowledgecenter/en/SSWSR9_11.6.0/com.ibm.swg.im.mdmhs.govctr_install.doc/topics/t_isc_configuring.html
-->

## License

The Dockerfile and associated scripts are licensed under the Apache License 2.0. 

## References

1. IBM InfoSphere Master Data Management V11.6 documentation (https://www.ibm.com/support/knowledgecenter/en/SSWSR9_11.6.0/com.ibm.mdmhs.homepage.doc/mdm11.6_welcome.html)

2. IBM Business Process Manager V8.6.0 documentation (https://www.ibm.com/support/knowledgecenter/SSFPJS_8.6.0/com.ibm.wbpm.main.doc/kc-homepage-bpm.html)
