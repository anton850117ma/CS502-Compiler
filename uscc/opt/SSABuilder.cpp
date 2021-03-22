//
//  SSABuilder.cpp
//  uscc
//
//  Implements SSABuilder class
//
//---------------------------------------------------------
//  Copyright (c) 2014, Sanjay Madhav
//  All rights reserved.
//
//  This file is distributed under the BSD license.
//  See LICENSE.TXT for details.
//---------------------------------------------------------

#include "SSABuilder.h"
#include "../parse/Symbols.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wconversion"
#include <llvm/IR/Value.h>
#include <llvm/IR/Instructions.h>
#include <llvm/IR/Function.h>
#include <llvm/IR/DerivedTypes.h>
#include <llvm/IR/Module.h>
#include <llvm/IR/LLVMContext.h>
#include <llvm/IR/BasicBlock.h>
#include <llvm/IR/Constants.h>
#include <llvm/IR/IRBuilder.h>
#include <llvm/IR/CFG.h>
#include <llvm/IR/Constants.h>
#pragma clang diagnostic pop

#include <list>

using namespace uscc::opt;
using namespace uscc::parse;
using namespace llvm;

// Called when a new function is started to clear out all the data
void SSABuilder::reset()
{
	// PA4: Implement
	for (auto& it: mVarDefs){
		it.second->clear();
		delete it.second;
	}
	for (auto& it: mIncompletePhis){
		it.second->clear();
		delete it.second;
	}
	mVarDefs.clear();
	mIncompletePhis.clear();
	mSealedBlocks.clear();
}

// For a specific variable in a specific basic block, write its value
void SSABuilder::writeVariable(Identifier* var, BasicBlock* block, Value* value)
{
	// PA4: Implement
	(*mVarDefs[block])[var] = value;
}

// Read the value assigned to the variable in the requested basic block
// Will recursively search predecessor blocks if it was not written in this block
Value* SSABuilder::readVariable(Identifier* var, BasicBlock* block)
{
	// PA4: Implement
	auto searched_block = mVarDefs.find(block);
	auto searched_id = searched_block->second->find(var);
	if (searched_id != searched_block->second->end())
		return searched_id->second;				// Local value numbering
	return readVariableRecursive(var, block);	// Global value numbering
}

// This is called to add a new block to the maps
void SSABuilder::addBlock(BasicBlock* block, bool isSealed /* = false */)
{
	// PA4: Implement
	SubMap *defMap = new SubMap();
	SubPHI *phiMap = new SubPHI();
	mVarDefs.insert(std::make_pair(block, defMap));
	mIncompletePhis.insert(std::make_pair(block, phiMap));
	if (isSealed) sealBlock(block);
}

// This is called when a block is "sealed" which means it will not have any
// further predecessors added. It will complete any PHI nodes (if necessary)
void SSABuilder::sealBlock(llvm::BasicBlock* block)
{
	// PA4: Implement
	auto searched_block = mIncompletePhis.find(block);
	for (auto it : *(searched_block->second))
	{
		addPhiOperands(it.first, it.second);
	}
	mSealedBlocks.insert(block);
}

// Recursively search predecessor blocks for a variable
Value* SSABuilder::readVariableRecursive(Identifier* var, BasicBlock* block)
{
	Value* retVal = nullptr;

	// PA4: Implement
	auto sealed_block = mSealedBlocks.find(block);
	BasicBlock* block_pred = block->getSinglePredecessor(); // if not one, return null

	if (sealed_block == mSealedBlocks.end())
	{
		// Incomplete CFG
		PHINode* new_node = block->empty() ?
			PHINode::Create(var->llvmType(), 0, "new_phi", block) : PHINode::Create(var->llvmType(), 0, "", &block->front());

		(*mIncompletePhis[block])[var] = new_node;
		retVal = new_node;
	}
	else if (block_pred)
	{
		// Optimize the common case of one predecessor: No phi needed
		retVal = readVariable(var, block_pred);
	}
	else
	{
		// Break potential cycles with operandless phi
		PHINode* new_node = block->empty() ?
			PHINode::Create(var->llvmType(), 0, "new_phi", block) : PHINode::Create(var->llvmType(), 0, "", &block->front());
		retVal = new_node;
		writeVariable(var, block, retVal);
		retVal = addPhiOperands(var, new_node);
	}
	writeVariable(var, block, retVal);
	return retVal;
}

// Adds phi operands based on predecessors of the containing block
Value* SSABuilder::addPhiOperands(Identifier* var, PHINode* phi)
{
	// PA4: Implement
	// Determine oprands from predecessors
	BasicBlock* pred = phi->getParent();
	for (auto itr = pred_begin(pred); itr != pred_end(pred); itr++)
	{
		phi->addIncoming(readVariable(var, *itr), *itr);
	}
	return tryRemoveTrivialPhi(phi);
}

// Removes trivial phi nodes
Value* SSABuilder::tryRemoveTrivialPhi(llvm::PHINode* phi)
{
	Value* same = nullptr, *op;

	// PA4: Implement
	// std::unordered_set<Value*> users;
	std::vector<Value*> users;
	unsigned num_ops = phi->getNumIncomingValues();
	for (unsigned it = 0; it < num_ops; it++)
	{
		op = phi->getIncomingValue(it);
		if (op == same || op == phi) continue;	// Unique value or self-reference
		if (same != nullptr) return phi; 		// The phi merges at least two values: not trivial
		same = op;
	}
	if (same == nullptr)
	{
		same = UndefValue::get(phi->getType());		// The phi is unreachable or in the start block
	}
	// Remember all users except the phi itself
	// for (auto it = phi->use_begin(); it != phi->use_end(); it++)
	// {
	// 	if (*it == phi) continue;
	// 	users.insert(*it);
	// }
	// another way to do above:
	std::remove_copy(phi->use_begin(), phi->use_end(), users.begin(), phi);

	// Reroute all uses of phi to same and remove phi
	phi->replaceAllUsesWith(same);
	for (auto bb_it : mVarDefs)
		for (auto id_it : *(bb_it.second))
			if (id_it.second == phi)
				id_it.second = same;
	phi->eraseFromParent();

	// Try to recursively remove all phi users which might have become trivial
	for (auto& use: users)
		if (isa<PHINode>(use))
			tryRemoveTrivialPhi(cast<PHINode>(use));

	return same;
}
