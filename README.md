# OpenPose Dockerfile with Fixed Model Download Issue

This project provides a custom Dockerfile based on the original [esemeniuc/openpose-docker](https://github.com/esemeniuc/openpose-docker) repository. The primary purpose of this Dockerfile is to resolve the issue of the OpenPose model files being unavailable for download in the original image.

## Features

- Fixes the model download issue by providing an alternative download method or location.
- Retains all functionality of the original OpenPose Docker setup.
- Easy-to-use build and run process.

## Prerequisites

- Docker installed on your machine
- Sufficient disk space for building the image and running OpenPose

## Building the Docker Image

1. Clone this repository:
   ```bash
   git clone <repository_url>
   cd <repository_folder>
   ```

2. Build the Docker image:
   ```bash
   docker build -t openpose .
   ```

## Running the Docker Container

1. Run the container with OpenPose installed:
   ```bash
   docker run --gpus all --name openpose -it openpose /bin/bash
   ```

## Modifications in the Dockerfile

- Added a new step to download the OpenPose model files from an alternative source.
- Ensured compatibility with GPUs using CUDA drivers.
- Verified that all dependencies are up to date.

## Notes

- Make sure that you have the necessary CUDA and cuDNN drivers installed on your host machine to utilize GPU acceleration.
- The model files are downloaded and stored inside the container during the build process. If you encounter issues with model downloading, verify the URLs in the Dockerfile or provide your own pre-downloaded models.

## Troubleshooting

- **Issue:** OpenPose fails to detect the GPU.
  - **Solution:** Ensure that NVIDIA drivers and the `nvidia-docker` runtime are correctly set up.

- **Issue:** Model download step fails.
  - **Solution:** Check your network connectivity and verify the alternative URLs provided in the Dockerfile.