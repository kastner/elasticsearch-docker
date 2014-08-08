#
# ElasticSearch Dockerfile
#
# https://github.com/dockerfile/elasticsearch
#

# Pull base image.
FROM dockerfile/java

# Install ElasticSearch.
RUN \
  cd /tmp && \
  wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.3.1.tar.gz && \
  tar xvzf elasticsearch-1.3.1.tar.gz && \
  rm -f elasticsearch-1.3.1.tar.gz && \
  mv /tmp/elasticsearch-1.3.1 /elasticsearch

# Define mountable directories.
VOLUME ["/data"]

# Define working directory.
WORKDIR /data

# Scoring scripts
COPY config/scripts/ /elasticsearch/config/scripts/

# Test config
COPY config/elasticsearch-test-cluster.yml /elasticsearch/config/

# Install plugin
RUN /elasticsearch/bin/plugin -i mobz/elasticsearch-head

# Define default command.
CMD ["/elasticsearch/bin/elasticsearch"]

# Expose ports.
#   - 9200: HTTP
#   - 9300: transport
EXPOSE 9200
EXPOSE 9300
