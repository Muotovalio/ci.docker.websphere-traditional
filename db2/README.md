# IBM DB2 Express-C

## What is IBM DB2 Express-C

IBM DB2 Express-C is the no-charge community edition of DB2 server, a simple, flexible, powerful, and reliable relational database server. 
It is easy to install, embed, deploy, and available for download, deployment, and redistribution at no charge.

Use this image to set up an IBM DB2 database for an installation of InfoSphere MDM CE.

## What is IBM Master Data Management Collaborative Edition

IBM InfoSphere Master Data Management Collaborative Edition (MDM CE) provides a highly scalable, enterprise Product Information Management (PIM) solution. MDM CE is the middleware that establishes a single, integrated, consistent view of products and services information inside and outside of an enterprise.

<!--
## What is IBM Master Data Management Advanced Edition

IBM InfoSphere MDM Advanced Edition enables multiple MDM styles and domains to work together to provide a comprehensive set of MDM capabilities.
-->

## Supported tags

11.6, 11.0

## How to use this image

### Build

<!--
- [ ] Copy database scripts to the ```ddl``` folder

	The scripts to create IBM DB2 databases and table spaces are located in STARTUPKIT_INSTALL_HOME/CoreData/Full/DB2/Standard/ddl/
	* CreateDB.sql
	* CreateTS.sql
-->
	
- [ ] Build an image from a Dockerfile

```
docker build -t mdm-db2:11.6.0.6 .
```

### Create a new bridge network

```
docker network create --subnet=172.18.0.0/16 mdmnet
```

### Start DB2 in a new container

```
docker run --name mdm-db2 --hostname mdmdb2 --network=mdmnet --ip 172.18.0.2 -d -p 50000:50000 -e DB2INST1_PASSWORD=db2inst1pwd -e LICENSE=accept mdm-db2:11.6.0.6 db2start
```

### Open a bash shell in the running container

```
docker exec -it mdm-db2 bash
```

## License

The Dockerfile and associated scripts are licensed under the Apache License 2.0. 

The license for DB2 Express-C can be found [online](http://www-03.ibm.com/software/sla/sladb.nsf/displaylis/5DF1EE126832D3F185257DAB0064BEFA?OpenDocument).

## References

1. Docker image for DB2 Express-C
   https://hub.docker.com/r/ibmcom/db2express-c/

2. IBM InfoSphere Master Data Management, Version 11 documentation
   https://www.ibm.com/support/knowledgecenter/en/SSWSR9_11.0.0/com.ibm.pim.ovr.doc/pim_ref_overview.html?pos=2

3. IBM InfoSphere Master Data Management V11.6 documentation (https://www.ibm.com/support/knowledgecenter/en/SSWSR9_11.6.0/com.ibm.mdmhs.homepage.doc/mdm11.6_welcome.html)
