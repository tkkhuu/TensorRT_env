FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    wget \
    python3-pip \
    sudo


WORKDIR /tmp
RUN wget https://developer.nvidia.com/compute/cuda/10.0/Prod/local_installers/cuda-repo-ubuntu1804-10-0-local-10.0.130-410.48_1.0-1_amd64

RUN dpkg -i /tmp/cuda-repo-ubuntu1804-10-0-local-10.0.130-410.48_1.0-1_amd64 \
    && apt-key add /var/cuda-repo-10-0-local-10.0.130-410.48/7fa2af80.pub \
    && wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-ubuntu1804.pin \
    && mv cuda-ubuntu1804.pin /etc/apt/preferences.d/cuda-repository-pin-600 \
    && apt-get update \
    && apt-get install -y cuda
ENV PATH=/usr/local/cuda-10.0/bin${PATH:+:${PATH}}
ENV LD_LIBRARY_PATH=/usr/local/cuda-10.0/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}



RUN wget http://192.168.1.57:8081/libcudnn7-dev_7.6.5.32-1+cuda10.0_amd64.deb \
    && wget http://192.168.1.57:8081/libcudnn7_7.6.5.32-1+cuda10.0_amd64.deb \
    && dpkg -i libcudnn7_7.6.5.32-1+cuda10.0_amd64.deb \
    && dpkg -i libcudnn7-dev_7.6.5.32-1+cuda10.0_amd64.deb




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

RUN apt-get install -y cmake libopencv-dev vim

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

WORKDIR /home/$USERNAME

