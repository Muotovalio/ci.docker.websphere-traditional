FROM ibmcom/websphere-traditional:9.0.0.6-profile
#FROM ibmcom/websphere-traditional:8.5.5.12-profile

ARG DB2_NODE=DBEXPC
ARG DB2_SERVER=172.18.0.2
ARG DB2_PORT=50000
ARG DB2_DBNAME=PIMDB

ARG WASUSER=was
ARG WASUSERPWD=waspwd
ARG WASGROUP=was

########## User account and permissions ####################################

USER root

# Create user account
#RUN groupadd ${WASGROUP} \
#  && useradd ${WASUSER} -g ${WASGROUP} -m

# Reset was password
RUN echo ${WASUSER}:${WASUSERPWD} | chpasswd

#RUN mkdir -p /opt/IBM
#RUN chown -R ${WASUSER}:${WASGROUP} /opt/IBM

#RUN mkdir -p /var/ibm/
#RUN chown -R ${WASUSER}:${WASGROUP} /var/ibm/

########## Utilities and required packages #################################

RUN echo "\033[1;34mAdd 32-bit architecture\033[0m"

RUN dpkg --add-architecture i386

RUN echo "\033[1;34mInstall utilities and required packages\033[0m"

RUN apt-get update && apt-get install -y unzip
RUN apt-get update && apt-get install -y build-essential
RUN apt-get update && apt-get install -y perl-doc
RUN apt-get update && apt-get install -y libpam0g:i386
RUN apt-get update && apt-get install -y language-pack-en-base  

RUN apt-get update && apt-get install -y vim
RUN apt-get update && apt-get install -y locate

RUN echo "\033[1;34mInstall Perl modules\033[0m"
RUN (echo y;echo o conf prerequisites_policy follow;echo o conf commit)|cpan
#RUN cpan Config::IniFiles
#RUN cpan Config::Properties
RUN cpan File::Find
RUN cpan Getopt::Long
RUN cpan Net::Domain
RUN cpan File::Copy
RUN cpan File::Temp
RUN cpan File::Basename
RUN cpan IO::Handle
RUN cpan File::Path
#Warning: Cannot install Util::EnvConfig, don't know what it is.
#RUN cpan Util::EnvConfig

RUN echo "\033[1;34mInstall packages needed to run X11 / IBMIM\033[0m"

RUN apt-get update && apt-get install -y libgtk2.0-0
RUN apt-get update && apt-get install -y libxtst6 
RUN apt-get update && apt-get install -y libxft2
# libxft2:i386

### TODO Enabling multicast network traffic
### https://www.ibm.com/support/knowledgecenter/en/SSWSR9_11.0.0/com.ibm.pim.ins.doc/pim_tsk_enablingmulticast.html?pos=2

########## IBM DB2 Data Server Client ######################################

RUN echo "\033[1;34mInstall IBM Data Server Client\033[0m"

COPY db2/v10.5fp9_linuxx64_client.tar.gz /tmp/db2/
COPY db2/db2client.rsp /tmp/db2/
RUN tar xfz /tmp/db2/v10.5fp9_linuxx64_client.tar.gz -C /tmp/db2/ \
	&& /tmp/db2/client/db2setup -r /tmp/db2/db2client.rsp \
	&& rm -rf /tmp/db2

RUN echo "\033[1;34mCatalog remote database\033[0m"

USER db2inst1

RUN /bin/bash -c 'source $HOME/.bashrc; /home/db2inst1/sqllib/bin/db2 catalog tcpip node ${DB2_NODE} remote ${DB2_SERVER} server ${DB2_PORT}'
RUN /bin/bash -c 'source $HOME/.bashrc; /home/db2inst1/sqllib/bin/db2 catalog db ${DB2_DBNAME} at node ${DB2_NODE} authentication server'

USER ${WASUSER} 

ENV PATH /opt/ibm/db2/V10.5/bin:$PATH
RUN echo ". /home/db2inst1/sqllib/db2profile" >> $HOME/.bashrc

########## IBM Installation Manager ########################################

RUN echo "\033[1;34mInstall IBM Installation Manager\033[0m"

COPY --chown=was:was im/agent.installer.linux.gtk.x86_64_*.zip /tmp/
RUN unzip -qd /tmp/im /tmp/agent.installer.linux.gtk.x86_64_*.zip \
  && /tmp/im/installc -acceptLicense -accessRights nonAdmin -showProgress \
#    -installationDirectory "/home/was/IBM/InstallationManager"  \
#    -dataLocation "/home/was/var/ibm/InstallationManager" \
  && rm -rf /tmp/agent.installer.linux.gtk.x86_64_*.zip /tmp/im
  
ENV PATH /home/was/IBM/InstallationManager/eclipse/tools:$PATH

RUN echo "\033[1;34mAdding offerings to IBM Installation Manager\033[0m"

# InfoSphere InfoSphere MDM CE 11.6
COPY --chown=was:was mdm/INFOSP_MDM_COLLABORATION_SERVER_F.tar /tmp/
RUN mkdir -p /tmp/mdm/mdmce \
	&& tar xf /tmp/INFOSP_MDM_COLLABORATION_SERVER_F.tar -C /tmp/mdm/mdmce \
