#include "llvm/IR/Function.h"
#include "llvm/Pass.h"
#include "llvm/Support/raw_ostream.h"

using namespace llvm;

namespace {
  struct MyOptimizationPass : public FunctionPass {
    static char ID;
    MyOptimizationPass() : FunctionPass(ID) {}

    virtual bool runOnFunction(Function &F) {
      errs() << "Function name: " << F.getName() << '\n';
      return false; // Return true if the function was modified
    }
  };
}

char MyOptimizationPass::ID = 0;
static RegisterPass<MyOptimizationPass> X("myopt", "My Optimization Pass", false, false);
