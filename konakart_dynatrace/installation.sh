#/bin/bash

if [ ! -f /usr/local/konakart ]; then
    #Set default DB type
    if [ -z "$DB_TYPE"]; then

DB_TYPE="mysql"
        echo 'db type set to mysql'
    fi
    #Check to make sure that DB address is included
    if [ -z "$DB_ADDRESS" ]; then
        echo "No DB address is set. Exiting..." 
        exit 1  
    fi
    echo $DB_ADDRESS
    #Set default DB port
    if [ -z "$DB_PORT" ]; then
        DB_PORT="3306"
        echo 'db port set to 3306'
    fi
    echo $DB_PORT
    #Set default DB password if nothing is set
    if [ -z "$DB_ROOT_PWD" ]; then
        DB_PWD="dynatrace"
        echo 'db root pwd set'
    fi
    echo "Installing ......"
    #Run manual KonaKart installation
    /tmp/konakart-installation -S -DJavaJRE /usr/lib/jvm/java-1.7.0-openjdk-amd64 -DDatabaseType "$DB_TYPE" -DDatabaseUrl jdbc:"$DB_TYPE"://"$DB_ADDRESS":"$DB_PORT"/konakart?zeroDateTimeBehavior=convertToNull -DDatabaseUsername "$DB_USER" -DDatabasePassword "$DB_PASS"
    sleep 10s   
    echo "...... Finished installing."
fi

echo $AGENT_NAME
echo $COLLECTOR_ADDRESS

echo $DB_USER
echo $DB_PASS

echo "export CATALINA_OPTS=\"-agentpath:/dynatrace-6.2/agent/lib64/libdtagent.so=name=$AGENT_NAME,server=$COLLECTOR_ADDRESS\"" > /usr/local/konakart/bin/setenv.sh

echo "Starting...."

#Run the KonaKart application
#The tail is needed in this case because Docker will stop if nothing is running the foreground
/bin/sh /usr/local/konakart/bin/startkonakart.sh
tail -f /usr/local/konakart/logs/catalina.out

