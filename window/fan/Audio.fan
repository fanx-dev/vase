//
// Copyright (c) 2021, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2021-10-30  Jed Young  Creation
//

@Js
class Sound {
    private Int handle
    const Uri uri
    
    new make(Uri uri) {
      this.uri = uri
    }
    
    native Bool play(Int loop, [Str:Obj]? options = null)
    native Void pause()
    
    This load() {
      doLoad()
      return this
    }
    private native Void doLoad()
    
    protected native override Void finalize()
}

@Js
class Speech {
  private Int handle
  new make() { init }
  private native Void init()

  native Bool speak(Str text, [Str:Obj]? options = null)
  protected native override Void finalize()
}