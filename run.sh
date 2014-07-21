#!/bin/bash
ES_HOST=${ES_HOST:-localhost}
ES_PORT=${ES_PORT:-9200}
DOCKER_ROOT=${DOCKER_ROOT:-/var/lib/docker/containers}

echo "ElasticSearch Host: $ES_HOST:$ES_PORT"
echo "Docker Root: $DOCKER_ROOT"

cat << EOF > /etc/logstash.conf
input {
    file {
        type => "docker"
        path    => "$DOCKER_ROOT/*/*.log"
        codec   => "json"
    }
}

filter {
    date {
        match => [ "time", "ISO8601" ]    
    }
    grok {
        match => ["path","%{GREEDYDATA}/%{GREEDYDATA:container}-json.log"]
    }
}
output {
    elasticsearch {
        protocol => "http"
        host => "$ES_HOST"
        port => $ES_PORT    
    }
}
EOF

/usr/local/bin/logstash agent -f /etc/logstash.conf
