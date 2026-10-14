#!/usr/bin/env bash
set -ex

rm -rf build_arm64 build_x64
rm -rf install
rm -f opencv-*.zip

LITERT_VERSION=2.3.0
export DEVELOPER_DIR="/Applications/Xcode_26.3.0.app/Contents/Developer"
export CC="/usr/bin/clang"
export CXX="/usr/bin/clang++"
PATH="/usr/local/rtc/cmake/4.2.1/bin:/usr/local/rtc/ninja/1.12.1/bin:$PATH"

cmake -S ../litert -B build_arm64 \
  -GNinja \
  -DCMAKE_OSX_ARCHITECTURES="arm64" \
  -DCMAKE_SYSTEM_PROCESSOR="arm64" \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_PREFIX=install/${LITERT_VERSION}/arm64 \
  \
  -DCMAKE_POLICY_VERSION_MINIMUM=3.5 \
  \
  -DLITERT_ENABLE_GPU=OFF \
  -DLITERT_ENABLE_NPU=OFF \
  -DLITERT_ENABLE_QUALCOMM=OFF \
  -DLITERT_ENABLE_SAMSUNG=OFF
cmake --build build_arm64 -t install/strip

arch -x86_64 cmake -S ../litert -B build_x64 \
  -GNinja \
  -DCMAKE_OSX_ARCHITECTURES="x86_64" \
  -DCMAKE_SYSTEM_PROCESSOR="x86_64" \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_PREFIX=install/${LITERT_VERSION}/x64 \
  \
  -DCMAKE_POLICY_VERSION_MINIMUM=3.5 \
  \
  -DLITERT_ENABLE_GPU=OFF \
  -DLITERT_ENABLE_NPU=OFF \
  -DLITERT_ENABLE_QUALCOMM=OFF \
  -DLITERT_ENABLE_SAMSUNG=OFF
cmake --build build_x64 -t install/strip

cd install
zip -r ../litert-${LITERT_VERSION}.zip ${LITERT_VERSION}
