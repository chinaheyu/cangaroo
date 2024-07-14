#!/bin/bash

docker container create -t -w /cangaroo --name build_cangaroo ubuntu:20.04
docker container start build_cangaroo
docker container cp . build_cangaroo:/cangaroo
docker container exec -it build_cangaroo bash build.sh
docker cp build_cangaroo:/cangaroo/bin/cangaroo-x86_64.AppImage .
docker container stop build_cangaroo
docker container rm build_cangaroo
