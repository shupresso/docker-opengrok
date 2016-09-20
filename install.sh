#!/bin/sh
mkdir $OPENGROK_INSTANCE_BASE
mkdir $OPENGROK_INSTANCE_BASE/data
mkdir $OPENGROK_INSTANCE_BASE/etc

#wget -O - https://java.net/projects/opengrok/downloads/download/opengrok-0.12.1.tar.gz | tar zxvf -

# Assuming the current WORKDIR is /(the root dir)
mv opengrok-* opengrok
cd /opengrok/bin
./OpenGrok deploy
