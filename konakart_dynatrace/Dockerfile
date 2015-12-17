FROM java:7
MAINTAINER mike

#Add files to directories on Docker Container
CMD echo "Adding installation script"

ADD ./installation.sh /opt/
ADD ./konakart-installation /tmp/
ADD ./dynatrace-agent-6.2.jar /opt/

#Listen on default konakart port
EXPOSE 8780

ENV AGENT_NAME kubernetes_agent
ENV COLLECTOR_ADDRESS 172.17.8.1

ENV DB_ADDRESS 127.0.0.1
ENV DB_USER root
ENV DB_PASS dynatrace


#Install agent
RUN java -jar /opt/dynatrace-agent-6.2.jar -y


#Run konakart
CMD /bin/bash /opt/installation.sh

