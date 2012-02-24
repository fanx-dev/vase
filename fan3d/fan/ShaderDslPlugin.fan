//
// Copyright (c) 2012, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-02-24  Jed Young  Creation
//

using compiler

class ShaderDslPlugin : DslPlugin
{
  new make(Compiler c) : super(c) {}

  override Expr compile(DslExpr dsl)
  {
    regexType := ns.resolveType(Shader#.qname)
    fromStr := regexType.method("fromStr")
    args := [Expr.makeForLiteral(dsl.loc, ns, dsl.src)]
    return CallExpr.makeWithMethod(dsl.loc, null, fromStr, args)
  }
}