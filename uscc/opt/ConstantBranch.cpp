//
//  ContantBranch.cpp
//  uscc
//
//  Implements Constant Branch Folding opt pass.
//  This converts conditional branches on constants to
//  unconditional branches.
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
#pragma clang diagnostic pop
#include <set>

using namespace llvm;

namespace uscc
{
namespace opt
{

bool ConstantBranch::runOnFunction(Function& F)
{
	bool changed = false;

	// PA5: Implement
	// Make a set that contains the branches we'll remove
	std::set<BranchInst*> removeSet;

	// Loop through each block
	Function::iterator blockIter = F.begin();
	while (blockIter != F.end())
	{
		// Loop through instructions in block
		BasicBlock::iterator instrIter = blockIter->begin();
		while (instrIter != blockIter->end())
		{
			// Is this a brach instruction?
			if (BranchInst* brInst = dyn_cast<BranchInst>(instrIter))
			{
				// Check if it is conditional and its condition is a constant int
				if (brInst->isConditional() && isa<ConstantInt>(brInst->getCondition()))
				{
					// Add br to removeSet
					removeSet.insert(brInst);
				}
			}
			++instrIter;
		}
		++blockIter;
	}

	// Now remove any braches we flagged
	if (removeSet.size() > 0)
	{
		changed = true;
		// foreach BranchInst br in removeSet...
		for (auto& br : removeSet)
		{
			BasicBlock* leftSuc = br->getSuccessor(0);
			BasicBlock* rightSuc = br->getSuccessor(1);
			// if br's condition is true...
			if (br->getCondition() == ConstantInt::getTrue(br->getContext()))
			{
				// Create a new BranchInst that's an unconditional branch to the left successor
				BranchInst* newBr = BranchInst::Create(leftSuc, br);
				// Notify the right successor that br's parent is no longer a predecessor
				rightSuc->removePredecessor(br->getParent());
			}
			else
			{
				// Create a new BranchInst that's an unconditional branch to the right successor
				BranchInst* newBr = BranchInst::Create(rightSuc, br);
				// Notify the left successor that br's parent is no longer a predecessor
				leftSuc->removePredecessor(br->getParent());
			}
			// Erase br
			br->eraseFromParent();
		}
	}
	return changed;
}

void ConstantBranch::getAnalysisUsage(AnalysisUsage& Info) const
{
	// PA5: Implement
	Info.addRequired<ConstantOps>();
}

} // opt
} // uscc

char uscc::opt::ConstantBranch::ID = 0;
