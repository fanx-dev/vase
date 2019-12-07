//
// Copyright (c) 2014, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2014-11-14  Jed Young  Creation
//

using vaseGraphics
using vaseWindow
using concurrent

@Js
class Interpolation {
  virtual Float evaluate(Float percent) {
    return percent
  }
}