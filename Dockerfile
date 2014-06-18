FROM stackbrew/debian:jessie
MAINTAINER Evan Hazlett <ejhazlett@gmail.com>
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN apt-get install -y wget openjdk-7-jre --no-install-recommends
RUN wget https://download.elasticsearch.org/logstash/logstash/logstash-1.4.1.tar.gz -O /tmp/logstash.tar.gz && tar xf /tmp/logstash.tar.gz -C /usr/local/ --strip-components=1
ADD run.sh /usr/local/bin/run
RUN chmod +x /usr/local/bin/run
CMD ["/usr/local/bin/run"]
