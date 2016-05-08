function docker_remove_all () {
  docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q)
}