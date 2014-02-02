FROM        ubuntu
MAINTAINER  Love Nyberg "love.nyberg@lovemusic.se"
 
# Update apt sources
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list

# Update the package repository
RUN apt-get update; apt-get upgrade -y; apt-get install locales

# Configure timezone and locale
RUN echo "Europe/Stockholm" > /etc/timezone; dpkg-reconfigure -f noninteractive tzdata
RUN export LANGUAGE=en_US.UTF-8; export LANG=en_US.UTF-8; export LC_ALL=en_US.UTF-8; locale-gen en_US.UTF-8; DEBIAN_FRONTEND=noninteractive dpkg-reconfigure locales

# Install base system
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y varnish

# Make our custom VCLs available on the container
ADD default.vcl /etc/varnish/vcl/default.vcl

ENV VARNISH_BACKEND_PORT 80
ENV VARNISH_BACKEND_IP 172.17.42.1
ENV VARNISH_PORT 80

# Expose port 80
EXPOSE 80

ADD start /start
RUN chmod 0755 /start
CMD ["/start"]
