function check_dir () {
	if [ ! -d "$1" ]; then
		echo "\`$2\` does not exist, attempting to create it now"
		mkdir -p "$1"
		chmod -R +777 "$1"
		sudo chown -R "$3":"$3" "$1"
	else
		echo "\`$2\` exists, no need to do anything"
	fi
}