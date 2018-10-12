FROM biocontainers/biocontainers:latest

LABEL base.image="biocontainers:latest"
LABEL version="1"
LABEL software="FASTQC"
LABEL software.version="0.11.5"
LABEL about.summary="A quality control tool for high throughput sequence data."
LABEL about.home="http://www.bioinformatics.babraham.ac.uk/projects/fastqc/"
LABEL about.documentation="http://www.bioinformatics.babraham.ac.uk/projects/fastqc/Help/"
LABEL license="https://www.gnu.org/copyleft/gpl.html"
LABEL about.tags="General"

# install in /opt instead of /tmp
USER root
ENV DST=/opt
ENV ZIP=fastqc_v0.11.5.zip
ENV LANG=C

RUN \
    # set locales
    apt-get update && apt-get install locales && apt-get clean && \
    echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && \
    locale-gen en_US.utf8 && \
    /usr/sbin/update-locale LANG=en_US.UTF-8 && \
    \
    # install fastqc dependencies
    wget https://github.com/agordon/libgtextutils/releases/download/0.7/libgtextutils-0.7.tar.gz -O /tmp/libgtextutils-0.7.tar.gz && \
    tar -xvf /tmp/libgtextutils-0.7.tar.gz -C /tmp && \
    rm /tmp/libgtextutils-0.7.tar.gz && \
    cd /tmp/libgtextutils-0.7 && \
    ./configure && \
    make && \
    make install && \
    cd / && \
    rm -rf /tmp/libgtextutils-0.7 && \
    wget https://github.com/agordon/fastx_toolkit/releases/download/0.0.14/fastx_toolkit-0.0.14.tar.bz2 -O /tmp/fastx_toolkit-0.0.14.tar.bz2 && \
    tar -xvf /tmp/fastx_toolkit-0.0.14.tar.bz2 -C /tmp && \
    rm /tmp/fastx_toolkit-0.0.14.tar.bz2 && \
    cd /tmp/fastx_toolkit-0.0.14 && \
    ./configure && \
    make && \
    make install && \
    cd / && \
    rm -rf $DST/fastx_toolkit-0.0.14 && \
    ldconfig && \
    \
    # install fastqc
    wget http://www.bioinformatics.babraham.ac.uk/projects/fastqc/$ZIP -O $DST/$ZIP && \
    unzip - $DST/$ZIP -d $DST && \
    rm $DST/$ZIP && \
    cd $DST/FastQC && \
    chmod 755 fastqc && \
    ln -s $DST/FastQC/fastqc /usr/local/bin/fastqc

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV PATH /usr/local/bin:$PATH
USER biodocker
CMD fastqc
WORKDIR /data/
