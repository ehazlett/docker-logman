# Logman
Log aggregator for Docker.  It uses the Logstash agent to forward Docker container logs to ElasticSearch.  This can then be searched and viewed by other systems such as Kibana.

Note: this is experimental.

# Usage
Start an instance of ElasticSearch

`docker run -p 9200:9200 -p 9300:9300 -d --name elasticsearch arcus/elasticsearch`

Start Logman with a bind mount to the Docker directory.  Note: this container will have access to all container directories.  Make sure to take the necessary security precautions.

`docker run -it -d --name logman -v /var/lib/docker/containers:/containers -e ES_HOST=<your-docker-host-ip> -e DOCKER_ROOT=/containers ehazlett/logman`

Start Kibana to view logs

`docker run -it -p 80:80 --name kibana -d arcus/kibana`
