# CS 263 Final Project

To compile the LLVM pass:

```bash
clang++ -shared -o llvm_pass.so -fPIC $(llvm-config --cxxflags --ldflags --libs core irreader) llvm_pass.cpp $(llvm-config --system-libs)
```

To compile the code you want to run the pass on:

```bash
clang -S -emit-llvm -o example.ll example.c -O1 -arch x86_64          
```

To run the pass:

```bash
opt -load-pass-plugin=./llvm_pass.so -passes="myopt" -S example.ll -o output.ll
```