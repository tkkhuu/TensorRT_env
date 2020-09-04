FROM nvidia/cuda:10.2-cudnn7-devel-ubuntu18.04


ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    wget \
    python3-pip \
    sudo \
    software-properties-common \
    linux-headers-$(uname -r)


WORKDIR /tmp

ENV PATH=/usr/local/cuda-10.2/bin${PATH:+:${PATH}}
ENV LD_LIBRARY_PATH=/usr/local/cuda-10.2/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
    

ENV PKG_NAME="TensorRT-7.0.0.11.Ubuntu-18.04.x86_64-gnu.cuda-10.2.cudnn7.6.tar.gz"

ENV DOWNLOAD_LINK="http://192.168.1.57:8081/${PKG_NAME}"

WORKDIR /tmp
RUN wget "${DOWNLOAD_LINK}" \
    && tar xzf ${PKG_NAME} \
    && cd TensorRT-7.0.0.11 \
    && mv include/* /usr/include/ \
    && mv lib/stubs/* /usr/lib/x86_64-linux-gnu/stubs \
    && rm -r lib/stubs \
    && mv lib/* /usr/lib/x86_64-linux-gnu/ 

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

