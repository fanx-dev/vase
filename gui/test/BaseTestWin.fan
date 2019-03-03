//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2015-12-5  Jed Young  Creation
//

using concurrent
using fanvasGraphics
using fanvasWindow

@Js
virtual class BaseTestWin
{
  protected RootView? root

  virtual Void main()
  {
    root = RootView()
    view := build
    root.mainView = view
    init(root)
    root.show(null)

    buf := StrBuf()
    buf.out.writeObj(root, true, ["indent":2,"skipDefaults":true])
    echo(buf)
  }

  protected virtual Widget build() { return Label{ text = "Hello "} }

  protected virtual Void init(RootView root) { }
}