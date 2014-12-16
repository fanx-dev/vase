//
// Copyright (c) 2012, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-02-24  Jed Young  Creation
//

using fgfxMath
using fgfxOpenGl
using fgfxArray

@Js
class TransformStack
{
  private Matrix[] stack

  new make(Int d := 4)
  {
    stack = [ Matrix.makeIndentity(d) ]
  }

  Matrix top() { stack.peek }
  This set(Matrix m) { stack.set(stack.size - 1, m); return this }

  Matrix pop() { stack.pop }

  This push()
  {
    dup := top.clone
    stack.push(dup)
    return this
  }

  This mult(Matrix t) { set(top * t); return this }
}

