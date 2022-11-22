//
// Copyright (c) 2020, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2020-11-08  Jed Young  Creation
//

using concurrent
using vaseGraphics
using vaseWindow
using util


virtual class FogViewer : AbstractMain
{
  protected Frame? root

  @Arg { help = "view file" }
  File? viewFile

  @Opt { help = "style file"; aliases=["s"] }
  File? styleFile

  @Opt { help = "auto scale"; aliases=["a"] }
  Bool autoScale = false


  override Int run() {
    root = Frame { it.autoScale = this.autoScale }
    reload
    watchFile
    root.show
    return 0
  }

  private Void reload() {
    if (styleFile != null) {
      [Str:Obj] style := styleFile.readAllStr.in.readObj
      root.styleManager = StyleManager()
      root.styleManager.styleClassMap.setAll(style)
    }

    view := viewFile.readAllStr.in.readObj
    root.removeAll.add(view)
    root.relayout
  }

  private Void watchFile() {
    files := [viewFile]
    if (styleFile != null) files.add(styleFile)

    self := Unsafe(this)
    watch := FileWatchActor {
      fileList = files
      onChanged = |->| {
        Toolkit.cur.callLater(0) |->| { self.val->reload }
      }
    }
  }
}


**
** notify if file changed
**
const class FileWatchActor : Actor {
  static const Str storeKey := "watchActor.map"
  const File[]? fileList
  const |->|? onChanged
  const Duration checkTime := 1sec

  new make(|This| f) : super(ActorPool{maxThreads=1}) {
    f(this)
    sendLater(4sec, null)
  }

  protected override Obj? receive(Obj? msg) {
    try {
      if (msg == "stop") {
        locals["stop"] = true
        return null
      }
      if (locals.get("stop") == true) return null
      sendLater(checkTime, null)

      if (fileList == null) return null

      [Str:TimePoint] map := locals.getOrAdd(storeKey) { [Str:TimePoint][:] }
      Bool changed := false

      fileList.each |dir| {
        if (changed) return

        dir.walk |file| {
          key := file.toStr
          time := map[key]
          if (time != null) {
            if (file.modified > time) {
              changed = true
              return
            }
          }
          map[key] = file.modified
        }
      }

      if (changed) {
        echo("file changed")
        locals.remove(storeKey)
        onChanged?.call()
      }
    }
    catch (Err e) { e.trace }
    return null
  }
}