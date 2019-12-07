//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-07-23  Jed Young  Creation
//

using vaseGraphics
using vaseWindow
using concurrent

**
** Call the specified function on the UI thread's event loop
**
@Js
class Timer
{
  **
  **  Schedules the specified task for repeated fixed-delay execution, beginning after the specified delay.
  **
  Int period

  **
  ** Cancels this timer task.
  **
  Bool canceled := true { private set }

  **
  ** callback
  **
  private |->| onTimeOut

  **
  ** current env
  **
  private Toolkit toolkit

  **
  **
  **
  new make(Int period, |->| onTimeOut)
  {
    toolkit = Toolkit.cur
    this.onTimeOut = onTimeOut
    this.period = period
  }

  **
  ** Starts the Timer
  **
  Void start()
  {
    canceled = false
    toolkit.callLater(period, timeOut)
  }

  **
  ** Cancel the Timer
  **
  Void cancel()
  {
    canceled = true
  }

  private |->| timeOut := |->|
  {
    if (canceled) return
    toolkit.callLater(period, timeOut)
    onTimeOut.call()
  }

}