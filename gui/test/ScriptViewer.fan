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


virtual class ScriptViewer
{
  protected Frame? root
  private File scriptFile

  new make() {
    scriptFile = Env.cur.args[0].toUri.toFile
  }

  Void show() {
    root = Frame()
    reload
    watchFile
    root.show
  }

  static Void main()
  {
    ScriptViewer().show
  }

  private Void reload() {
    try {
      type := Env.cur.compileScript(scriptFile)

      Widget view := type.make()->view
      if (view is Frame) {
        root = (view as Frame)
        root.show
      }
      else {
        root.removeAll().add(view)
        root.relayout
      }
    } catch (Err e) {
      e.trace
    }
  }

  private Void watchFile() {
    files := [scriptFile]

    self := Unsafe(this)
    watch := FileWatchActor {
      fileList = files
      onChanged = |->| {
        Toolkit.cur.callLater(0) |->| { self.val->reload }
      }
    }
  }
}