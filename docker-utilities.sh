dim_rest(){
  docker restart $(docker ps -q)
}

dim_sort() {
  docker images | sed -n "s/\(.*\) \([0-9]*\)\.[0-9]* MB$/\2+++\1/p"|sed "s/ \+/ /g"|cut -d' ' -f 1,2|tr ' ' ':'|sed 's/+++/ /'|sort -n
}

dim_up(){
  docker-compose stop && docker-compose up -d --force-recreate --build
}

dim_exec(){
docker exec -it $1 /bin/bash;
}

docker_compose_restart(){ 
docker-compose stop $@; 
docker-compose rm -f -v $@; 
docker-compose create --force-recreate $@; 
docker-compose start $@; 
}

docker_inspect(){
docker inspect -f "{{ .NetworkSettings.IPAddress }}" $1;
}

docker_commit(){
docker build -t my-image dockerfiles/
docker run my-image /script/to/run/tests
docker tag my-image my-registry:5000/my-image
docker push my-registry:5000/my-image
}
