//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-7-7  Jed Young  Creation
//

using fan2d
using concurrent

@Js
abstract const class Toolkit
{
  static Toolkit cur()
  {
    Toolkit? env := Actor.locals["fanWt.env"]
    if (env == null) throw Err("No fanWt.env is active")
    return env
  }

  abstract Window build(View view)

  abstract Void callLater(Int delay, |->| f)
}

@Js
class ToolkitEnv
{
  native static Void init()
}