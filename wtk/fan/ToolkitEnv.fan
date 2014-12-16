//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-7-7  Jed Young  Creation
//

using fgfxGraphics
using concurrent

**
** Window Toolkit
**
@Js
abstract const class Toolkit
{
  **
  ** get current instance
  ** throw Err when not install in current thread
  **
  static Toolkit cur()
  {
    Toolkit? env := Actor.locals["fgfxWtk.env"]
    if (env == null) throw Err("No fgfxWtk.env is active")
    return env
  }

  **
  ** make a new window
  **
  abstract Window build()

  **
  ** call on UI thread. delay on millisecond
  **
  abstract Void callLater(Int delay, |->| f)

  **
  ** return the current devices DPI(dot per inch)
  **
  virtual Int dpi() { 80 }

  **
  ** current Env name
  ** one of "HTML5","SWT","AWT","Android"
  **
  abstract Str name()
}

**
** Default Toolkit maker
**
@Js
class ToolkitEnv
{
  **
  ** install Toolkit for current thread
  **
  native static Void init()
}