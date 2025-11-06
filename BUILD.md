# Source builds

## Windows

### 64-bit Windows 10 native binary

This is for first build only. See other sections for incremental/clean builds.

- Install Visual Studio Installer - this is just a launch app that
  lets you install various 'workloads', and the full IDE if you want (we don't need it)
- Install command line tools by installing a workload named something like
  'Desktop apps...', this gives you cmake and Ninja used below
- Open a cmd.exe prompt called something like 'x64 Native tools ...' so
  the correct vsvars[..].bat file is read and setup to use 64-bit compiler etc.,
  I've built it using the x86 (32bit) toolchain and nvim was messed up, colors didn't
  work right and other glitches. So don't build x86!

```
cmake -S cmake.deps -B .deps -G Ninja -D CMAKE_BUILD_TYPE=Release
cmake --build .deps --config Release
cmake -B build -G Ninja -D CMAKE_BUILD_TYPE=Release
cmake --build build --config Release

# no admin rights required to install under `C:\Users\{me}\AppData\Local`
cmake --install build --config Release --prefix %LOCALAPPDATA%\Programs\nvim
```

#### Rebuilds

A full clean rebuild is recommended when switching branches or changing toolchain.

An increment (fast) build is when only some source files have updated and we don't
need to rebuild dependencies.

##### Incremental fast build

Used when we only have to rebuild certain updated source files, like a normal
rebuild after a git pull.

Start the compiler environment we want - 'x64 Native Tools...' cmd.exe prompt.

```
:: rebuild only changed files
ninja -C build -v

:: reinstall, since this is rebuild we've already set the CMAKE_INSTALL_PREFIX
cmake --install build --config Release
```

##### Full clean rebuild

Start the compiler environment we want - 'x64 Native Tools...' cmd.exe prompt.

```
rmdir /s /q .deps build
cmake -S cmake.deps -B .deps -G Ninja -D CMAKE_BUILD_TYPE=Release
cmake --build .deps --config Release
cmake -B build -G Ninja -D CMAKE_BUILD_TYPE=Release
cmake --build build --config Release
```


