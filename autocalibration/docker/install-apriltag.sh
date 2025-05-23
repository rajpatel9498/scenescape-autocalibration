#!/bin/sh

# Copyright (C) 2023 Intel Corporation
#
# This software and the related documents are Intel copyrighted materials,
# and your use of them is governed by the express license under which they
# were provided to you ("License"). Unless the License provides otherwise,
# you may not use, modify, copy, publish, distribute, disclose or transmit
# this software or the related documents without Intel's prior written permission.
#
# This software and the related documents are provided as is, with no express
# or implied warranties, other than those that are expressly stated in the License.

set -e  # Exit on any error

WORKDIR=/tmp/apriltag

mkdir -p ${WORKDIR}
cd ${WORKDIR}

# Clone and build AprilTag
git clone https://github.com/duckietown/lib-dt-apriltags.git apriltag-dev
cd apriltag-dev
git submodule init
git submodule update

# Build and install AprilTag
cd apriltags
mkdir -p build
cd build
cmake -DCMAKE_INSTALL_PREFIX=/usr/local -DCMAKE_BUILD_TYPE=Release ..
make -j $(nproc)
make install

# Verify installation
echo "Verifying AprilTag installation..."
ls -l /usr/local/lib/libapriltag*
ls -l /usr/local/include/apriltag/

# Install Python package
cd ../../
pip install .

# Cleanup
cd
rm -rf ${WORKDIR}
