FROM centos:7

ARG USER=ibmadmin
ARG GROUP=ibm	

########## Utilities and required packages #################################

# USER root

RUN echo "\033[1;34mInstall utilities and required packages\033[0m"

RUN yum install -y unzip

RUN echo "\033[1;34mInstall packages needed to run IBMIM\033[0m"

RUN yum install -y xeyes
RUN yum install -y gtk2-devel-2.24.31-1.el7.i686
RUN yum install -y libXtst-1.2.3-1.el7.i686
RUN yum install -y libXtst.x86_64

########## User account and permissions ####################################

RUN groupadd ${GROUP} \
  && useradd ${USER} -g ${GROUP} -m

RUN mkdir -p /opt/IBM
RUN chown -R ${USER}:${GROUP} /opt/IBM

#RUN mkdir -p /var/ibm/
#RUN chown -R ${USER}:${GROUP} /var/ibm/
  
USER ${USER} 

########## IBM Installation Manager ########################################

RUN echo "\033[1;34mInstall IBM Installation Manager\033[0m"

COPY --chown=ibmadmin:ibm im/agent.installer.linux.gtk.x86_64_*.zip /tmp/
RUN unzip -qd /tmp/im /tmp/agent.installer.linux.gtk.x86_64_*.zip \
  && /tmp/im/installc -acceptLicense -accessRights nonAdmin -showProgress \
#    -installationDirectory "/home/ibmadmin/IBM/InstallationManager"  \
#    -dataLocation "/home/ibmadmin/var/ibm/InstallationManager" \
  && rm -rf /tmp/agent.installer.linux.gtk.x86_64_*.zip /tmp/im
  
ENV PATH /home/ibmadmin/IBM/InstallationManager/eclipse/tools:$PATH

RUN echo "\033[1;34mAdding offerings to IBM Installation Manager\033[0m"

COPY --chown=ibmadmin:ibm rad/RAD_WS_9.5_* /tmp/
RUN unzip -qd /tmp/rad '/tmp/RAD_WS_9.5_*' \
	&& rm -rf  /tmp/RAD_WS_9.5_* 

COPY --chown=ibmadmin:ibm mdm/INFOS_MASTER_DATA_MGT_WORKBENCH_S.zip /tmp/
RUN unzip -qd /tmp/mdm /tmp/INFOS_MASTER_DATA_MGT_WORKBENCH_S.zip \
	&& rm -rf /tmp/INFOS_MASTER_DATA_MGT_WORKBENCH_S.zip 

########## Install MDM Workbench ###########################################

RUN echo "\033[1;34mInstall MDM Workbench using silent mode\033[0m"
COPY --chown=ibmadmin:ibm mdm/install.rsp /tmp/mdm
RUN imcl input /tmp/mdm/install.rsp -installationDirectory /opt/IBM/SDP -log /tmp/mdm/install.log -acceptLicense

#RUN imcl install com.ibm.rational.application.developer.v95_9.5.0.RADO95-I20150908_2025 -repositories /tmp/rad/RAD_SETUP -installationDirectory /opt/IBM/SDP -acceptLicense
#RUN imcl install com.ibm.rational.application.developer.v95.pek.offering_9.0.1.20150203_1357 -repositories /tmp/rad/Activation_Kit/RAD95_Lic.jar -installationDirectory /opt/IBM/SDP -acceptLicense
#RUN imcl install com.ibm.im.mdm.workbench_11.6.0.201711291918 -repositories /tmp/mdm -installationDirectory /opt/IBM/SDP -acceptLicense

########## Configure MDM Workbench #########################################

RUN echo "\033[1;34mConfiguring the remote server connection\033[0m"

## TODO

RUN echo "\033[1;34mConfiguring the remote database connection\033[0m"

## TODO

########## Clean up ########################################################

RUN rm -rf /tmp/rad /tmp/mdm 

RUN rm -rf /home/ibmadmin/IBM/InstallationManager

WORKDIR /home/ibmadmin

USER root
