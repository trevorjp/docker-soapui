FROM centos:7
FROM python:2.7
FROM java:openjdk-7-jdk
MAINTAINER Daniel Davison <sircapsalot@gmail.com>

#  Version
ENV   SOAPUI_VERSION  5.3.0
ENV   MYSQL_VERSOIN   5.1.4.4

COPY entry_point.sh /opt/bin/entry_point.sh
COPY server.py /opt/bin/server.py
COPY server_index.html /opt/bin/server_index.html

RUN chmod +x /opt/bin/entry_point.sh
RUN chmod +x /opt/bin/server.py

# Download and unarchive SoapUI
RUN mkdir -p /opt &&\
    curl  http://cdn01.downloads.smartbear.com/soapui/${SOAPUI_VERSION}/SoapUI-${SOAPUI_VERSION}-linux-bin.tar.gz \
    | gunzip -c - | tar -xf - -C /opt && \
    ln -s /opt/SoapUI-${SOAPUI_VERSION} /opt/SoapUI
    
RUN curl -SL https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.44.tar.gz \
    | tar xz mysql-connector-java-5.1.44/mysql-connector-java-5.1.44-bin.jar --strip-components=1
    
COPY mysql-connector-java-5.1.44-bin.jar /opt/SoapUI/bin/ext/mysql-connector-java-5.1.44-bin.jar

# Set working directory
WORKDIR /opt/bin

# Set environment
ENV PATH ${PATH}:/opt/SoapUI/bin

EXPOSE 3000
CMD ["/opt/bin/entry_point.sh"]
