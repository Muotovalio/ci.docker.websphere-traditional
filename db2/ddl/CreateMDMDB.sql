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
-- <TERRITORY> : Territory name

CREATE DB <DBNAME> AUTOMATIC STORAGE YES  
 USING CODESET UTF-8 TERRITORY <TERRITORY> COLLATE USING UCA400_NO PAGESIZE 8 K;

-- in real customer environments, the following style is suggested
-- CREATE DB <DBNAME> AUTOMATIC STORAGE YES ON /<DATAPATH1> DBPATH ON /HOME/<SCHEMA> 
--  USING CODESET UTF-8 TERRITORY <TERRITORY> COLLATE USING UCA400_NO PAGESIZE 8 K;


UPDATE DB CONFIG FOR <DBNAME> USING APP_CTL_HEAP_SZ 144;
UPDATE DB CONFIG FOR <DBNAME> USING APPLHEAPSZ 768;     
UPDATE DB CONFIG FOR <DBNAME> USING LOGPRIMARY 10;       
UPDATE DB CONFIG FOR <DBNAME> USING LOGSECOND 20;
UPDATE DB CONFIG FOR <DBNAME> USING LOGFILSIZ 5000;
UPDATE DB CONFIG FOR <DBNAME> USING STMT_CONC LITERALS;
UPDATE DB CONFIG FOR <DBNAME> USING DFT_DEGREE 1;
-- Setup Multinational Language Support
UPDATE DB CONFIG FOR <DBNAME> USING STRING_UNITS CODEUNITS32;

TERMINATE;
