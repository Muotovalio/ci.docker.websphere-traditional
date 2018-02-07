FROM centos:7

ARG USER=mdmdev
ARG GROUP=users	

########## Utilities and required packages #################################

USER root

RUN echo "\033[1;34mInstall utilities and required packages\033[0m"

RUN yum install -y unzip

RUN echo "\033[1;34mInstall packages needed to run IBMIM\033[0m"

RUN yum install -y xeyes
RUN yum install -y gtk2-devel-2.24.31-1.el7.i686
RUN yum install -y libXtst-1.2.3-1.el7.i686
RUN yum install -y libXtst.x86_64

########## User account ####################################################

RUN useradd ${USER} -g ${GROUP} -m
  
USER ${USER} 

########## IBM Installation Manager ########################################

RUN echo "\033[1;34mInstall IBM Installation Manager\033[0m"

COPY --chown=mdmdev:users im/agent.installer.linux.gtk.x86_64_*.zip /tmp/

RUN unzip -qd /tmp/im /tmp/agent.installer.linux.gtk.x86_64_*.zip \
  && /tmp/im/installc -acceptLicense -accessRights nonAdmin -showProgress \
    -installationDirectory "/home/mdmdev/IBM/InstallationManager"  \
    -dataLocation "/home/mdmdev/var/ibm/InstallationManager" \
  && rm -rf /tmp/agent.installer.linux.gtk.x86_64_*.zip /tmp/im
  
ENV PATH /home/mdmdev/IBM/InstallationManager/eclipse/tools:$PATH

RUN echo "\033[1;34mAdding offerings to IBM Installation Manager\033[0m"

COPY --chown=mdmdev:users rad/RAD_WS_9.5_* /tmp/
RUN unzip -qd /tmp/rad '/tmp/RAD_WS_9.5_*' \
	&& rm -rf  /tmp/RAD_WS_9.5_* 

COPY --chown=mdmdev:users mdm/INFOS_MASTER_DATA_MGT_WORKBENCH_S.zip /tmp/
RUN unzip -qd /tmp/mdm /tmp/INFOS_MASTER_DATA_MGT_WORKBENCH_S.zip \
	&& rm -rf /tmp/INFOS_MASTER_DATA_MGT_WORKBENCH_S.zip 

########## MDM Workbench ###################################################

RUN echo "\033[1;34mInstall MDM Workbench using silent mode\033[0m"
COPY --chown=mdmdev:users mdm/install_workbench.rsp /tmp/mdm
RUN imcl input /tmp/mdm/install_workbench.rsp -log /tmp/mdm/install_workbench.rsp -acceptLicense

########## Clean up ########################################################

#RUN rm -rf /tmp/rad /tmp/workbench 

WORKDIR /home/mdmdev
