# vi:syntax=sh
#!/usr/bin/env bash

now=$(date +"%m_%d_%Y")
DIR="$PWD/%LOG_DIR_DOCKER%"
FILE="$DIR/$now.log"
touch $FILE
docker-compose logs --no-color >& $FILE