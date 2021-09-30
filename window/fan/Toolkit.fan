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
@Js @NoPeer
abstract const class Toolkit
{
  **
  ** get current instance
  **
  native static Toolkit cur()

  //call by native
  private Void onInit() {
    Actor.locals["vaseGraphics.env"] = gfxEnv;
    tryInitAsyncRunner
  }

  @NoDoc
  abstract GfxEnv gfxEnv()

  internal static Void tryInitAsyncRunner() {
    client := Pod.find("vaseClient", false)
    if (client != null) {
      client.type("UiAsyncRunner").method("init").call()
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


  ** Look up a resource file in pod
  virtual Obj loadResFile(Str pod, Uri uri) {
    return Pod.find(pod).file(uri).readAllStr
  }

  virtual Str resFilePath(Str pod, Str uri) {
    if (Env.cur.isJs) return "/pod/$pod/$uri"
    else return "fan://$pod/$uri"
  }
}


internal const class NToolkit : Toolkit
{
  override GfxEnv gfxEnv() { NGfxEnv.cur }

  native override Window? window(View? view := null)

  native override Void callLater(Int delay, |->| f)

  native override Int dpi()

  override Str name() { "native" }

  override once Clipboard clipboard() { NClipboard() }

  native override Bool openUri(Uri uri, [Str:Str]? options := null)

  override Obj loadResFile(Str pod, Uri uri) {
    path := resFilePath(pod, uri.toStr)
    return File.os(path)
  }
  native override Str resFilePath(Str pod, Str uri)
}
