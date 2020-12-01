FROM ubuntu:18.04
#ANSIBLE SERVER

# Labels.
LABEL maintainer="will@willhallonline.co.uk" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.name="willhallonline/ansible" \
    org.label-schema.description="Ansible inside Docker" \
    org.label-schema.url="https://github.com/willhallonline/docker-ansible" \
    org.label-schema.vcs-url="https://github.com/willhallonline/docker-ansible" \
    org.label-schema.vendor="Will Hall Online" \
    org.label-schema.docker.cmd="docker run --rm -it -v $(pwd):/ansible -v ~/.ssh/id_rsa:/root/id_rsa willhallonline/ansible:2.9-ubuntu-20.04"

RUN apt-get update && \
    apt-get install -y gnupg2 python3-pip sshpass iputils-ping net-tools git openssh-client openssh-server && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean
    
RUN python3 -m pip install --upgrade pip cffi && \
    pip install ansible==2.10.3 && \
    pip install mitogen ansible-lint jmespath && \
    pip install --upgrade pywinrm

RUN mkdir /ansible && \
    mkdir -p /etc/ansible && \
    echo 'localhost' > /etc/ansible/hosts

RUN mkdir /ansible-generator
RUN git clone https://github.com/kkirsche/ansible-generator.git /ansible-generator
RUN cd /ansible-generator && \
    pip install -U wheel && \
    python3 setup.py bdist_wheel --universal && \
    pip install -U  dist/*.whl

RUN ssh-keygen -q -t rsa -N '' -f /root/.ssh/id_rsa && \
    cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys && \
    for key in /etc/ssh/ssh_host_*_key.pub; do echo "localhost $(cat ${key})" >> /root/.ssh/known_hosts; done
COPY sshd_config /etc/ssh/sshd_config

RUN service ssh start
EXPOSE 22

RUN echo 'root:root' | chpasswd


WORKDIR /project
CMD ["/bin/bash"]
#CMD [ "ansible-playbook", "--version" ]
