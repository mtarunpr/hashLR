clang++ -shared -o llvm.so -fPIC $(llvm-config --cxxflags --ldflags --libs core irreader) llvm.cpp $(llvm-config --system-libs) -O1

clang -S -emit-llvm example.c -o example.ll

opt -load-pass-plugin=./llvm.so -passes="mypass" -S example.ll