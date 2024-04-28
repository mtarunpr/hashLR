#include "llvm/IR/PassManager.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Pass.h"
#include "llvm/CodeGen/MachineBasicBlock.h"
#include "llvm/CodeGen/MachineFunction.h"
#include "llvm/CodeGen/MachineFunctionPass.h"
#include "llvm/CodeGen/MachineInstrBuilder.h"
#include "llvm/CodeGen/MachineInstr.h"
#include "llvm/CodeGen/MachineInstr.h"
#include "llvm/CodeGen/TargetInstrInfo.h"
#include <llvm/Target/TargetSubtargetInfo.h>
#include <llvm/Target/TargetMachine.h>
#include <llvm/CodeGen/Passes.h>

#define GET_INSTRINFO_ENUM
#include "../Target/X86/X86GenInstrInfo.inc"

#define GET_REGINFO_ENUM
#include "../Target/X86/X86GenRegisterInfo.inc.tmp"


using namespace llvm;

namespace
{
  struct MyOptimizationPass : public MachineFunctionPass
  {
    static char ID;
    MyOptimizationPass() : MachineFunctionPass(ID) {}

    bool runOnMachineFunction(MachineFunction &MF) override {
        const TargetInstrInfo *TII = MF.getSubtarget().getInstrInfo();

        for (auto &MBB : MF) {
            if (!MBB.empty()) {
                MachineBasicBlock::instr_iterator MI = MBB.instr_begin();
                BuildMI(MBB, MI, MI->getDebugLoc(), TII->get(TargetOpcode::NOP));
            }
        }

        return true;
    }
    StringRef getPassName() const override {
        return "My Custom Machine Function Pass";
    }
};
char MyOptimizationPass::ID = 0;
}

extern "C" LLVM_EXTERNAL_VISIBILITY void LLVMInitializeMyOptimizationPassPass(LLVMPassRegistryRef R) {
    initializeMyOptimizationPassPass(*unwrap(R));
}
// Ensure the pass is initialized when the library is loaded (if dynamically loading)
__attribute__((constructor)) static void initializePass() {
    LLVMInitializeMyOptimizationPassPass(LLVMPassRegistry::getPassRegistry());
}