export DOCKER_TLS_VERIFY=1
export DOCKER_CERT_PATH=~/.docker/trust
export DOCKER_HOST=tcp://192.168.0.111:443
export DOCKER_CONTENT_TRUST=1
env
if  docker service ls | grep -i $1; then
  docker service update --image $5/$1:$2 $1
else
  docker service create -p $3 --network ucp-hrm --name $1 --label com.docker.ucp.mesh.http.$3=external_route=$4,internal_port=$3 --replicas $6 --update-parallelism 1 --update-delay 5s $5/$1:$2
fi
