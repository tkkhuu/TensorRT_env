FROM tensorflow/tensorflow:1.15.0-gpu-py3

# RUN lsb_release -a

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    wget \
    sudo

# ======================== Installing Protobuf ========================
RUN apt-get update && apt-get install -y \
    autoconf \
    automake \
    libtool \
    curl \
    make \
    g++ \
    unzip

WORKDIR /tmp
RUN wget https://github.com/protocolbuffers/protobuf/releases/download/v3.12.3/protobuf-cpp-3.12.3.tar.gz \
    && tar xzf protobuf-cpp-3.12.3.tar.gz \
    && cd protobuf-3.12.3 \
    && ./configure \
    && make -j12 \
    && make check \
    && make install \
    && ldconfig

ENV TENSORRT_OS="ubuntu1804"
ENV TENSORRT_VERSION="5.1.5.0"
ENV TENSORRT_TAG="cuda10.0-trt${TENSORRT_VERSION}-ga-20190427"

ENV PKG_NAME_DEB="nv-tensorrt-repo-${TENSORRT_OS}-${TENSORRT_TAG}_1-1_amd64.deb"
ENV PKG_NAME_TAR="TensorRT-${TENSORRT_VERSION}.Ubuntu-18.04.2.x86_64-gnu.cuda-10.0.cudnn7.5.tar.gz"

ENV TENSORRT_DOWNLOAD_LINK_DEB="http://192.168.1.57:8081/${PKG_NAME_DEB}"
ENV TENSORRT_DOWNLOAD_LINK_TAR="http://192.168.1.57:8081/${PKG_NAME_TAR}"

# WORKDIR /tmp
# RUN wget "${TENSORRT_DOWNLOAD_LINK_DEB}" \
#     && dpkg -i "${PKG_NAME_DEB}" \
#     && apt-key add /var/nv-tensorrt-repo-${TENSORRT_TAG}/7fa2af80.pub \
#     && apt-get update && apt-get install -y cuda-nvrtc-10-0 \
#                                             python3-libnvinfer-dev

    # && mv include /usr/include/tensorrt \
    # && mv lib/* /usr/lib/x86_64-linux-gnu/ \

# ======================== Installing cuDNN ========================
WORKDIR /tmp
RUN wget "http://192.168.1.57:8081/cudnn-10.0-linux-x64-v7.5.1.10.tgz" \
    && tar -xzvf cudnn-10.0-linux-x64-v7.5.1.10.tgz \
    && cp cuda/include/cudnn*.h /usr/local/cuda/include \
    && cp cuda/lib64/libcudnn* /usr/local/cuda/lib64 \
    && chmod a+r /usr/local/cuda/include/cudnn*.h /usr/local/cuda/lib64/libcudnn*

# ======================== Installing TensrRT ========================
WORKDIR  /usr/lib/x86_64-linux-gnu
RUN rm -rf libnvcaffe_parser* libnvinfer* libnvonnxparser.so* libnvparsers*
RUN rm -rf /usr/include/tensorrt

WORKDIR /usr/include
RUN wget "${TENSORRT_DOWNLOAD_LINK_TAR}" \
    && tar xzf "${PKG_NAME_TAR}" \
    && cd TensorRT-${TENSORRT_VERSION} \
    && pip3 install python/tensorrt-*-cp36-none-linux_x86_64.whl \
    && pip3 install graphsurgeon/graphsurgeon-*.whl \
    && pip3 install uff/uff-*.whl
ENV LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/include/TensorRT-${TENSORRT_VERSION}/lib"

# ======================== Installing ONNX2TRT ========================
RUN apt-get install -y \
    git \
    cmake

WORKDIR /tmp
RUN git clone --recursive https://github.com/onnx/onnx-tensorrt.git \
    && cd onnx-tensorrt \
    && git checkout 5.1 \
    && mkdir build && cd build \
    && cmake .. -DTENSORRT_ROOT=/usr/include/TensorRT-${TENSORRT_VERSION} \
    && make -j8 \
    && make install





RUN pip3 install onnx==1.6.0 tf2onnx==1.5.4
#git+https://github.com/onnx/tensorflow-onnx

RUN apt-get update && apt-get install -y \
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
