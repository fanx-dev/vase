//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2015-12-5  Jed Young  Creation
//

using concurrent
using vaseGraphics
using vaseWindow

@Js
virtual class BaseTestWin
{
  protected Frame? root

  virtual Void main()
  {
    root = Frame()
    view := build
    root.content = view
    init(root)
    root.show

    buf := StrBuf()
    buf.out.writeObj(root, true, ["indent":2,"skipDefaults":true])
    echo(buf)
  }

  protected virtual Widget build() { return Label{ text = "Hello "} }

  protected virtual Void init(Frame root) { }
}