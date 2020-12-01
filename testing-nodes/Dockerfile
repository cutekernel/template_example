FROM ubuntu:14.04

USER root 
#RUN add-apt-repository ppa:deadsnakes/ppa

# # set noninteractive installation
# ENV DEBIAN_FRONTEND noninteractive
# #install tzdata package
# RUN apt-get install -y tzdata
# # set your timezone
# RUN ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime
# RUN dpkg-reconfigure --frontend noninteractive tzdata

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
    #tzdata \
    acl \
    apache2 \
    asciidoc \
    bzip2 \
    cdbs \
    curl \
    debhelper \
    debianutils \
    devscripts \
    docbook-xml \
    dpkg-dev \
    fakeroot \
    gawk \
    gcc \
    git \
    libffi-dev \
    libssl-dev \
    libxml2-utils \
    locales \
    make \
    mercurial \
    mysql-server \
    openssh-client \
    openssh-server \
    python-dev \
    pass \
    python-httplib2 \
    python-jinja2 \
    python-keyczar \
    python-lxml \
    python-mock \
    python-mysqldb \
    python-nose \
    python-paramiko \
    python-passlib \
    python-pip \
    python-setuptools \
    python-virtualenv \
    python-yaml \
    reprepro \
    rsync \
    ruby \
    sshpass \
    subversion \
    sudo \
    # tzdata \
    unzip \ 
    xsltproc \
    zip \
    wget \
    && \
    apt-get clean

# Install Python3.5
RUN apt-get -y install software-properties-common \
    python-software-properties
RUN add-apt-repository ppa:fkrull/deadsnakes \
    && apt-get update -y \
    && apt-get -y install python3.6 python3.6-dev
RUN wget https://bootstrap.pypa.io/get-pip.py \
    && python3.6 get-pip.py
RUN pip3 install --upgrade pip setuptools pycrypto cryptography

# Python 2.7
#RUN python --version
#RUN pip install pip --upgrade
RUN pip install --upgrade pycrypto cryptography

#RUN python -m pip3 install pip --upgrade --force

# helpful things taken from the ubuntu-upstart Dockerfile:
# https://github.com/tianon/dockerfiles/blob/4d24a12b54b75b3e0904d8a285900d88d3326361/sbin-init/ubuntu/upstart/14.04/Dockerfile
ADD init-fake.conf /etc/init/fake-container-events.conf

# undo some leet hax of the base image
RUN rm /usr/sbin/policy-rc.d; \
	rm /sbin/initctl; dpkg-divert --rename --remove /sbin/initctl
# remove some pointless services
RUN /usr/sbin/update-rc.d -f ondemand remove; \
	for f in \
		/etc/init/u*.conf \
		/etc/init/mounted-dev.conf \
		/etc/init/mounted-proc.conf \
		/etc/init/mounted-run.conf \
		/etc/init/mounted-tmp.conf \
		/etc/init/mounted-var.conf \
		/etc/init/hostname.conf \
		/etc/init/networking.conf \
		/etc/init/tty*.conf \
		/etc/init/plymouth*.conf \
		/etc/init/hwclock*.conf \
		/etc/init/module*.conf\
	; do \
		dpkg-divert --local --rename --add "$f"; \
	done; \
	echo '# /lib/init/fstab: cleared out for bare-bones Docker' > /lib/init/fstab
# end things from ubuntu-upstart Dockerfile

RUN rm /etc/apt/apt.conf.d/docker-clean


#Create Keys
RUN locale-gen en_US.UTF-8
# RUN ssh-keygen -q -t rsa -N '' -f /root/.ssh/id_rsa && \
#     cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys && \
#     for key in /etc/ssh/ssh_host_*_key.pub; do echo "localhost $(cat ${key})" >> /root/.ssh/known_hosts; done



VOLUME /sys/fs/cgroup /run/lock /run /tmp
RUN pip3 install coverage junit-xml

#Setup root password
RUN echo 'root:root' | chpasswd

# Set up SSH
COPY sshd_config /etc/ssh/sshd_config
ENTRYPOINT service ssh restart && bash
EXPOSE 22

ENV container=docker
CMD ["/sbin/init"]