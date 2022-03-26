//
// Copyright (c) 2021, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2021-11-03  Jed Young  Creation
//

@Js
class Video {
    private Int handle
    Uri uri := ``
    |Str->Void|? onEvent
    Bool controller := true
    Int x := 0
    Int y := 0
    Int w := 300
    Int h := 300
    Bool center := false
    [Str:Obj]? options
    Bool fullScreen := false

    protected Void fireEvent(Str event) {
        onEvent?.call(event)
    }
    
    native Bool play(Int loop, [Str:Obj]? options = null)
    native Void pause()
    
    This setup(Window win) {
      doSetup(win)
      return this
    }
    private native Void doSetup(Window win)

    native Void remove()
    
    //protected native override Void finalize()
}
