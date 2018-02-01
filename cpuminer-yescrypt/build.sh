#!/bin/sh

cd `dirname ${0}`
docker build -t akrfjmtt/cpuminer-yescrypt . -f ./Dockerfile
