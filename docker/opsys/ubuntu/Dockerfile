FROM BASE_OS_IMAGE

ENV USER_HOME=/usr/local/

# Update the operating system.
RUN apt-get update -y --fix-missing && \
    apt-get upgrade -y

# Add Service user:group (service:service).
RUN addgroup --gid 1000 service && \
    adduser --uid 1000 \
            --gid 1000 \
            --home ${USER_HOME} \
            --shell /bin/false \
            --disabled-password \
            --disabled-login \
            --gecos '' service

# Set the working directory
WORKDIR ${USER_HOME}
