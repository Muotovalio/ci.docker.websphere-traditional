FROM ibmcom/websphere-traditional:8.5.5.9-profile

ARG DB2_NODE=DBEXPC
ARG DB2_SERVER=172.17.0.2
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


RUN echo "\033[1;34mInstall packages needed to run X11 / IBMIM\033[0m"

RUN apt-get update && apt-get install -y libgtk2.0-0
RUN apt-get install -y libxtst6 


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

COPY --chown=was:was mdm/*gz /tmp/

# InfoSphere InfoSphere MDM CE 11.0.0.0
RUN mkdir -p /tmp/mdm/mdmce \
	&& tar xzf /tmp/MDM_COLLAB_ED_V11.0.tar.gz -C /tmp/mdm/mdmce \
	&& rm /tmp/MDM_COLLAB_ED_V11.0.tar.gz

#RUN mkdir -p /tmp/mdm/StartupKit \
#	&& tar xzf /tmp/INSTL_STUP_TK_IMDM_V11.0.tar.gz -C /tmp/mdm/StartupKit \
#	&& rm /tmp/INSTL_STUP_TK_IMDM_V11.0.tar.gz

#RUN unzip -qd /tmp/mdm/la /tmp/IMDM_COLLABORATIVE_EDITION_V11.0.zip \
#	&& rm /tmp/IMDM_COLLABORATIVE_EDITION_V11.0.zip

########## IBM WebSphere Application Server ################################

RUN echo "\033[1;34mUpdate wsadmin password\033[0m"

COPY --chown=was:was mdm/reset_password.sh /tmp/mdm/
RUN /tmp/mdm/reset_password.sh

########## IBM MDM CE ######################################################

RUN echo "\033[1;34mInstall InfoSphere MDM CE using silent mode\033[0m"
COPY --chown=was:was mdm/install.rsp /tmp/mdm/

# Setting the environment variables
ENV PERL5LIB /opt/IBM/MDM/bin/perllib
ENV LANG en_US
ENV LC_CTYPE en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV DB2DIR /opt/ibm/db2/V10.5
ENV DB2INSTANCE db2inst1
RUN echo "export PERL5LIB=/opt/IBM/MDM/bin/perllib" >> $HOME/.bashrc
RUN echo "export LANG=en_US" >> $HOME/.bashrc
RUN echo "export LC_CTYPE=en_US.UTF-8" >> $HOME/.bashrc
RUN echo "export LC_ALL=en_US.UTF-8" >> $HOME/.bashrc
RUN echo "export DB2DIR=/opt/ibm/db2/V10.5" >> $HOME/.bashrc
RUN echo "export DB2INSTANCE=db2inst1" >> $HOME/.bashrc

RUN /opt/IBM/WebSphere/AppServer/profiles/AppSrv01/bin/startServer.sh server1 \
	&& /home/was/IBM/InstallationManager/eclipse/tools/imcl input /tmp/mdm/install.rsp -log /tmp/mdm/install.log -acceptLicense

# Start MDM CE and all services
COPY mdm/start_mdm.sh /work/
CMD ["/work/start_mdm.sh"]

WORKDIR /home/was/

