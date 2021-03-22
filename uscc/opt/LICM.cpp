//
//  LICM.cpp
//  uscc
//
//  Implements basic loop invariant code motion
//
//---------------------------------------------------------
//  Copyright (c) 2014, Sanjay Madhav
//  All rights reserved.
//
//  This file is distributed under the BSD license.
//  See LICENSE.TXT for details.
//---------------------------------------------------------
#include "Passes.h"
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wconversion"
#include <llvm/IR/Function.h>
#include <llvm/IR/Instructions.h>
#include <llvm/IR/Constants.h>
#include <llvm/IR/Dominators.h>
#include <llvm/Analysis/ValueTracking.h>
#pragma clang diagnostic pop

using namespace llvm;

namespace uscc
{
namespace opt
{

bool LICM::isSafeToHoistInstr(llvm::Instruction *Inst)
{
	// cond1 = has loop invariant operands
	// cond2 = safe to speculatively execute
	// cond3 = one of the following instruction classes:
	// 		   BinaryOperator, CastInst, SelectInst, GetElementPtrInst, and CmpInst
	bool cond1 = false, cond2 = false, cond3 = false;
	if (mCurrLoop->hasLoopInvariantOperands(Inst)) cond1 = true;
	if (isSafeToSpeculativelyExecute(Inst)) cond2 = true;

	if (isa<BinaryOperator>(Inst)) cond3 = true;
	else if (isa<CastInst>(Inst)) cond3 = true;
	else if (isa<SelectInst>(Inst)) cond3 = true;
	else if (isa<GetElementPtrInst>(Inst)) cond3 = true;
	else if (isa<CmpInst>(Inst)) cond3 = true;

	if (cond1 && cond2 && cond3) return true;
	else return false;
}
void LICM::hoistInstr(llvm::Instruction *Inst)
{
	// hoists the instruction to the preheader block
	Inst->moveBefore(mCurrLoop->getLoopPreheader()->getTerminator());
	mChanged = true;
}

void LICM::hoistPreOrder(llvm::DomTreeNode *DTNode)
{
	BasicBlock *bb = DTNode->getBlock();
	
	// if BB is in the current loop...
	if (mCurrLoop == mLoopInfo->getLoopFor(bb))
	{
		BasicBlock::iterator it = bb->begin(), currentInstr;
		while (it != bb->end())
		{
			currentInstr = it;
			it++;
			if (isSafeToHoistInstr(currentInstr))
				hoistInstr(currentInstr);
		}
	}
	std::vector<DomTreeNode*> DTChildren = DTNode->getChildren();
	for (auto& child : DTChildren)
		hoistPreOrder(child);
}

bool LICM::runOnLoop(llvm::Loop *L, llvm::LPPassManager &LPM)
{
	mChanged = false;

	// PA5: Implement
	// Save the current loop
	mCurrLoop = L;
	// Grab the loop info
	mLoopInfo = &getAnalysis<LoopInfo>();
	// Grab the dominator tree
	mDomTree = &getAnalysis<DominatorTreeWrapperPass>().getDomTree();

	hoistPreOrder(mDomTree->getNode(mCurrLoop->getHeader()));
	return mChanged;
}

void LICM::getAnalysisUsage(AnalysisUsage &Info) const
{
	// PA5: Implement
	// LICM does not modify the CFG
	Info.setPreservesCFG();
	// Execute after dead blocks have been removed
	Info.addRequired<DeadBlocks>();
	// Use the built-in Dominator tree and loop info passes
	Info.addRequired<DominatorTreeWrapperPass>();
	Info.addRequired<LoopInfo>();
}

} // opt
} // uscc

char uscc::opt::LICM::ID = 0;
