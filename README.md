# CS 263 Final Project

In the LLVM project repo, to compile LLVM with the additional X86HashLR pass:

```bash
cmake -S llvm -B build -G Ninja -DCMAKE_BUILD_TYPE=Release -DLLVM_TARGETS_TO_BUILD=X86
ninja -C build
```

In this repo, to compile (to LLVM) the code you want to run the pass on (say `tests/five_functions/five_functions.c`),
and then compile the LLVM to assembly code (including the additional CodeGen pass):

```bash
clang -S -emit-llvm -o tests/five_functions/five_functions.ll tests/five_functions/five_functions.c -arch x86_64
/path/to/llvm/repo/build/bin/llc  tests/five_functions/five_functions.ll -o tests/five_functions/five_functions-hashlr.S  > tests/five_functions/five_functions-hashlr_bb_identifiers.txt
```

Note that we redirect the output of `llc` (the identifiers of the basic blocks)
to a text file so that we can use it in the objdump parser script.

To compare with the original assembly code generated by LLVM:

```bash
clang -S -o tests/five_functions/five_functions.S tests/five_functions/five_functions.c -arch x86_64
```

To compile the HashLR version of the assembly code to an executable binary file:

```bash
clang -o tests/five_functions/five_functions-hashlr tests/five_functions/five_functions-hashlr.S -arch x86_64
```

To extract the machine code bytes from the executable binary so that the injector can use it:

```bash
python binary_parser.py -b tests/five_functions/five_functions-hashlr -i tests/five_functions/five_functions-hashlr_bb_identifiers.txt -o tests/five_functions/five_functions_bytes.txt
```

To compile the injector:

```bash
g++ src/injector.cpp -o src/injector
g++ src/mmapper.cpp -o src/mmapper
```

To read the machine code bytes and run the HashLR version of the executable:

```bash
./src/injector tests/five_functions/five_functions_bytes.txt
```
