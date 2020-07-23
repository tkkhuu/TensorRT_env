XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth
touch $XAUTH
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -
CONTAINER_USER=tensorrt

docker run -it \
           --rm \
           --gpus all \
           --volume=$XSOCK:$XSOCK:rw \
           --volume=$XAUTH:$XAUTH:rw \
           --env="XAUTHORITY=${XAUTH}" \
           --env="DISPLAY" \
           --user=$CONTAINER_USER \
           --volume=`pwd`/shared_dir:/home/$CONTAINER_USER/shared_dir \
           tensorrt:trt5