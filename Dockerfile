FROM dorowu/ubuntu-desktop-lxde-vnc
MAINTAINER Mark Fernandes <mark.fernandes@ifr.ac.uk>
# Install LXDE and VNC server.
RUN \
  apt-get update && \
   apt-get install -y  software-properties-common && \
   add-apt-repository  "deb http://archive.ubuntu.com/ubuntu precise universe" && \
	add-apt-repository  "deb http://archive.ubuntu.com/ubuntu precise main restricted universe multiverse" && \
	add-apt-repository  "deb http://archive.ubuntu.com/ubuntu precise-updates main restricted universe multiverse" && \
	add-apt-repository  "deb http://archive.ubuntu.com/ubuntu precise-backports main restricted universe multiverse" && \
	apt-get install -y wget unzip r-base fastqc  && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 

#
# create our fastqc folder & files that are not installed by apt-get install fastqc :-(
RUN mkdir /etc/fastqc && mkdir /etc/fastqc/Configuration
ADD fastqc/* /etc/fastqc/Configuration/
RUN mkdir /docs && cd /docs && wget http://www.bioinformatics.babraham.ac.uk/training/RNASeq_Course/RNA-Seq_analysis_course.pdf &&\
	wget http://www.bioinformatics.babraham.ac.uk/training/RNASeq_Course/Analysing%20RNA-Seq%20data%20Exercise.pdf
# RUN Mkdir /data && wget http://www.bioinformatics.babraham.ac.uk/training/RNASeq_Course/RNA-Seq_Course_Data.tar.gz

RUN mkdir /tools && cd /tools && wget http://www.bioinformatics.babraham.ac.uk/projects/seqmonk/seqmonk_v1.37.0.zip && \
	wget ftp://ftp.ccb.jhu.edu/pub/infphilo/hisat2/downloads/hisat2-2.0.5-Linux_x86_64.zip &&\
	mkdir /tools/examples && cd /tools/examples && wget http://www.bioinformatics.babraham.ac.uk/projects/seqmonk/example_seqmonk_data.smk
USER root

#RUN R -e \"source('https://bioconductor.org/biocLite.R'); biocLite('DESeq2')\"
# RUN bash - -c "R -e \"source('http://bioconductor.org/biocLite.R'); biocLite('DESeq2')\""
# -c means commands read from string 

ADD Welcome.txt /etc/motd
RUN mkdir /scripts
ADD /scripts/*.sh /scripts/
RUN chmod +x /scripts/*.sh 
# RUN ./scripts/add2R.sh

EXPOSE 22 
VOLUME /Coursedata
