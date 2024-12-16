FROM cwaffles/openpose

# Add NVIDIA's GPG key for package verification
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys A4B469963BF863CC

# Copy the model files from the flat 'models' directory to the correct locations in OpenPose
COPY models/pose_iter_584000.caffemodel /openpose/models/pose/body_25/pose_iter_584000.caffemodel
COPY models/pose_iter_440000.caffemodel /openpose/models/pose/coco/pose_iter_440000.caffemodel
COPY models/pose_iter_160000.caffemodel /openpose/models/pose/mpi/pose_iter_160000.caffemodel
COPY models/pose_iter_116000.caffemodel /openpose/models/face/pose_iter_116000.caffemodel
COPY models/pose_iter_102000.caffemodel /openpose/models/hand/pose_iter_102000.caffemodel

# Run OpenPose build and install Python API
RUN cd /openpose/build/python/openpose && \
    make install && \
    cp ./pyopenpose.cpython-36m-x86_64-linux-gnu.so /usr/local/lib/python3.6/dist-packages && \
    ln -s /usr/local/lib/python3.6/dist-packages/pyopenpose.cpython-36m-x86_64-linux-gnu.so /usr/local/lib/python3.6/dist-packages/pyopenpose && \
    export LD_LIBRARY_PATH=/openpose/build/python/openpose:$LD_LIBRARY_PATH

# Use China mirror sources for apt
RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak && \
    echo "deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal main restricted universe multiverse" > /etc/apt/sources.list && \
    echo "deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-updates main restricted universe multiverse" >> /etc/apt/sources.list && \
    echo "deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-backports main restricted universe multiverse" >> /etc/apt/sources.list && \
    echo "deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-security main restricted universe multiverse" >> /etc/apt/sources.list

# Update and install dependencies
RUN apt-get update && apt-get install vim -y

# Set working directory to OpenPose
WORKDIR /openpose
