FROM ubuntu:16.04

USER root
RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install nano apt-utils iputils-ping -y
RUN mkdir /var/keytabs
RUN useradd -u 1098 hdfs

RUN echo "EXAMPLE.COM\n\
    kerberos.example.com\n\
    kerberos.example.com" | apt-get install krb5-admin-server -y

COPY start-kdc.sh /app/
RUN chmod a+x /app/start-kdc.sh