FROM ubuntu:14.04
MAINTAINER 0.1.2 shupresso@gmail.com

# -------------------------------------------
# Environment variables
# -------------------------------------------
ENV DEBIAN_FRONTEND noninteractive
ENV OPENGROK_INSTANCE_BASE /grok

# -------------------------------------------
# During building an image
# -------------------------------------------
RUN apt-get update
RUN apt-get install -y openjdk-7-jre-headless exuberant-ctags git subversion mercurial tomcat7 wget inotify-tools

# By executing install.sh, install OpenGrok and deploy the OpenGrok war to Tomcat
ADD opengrok-0.12.1.tar.gz /
ADD install.sh /usr/local/bin/install
RUN /usr/local/bin/install

ADD run.sh /usr/local/bin/run

# -------------------------------------------
# After running an image
# -------------------------------------------
ENTRYPOINT ["/usr/local/bin/run"]
EXPOSE 8080
