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
      std::cout << "Didn't find named value " << name << std::endl;
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
  }else if (type =="OrExpression"){
    auto L = GenExpression(exp["left"]);
    auto R = GenExpression(exp["right"]);
    return Builder->CreateLogicalOr(L, R, "OR");
  }else if(type=="AndExpression"){
    auto L = GenExpression(exp["left"]);
    auto R = GenExpression(exp["right"]);
    return Builder->CreateLogicalAnd(L, R, "AND");
  }else if(type=="EQExpression"){
    auto L = GenExpression(exp["left"]);
    auto R = GenExpression(exp["right"]);
    return Builder->CreateICmpEQ(L,R,"igualdade");
  }else if(type=="NEQExpression"){
    auto L = GenExpression(exp["left"]);
    auto R = GenExpression(exp["right"]);
    return Builder->CreateICmpNE(L,R,"desigualdade");
  }else if(type=="GTExpression"){
    auto L = GenExpression(exp["left"]);
    auto R = GenExpression(exp["right"]);
    return Builder->CreateICmpSGT(L,R,"maior que");
  }else if(type=="LTExpression"){
    auto L = GenExpression(exp["left"]);
    auto R = GenExpression(exp["right"]);
    return Builder->CreateICmpSLT(L,R,"menor que");
  }else if(type=="GTEExpression"){
    auto L = GenExpression(exp["left"]);
    auto R = GenExpression(exp["right"]);
    return Builder->CreateICmpSGE(L,R,"maior ou igual a");
  }else if(type=="LTEExpression"){
    auto L = GenExpression(exp["left"]);
    auto R = GenExpression(exp["right"]);
   return Builder->CreateICmpSLE(L,R,"menor ou igual a");
  }

  std::cout << "Expression type not implemented!!!" << std::endl;
  exit(1);
  return nullptr;
}

void generate_statement(json statement);

void create_IfElse(json statement){
  Function *TheFunction = Builder->GetInsertBlock()->getParent();

  BasicBlock *ThenBB = BasicBlock::Create(*TheContext, "entao_IffElse", TheFunction);
  BasicBlock *ElseBB = BasicBlock::Create(*TheContext, "senao_IfElse");
  TheFunction->getBasicBlockList().insert(TheFunction->end(), ThenBB);
  TheFunction->getBasicBlockList().insert(TheFunction->end(), ElseBB);

  auto CondV = GenExpression(statement["condition"]);
  Builder->CreateCondBr(CondV, ThenBB, ElseBB);

  Builder->SetInsertPoint(ThenBB);
  generate_statement(statement["thenStmt"]);

  Builder->SetInsertPoint(ElseBB);
  generate_statement(statement["elseStmt"]);
}

void create_ReturnStmt(json statement) {
  auto return_expression = statement["exp"];
  auto Ret = GenExpression(return_expression);
  Builder->CreateRet(Ret);
}


void create_IfElseIf(json statement){
  Function *TheFunction = Builder->GetInsertBlock()->getParent();

  BasicBlock *ThenBB = BasicBlock::Create(*TheContext, "entao_IfElseIF", TheFunction);
  BasicBlock *ElseBB = BasicBlock::Create(*TheContext, "entao_IfElseIF");
  TheFunction->getBasicBlockList().insert(TheFunction->end(), ThenBB);
  TheFunction->getBasicBlockList().insert(TheFunction->end(), ElseBB);

  auto CondV = GenExpression(statement["condition"]);
  Builder->CreateCondBr(CondV, ThenBB, ElseBB);

  Builder->SetInsertPoint(ThenBB);
  generate_statement(statement["thenStmt"]);


  Builder->SetInsertPoint(ElseBB);
  auto const& elsifs = statement["elseifStmt"];
  for (auto const& elsif : elsifs){
    generate_statement(elsif);
  }

  generate_statement(statement["elseStmt"]);
}

void create_ElseIf(json statement){
  Function *TheFunction = Builder->GetInsertBlock()->getParent();

  BasicBlock *ThenBB = BasicBlock::Create(*TheContext, "entao_ElseIf", TheFunction);
  BasicBlock *ElseBB = BasicBlock::Create(*TheContext, "senao_ElseIf");
  TheFunction->getBasicBlockList().insert(TheFunction->end(), ThenBB);
  TheFunction->getBasicBlockList().insert(TheFunction->end(), ElseBB);

  auto CondV = GenExpression(statement["condition"]);
  Builder->CreateCondBr(CondV, ThenBB, ElseBB);

  Builder->SetInsertPoint(ThenBB);
  generate_statement(statement["thenStmt"]);
  std::cout<<"Them Stmt: "<<statement["thenStmt"]<<"\n";
  Builder->SetInsertPoint(ElseBB);
}


void generate_statement(json statement) {
  auto type = statement["type"];
  std::cout << "Should generate statement of type " << type << std::endl;
  if (type == "IfElseStmt") {
    create_IfElse(statement);
  } else if (type=="IfElseIfStmt"){
    create_IfElseIf(statement);
  }else if (type=="ElseIfStmt"){
    create_ElseIf(statement);
  }else if (type=="ForStmt"){
    c
  }else if (type == "ReturnStmt") {
    create_ReturnStmt(statement);
  } else if (type == "SequenceStmt") {
    for (auto const& st : statement["stmts"])
      generate_statement(st);
  } else if (type == "AssignmentStmt") {
  } else {
    std::cout << "Statement of type " << type << " not implemented" << std::endl;
  }
}

Type* str_to_llvm_type(std::string const& type) {
  if (type == "IntegerType$")
    return Type::getInt32Ty(*TheContext);
  std::cout << "Type not implemented " << type << std::endl;
  return nullptr;
}

void generate_procedure(json procedure) {
  std::cout << "Generating procedure " << procedure["name"] << std::endl;

  Type *return_type = str_to_llvm_type(procedure["returnType"]["type"]);
  std::vector<Type*> arg_types;
  for (auto const& arg : procedure["args"])
    arg_types.push_back(str_to_llvm_type(arg["argumentType"]["type"]));
  FunctionType *FT = FunctionType::get(return_type, arg_types, false);
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

  auto function_stmt = procedure["stmt"];
  generate_statement(function_stmt);

  if (procedure["name"] == "main") {
    auto zero = ConstantInt::getSigned(Type::getInt32Ty(*TheContext), 0);
    Builder->CreateRet(zero);
  }

  verifyFunction(*F);
  F->print(errs());
}

int main() {
  InitializeModule();

  std::ifstream f{"IfElseIf.json"};
  json data = json::parse(f);

  auto const& procedures = data["procedures"];
  for (auto const& procedure : procedures)
    generate_procedure(procedure);

  json main_function;
  main_function["stmt"] = data["stmt"];
  main_function["name"] = "main";
  main_function["returnType"]["type"] = "IntegerType$";
  generate_procedure(main_function);

  TheModule->print(errs(), nullptr);
}
