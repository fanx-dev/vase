//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-7-7  Jed Young  Creation
//

using fanvasGraphics
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
    Toolkit? env := Actor.locals["fanvasWindow.env"]
    if (env != null) return env

    ToolkitEnv.init
    env = Actor.locals["fanvasWindow.env"]
    if (env != null) return env
    throw Err("No fanvasWindow.env is active")
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
  protected virtual Int dpi() { 135 }

  **
  ** density base on 320 dpi
  **
  virtual Float density() { dpi / 320.0f }

  **
  ** current Env name
  ** one of "HTML5","SWT","AWT","Android"
  **
  abstract Str name()
}

**
** Default Toolkit maker
**
@Js @NoDoc
class ToolkitEnv
{
  **
  ** install Toolkit for current thread
  **
  native static Void init()
}

