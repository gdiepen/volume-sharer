FROM dperson/samba
MAINTAINER site-github@guidodiepen.nl

#Overwrite the original samba.sh script with my updated version

COPY samba.sh /usr/bin/

VOLUME ["/etc/samba"]


#Based on this, we now install docker inside this image
#this means we have to install cURL and docker
RUN apt-get update -qq -y  && \
    apt-get install -qqy --force-yes curl && \
    curl -sSL https://get.docker.com | sh && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/*

EXPOSE 137/udp 138/udp 139 445

ENTRYPOINT ["samba.sh"]
