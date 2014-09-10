FROM ubuntu:14.04
 
# Update the package repository
RUN apt-get update; apt-get upgrade -y

# Install base system
RUN apt-get install -y varnish

# Make our custom VCLs available on the container
ADD default.vcl /etc/varnish/default.vcl

# Expose port 80
EXPOSE 80

ADD start /start
RUN chmod 0755 /start
CMD ["/start"]