#	&& unzip -qd /tmp/mdm/mdmce/Collaborative_disks/ /tmp/mdm/mdmce/Collaborative_disks/disk1.zip \
	&& cd /tmp/mdm/mdmce/Collaborative_disks \
	&& /opt/IBM/WebSphere/AppServer/java/8.0/bin/jar -xf disk1.zip \
#	&& /opt/IBM/WebSphere/AppServer/java/bin/jar -xf disk1.zip \
	&& rm /tmp/INFOSP_MDM_COLLABORATION_SERVER_F.tar

########## IBM WebSphere Application Server ################################

RUN echo "\033[1;34mUpdate wsadmin password\033[0m"

COPY --chown=was:was mdm/reset_password.sh /tmp/mdm/
RUN /tmp/mdm/reset_password.sh

########## IBM MDM CE ######################################################

RUN echo "\033[1;34mInstall InfoSphere MDM CE using silent mode\033[0m"
COPY --chown=was:was mdm/install_mdm_ce_11.6.rsp /tmp/mdm/
COPY --chown=was:was mdm/extract_mdm_ce_11.6.rsp /tmp/mdm/

# Setting the environment variables
ENV PERL5LIB /opt/IBM/MDMCE/bin/perllib
ENV LANG en_US
ENV LC_CTYPE en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV DB2DIR /opt/ibm/db2/V10.5
ENV DB2INSTANCE db2inst1
RUN echo "export PERL5LIB=/opt/IBM/MDMCE/bin/perllib" >> $HOME/.bashrc
RUN echo "export LANG=en_US" >> $HOME/.bashrc
RUN echo "export LC_CTYPE=en_US.UTF-8" >> $HOME/.bashrc
RUN echo "export LC_ALL=en_US.UTF-8" >> $HOME/.bashrc
RUN echo "export DB2DIR=/opt/ibm/db2/V10.5" >> $HOME/.bashrc
RUN echo "export DB2INSTANCE=db2inst1" >> $HOME/.bashrc
RUN echo ". /opt/IBM/MDMCE/bin/compat.sh" >> $HOME/.bashrc

# Install MDM CE 11.6
RUN /opt/IBM/WebSphere/AppServer/profiles/AppSrv01/bin/startServer.sh server1 \
#	&& /home/was/IBM/InstallationManager/eclipse/tools/imcl input /tmp/mdm/install_mdm_ce_11.6.rsp -log /tmp/mdm/install.log -acceptLicense
	&& /home/was/IBM/InstallationManager/eclipse/tools/imcl input /tmp/mdm/extract_mdm_ce_11.6.rsp -log /tmp/mdm/install.log -acceptLicense

# Manual install
#/opt/IBM/WebSphere/AppServer/bin/startServer.sh server1
COPY --chown=was:was mdm/env_settings.ini /opt/IBM/MDMCE/bin/conf/env_settings.ini
WORKDIR /opt/IBM/MDMCE
RUN ./setup.sh --overwrite
RUN ./bin/configureEnv.sh --overwrite 
RUN /opt/IBM/WebSphere/AppServer/profiles/AppSrv01/bin/startServer.sh server1 \
	&& . /opt/IBM/MDMCE/bin/compat.sh \
	&& $TOP/bin/websphere/create_vhost.sh --silent  --wsadminUsername wsadmin --wsadminPwd wsadminpwd \
	&& $TOP/bin/websphere/create_appsvr.sh --silent  --wsadminUsername wsadmin --wsadminPwd wsadminpwd \
	&& $TOP/bin/websphere/install_war.sh --silent  --wsadminUsername wsadmin --wsadminPwd wsadminpwd \
	&& $TOP/bin/websphere/install_gds_war.sh --silent  --wsadminUsername wsadmin --wsadminPwd wsadminpwd 
	
#RUN ./bin/test_db.sh 
RUN ./bin/db/create_schema.sh --silent

## MDM CE 11.6 Fix Pack 6
COPY --chown=was:was mdm/ccd_11.6.0.6_201802050124.tar.gz.gz /tmp/mdm/
RUN tar zxf /tmp/mdm/ccd_11.6.0.6_201802050124.tar.gz.gz -C /opt/IBM/MDMCE/
COPY --chown=was:was mdm/env_settings.ini /opt/IBM/MDMCE/bin/conf/env_settings.ini
WORKDIR /opt/IBM/MDMCE
RUN ./setup.sh --overwrite
RUN ./bin/configureEnv.sh --overwrite 
RUN /opt/IBM/WebSphere/AppServer/profiles/AppSrv01/bin/startServer.sh server1 \
	&& ./bin/websphere/install_war.sh --wsadminUsername=wsadmin --wsadminPwd=wsadminpwd --silent

# Setting up a test company using a script (username: Admin, password: trinitron, company: Acme
RUN /opt/IBM/MDMCE/bin/db/create_cmp.sh --code=Acme --silent

## TODO Cleanup
# RUN rm -rf /tmp/mdm/

# Start MDM CE and all services
COPY mdm/start_mdm.sh /work/
CMD ["/work/start_mdm.sh"]

########## Cleanup #########################################################

WORKDIR /home/was/

USER root
