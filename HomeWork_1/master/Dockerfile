FROM hadoop-base-image

LABEL maintainer="Ваше имя <e-mail>"

USER root

# Copy a private key
COPY --chown=bigdata:bigdata ./keys/id_rsa .ssh/

# Copy the entrypoint script
COPY ./master/entrypoint.sh /usr/local/bin/

RUN chmod 400 .ssh/id_rsa && \
    chmod 755 /usr/local/bin/entrypoint.sh 

USER bigdata

# Format Namenode
# Ваш код

ENTRYPOINT ["sh", "/usr/local/bin/entrypoint.sh"]