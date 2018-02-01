#!/bin/sh
cd `dirname ${0}`

CONTEXT="stack"

while [ "$1" != "" ]
do
  case "$CONTEXT:$1" in
    "stack:deploy")
      docker stack deploy -c ./docker-compose.yml koto
      ;;
    "stack:rm")
      docker stack rm koto
      ;;
    "stack:up_cpuminer-yescrypt")
      docker service scale koto_cpuminer-yescrypt=1
      ;;
    "stack:down_cpuminer-yescrypt")
      docker service scale koto_cpuminer-yescrypt=0
      ;;
    "stack:build")
      sh ./koto/build.sh
      sh ./cpuminer-yescrypt/build.sh
      ;;
    "stack:blocks_headers")
      sh ./swarm-exec.sh koto_koto koto-cli getblockchaininfo|egrep -e blocks -e headers
      ;;
    "stack:getnewaddress")
      sh ./swarm-exec.sh koto_koto koto-cli getnewaddress
      ;;
    "stack:dumpprivkey")
      sh ./swarm-exec.sh koto_koto koto-cli dumpprivkey $2
      shift
      ;;
    "stack:getbalance")
      sh ./swarm-exec.sh koto_koto koto-cli getbalance
      ;;
    "secret:create")
      cat ./authorized_keys | docker secret create authorized_keys -
      cat ./id_rsa | docker secret create id_rsa -
      ;;
    *)
      case "$1" in
        stack)
          CONTEXT="stack"
          ;;
        secret)
          CONTEXT="secret"
          ;;
        *)
          echo "不明なトークンです : $1"
          ;;
      esac
      ;;
  esac

  shift
done
