#!/bin/sh

# link mounted source directory to opengrok
if [ ! -h $OPENGROK_INSTANCE_BASE/src ]; then
  ln -s /src $OPENGROK_INSTANCE_BASE/src
fi

# first-time index
echo "** Running first-time indexing"
cd /opengrok/bin
./OpenGrok index

# Start Tomcat
echo "** Staring Tomcat"
service tomcat7 start

if [ -n "$ENABLE_INOTIFY" ];
then
  # ... and we keep running the indexer to keep the container on
  echo "** Waiting for source updates..."
  touch $OPENGROK_INSTANCE_BASE/reindex

  if [ $INOTIFY_NOT_RECURSIVE ]; then
    INOTIFY_CMDLINE="inotifywait -m -e CLOSE_WRITE $OPENGROK_INSTANCE_BASE/reindex"
  else
    INOTIFY_CMDLINE="inotifywait -mr -e CLOSE_WRITE $OPENGROK_INSTANCE_BASE/src"
  fi

  $INOTIFY_CMDLINE | while read f; do
    printf "*** %s\n" "$f"
    echo "*** Updating index"
    ./OpenGrok index
  done
done
