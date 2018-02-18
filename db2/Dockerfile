FROM ibmcom/db2express-c:latest

ENV PATH /home/db2inst1/sqllib/adm:/home/db2inst1/sqllib/bin/:$PATH

ARG DBNAME=PIMDB
ARG CODESET=UTF-8
ARG TERRITORY=US

ARG DBADMIN=db2inst1
ARG DBUSERPWD=db2inst1pwd
ARG DBUSER=pimdb1
ARG DBUSERPWD=pimdb1pwd

ARG TABLE_MDS4K=TBS4K
ARG TABLE_SPACE=TBS8K
ARG TABLE_SPMDS=TBS16K
ARG INDEX_SPACE=INDEXSPACE1
ARG LONG_SPACE=LONGSPACE1
ARG TABLE_SPPMD=EMESPACE1
ARG TABLE_SPPMI=EMESPACE2

RUN echo "\033[1;34mPrepare the database scripts\033[0m"

COPY ddl/CreatePIMDB.sql /tmp
RUN sed -i 's/<DBNAME>/'${DBNAME}'/g' /tmp/CreatePIMDB.sql
RUN sed -i 's/<CODESET>/'${CODESET}'/g' /tmp/CreatePIMDB.sql
RUN sed -i 's/<TERRITORY>/'${TERRITORY}'/g' /tmp/CreatePIMDB.sql
COPY ddl/CreatePIMBP.sql /tmp
RUN sed -i 's/<DBNAME>/'${DBNAME}'/g' /tmp/CreatePIMBP.sql
COPY ddl/CreatePIMTS.sql /tmp
RUN sed -i 's/<DBNAME>/'${DBNAME}'/g' /tmp/CreatePIMTS.sql
COPY ddl/GrantPIMDB.sql /tmp
RUN sed -i 's/<DBNAME>/'${DBNAME}'/g' /tmp/GrantPIMDB.sql
RUN sed -i 's/<DBUSER>/'${DBUSER}'/g' /tmp/GrantPIMDB.sql

RUN echo "\033[1;34mCreate database user at the operating system level\033[0m"

RUN useradd ${DBUSER}; echo ${DBUSER}:${DBUSERPWD} | chpasswd

RUN echo "\033[1;34mRun the database scripts\033[0m"

RUN su - db2inst1 -c "db2start; db2 -t -f /tmp/CreatePIMDB.sql" \
	&& su - db2inst1 -c "db2stop force"	
RUN su - db2inst1 -c "db2start; db2 -t -f /tmp/CreatePIMBP.sql" \
	&& su - db2inst1 -c "db2stop force"
RUN su - db2inst1 -c "db2start; db2 -t -f /tmp/CreatePIMTS.sql" \
	&& su - db2inst1 -c "db2stop force"
RUN su - db2inst1 -c "db2start; db2 -t -f /tmp/GrantPIMDB.sql" \
	&& su - db2inst1 -c "db2stop force"
