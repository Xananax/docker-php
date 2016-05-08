# vi:syntax=sh
#!/usr/bin/env bash

docker exec -it %CONTAINER_NAME% bash -c "/var/www/install.sh"
