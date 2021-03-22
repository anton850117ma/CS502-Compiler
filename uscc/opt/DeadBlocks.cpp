//
//  DeadBlocks.cpp
//  uscc
//
//  Implements Dead Block Removal optimization pass.
//  This removes blocks from the CFG which are unreachable.
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
#include <llvm/IR/CFG.h>
#include <llvm/ADT/DepthFirstIterator.h>
#pragma clang diagnostic pop
#include <set>

using namespace llvm;

namespace uscc
{
namespace opt
{

bool DeadBlocks::runOnFunction(Function& F)
{
	bool changed = false;
	// PA5: Implement

	std::set<BasicBlock*> visitedSet, unreachableSet;
	// Perform a DFS from the entry block, adding each visited block to the visitedSet
	BasicBlock* entry = F.begin();
	for (df_ext_iterator<BasicBlock*> dfi = df_ext_begin(entry, visitedSet), endi = df_ext_end(entry, visitedSet); dfi != endi; ++dfi){;}

	Function::iterator blockIter = F.begin();
	// foreach BasicBlock BB in F...
	while (blockIter != F.end())
	{
		// if BB is not in the visitedSet
		if (visitedSet.find(blockIter) == visitedSet.end())
			// Add BB to unreachableSet
			unreachableSet.insert(blockIter);
		++blockIter;
	}
	// foreach BasicBlock BB in unreachableSet...
	for (auto& bb : unreachableSet)
	{
		// foreach successor to BB...
		for (auto it = succ_begin(bb); it != succ_end(bb); ++it)
		{
			// Tell the successor to remove BB as a predecessor
			it->removePredecessor(bb);
		}
		// Erase BB
		bb->eraseFromParent();
	}
	return changed;
}

void DeadBlocks::getAnalysisUsage(AnalysisUsage& Info) const
{
	// PA5: Implement
	Info.addRequired<ConstantBranch>();
}

} // opt
} // uscc

char uscc::opt::DeadBlocks::ID = 0;
