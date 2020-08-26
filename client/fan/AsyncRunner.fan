
//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2019-03-31  Jed Young  Creation
//

using concurrent
using vaseWindow


const class UiAsyncRunner : AsyncRunner {
  private static const UiAsyncRunner cur := UiAsyncRunner()

  static Void init() {
    //echo("AsyncRunner init")
    Actor.locals["async.runner"] = cur
  }

  protected override Bool awaitOther(Async s, Obj? awaitObj) {
    if (awaitObj isnot Future) {
      return false
    }
    Future future := awaitObj

    |->|? checkFuture := null
    checkFuture = |->|{
      if (future.state.isComplete) {
        try {
          s.awaitRes = future.get
        }
        catch (Err e) {
          s.err = e
        }
        run(s)
      }
      else {
        Toolkit.cur.callLater(200, checkFuture)
      }
    }
    Toolkit.cur.callLater(200, checkFuture)
    return true
  }

  ** run in custem thread
  override Void run(Async s) {
    Toolkit.cur.callLater(0) {
      s.step
    }
  }
}