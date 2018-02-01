#!/bin/sh
cd `dirname ${0}`
docker build -t akrfjmtt/koto:latest . -f ./Dockerfile
