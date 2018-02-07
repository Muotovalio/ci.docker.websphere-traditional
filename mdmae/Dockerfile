############################################################################
# (C) Copyright IBM Corporation 2015.                                      #
#                                                                          #
# Licensed under the Apache License, Version 2.0 (the "License");          #
# you may not use this file except in compliance with the License.         #
# You may obtain a copy of the License at                                  #
#                                                                          #
#      http://www.apache.org/licenses/LICENSE-2.0                          #
#                                                                          #
# Unless required by applicable law or agreed to in writing, software      #
# distributed under the License is distributed on an "AS IS" BASIS,        #
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. #
# See the License for the specific language governing permissions and      #
# limitations under the License.                                           #
#                                                                          #
############################################################################

FROM ibmcom/websphere-traditional:profile

ARG DB2_NODE=DBEXPC
ARG DB2_SERVER=172.17.0.2
ARG DB2_PORT=50000
ARG DB2_DBNAME=MDMDB

########## Utilities and required packages #################################

USER root

RUN echo "\033[1;34mAdd 32-bit architecture\033[0m"

RUN dpkg --add-architecture i386

RUN echo "\033[1;34mInstall utilities and required packages\033[0m"

RUN apt-get update && apt-get install -y unzip
RUN apt-get update && apt-get install -y ksh
RUN apt-get update && apt-get install -y libxml2
RUN apt-get update && apt-get install -y binutils
RUN apt-get update && apt-get install -y libpam0g:i386 

RUN echo "\033[1;34mInstall packages needed to run db2setup\033[0m"

RUN apt-get update && apt-get install -y xorg
RUN apt-get update && apt-get install -y openbox
RUN apt-get update && apt-get install -y libxext6 
RUN apt-get update && apt-get install -y libxrender1

RUN echo "\033[1;34mInstall packages needed to run IBMIM\033[0m"

RUN apt-get update && apt-get install -y libgtk2.0-0

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

########## IBM WebSphere Application Server ################################

USER was

RUN mkdir -p /tmp/mdm/

RUN echo "\033[1;34mUpdate wsadmin password\033[0m"
COPY --chown=was:was mdm/reset_password.sh /tmp/mdm/
RUN /tmp/mdm/reset_password.sh

#RUN echo "\033[1;34mStart the server\033[0m"
#RUN /opt/IBM/WebSphere/AppServer/profiles/AppSrv01/bin/startServer.sh server1

########## IBM Installation Manager ########################################

RUN echo "\033[1;34mInstall IBM Installation Manager\033[0m"

COPY --chown=was:was im/agent.installer.linux.gtk.x86_64_*.zip /tmp/
RUN unzip -qd /tmp/im /tmp/agent.installer.linux.gtk.x86_64_*.zip \
  && /tmp/im/installc -acceptLicense -accessRights nonAdmin \
    -installationDirectory "/home/was/IBM/InstallationManager"  \
    -dataLocation "/home/was/var/ibm/InstallationManager" -showProgress \
  && rm -rf /tmp/agent.installer.linux.gtk.x86_64_*.zip /tmp/im
    
ENV PATH /home/was/IBM/InstallationManager/eclipse/tools:$PATH

RUN echo "\033[1;34mAdding offerings to IBM Installation Manager\033[0m"

# InfoSphere MDM Standard Edition or Advanced Edition 11.6.0.4
COPY --chown=was:was mdm/mdm_installer-11.6.0.4-mdmseae_web.tar.gz /tmp/
RUN mkdir -p /tmp/mdm/mdmseae \
	&& tar xzf /tmp/mdm_installer-11.6.0.4-mdmseae_web.tar.gz -C /tmp/mdm/mdmseae \
	&& rm /tmp/mdm_installer-11.6.0.4-mdmseae_web.tar.gz
	
# Application Toolkit 11.6.0.4
COPY --chown=was:was mdm/mdm_installer-11.6.0.4-at4bpm_web.tar.gz /tmp/
RUN mkdir -p /tmp/mdm/at4bpm \
	&& tar xzf /tmp/mdm_installer-11.6.0.4-at4bpm_web.tar.gz -C /tmp/mdm/at4bpm \
	&& rm /tmp/mdm_installer-11.6.0.4-at4bpm_web.tar.gz

# Data Stewardship and Governance 11.6.0.4
#COPY --chown=was:was mdm/mdm_installer-11.6.0.4-mdph_web.tar.gz /tmp/
#RUN mkdir -p /tmp/mdm/mdph \
#	&& tar xzf /tmp/mdm_installer-11.6.0.4-mdph_web.tar.gz -C /tmp/mdm/mdph \
#	&& rm /tmp/mdm_installer-11.6.0.4-mdph_web.tar.gz

########## IBM MDM AE ######################################################

RUN echo "\033[1;34mInstall InfoSphere MDM using silent mode\033[0m"
COPY --chown=was:was mdm/install_mdm.rsp /tmp/mdm/
#RUN imcl input /tmp/mdm/install_mdm.rsp -log /tmp/mdm/install_mdm.rsp -acceptLicense

RUN echo "\033[1;34mComplete the configuration\033[0m"
COPY --chown=was:was mdm/conf_mdm.properties /tmp/mdm/
#WORKDIR /opt/IBM/MDM/mds/scripts/
#RUN ./madconfig.sh -propertyfile /tmp/mdm/conf_mdm.properties Configure_MasterDataManagement

#RUN rm -rf /tmp/mdm/

WORKDIR /home/was/
COPY --chown=was:was mdm/startApplication.py /work/
COPY --chown=was:was mdm/stopApplication.py /work/

#CMD ["/work/create_and_start"]
## /work/create_profile
## exec /work/start_server
#RUN echo "\033[1;34mStart the server and print log\033[0m"
#CMD ["/work/start_server"]
