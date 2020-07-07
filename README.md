# Build Instructions

1) Download the TensorRT package (.tar.gz) from NVIDIA
2) From the directory where the TensorRT package was downloaded run:

    ```
    python3 -m http.server 8081
    ```

    to host the package on a local server where Docker can download and build from.

3) Modify the DOWNLOAD_LINK environment in the Dockerfile to use your local IP address
4) Build the container:
    ```
    docker build docker/ -t tensorrt
    ```

