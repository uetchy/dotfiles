
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
  curl -s https://registry.hub.docker.com/v2/repositories/$1/tags/ | jq -r '."results"[]["name"]'
}