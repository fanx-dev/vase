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
using fanvasFwt

@Js
abstract class BaseTestWin
{
  private Bool initEnv() {
    if (Env.cur.runtime != "java") {
      ToolkitEnv.init
      return true
    }
    if (Env.cur.args.size > 0) {
      if (Env.cur.args.first == "AWT") {
        ToolkitEnv.init
        return true
      }
      else if (Env.cur.args.first == "SWT") {
        FwtToolkitEnv.init
        return true
      }
    }
    echo("AWT or SWT ?")
    FwtToolkitEnv.init
    return true
  }

  Void main()
  {
    if (!initEnv) return

    RootView? view
    view = RootView
    {
      mainView = build
    }

    init(view)
    view.show(null)

    buf := StrBuf()
    buf.out.writeObj(view, ["indent":2,"skipDefaults":true])
    echo(buf)
  }

  protected abstract Widget build()

  protected virtual Void init(RootView root) {}
}