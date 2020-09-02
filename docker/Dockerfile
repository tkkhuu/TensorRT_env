FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    wget \
    python3-pip \
    sudo

WORKDIR /tmp
RUN wget https://developer.nvidia.com/compute/cuda/10.0/Prod/local_installers/cuda-repo-ubuntu1804-10-0-local-10.0.130-410.48_1.0-1_amd64 \
    && dpkg -i /tmp/cuda-repo-ubuntu1804-10-0-local-10.0.130-410.48_1.0-1_amd64 \
    && apt-key add /var/cuda-repo-10-0-local-10.0.130-410.48/7fa2af80.pub \
    && apt-get update \
    && apt-get install -y cuda

RUN wget http://192.168.1.57:8081/cudnn-10.0-linux-x64-v7.6.5.32.tgz \
    && tar -xzvf cudnn-10.0-linux-x64-v7.6.5.32.tgz \
    && cp cuda/include/cudnn*.h /usr/local/cuda/include \
    && cp cuda/lib64/libcudnn* /usr/local/cuda/lib64 \
    && chmod a+r /usr/local/cuda/include/cudnn*.h /usr/local/cuda/lib64/libcudnn*




ENV PKG_NAME="nv-tensorrt-repo-ubuntu1804-cuda10.0-trt7.0.0.11-ga-20191216_1-1_amd64.deb"

ENV DOWNLOAD_LINK="http://192.168.1.57:8081/${PKG_NAME}"

WORKDIR /tmp
RUN wget "${DOWNLOAD_LINK}" \
    && dpkg -i ${PKG_NAME} \
    && apt-key add /var/nv-tensorrt-repo-cuda10.0-trt7.0.0.11-ga-20191216/7fa2af80.pub \
    && apt-get update \
    && apt-get install -y tensorrt \
    && apt-get install -y python3-libnvinfer-dev \
    && apt-get install -y uff-converter-tf \
    && dpkg -l | grep TensorRT


#Add new sudo user
ENV USERNAME tensorrt
RUN useradd -m $USERNAME && \
        echo "$USERNAME:$USERNAME" | chpasswd && \
        usermod --shell /bin/bash $USERNAME && \
        usermod -aG sudo $USERNAME && \
        echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/$USERNAME && \
        chmod 0440 /etc/sudoers.d/$USERNAME && \
        # Replace 1000 with your user/group id
        usermod  --uid 1000 $USERNAME && \
        groupmod --gid 1000 $USERNAME

