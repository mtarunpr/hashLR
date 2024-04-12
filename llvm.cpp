#include "llvm/IR/PassManager.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/IR/Function.h"
#include "llvm/Support/raw_ostream.h"

using namespace llvm;

namespace {
class MyOptimizationPass : public PassInfoMixin<MyOptimizationPass> {
public:
  PreservedAnalyses run(Function &F, FunctionAnalysisManager &) {
    errs() << "Function name: " << F.getName() << "\n";

    // Insert new variable at the beginning of the function
    LLVMContext &Ctx = F.getContext();
    IRBuilder<> Builder(&F.getEntryBlock(), F.getEntryBlock().begin());
    Type *Int32Ty = Type::getInt32Ty(Ctx);
    Value *NewVar = Builder.CreateAlloca(Int32Ty, nullptr, "new_var");

    // Indicate that the function was modified
    return PreservedAnalyses::none();
  }
};

extern "C" LLVM_ATTRIBUTE_WEAK PassPluginLibraryInfo llvmGetPassPluginInfo() {
    return {
        LLVM_PLUGIN_API_VERSION, "MyOptimizationPass", LLVM_VERSION_STRING,
        [](PassBuilder &PB) {
            PB.registerPipelineParsingCallback(
                [](StringRef Name, FunctionPassManager &FPM, ArrayRef<PassBuilder::PipelineElement>) {
                    if (Name == "myopt") {
                        FPM.addPass(MyOptimizationPass());
                        return true;
                    }
                    return false;
                });
        }
    };
}
}
