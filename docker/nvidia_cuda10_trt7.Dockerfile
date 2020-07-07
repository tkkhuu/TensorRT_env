FROM nvidia/cuda:10.0-cudnn7-devel-ubuntu16.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    wget \
    python3-pip \
    sudo

RUN pip3 install --upgrade pip
RUN pip3 install tensorflow-gpu==1.15.0 jupyter

ENV VERSION="7.0.0.11"
ENV PKG_NAME="TensorRT-${VERSION}.Ubuntu-16.04.x86_64-gnu.cuda-10.0.cudnn7.6.tar.gz"

ENV DOWNLOAD_LINK="http://192.168.1.57:8081/${PKG_NAME}"

WORKDIR /tmp
RUN wget "${DOWNLOAD_LINK}" \
    && tar xzf "${PKG_NAME}"

WORKDIR  /usr/lib/x86_64-linux-gnu
RUN rm -rf libnvcaffe_parser* libnvinfer* libnvonnxparser.so* libnvparsers*
RUN rm -rf /usr/include/tensorrt

WORKDIR /tmp/TensorRT-${VERSION}
RUN mv include /usr/include/tensorrt \
    && mv lib/* /usr/lib/x86_64-linux-gnu/ \
    && pip3 install python/tensorrt-*-cp35-none-linux_x86_64.whl \
    && pip3 install graphsurgeon/graphsurgeon-*.whl \
    && pip3 install uff/uff-*.whl

WORKDIR /tmp
RUN rm -rf ${PKG_NAME} TensorRT-${VERSION}

#Add new sudo user
# ENV USERNAME tf_utils
# RUN useradd -m $USERNAME && \
#         echo "$USERNAME:$USERNAME" | chpasswd && \
#         usermod --shell /bin/bash $USERNAME && \
#         usermod -aG sudo $USERNAME && \
#         echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/$USERNAME && \
#         chmod 0440 /etc/sudoers.d/$USERNAME && \
#         # Replace 1000 with your user/group id
#         usermod  --uid 1000 $USERNAME && \
#         groupmod --gid 1000 $USERNAME

