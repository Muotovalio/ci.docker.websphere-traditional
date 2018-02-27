FROM ubuntu:16.04

ARG USER=was
ARG GROUP=was

USER root

########## Preparing Linux systems for installation ########################

COPY limits.conf /tmp/
RUN cat /tmp/limits.conf >> /etc/security/limits.conf

RUN ulimit -n 8192
RUN umask 077

########## Utilities and required packages #################################

#RUN echo "\033[1;34mAdd 32-bit architecture\033[0m"

#RUN dpkg --add-architecture i386

RUN echo "\033[1;34mInstall utilities and required packages\033[0m"

RUN apt-get update && apt-get install -y unzip

RUN echo "\033[1;34mInstall packages needed to run X11 / IBMIM\033[0m"

RUN apt-get update && apt-get install -y libgtk2.0-0
RUN apt-get install -y libxtst6 

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

#COPY --chown=was:was im/agent.installer.linux.gtk.x86_64_*.zip /tmp/
#RUN unzip -qd /tmp/im /tmp/agent.installer.linux.gtk.x86_64_*.zip \
#  && /tmp/im/installc -acceptLicense -accessRights nonAdmin \
#    -installationDirectory "/opt/IBM/InstallationManager"  \
#    -dataLocation "/var/ibm/InstallationManager" -showProgress \
#  && rm -rf /tmp/agent.installer.linux.gtk.x86_64_*.zip /tmp/im
    
ENV PATH /home/was/IBM/InstallationManager/eclipse/tools:$PATH

RUN echo "\033[1;34mAdding offerings to IBM Installation Manager\033[0m"

COPY --chown=was:was bpm/BPM_Exp_V86_Linux* /tmp/
RUN mkdir -p /tmp/bpm \
	&& tar tvf /tmp/BPM_Exp_V86_Linux_x86_1_of_3.tar.gz \
	&& tar xzf /tmp/BPM_Exp_V86_Linux_x86_1_of_3.tar.gz -C /tmp/bpm \
	&& tar xzf /tmp/BPM_Exp_V86_Linux_x86_2_of_3.tar.gz -C /tmp/bpm \
	&& tar xzf /tmp/BPM_Exp_V86_Linux_x86_3_of_3.tar.gz -C /tmp/bpm \
	&& rm /tmp/BPM_Exp_V86_Linux*

COPY --chown=was:was bpm/8.0.5.6-WS-IBMWASJAVA-Linux.zip /tmp/bpm/repository/

COPY --chown=was:was mdm/mdm_installer-11.6.0.4-mdph_web.tar.gz /tmp/
RUN mkdir -p /tmp/mdm \
	&& tar xzf /tmp/mdm_installer-11.6.0.4-mdph_web.tar.gz -C /tmp/mdm \
	&& rm /tmp/mdm_installer-11.6.0.4-mdph_web.tar.gz

########## Installing and configuring IBM BPM Express ######################

RUN echo "\033[1;34mInstalling IBM BPM Express silently using a response file\033[0m"

COPY --chown=was:was bpm/bpmExp_linux_response_nonroot_64bit.xml /tmp/bpm/
RUN /tmp/bpm/IM64/userinstc input /tmp/bpm/bpmExp_linux_response_nonroot_64bit.xml -acceptLicense -log /tmp/bpm/silent_install.log

RUN echo "\033[1;34mConfiguring profiles and databases\033[0m"

COPY --chown=was:was bpm/Express-PC-Standalone-DB2.properties /tmp/bpm/
RUN  /opt/IBM/BPM/v8.6/bin/managesdk.sh -setNewProfileDefault -sdkname 1.8_64 
RUN /opt/IBM/BPM/v8.6/bin/BPMConfig.sh -create -de /tmp/bpm/Express-PC-Standalone-DB2.properties

########## Installing and configuring IBM Stewardship Center ###############

RUN echo "\033[1;34mInstalling IBM Stewardship Center silently using a response file\033[0m"
RUN imcl input /tmp/mdm/install.rsp -log /tmp/mdm/silent_install.log -acceptLicense

# Installing and configuring initially for a Process Center installation
 
# TODO Catalog the InfoSphere MDM database.

# TODO RUN InstallGovernanceApplication.sh install_configure_governance_apps


USER root
