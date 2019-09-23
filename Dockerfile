LABEL maintainer="fran@fransedano.net"
FROM ubuntu:18.04
WORKDIR /asterisk
RUN apt-get update && apt-get install -y git curl vim
RUN apt-get install -y git curl wget libnewt-dev libssl-dev libncurses5-dev subversion  libsqlite3-dev build-essential libjansson-dev libxml2-dev  uuid-dev libedit-dev libjansson-dev libsqlite3-dev uuid-dev libxml2-dev libcodec2-dev libfftw3-dev libsndfile1-dev libunbound-dev
RUN apt-get install -y aptitude-common libboost-filesystem1.65.1 libboost-iostreams1.65.1 libboost-system1.65.1 libcgi-fast-perl libcgi-pm-perl libclass-accessor-perl libcwidget3v5 libencode-locale-perl libfcgi-perl libhtml-parser-perl libhtml-tagset-perl libhttp-date-perl libhttp-message-perl libio-html-perl libio-string-perl liblwp-mediatypes-perl libparse-debianchangelog-perl libsigc++-2.0-0v5 libsub-name-perl libtimedate-perl liburi-perl libxapian30
RUN curl -O http://downloads.asterisk.org/pub/telephony/asterisk/asterisk-16-current.tar.gz
RUN tar xvf asterisk-16-current.tar.gz
WORKDIR /asterisk/asterisk-16.5.1
RUN contrib/scripts/get_mp3_source.sh
#RUN contrib/scripts/install_prereq install
RUN ./configure
COPY data/* /asterisk/asterisk-16.5.1/
RUN make
RUN make install
RUN make samples
RUN make config && ldconfig
RUN groupadd asterisk && useradd -r -d /var/lib/asterisk -g asterisk asterisk &&  usermod -aG audio,dialout asterisk
RUN apt-get install -y tcpdump festival
COPY festival/* /etc/
COPY bootstrap/* /
COPY dialplan/* /etc/asterisk/
#CMD [ "/bin/bash", "-c", "sleep 100000" ]
CMD ["/bootstrap.sh"]
