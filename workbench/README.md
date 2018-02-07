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

Prerequisites
* Rational Application Developer for WebSphere Software 9.5

* Quick Start Guide for IBM Rational Application Developer for WebSphere Software Multilingual - READ ME FIRST (CIY03ML ) 
* IBM Rational Application Developer for WebSphere Software V9.5 MASTER Multilingual Multiplatform Set up (CN6N2ML )
* IBM Rational Application Developer for WebSphere Software V9.5 Multilingual Multiplatform Core Part 1 (CN6N3ML ) 
* IBM Rational Application Developer for WebSphere Software V9.5 Multilingual Multiplatform Core Part 2 (CN6N4ML ) 
* IBM Rational Application Developer for WebSphere Software V9.5 Activation Kit Multiplatform Multilingual (CN6N6ML ) 
* Rational License Key Notification V2.0 Multilingual (CZ7E5ML )

```
docker build -t mdm-workbench:11.6.0.4 .
```

./IBM/InstallationManager/eclipse/IBMIM  -record /share/install_workbench.rsp -input /share/install_workbench.rsp

### Start workbench in a new container

xhost + 9.183.71.231

```
docker run --name mdm-workbench --hostname mdmworkbench --rm -it -v $(pwd):/share mdm-workbench:11.6.0.4 bash
```

```
docker exec -it -e DISPLAY=9.183.71.231:0 mdm-workbench bash
```

docker run --name mdm-workbench --hostname mdmworkbench-it -e DISPLAY=9.183.71.231:0 -v $(pwd):/share mdm-workbench:11.6.0.4 bash

## License

The Dockerfile and associated scripts are licensed under the Apache License 2.0. 

## References

1. MDM Workbench overview https://www.ibm.com/support/knowledgecenter/en/SSWSR9_11.6.0/com.ibm.mdmhs.wb.workbench.doc/c_mdmworkbench.html


