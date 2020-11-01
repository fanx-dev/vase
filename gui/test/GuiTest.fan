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
virtual class GuiTest
{
  protected Frame? root

  virtual Void main()
  {
    root = Frame()

    if (Env.cur.args.size > 1) {
      file := Env.cur.args[1].toUri.toFile
      if (file.ext == "fog") {
        [Str:Obj] style := file.readAllStr.in.readObj
        root.styleManager.styleClassMap.setAll(style)
      }
    }

    view := build
    root.content = view
    init(root)
    root.show

    buf := StrBuf()
    buf.out.writeObj(root, true, ["indent":2,"skipDefaults":true])
    echo(buf)
  }

  protected virtual Widget build() {
    if (Env.cur.args.size > 0) {
      file := Env.cur.args[0].toUri.toFile
      if (file.ext == "fog") {
        return file.readAllStr.in.readObj
      }
    }
    return Label{ text = "Hello "}
  }

  protected virtual Void init(Frame root) { }
}