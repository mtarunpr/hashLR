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

    bool runOnMachineFunction(MachineFunction &MF) override
    {
      const llvm::TargetInstrInfo &TII = *MF.getSubtarget().getInstrInfo();
      MachineBasicBlock &MBB = *MF.begin();
      BuildMI(MBB, MBB.begin(), llvm::DebugLoc(), TII.get(X86::NOOP));

      // for (auto &MBB : MF) {
      //     // Get the end of the basic block
      //     MachineBasicBlock::iterator MBBI = MBB.end();
      //     --MBBI;

      //     // Create a new machine instruction: "mov rax, rdi"
      //     MachineInstrBuilder MIB = BuildMI(MBB, MBBI, MBB.findRegisterDefOperandIdx(X86::RAX, false, false));
      //     MIB.addReg(X86::RDI);

      //     // Insert the instruction
      //     MBB.insert(MBBI, MIB);

      //     // Update machine basic block iterator
      //     MBBI = MBB.end();
      // }
      return true;
    }
  };
}

extern "C" LLVM_ATTRIBUTE_WEAK PassPluginLibraryInfo llvmGetPassPluginInfo()
{
  return {
      LLVM_PLUGIN_API_VERSION, "MyOptimizationPass", LLVM_VERSION_STRING,
      [](PassBuilder &PB)
      {
        PB.registerPipelineParsingCallback(
            [](StringRef Name, FunctionPassManager &FPM, ArrayRef<PassBuilder::PipelineElement>)
            {
              if (Name == "myopt")
              {
                FPM.addPass(MyOptimizationPass());
                return true;
              }
              return false;
            });
      }};
}
