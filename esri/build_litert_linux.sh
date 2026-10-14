#!/usr/bin/env bash
set -ex

rm -rf build_arm64 build_x64
rm -rf install
rm -f litert-*.zip

LITERT_VERSION=2.3.0
export CC="/usr/local/rtc/llvm/19.1.2/bin/clang"
export CXX="/usr/local/rtc/llvm/19.1.2/bin/clang++"
PATH="/usr/local/rtc/cmake/4.2.1/bin:/usr/local/rtc/ninja/1.12.1/bin:$PATH"

cmake -S ../litert -B build_arm64 \
  -GNinja \
  -DCMAKE_SYSTEM_NAME=Linux \
  -DCMAKE_SYSTEM_PROCESSOR=aarch64 \
  -DCMAKE_SYSROOT=/usr/local/rtc/sysroot/redhat8.4/aarch64 \
  -DCMAKE_ASM_COMPILER_TARGET=aarch64-unknown-linux-gnu \
  -DCMAKE_C_COMPILER_TARGET=aarch64-unknown-linux-gnu \
  -DCMAKE_CXX_COMPILER_TARGET=aarch64-unknown-linux-gnu \
  -DCMAKE_C_FLAGS="-stdlib=libc++ -fuse-ld=lld -rtlib=compiler-rt" \
  -DCMAKE_CXX_FLAGS="-stdlib=libc++ -fuse-ld=lld -rtlib=compiler-rt" \
  -DCMAKE_SHARED_LINKER_FLAGS="-stdlib=libc++ -static-libstdc++ -fuse-ld=lld -rtlib=compiler-rt -ldl -pthread" \
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

cmake -S ../litert -B build_x64 \
  -GNinja \
  -DCMAKE_SYSTEM_NAME=Linux \
  -DCMAKE_SYSTEM_PROCESSOR=x86_64 \
  -DCMAKE_SYSROOT=/usr/local/rtc/sysroot/redhat8.4/x86_64 \
  -DCMAKE_ASM_COMPILER_TARGET=x86_64-unknown-linux-gnu \
  -DCMAKE_C_COMPILER_TARGET=x86_64-unknown-linux-gnu \
  -DCMAKE_CXX_COMPILER_TARGET=x86_64-unknown-linux-gnu \
  -DCMAKE_C_FLAGS="-m64 -stdlib=libc++ -fuse-ld=lld -rtlib=compiler-rt" \
  -DCMAKE_CXX_FLAGS="-m64 -stdlib=libc++ -fuse-ld=lld -rtlib=compiler-rt" \
  -DCMAKE_SHARED_LINKER_FLAGS="-stdlib=libc++ -static-libstdc++ -rtlib=compiler-rt -ldl -pthread" \
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
