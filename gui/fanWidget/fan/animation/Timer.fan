//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-07-23  Jed Young  Creation
//

using fan2d
using fanWt
using concurrent

class Timer
{
  Int delay := 1000
  Bool canceled := false
  |->|? onTimeOut
  Toolkit toolkit

  new make()
  {
    toolkit = Toolkit.cur
  }

  Void start()
  {
    canceled = false
    toolkit.callLater(delay, timeOut)
  }

  Void stop()
  {
    canceled = true
  }

  |->| timeOut := |->|
  {
    if (canceled) return
    toolkit.callLater(delay, timeOut)
    onTimeOut?.call()
  }

}