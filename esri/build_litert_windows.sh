#!/usr/bin/env bash
LITERT_VERSION=2.3.0
PATH="/c/rtc/cmake/4.2.1/bin:${PATH}"

function cmake_configure
{
  cmake \
    -G "Visual Studio 18 2026" \
    -T "version=14.50.35717" \
    -DCMAKE_SYSTEM_VERSION=10.0.19041.0 \
    -DCMAKE_INSTALL_PREFIX=do_not_install_here \
    \
    -DLITERT_ENABLE_GPU=OFF \
    -DLITERT_ENABLE_NPU=OFF \
    -DLITERT_ENABLE_QUALCOMM=OFF \
    -DLITERT_ENABLE_SAMSUNG=OFF \
    "$@"
}

set -ex

rm -rf build

mkdir build
cd build

rm -rf build_x64
rm -rf install_x64

cmake_configure -S ../litert -B build_x64 -A x64
cmake --build build_x64 --config Debug
cmake --build build_x64 --config Release
cmake --install build_x64 --config Debug --prefix install_x64
cmake --install build_x64 --config Release --prefix install_x64

rm -rf build_arm64
rm -rf install_arm64
cmake_configure -S ../litert -B build_arm64 \
    -A ARM64 \
    -DCMAKE_SYSTEM_NAME=Windows \
    -DCMAKE_SYSTEM_VERSION=10.0 \
    -DCMAKE_SYSTEM_PROCESSOR=ARM64
cmake --build build_arm64 --config Debug
cmake --build build_arm64 --config Release
cmake --install build_arm64 --config Debug --prefix install_arm64
cmake --install build_arm64 --config Release --prefix install_arm64

cd ..
rm -rf install/${LITERT_VERSION}
mkdir -p install/${LITERT_VERSION}
cd install
cp -r ../build/install_x64/* ${LITERT_VERSION}/
cp -r ../build/install_arm64/ARM64 ${LITERT_VERSION}/ARM64

powershell.exe Compress-Archive ${LITERT_VERSION} ../litert-${LITERT_VERSION}.zip
