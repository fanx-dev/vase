//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-7-7  Jed Young  Creation
//

using vaseGraphics
using concurrent

**
** Window Toolkit
**
@Js
@NoPeer
abstract const class Toolkit
{
  **
  ** get current instance
  ** throw Err when not install in current thread
  **
  static Toolkit cur()
  {
    Toolkit? env := instance
    if (env != null) return env

    ToolkitEnv.init
    return instance
  }

  @NoDoc
  protected native static Toolkit instance()
  @NoDoc
  abstract GfxEnv gfxEnv()

  internal static Void tryInitAsyncRunner() {
    client := Pod.find("vaseClient", false)
    if (client != null) {
      client.type("AsyncRunner").method("init").call()
    }
  }

  **
  ** get or make window
  **
  abstract Window? window(View? view := null)

  **
  ** call on UI thread. delay on millisecond
  **
  abstract Void callLater(Int delay, |->| f)

  **
  ** return the current devices DPI(dot per inch)
  **
  protected virtual Int dpi() { 160 }

  **
  ** density base on 320 dpi
  **
  virtual Float density() { dpi / 320.0f }

  **
  ** current Env name
  ** one of "HTML5","SWT","AWT","Android"
  **
  abstract Str name()

  **
  ** Reference to the system clipboard for data transfer.
  **
  abstract Clipboard clipboard()


  abstract Bool openUri(Uri uri, [Str:Str]? options := null)
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

**
** Clipboard provides access to the system clipboard for data transfer.
** Access is via `Desktop.clipboard`.
**
@Js
abstract class Clipboard
{
  **
  ** Get the current clipboard contents as plain text or null
  ** if clipboard doesn't contain text data.
  **
  abstract Str? getText(|Str?| callback)

  **
  ** Set the clipboard contents to given plain text data.
  **
  abstract Void setText(Str data)
}
