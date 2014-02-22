# -------------------------------------------------
# docker-starbound
#
# Create a docker image to run a starbound server with the StarryPy wrapper
# http://playstarbound.com/
# http://github.com/CarrotsAreMediocre/StarryPy
#
# Authors: John Eckhart
# Updated: 2014-02-22
# -------------------------------------------------


# Base system is the latest version of Ubuntu.
FROM   ubuntu:13.10
MAINTAINER John Eckhart, jweckhart@gmail.com

# Make sure we don't get notifications we can't answer during building.
env    DEBIAN_FRONTEND noninteractive

# Update the env
run    apt-get --yes update; apt-get --yes dist-upgrade
run    apt-get --yes install python2.7 python-dev python-pip git
# Uncomment if you want to run the 32bit server
#run    apt-get --yes lib32stdc++6 lib32gcc1

# Install Starbound
# make sure you start the dockerfile with -v <path_to_local_starbound>:/opt/starbound
add    ./starbound/linux32/bootstrap.config /etc/starbound/bootstrap.config
add    ./starbound/starbound.config /etc/starbound/starbound.config
#run    [ -f /data/starbound.config ] || cp /etc/starbound/starbound.config /data

# Install StarryPy
run    cd /opt; git clone https://github.com/CarrotsAreMediocre/StarryPy; pip install -r StarryPy/requirements.txt

expose 21025

#cmd    ["/opt/starbound/linux64/starbound_server", "-bootconfig", "/etc/starbound/bootstrap.config"]
add    scripts/start /start
cmd    ["/start"] 

