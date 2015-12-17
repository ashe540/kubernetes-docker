FROM java:8-jre

CMD echo "Copying dynatrace collector installation file..."
ADD dynatrace-collector.jar /opt/


WORKDIR /opt/

CMD java -jar dynatrace-collector.jar

CMD ["./dtcollector -instance $DT_COLLECTOR_NAME -server $DT_SERVER"] 
