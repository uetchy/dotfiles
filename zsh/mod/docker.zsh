
alias d="docker"
alias dc="docker-compose"
alias da="docker ps -a"
alias di="docker images"
alias dim="docker images --format \"{{.Repository}}:{{.Tag}}\" | sort"
alias drm="docker ps -aqf status=exited | xargs docker rm -v"
alias drmi="docker images -qf dangling=true | xargs docker rmi"
alias drmii="docker images --format \"{{.Repository}}:{{.Tag}}\" | sort | peco | xargs docker rmi"

alias sandbox="docker run --rm -it --workdir /root -v \"\$HOME/Downloads:/root/Downloads\" uetchy/sandbox"

docker-tags() {
  curl -s https://registry.hub.docker.com/v2/repositories/$(echo $i | sed -E 's|^([^/]*)$|library/\1|')/tags/ | jq -r '" - " + .results[].name'
}

docker-compose-list-tags() {
  for i in $(docker-compose config | yq .services[].image -r | cut -d ':' -f1)
  do
    echo "# $i"
    docker-tags $i
  done
}
