FROM ibmcom/db2express-c:latest

ENV PATH /home/db2inst1/sqllib/adm:/home/db2inst1/sqllib/bin/:$PATH

# Prepare the database scripts in the Installation Startup Kit

ARG DBNAME=MDMDB
ARG DBUSER=mdmdb1
ARG DBPASSWORD=mdmdb1pwd
ARG TERRITORY=US
ARG TABLE_MDS4K=TBS4K
ARG TABLE_SPACE=TBS8K
ARG TABLE_SPMDS=TBS16K
ARG INDEX_SPACE=INDEXSPACE1
ARG LONG_SPACE=LONGSPACE1
ARG TABLE_SPPMD=EMESPACE1
ARG TABLE_SPPMI=EMESPACE2

# Create database user

RUN useradd ${DBUSER}; echo ${DBUSER}:${DBPASSWORD} | chpasswd

COPY ddl/CreateDB.sql /tmp
RUN sed -i 's/<DBNAME>/'${DBNAME}'/g' /tmp/CreateDB.sql
RUN sed -i 's/<TERRITORY>/'${TERRITORY}'/g' /tmp/CreateDB.sql

COPY ddl/CreateTS.sql /tmp
RUN sed -i 's/<DBNAME>/'${DBNAME}'/g' /tmp/CreateTS.sql
RUN sed -i 's/<DBUSER>/'${DBUSER}'/g' /tmp/CreateTS.sql
RUN sed -i 's/<TABLE_MDS4K>/'${TABLE_MDS4K}'/g' /tmp/CreateTS.sql
RUN sed -i 's/<TABLE_SPACE>/'${TABLE_SPACE}'/g' /tmp/CreateTS.sql
RUN sed -i 's/<TABLE_SPMDS>/'${TABLE_SPMDS}'/g' /tmp/CreateTS.sql
RUN sed -i 's/<INDEX_SPACE>/'${INDEX_SPACE}'/g' /tmp/CreateTS.sql
RUN sed -i 's/<LONG_SPACE>/'${LONG_SPACE}'/g' /tmp/CreateTS.sql
RUN sed -i 's/<TABLE_SPPMD>/'${TABLE_SPPMD}'/g' /tmp/CreateTS.sql
RUN sed -i 's/<TABLE_SPPMI>/'${TABLE_SPPMI}'/g' /tmp/CreateTS.sql

# Run the database scripts
RUN su - db2inst1 -c "db2start; db2 -t -f /tmp/CreateDB.sql; db2 -t -f /tmp/CreateTS.sql" \
	&& su - db2inst1 -c "db2stop force"

# COPY docker-entrypoint.sh /entrypoint-mdm.sh
