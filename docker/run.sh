#!/bin/bash

WS_DIR_PATH=$(realpath "$PWD/..")

docker run -ti \
--gpus=all \
--privileged=true \
--cap-add=CAP_SYS_ADMIN \
--ipc=host \
-v $WS_DIR_PATH:/workspace/stable-diffusion \
-v /media/pedro/thor/.datasets:/data \
-v /media/pedro/thor/.outputs:/output \
-v /media/pedro/thor/.models:/model \
-v /media/pedro/thor/.cache:/root/.cache \
-p 6006:6006 \
-p 8080:8080 \
-p 7860:7860 \
--name sd sd:lastest \
/bin/bash