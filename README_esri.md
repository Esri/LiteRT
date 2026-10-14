
# How to build for runtimecore

Update the version of compilers, cmake, and ninja in the scripts.

- LiteRT 2.3.0
- llvm 19.1.2
- CMake 4.2.1
- Ninja 1.12.1
- Xcode 26.3.0 targeting macOS 16.0
- Visual Studio 2026 toolchain version 14.50.35717 targeting Windows SDK 10.0.19041.0

## linux

```bash
cd esri
./build_litert_linux.sh
```

## macos

```bash
cd esri
./build_litert_macos.sh
```

## windows

```bash
cd esri
./build_litert_windows.sh
```

Copy the generated litert zip file to the network shares
