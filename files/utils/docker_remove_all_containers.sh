function docker_remove_all_containers () {
  docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q)
}
