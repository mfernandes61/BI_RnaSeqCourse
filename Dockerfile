FROM ubuntu
MAINTAINER Mark Fernandes <mark.fernandes@ifr.ac.uk>
# Install LXDE and VNC server.
RUN \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y lxde-core lxterminal tightvncserver software-properties-common && \
  add-apt-repository  "deb http://archive.ubuntu.com/ubuntu precise universe" && \
	add-apt-repository  "deb http://archive.ubuntu.com/ubuntu precise main restricted universe multiverse" && \
	add-apt-repository  "deb http://archive.ubuntu.com/ubuntu precise-updates main restricted universe multiverse" && \
	add-apt-repository  "deb http://archive.ubuntu.com/ubuntu precise-backports main restricted universe multiverse" && \
	apt-get install -y wget r-base fastqc  && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 

# Define working directory.
WORKDIR /data
a
# create our fastqc folder & files that are not installed by apt-get install fastqc :-(
RUN mkdir /etc/fastqc && mkdir /etc/fastqc/Configuration
ADD fastqc/* /etc/fastqc/Configuration/

RUN mkdir /tools && cd /tools && wget http://www.bioinformatics.babraham.ac.uk/projects/seqmonk/seqmonk_v1.37.0.zip && \
	wget ftp://ftp.ccb.jhu.edu/pub/infphilo/hisat2/downloads/hisat2-2.0.5-Linux_x86_64.zip &&\
	mkdir /tools/examples && cd /tools/examples && wget http://www.bioinformatics.babraham.ac.uk/projects/seqmonk/example_seqmonk_data.smk
USER root

RUN R -e \"source('https://bioconductor.org/biocLite.R'); biocLite('DESeq2')\"

# install pre-requisites
# RUN apt-get install -y python-software-properties
# RUN  apt-get update && apt-get install -y build-essential git libssl-dev  libpam0g-dev zlib1g-dev dh-autoreconf openssh-client openssl 

ADD Welcome.txt /etc/motd
RUN mkdir /scripts
# ADD entrypoint.sh /scripts/entrypoint.sh
# ADD launchsiab.sh /scripts/launchsiab.sh
#RUN chmod +x /usr/local/sbin/entrypoint.sh
# RUN chmod +x /scripts/entrypoint.sh && chmod +x /scripts/launchsiab.sh

EXPOSE 22 5901

VOLUME /Coursedata

CMD ["/bin/bash"]
