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

@Js
virtual class Viewer
{
  protected Frame? root
  private File viewFile
  private File? styleFile

  new make() {
    viewFile = Env.cur.args[0].toUri.toFile
    if (Env.cur.args.size > 1) {
      styleFile = Env.cur.args[1].toUri.toFile
    }
  }

  Void show() {
    root = Frame()
    reload
    watchFile
    root.show
  }

  static Void main()
  {
    Viewer().show
  }

  private Void reload() {
    if (styleFile != null) {
      [Str:Obj] style := styleFile.readAllStr.in.readObj
      root.styleManager.styleClassMap.setAll(style)
    }

    view := viewFile.readAllStr.in.readObj
    root.content = view
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
internal const class FileWatchActor : Actor {
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