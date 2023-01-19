#include "llvm/ADT/STLExtras.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/DerivedTypes.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Type.h"
#include "llvm/IR/Verifier.h"

#include <fstream>
#include <iostream>
#include "json.hpp"

using namespace llvm;
using json = nlohmann::json;

static std::unique_ptr<LLVMContext> TheContext;
static std::unique_ptr<Module> TheModule;
static std::unique_ptr<IRBuilder<>> Builder;
static std::map<std::string, Value*> NamedValues;

static void InitializeModule() {
  std::cout << "Initializing Module..." << std::endl;

  TheContext = std::make_unique<LLVMContext>();
  TheModule = std::make_unique<Module>("Oberon is Cool B)", *TheContext);
  Builder = std::make_unique<IRBuilder<>>(*TheContext);
}

Value* GenExpression(json exp) {
  auto const& type = exp["type"];
  std::cout << "Generating Expression of type: " << type << std::endl;
  if (type == "IntValue") {
    return ConstantInt::getSigned(Type::getInt32Ty(*TheContext), exp["value"]);
  } else if (type == "VarExpression") {
    auto const& name = exp["name"];
    if (NamedValues.find(name) == NamedValues.end())
      std::cout << "Didn't find " << name << std::endl;
    return NamedValues[name];
  } else if (type == "MultExpression") {
    auto L = GenExpression(exp["left"]);
    auto R = GenExpression(exp["right"]);
    return Builder->CreateMul(L, R, "produto");
  } else if (type == "AddExpression") {
    auto L = GenExpression(exp["left"]);
    auto R = GenExpression(exp["right"]);
    return Builder->CreateAdd(L, R, "soma");
  } else if (type == "SubExpression") {
    auto L = GenExpression(exp["left"]);
    auto R = GenExpression(exp["right"]);
    return Builder->CreateSub(L, R, "diferenca");
  }
  std::cout << "Expression type not implemented!!!" << std::endl;
  exit(1);
  return nullptr;
}

Type* str_to_llvm_type(std::string const& type) {
  if (type == "IntegerType$")
    return Type::getInt32Ty(*TheContext);
  std::cout << "Type not implemented" << std::endl;
  return nullptr;
}

int main() {
  InitializeModule();

  std::ifstream f{"SimpleModule.json"};
  json data = json::parse(f);

  for (auto const& procedure : data["procedures"]) {
    Type *RT = str_to_llvm_type(procedure["returnType"]["type"]);
    std::vector<Type*> ARG_TYPES;
    for (auto const& arg : procedure["args"]) 
      ARG_TYPES.push_back(str_to_llvm_type(arg["argumentType"]["type"]));
    FunctionType *FT = FunctionType::get(RT, ARG_TYPES, false);
    Function *F = Function::Create(FT, Function::ExternalLinkage, (std::string)procedure["name"], TheModule.get());

    std::vector<std::string> arg_names;
    for (auto const& arg : procedure["args"])
      arg_names.push_back(arg["name"]);

    int idx = 0;
    for (auto &Arg : F->args())
      Arg.setName(arg_names[idx++]);

    NamedValues.clear();
    for (auto &Arg : F->args())
      NamedValues[(std::string)Arg.getName()] = &Arg;

    BasicBlock *BB = BasicBlock::Create(*TheContext, "entry", F);
    Builder->SetInsertPoint(BB);

    auto const& return_expression = procedure["stmt"]["exp"];
    Value* Ret = GenExpression(return_expression);
    Builder->CreateRet(Ret);

    verifyFunction(*F);
    F->print(errs());
  }

  TheModule->print(errs(), nullptr);
}
