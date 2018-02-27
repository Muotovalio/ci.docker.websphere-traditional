-- ---------------------------------------------------- {COPYRIGHT-TOP} -----
-- Licensed Materials - Property of IBM
-- Restricted Materials of IBM
--
-- 5725-E59
--;
-- (C) Copyright IBM Corp. 2008, 2011  All Rights Reserved.
--
-- US Government Users Restricted Rights - Use, duplication, or
-- disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
-- ---------------------------------------------------- {COPYRIGHT-END} -----
-- Please Replace the following tags with their appropriate values --
-- <DBNAME> : The name of the DB2 Database to create
-- <DBUSER>: The user name that will own the schema
-- <TABLE_MDS4K> : The tablespace name for user tables 4K reference on sto files as <TBS4K>
-- <TABLE_SPACE> : The tablespace name for user tables 8K reference on sto files as <TBS8K>
-- <TABLE_SPMDS> : The tablespace name for MDS user tables 16K reference on sto files as <TBS16K>
-- <INDEX_SPACE> : The tablespace name for user indexes. This should be replaced with INDEXSPACE1
-- <LONG_SPACE>:  The tablespace name for CLOB/XML columns. This should be replaced with LONGSPACE1
-- <TABLE_SPPMD>:  The tablespace name for CLOB/XML columns. This should be replaced with EMESPACE1
-- <TABLE_SPPMI>:  The tablespace name for CLOB/XML columns. This should be replaced with EMESPACE2



CONNECT TO <DBNAME>;

-- Please replace the values for size according the local environment  --

CREATE BUFFERPOOL "B4K_MDS" SIZE 2000 AUTOMATIC PAGESIZE 4K;
CREATE BUFFERPOOL "BUF_MDM" SIZE 20000 AUTOMATIC PAGESIZE 8K;
CREATE BUFFERPOOL "BUF_EMEIND" SIZE 10000 AUTOMATIC PAGESIZE 8K;
CREATE BUFFERPOOL "BUF_MDS" SIZE 10000 AUTOMATIC PAGESIZE 16K;
CREATE BUFFERPOOL "BUF_LONG" SIZE 10000 AUTOMATIC PAGESIZE 32K;

CREATE TABLESPACE <TABLE_MDS4K> PAGESIZE 4K MANAGED BY AUTOMATIC STORAGE 
INITIALSIZE 512 M AUTORESIZE YES INCREASESIZE 512 M 
EXTENTSIZE 32 
PREFETCHSIZE 384 
BUFFERPOOL B4K_MDS; 

CREATE TABLESPACE <TABLE_SPACE> PAGESIZE 8K MANAGED BY AUTOMATIC STORAGE 
INITIALSIZE 512 M AUTORESIZE YES INCREASESIZE 1024 M 
EXTENTSIZE 32 
PREFETCHSIZE 384 
BUFFERPOOL BUF_MDM; 

CREATE TABLESPACE <TABLE_SPMDS> PAGESIZE 16K MANAGED BY AUTOMATIC STORAGE 
INITIALSIZE 512 M AUTORESIZE YES INCREASESIZE 1024 M 
EXTENTSIZE 32 
PREFETCHSIZE 384 
BUFFERPOOL BUF_MDS; 

CREATE TABLESPACE <INDEX_SPACE> PAGESIZE 16K MANAGED BY AUTOMATIC STORAGE 
INITIALSIZE  512 M AUTORESIZE YES INCREASESIZE 1024 M 
EXTENTSIZE 32 
PREFETCHSIZE 384 
BUFFERPOOL BUF_MDS; 

CREATE TABLESPACE <TABLE_SPPMD> PAGESIZE 8K MANAGED BY AUTOMATIC STORAGE 
INITIALSIZE  512 M AUTORESIZE YES INCREASESIZE 1024 M 
EXTENTSIZE 32 
PREFETCHSIZE 384 
BUFFERPOOL BUF_MDM; 


CREATE TABLESPACE <TABLE_SPPMI> PAGESIZE 8K MANAGED BY AUTOMATIC STORAGE 
INITIALSIZE  512 M AUTORESIZE YES INCREASESIZE 1024 M 
EXTENTSIZE 32 
PREFETCHSIZE 384 
BUFFERPOOL BUF_EMEIND; 


CREATE TEMPORARY TABLESPACE TMPSPACE1 PAGESIZE 32K MANAGED BY AUTOMATIC STORAGE 
PREFETCHSIZE 64 
BUFFERPOOL BUF_LONG; 

CREATE TEMPORARY TABLESPACE TMPSPACE2 PAGESIZE 16K MANAGED BY AUTOMATIC STORAGE 
PREFETCHSIZE 64 
BUFFERPOOL BUF_MDS; 

CREATE TEMPORARY TABLESPACE TMPSPACE3 PAGESIZE 8K MANAGED BY AUTOMATIC STORAGE 
PREFETCHSIZE 64 
BUFFERPOOL BUF_MDM; 

CREATE TEMPORARY TABLESPACE TMPSPACE4 PAGESIZE 4K MANAGED BY AUTOMATIC STORAGE 
PREFETCHSIZE 64 
BUFFERPOOL B4K_MDS; 

CREATE USER TEMPORARY TABLESPACE TMPSPACE5 PAGESIZE 4K MANAGED BY AUTOMATIC STORAGE 
PREFETCHSIZE 64 
BUFFERPOOL B4K_MDS;

CREATE TABLESPACE <LONG_SPACE> PAGESIZE 32K MANAGED BY AUTOMATIC STORAGE 
INITIALSIZE 1024 M AUTORESIZE YES INCREASESIZE 1024 M 
BUFFERPOOL BUF_LONG; 

ALTER TABLESPACE <TABLE_MDS4K> NO FILE SYSTEM CACHING;
ALTER TABLESPACE <TABLE_SPACE> NO FILE SYSTEM CACHING;
ALTER TABLESPACE <TABLE_SPMDS> NO FILE SYSTEM CACHING;
ALTER TABLESPACE <INDEX_SPACE> NO FILE SYSTEM CACHING;
ALTER TABLESPACE <TABLE_SPPMD> NO FILE SYSTEM CACHING;
ALTER TABLESPACE <TABLE_SPPMI> NO FILE SYSTEM CACHING;
ALTER TABLESPACE <LONG_SPACE> NO FILE SYSTEM CACHING;

RESTART DATABASE <DBNAME>;

GRANT CREATETAB,BINDADD,CONNECT,CREATE_NOT_FENCED,IMPLICIT_SCHEMA,LOAD ON DATABASE TO USER <DBUSER>;
GRANT USE OF TABLESPACE <TABLE_MDS4K> TO USER <DBUSER>;
GRANT USE OF TABLESPACE <TABLE_SPACE> TO USER <DBUSER>;
GRANT USE OF TABLESPACE <TABLE_SPMDS> TO USER <DBUSER>;
GRANT USE OF TABLESPACE <INDEX_SPACE> TO USER <DBUSER>;
GRANT USE OF TABLESPACE <TABLE_SPPMD> TO USER <DBUSER>;
GRANT USE OF TABLESPACE <TABLE_SPPMI> TO USER <DBUSER>;
GRANT USE OF TABLESPACE <LONG_SPACE> TO USER <DBUSER>;
GRANT USE OF TABLESPACE TMPSPACE5 TO USER <DBUSER>;

REVOKE USE OF TABLESPACE USERSPACE1 FROM PUBLIC;
REVOKE CREATETAB,BINDADD,CONNECT,IMPLICIT_SCHEMA ON DATABASE FROM PUBLIC;

TERMINATE;