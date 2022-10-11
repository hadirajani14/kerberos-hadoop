FROM ubuntu:16.04

USER root
RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install nano apt-utils iputils-ping openssh-server openssh-client openjdk-8-jdk jsvc -y

RUN ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
RUN cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
RUN chmod 0600 ~/.ssh/authorized_keys

RUN echo "EXAMPLE.COM\n\
    kerberos\n\
    kerberos" | apt-get install krb5-user -y

ADD hadoop-3.3.4.tar.gz /
RUN ln -s hadoop-3.3.4 hadoop

RUN mkdir -p /hadoop/dfsdata/datanode && mkdir -p /hadoop/dfsdata/namenode && mkdir /hadoop/tmp

COPY setup.sh /app/
COPY start.sh /app/
COPY *.xml /hadoop/etc/hadoop/

RUN chmod a+x /app/setup.sh
RUN chmod a+x /app/start.sh

RUN /bin/bash -C /app/setup.sh

CMD  service ssh restart && /app/start.sh