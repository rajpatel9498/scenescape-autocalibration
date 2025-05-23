# Open Source and Third Party Dependencies (OSPDT)

This document lists all open source and third-party dependencies used in the SceneScape Auto Calibration component.

## Build Dependencies

These dependencies are only required during the build process:

- **coverage**: Code coverage measurement tool
- **dt-apriltags**: AprilTag detection library
- **intel_extension_for_pytorch**: Intel's extension for PyTorch (v2.6.0)
- **intel-openmp**: Intel OpenMP runtime (v2022.2.1)
- **numpy**: Numerical computing library (v1.16.6-1.26.4)
- **opencv-python**: OpenCV Python bindings
- **pybind11**: Python/C++ binding library
- **pytest**: Testing framework
- **scipy**: Scientific computing library (v>=1.4.0)
- **torch**: PyTorch deep learning framework (v2.6.0)
- **torchvision**: PyTorch vision library (v0.21.0)

## Runtime Dependencies

These dependencies are required for running the application:

- **addict**: Dictionary with attribute-style access
- **h5py**: HDF5 for Python
- **kornia**: Computer vision library
- **kubernetes**: Kubernetes Python client
- **numpy**: Numerical computing library (v1.16.6-1.26.4)
- **onvif-zeep**: ONVIF client library
- **open3d-cpu**: 3D data processing library (CPU version)
- **opencv-python**: OpenCV Python bindings
- **paho-mqtt**: MQTT client library
- **pillow**: Python Imaging Library
- **pycolmap**: COLMAP Python bindings (v0.4.0)
- **pyyaml**: YAML parser and emitter
- **scipy**: Scientific computing library (v>=1.4.0)
- **trimesh**: 3D mesh processing library
- **torch**: PyTorch deep learning framework (v2.6.0)
- **torchvision**: PyTorch vision library (v0.21.0)

## System Dependencies

These are the system-level dependencies installed via apt:

### Build Stage
- build-essential
- curl
- g++
- libboost-python-dev
- libeigen3-dev
- libgtest-dev
- make
- pybind11-dev
- python3-dev
- python3-pip
- python3-scipy

### Runtime Stage
- bindfs
- libboost-python-dev
- libegl1
- libgl1
- libglib2.0-0
- libgomp1
- python-is-python3
- python3-pip
- python3-scipy

## License Information

Each dependency is used under its respective open source license. The main licenses include:

- Apache License 2.0
- MIT License
- BSD License
- LGPL
- GPL

For detailed license information of each dependency, please refer to their respective documentation.

## Version Management

Dependencies are pinned to specific versions to ensure reproducibility and stability. The versions are managed through:

1. requirements-build.txt for build dependencies
2. requirements-runtime.txt for runtime dependencies
3. System package versions in Dockerfile.build and Dockerfile.runtime

To update dependencies, please ensure compatibility testing is performed and update the version numbers in the appropriate requirements file. 