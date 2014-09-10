FROM ubuntu:14.04

# Set the env variable DEBIAN_FRONTEND to noninteractive
ENV DEBIAN_FRONTEND noninteractive
 
# Update the package repository
RUN apt-get update; apt-get upgrade -y

# Install base system
RUN apt-get install -y varnish && apt-get clean 

# Make our custom VCLs available on the container
COPY default.vcl /etc/varnish/default.vcl

# Expose port 80
EXPOSE 80

COPY start /start
RUN chmod 0755 /start
CMD ["/start"]
