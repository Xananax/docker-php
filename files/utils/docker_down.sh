function docker_is_down () {
	EXISTS=`docker ps | grep $1`
	if [ "$EXISTS" ]; then
	 return 1
	else
	 return 0
	fi
}