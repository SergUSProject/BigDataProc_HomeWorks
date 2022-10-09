FROM ubuntu:14.04

LABEL maintainer="Ваше имя <e-mail>"


# ======================
#
# Install packages 
#
# ======================

RUN apt-get update && apt-get install -y openssh-server software-properties-common nano tini && \
    add-apt-repository ppa:openjdk-r/ppa && \
    apt update && apt -y install openjdk-8-jdk \
    apt-get clean && rm -rf /var/lib/apt/lists/*


# ======================
#
# Create user
#
# ======================

# User home directory
# Ваш код

# Create user
# Ваш код

# Set current dir
# Ваш код

# Add sudo permission for hadoop user to start ssh service
# Ваш код

# Copy the entrypoint script
COPY entrypoint.sh /usr/local/bin/
RUN chmod 755 /usr/local/bin/entrypoint.sh

# ======================
#
# Install Hadoop
#
# ======================

# TODO: try it out instead of wget
#ADD http://example.com/big.tar.xz /usr/src/things/

# Change root to the bigdata user
# Ваш код

# Install Hadoop
# Ваш код

# Set Hadoop environment variables
# Ваш код

# Copy hadoop configuration files
COPY --chown=bigdata:bigdata ["config/hdfs", "config/yarn", "config/mapreduce", "$HADOOP_CONF_DIR/"]

ENTRYPOINT ["sh", "/usr/local/bin/entrypoint.sh"]