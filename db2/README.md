# IBM DB2 Express-C

## Supported tags

11.6.0.4

## What is IBM Master Data Management Advanced Edition

IBM InfoSphere MDM Advanced Edition enables multiple MDM styles and domains to work together to provide a comprehensive set of MDM capabilities.

## What is IBM DB2 Express-C

...

## How to use this image

### Build

- [ ] Copy database scripts to the ddl folder

The scripts to create IBM® DB2® databases and table spaces are located in STARTUPKIT_INSTALL_HOME/CoreData/Full/DB2/Standard/ddl/
* CreateDB.sql
* CreateTS.sql

- [ ] Build an image from a Dockerfile

docker build -t mdm-db:11.6.0.4 .

### Start DB2 in a new container

docker run --name mdm-db --hostname 172.17.0.2 -d -p 50000:50000 -e DB2INST1_PASSWORD=db2inst1-pwd -e LICENSE=accept mdm-db:11.6.0.4 db2start

### Open a bash shell in the running container

docker exec -it mdm-db bash

## License

The Dockerfile and associated scripts are licensed under the Apache License 2.0. The license for DB2 Express-C can be found [online](http://www-03.ibm.com/software/sla/sladb.nsf/displaylis/5DF1EE126832D3F185257DAB0064BEFA?OpenDocument).

## References

1. https://hub.docker.com/r/ibmcom/db2express-c/


