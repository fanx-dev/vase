//
// Copyright (c) 2014, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2014-11-14  Jed Young  Creation
//

@Js
class FloatPropertyAnimChannel : AnimChannel {
  Obj target
  Field field
  |->|? updateFunc
  
  Float from := 0f
  Float to := 1f
  
  new make(Obj target, Field field) {
    this.target = target
    this.field = field
  }
  
  Interpolation interpolation := Interpolation()

  override Void update(Int elapsedTime, Int frameTime, Float percent, Float blendWeight) {
    Float p := interpolation.evaluate(percent)
    
    val := (to-from)*p + from
    
    field.set(target, val)
  }
}
