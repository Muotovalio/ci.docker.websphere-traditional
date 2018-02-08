# MDM Workbench

## What is IBM Master Data Management Advanced Edition

IBM InfoSphere MDM Advanced Edition enables multiple MDM styles and domains to work together to provide a comprehensive set of MDM capabilities.

## What is MDM Workbench

The InfoSphere MDM Workbench application enables implementers and administrators to easily manage the operational server. Use this application 
to manage algorithms, create composite views, edit dictionary data tables, and to develop member logical models, flows, and mappings to data sources.

Use this image to set up an IBM MDM workbench for development.

## Supported tags

11.6.0.4

## How to use this image

### Build

- [ ] Download Rational Application Developer from the SSW Software Downloads site / Passport Advantage and place the files in the ```rad``` folder

	* IBM Rational Application Developer for WebSphere Software V9.5 MASTER Multilingual Multiplatform Set up (CN6N2ML )
	* IBM Rational Application Developer for WebSphere Software V9.5 Multilingual Multiplatform Core Part 1 (CN6N3ML ) 
	* IBM Rational Application Developer for WebSphere Software V9.5 Multilingual Multiplatform Core Part 2 (CN6N4ML ) 
	* IBM Rational Application Developer for WebSphere Software V9.5 Activation Kit Multiplatform Multilingual (CN6N6ML ) 

- [ ] Download Master Data Management Workbench from the SSW Software Downloads site / Passport Advantage and place the files in the ```mdm``` folder

	* IBM InfoSphere Master Data Management Workbench Standard & Advanced Edition Mulitplatform Multilingual V11.6.0.4 (CNPC0EN )

- [ ] Build the Workbench Docker image

```
docker build -t mdm-workbench:11.6.0.4 .
```

<!--
Use the IBM Installation Manager to record a response file to be used in silent mode:
/opt/IBM/InstallationManager/eclipse/IBMIM  -record /share/install_workbench_new.rsp -input /share/install_workbench.rsp
-->

### Start workbench in a new container

- [ ] Install X11 (XQuartz for Mac)

- [ ] Allow your local host to make connections to the  X server

```
ifconfig
xhost +<ipaddress>
```

- [ ] Run the container

```
docker run --name mdm-workbench --hostname mdmworkbench -e DISPLAY=9.183.71.231:0 -d mdm-workbench:11.6.0.4 /opt/IBM/SDP/eclipse
```
<!--
docker run --name mdm-workbench --hostname mdmworkbench --rm -it -e DISPLAY=9.183.71.231:0 -v $(pwd):/share mdm-workbench:11.6.0.4 bash

```
docker exec -it -e DISPLAY=9.183.71.231:0 mdm-workbench bash
```

docker run --name mdm-workbench --hostname mdmworkbench-it -e DISPLAY=9.183.71.231:0 -v $(pwd):/share mdm-workbench:11.6.0.4 bash

/opt/IBM/SDP/eclipse 
-->

- [ ] Configuring the remote server connection https://www.ibm.com/support/knowledgecenter/SSWSR9_11.6.0/com.ibm.swg.im.mdmhs.release.install.doc/scenarios/installscenario4b.html?view=kc

- [ ] Configuring the remote database connection https://www.ibm.com/support/knowledgecenter/en/SSWSR9_11.6.0/com.ibm.swg.im.mdmhs.release.install.doc/scenarios/installscenario4c.html

- [ ] Setting Workbench server definitions https://www.ibm.com/support/knowledgecenter/en/SSWSR9_11.6.0/com.ibm.swg.im.mdmhs.release.install.doc/Topics/setting_workbench_server_definitions.html

- [ ] Restart exited container

```
docker start -a -i `docker ps -q -l`
```


## License

The Dockerfile and associated scripts are licensed under the Apache License 2.0. 

## References

1. MDM Workbench overview https://www.ibm.com/support/knowledgecenter/en/SSWSR9_11.6.0/com.ibm.mdmhs.wb.workbench.doc/c_mdmworkbench.html


