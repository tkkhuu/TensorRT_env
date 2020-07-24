FROM nvcr.io/nvidia/tensorrt:19.02-py3

# RUN lsb_release -a

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    wget \
    sudo

# ENV TENSORRT_OS="ubuntu1804"
# ENV TENSORRT_VERSION="5.1.5.0"
# ENV TENSORRT_TAG="cuda10.0-trt${TENSORRT_VERSION}-ga-20190427"

# ENV PKG_NAME_DEB="nv-tensorrt-repo-${TENSORRT_OS}-${TENSORRT_TAG}_1-1_amd64.deb"
# ENV PKG_NAME_TAR="TensorRT-${TENSORRT_VERSION}.Ubuntu-18.04.2.x86_64-gnu.cuda-10.0.cudnn7.5.tar.gz"

# ENV TENSORRT_DOWNLOAD_LINK_DEB="http://10.1.0.9:8081/${PKG_NAME_DEB}"
# ENV TENSORRT_DOWNLOAD_LINK_TAR="http://10.1.0.9:8081/${PKG_NAME_TAR}"

# WORKDIR /tmp
# RUN wget "${TENSORRT_DOWNLOAD_LINK_DEB}" \
#     && dpkg -i "${PKG_NAME_DEB}" \
#     && apt-key add /var/nv-tensorrt-repo-${TENSORRT_TAG}/7fa2af80.pub \
#     && apt-get update && apt-get install -y cuda-nvrtc-10-0 \
#                                             python3-libnvinfer-dev

# RUN wget "${TENSORRT_DOWNLOAD_LINK_TAR}" \
#     && tar xzf "${PKG_NAME_TAR}" \
#     && cd TensorRT-${TENSORRT_VERSION} \
#     && pip3 install python/tensorrt-*-cp36-none-linux_x86_64.whl \
#     && pip3 install graphsurgeon/graphsurgeon-*.whl \
#     && pip3 install uff/uff-*.whl

# RUN apt-get install -y git python3-pip

RUN pip3 install tensorflow-gpu==1.15 

RUN pip3 install onnx==1.6.0 tf2onnx==1.5.4
# #git+https://github.com/onnx/tensorflow-onnx

RUN apt-get install -y \
    vim \
    terminator \
    dbus \
    dbus-x11

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
