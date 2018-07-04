#Copyright (c) 2014-2017 Oracle and/or its affiliates. All rights reserved.
#
#Licensed under the Universal Permissive License v 1.0 as shown at http://oss.oracle.com/licenses/upl.
#
# ORACLE DOCKERFILES PROJECT
# --------------------------
# This is the Dockerfile for Oracle WebLogic Server 12.2.1.2 Generic Distro
# 
# REQUIRED FILES TO BUILD THIS IMAGE
# ----------------------------------
# (1) fmw_12.2.1.2.0_wls_Disk1_1of1.zip 
#     Download the Generic installer from http://www.oracle.com/technetwork/middleware/weblogic/downloads/wls-for-dev-1703574.html 
#
# (2) server-jre-8uXX-linux-x64.tar.gz
#     Download from http://www.oracle.com/technetwork/java/javase/downloads/server-jre8-downloads-2133154.html 
#
# HOW TO BUILD THIS IMAGE
# -----------------------
# Put all downloaded files in the same directory as this Dockerfile
# Run: 
#      $ docker build -f Dockerfile.generic -t oracle/weblogic:12.2.1.2-generic . 
#
# IMPORTANT
# ---------
# The resulting image of this Dockerfile contains a WLS Empty Domain.
#
# Pull base image
# From the Oracle Registry
# -------------------------
FROM oracle/serverjre:8

# Maintainer
# ----------
MAINTAINER Soumik Dan <soumik.k.dan@oracle.com>

# Common environment variables required for this build (do NOT change)
# --------------------------------------------------------------------
ENV ORACLE_HOME=/scratch/gsh/oracle \
    USER_MEM_ARGS="-Djava.security.egd=file:/dev/./urandom" \
    SCRIPT_FILE=/scratch/gsh/createAndStartEmptyDomain.sh \
    PATH=$PATH:/usr/java/default/bin:/scratch/gsh/oracle/oracle_common/common/bin:/scratch/gsh/oracle/wlserver/common/bin
    
# Setup filesystem and oracle user
# Adjust file permissions, go to /u01 as user 'oracle' to proceed with WLS installation
# ------------------------------------------------------------  
#RUN mkdir -p /u01 && \
#    chmod a+xr /u01 && \
#    useradd -b /u01 -d /scratch/gsh/oracle -m -s /bin/bash oracle
   
# Copy scripts
#-------------
RUN mkdir -p /scratch/gsh/oracle \
    chmod 777 /scratch/gsh/oracle
COPY container-scripts/createAndStartEmptyDomain.sh container-scripts/create-wls-domain.py /scratch/gsh/

# Domain and Server environment variables
# ------------------------------------------------------------  
ENV DOMAIN_NAME="${DOMAIN_NAME:-base_domain}" \
    DOMAIN_HOME=/scratch/gsh/oracle/user_projects/domains/${DOMAIN_NAME:-base_domain} \
    ADMIN_PORT="${ADMIN_PORT:-7001}" \
    ADMIN_USERNAME="${ADMIN_USERNAME:-weblogic}" \
    ADMIN_NAME="${ADMIN_NAME:-AdminServer}" \
    ADMIN_PASSWORD="${ADMIN_PASSWORD:-""}"


# Environment variables required for this build (do NOT change)
# -------------------------------------------------------------
ENV FMW_PKG=fmw_12.2.1.2.0_wls_Disk1_1of1.zip \
    FMW_JAR=fmw_12.2.1.2.0_wls.jar

# Copy packages
# -------------
COPY $FMW_PKG install.file oraInst.loc /scratch/gsh/
RUN  chown gsh:gsh -R /scratch/gsh && \
     chmod +xr $SCRIPT_FILE 

# Install
# ------------------------------------------------------------
USER gsh

RUN cd /scratch/gsh && $JAVA_HOME/bin/jar xf /scratch/gsh/$FMW_PKG && cd - && \
    $JAVA_HOME/bin/java -jar /scratch/gsh/$FMW_JAR -silent -responseFile /scratch/gsh/install.file -invPtrLoc /scratch/gsh/oraInst.loc -jreLoc $JAVA_HOME -ignoreSysPrereqs -force -novalidation ORACLE_HOME=$ORACLE_HOME INSTALL_TYPE="WebLogic Server" && \
    rm /scratch/gsh/$FMW_JAR /scratch/gsh/$FMW_PKG /scratch/gsh/oraInst.loc /scratch/gsh/install.file

WORKDIR ${ORACLE_HOME}

# Define default command to start script.
# CMD ["/scratch/gsh/createAndStartEmptyDomain.sh"]
# Change to User Root
USER root
