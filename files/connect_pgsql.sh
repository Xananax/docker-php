# vi:syntax=sh
#!/usr/bin/env bash

docker exec -it %PGSQL_CONTAINER_NAME% su -s /bin/sh - postgres -c "sh -c psql"