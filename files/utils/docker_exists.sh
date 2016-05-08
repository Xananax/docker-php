function docker_exists () {
	EXISTS=`docker ps -a | grep $1`
	if [ "$EXISTS" ]; then
	 return 0
	else
	 return 1
	fi
}