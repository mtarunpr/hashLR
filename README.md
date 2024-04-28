# CS 263 Final Project

In the LLVM project repo, to compile LLVM with the additional CodeGen pass:

```bash
cmake -S llvm -B build -G Ninja -DCMAKE_BUILD_TYPE=Release -DLLVM_TARGETS_TO_BUILD=X86
ninja -C build
```

In this repo, to compile (to LLVM) the code you want to run the pass on, and then compile the LLVM to assembly code (including the additional CodeGen pass):

```bash
clang -S -emit-llvm -o example.ll example.c -arch x86_64
/path/to/llvm/repo/build/bin/llc  example.ll -o output.S  
```
