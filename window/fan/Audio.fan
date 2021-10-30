//
// Copyright (c) 2021, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2021-10-30  Jed Young  Creation
//

@Js
class Sound {
    const Uri uri
    
    new make(Uri uri) {
      this.uri = uri
    }
    
    native Bool play(Int loop, [Str:Obj]? options = null)
    native Void pause()
    
    native Void load()
    native Void release()
}

@Js
class Speech {
  native Bool speak(Str text, [Str:Obj]? options = null)
}