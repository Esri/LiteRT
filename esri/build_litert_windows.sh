#!/usr/bin/env bash
set -ex

# rm -rf build_arm64 build_x64
rm -rf install
rm -f opencv-*.zip

LITERT_VERSION=2.3.0
GENERATOR="Visual Studio 18 2026"
TOOLSET="version=14.50.35717"
TARGET_SDK="10.0.19041.0"
PATH="/c/rtc/cmake/4.2.1/bin:${PATH}"

# cmake -S ../litert -B build_arm64 \
#   -G "${GENERATOR}" \
#   -T "${TOOLSET}" \
#   -A ARM64 \
#   -DCMAKE_SYSTEM_PROCESSOR=ARM64 \
#   -DCMAKE_SYSTEM_VERSION=${TARGET_SDK} \
#   -DCMAKE_BUILD_TYPE=Release \
#   -DCMAKE_INSTALL_PREFIX=install/${LITERT_VERSION}/arm64 \
#   \
#   -DCMAKE_POLICY_VERSION_MINIMUM=3.5 \
#   \
#   -DLITERT_ENABLE_GPU=OFF \
#   -DLITERT_ENABLE_NPU=OFF \
#   -DLITERT_ENABLE_QUALCOMM=OFF \
#   -DLITERT_ENABLE_SAMSUNG=OFF
# cmake --build build_arm64
# cmake --install build_arm64

cmake -S ../litert -B build_x64 \
  -G "${GENERATOR}" \
  -T "${TOOLSET}" \
  -A x64 \
  -DCMAKE_SYSTEM_PROCESSOR=x64 \
  -DCMAKE_SYSTEM_VERSION=${TARGET_SDK} \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_PREFIX=install/${LITERT_VERSION}/x64 \
  \
  -DCMAKE_POLICY_VERSION_MINIMUM=3.5 \
  \
  -DLITERT_ENABLE_GPU=OFF \
  -DLITERT_ENABLE_NPU=OFF \
  -DLITERT_ENABLE_QUALCOMM=OFF \
  -DLITERT_ENABLE_SAMSUNG=OFF
cmake --build build_x64
cmake --install build_x64

# cd install
# powershell.exe Compress-Archive ${LITERT_VERSION} ../litert-${LITERT_VERSION}.zip
