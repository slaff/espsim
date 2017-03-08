# ------------------------------------
# Fast dockerized development environment 
# for the Sming Framework: https://github.com/SmingHub/Sming.git
# ------------------------------------
FROM 32bit/ubuntu:16.04 
MAINTAINER Slavey Karadzhov <slav@attachix.com>

RUN apt-get -y update && \
    apt-get -y install git wget unzip build-essential

# ------------------------------------------------------------------------------    
# Install Espressif NONOS SDK v2.0
# ------------------------------------------------------------------------------

RUN cd /tmp && \
    mkdir -p /opt/esp-open-sdk && \
    wget http://bbs.espressif.com/download/file.php?id=1690 -O sdk.zip && \
    unzip sdk.zip && \
    mv `pwd`/ESP8266_NONOS_SDK/ /opt/esp-open-sdk/sdk && \
    rm sdk.zip

# ------------------------------------------------------------------------------
# Set Environment
# ------------------------------------------------------------------------------

ENV PATH /opt/esp-open-sdk/xtensa-lx106-elf/bin:$PATH
ENV XTENSA_TOOLS_ROOT /opt/esp-open-sdk/xtensa-lx106-elf/bin
ENV SDK_BASE /opt/esp-open-sdk/sdk
ENV FW_TOOL /opt/esp-open-sdk/xtensa-lx106-elf/bin/esptool.py  

ENV ESP_HOME /opt/esp-open-sdk

COPY assets/c_types.h /opt/esp-open-sdk/sdk/include/c_types.h
COPY assets/eagle_soc.h /opt/esp-open-sdk/sdk/include/eagle_soc.h

RUN cd /root && git clone https://github.com/slaff/espsim.git
RUN cd /root/espsim && make SDK=$SDK_BASE
