
using concurrent
using fanvasWindow


class Promise {
  protected |Obj?|? callback := |res| {
    lock.sync {
      result = res
      isDone = true
      lret null
    }
  }

  private Bool isDone := false
  private Obj? result
  private Lock lock := Lock()

  Void then(|Obj?| f) {
    lock.sync {
      if (isDone) {
        f.call(result)
      }
      else callback = f
      lret null
    }
  }
}

class AsyncRunner {

  static Void init() {
    echo("AsyncRunner init")
    Actor.locals["async.runner"] = |Async<Obj> s| { run(s) }
  }

  private static Void run(Async<Obj> s) {
    if (s.next) {
      awaitObj := s.awaitObj
      echo("pause :" + awaitObj)

      if (awaitObj is Promise) {
        Promise promise = awaitObj
        promise.then |res| {
          s.awaitObj = res
          Toolkit.cur.callLater(0) {
            s.run
          }
        }
      }
      else if (awaitObj is Async) {
        Async sub := awaitObj
        sub.then {
          s.awaitObj = sub.result
          Toolkit.cur.callLater(0) {
            s.run
          }
        }
        sub.run
      }
      else if (awaitObj is Future) {
        Future future := awaitObj

        |->|? checkFuture := null
        checkFuture = |->|{
          if (future.state.isComplete) {
            Obj? res := null
            try {
              res = future.get
            }
            catch (Err e) {
              res = e
            }
          }
          else {
            Toolkit.cur.callLater(100, checkFuture)
          }
        }
        Toolkit.cur.callLater(100, checkFuture)
      }
      else {
        Toolkit.cur.callLater(0) {
          s.run
        }
      }
    }
    echo("end: $s")
  }
}