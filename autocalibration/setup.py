# Copyright (C) 2024-2025 Intel Corporation
#
# This software and the related documents are Intel copyrighted materials,
# and your use of them is governed by the express license under which they
# were provided to you ("License"). Unless the License provides otherwise,
# you may not use, modify, copy, publish, distribute, disclose or transmit
# this software or the related documents without Intel's prior written permission.
#
# This software and the related documents are provided as is, with no express
# or implied warranties, other than those that are expressly stated in the License.

from setuptools import setup, find_packages

setup(
    name="autocalibration",
    version="1.3.0",
    packages=find_packages(),
    install_requires=[
        "numpy>=1.16.6,<=1.26.4",
        "opencv-python",
        "scipy>=1.4.0",
        "torch==2.6.0",
        "torchvision==0.21.0",
        "dt-apriltags",
        "intel_extension_for_pytorch==2.6.0",
        "intel-openmp==2022.2.1",
    ],
    python_requires=">=3.8",
    author="Intel Corporation",
    description="Auto Camera Calibration for SceneScape",
    long_description=open("README.md").read(),
    long_description_content_type="text/markdown",
    classifiers=[
        "Development Status :: 4 - Beta",
        "Intended Audience :: Developers",
        "License :: Other/Proprietary License",
        "Programming Language :: Python :: 3",
        "Programming Language :: Python :: 3.8",
        "Programming Language :: Python :: 3.9",
        "Programming Language :: Python :: 3.10",
    ],
) 