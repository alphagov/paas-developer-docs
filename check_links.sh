#!/bin/sh

# build docs site
mkdocs build --clean

# start serving docs site
mkdocs serve&

# wait for docs site to be up and running
while ! nc -z localhost 8000; do
  sleep 1
done

# check links
linkchecker http://localhost:8000
res=$?

pkill mkdocs

exit $res
