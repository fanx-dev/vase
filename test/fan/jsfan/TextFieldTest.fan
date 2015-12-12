//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2015-12-5  Jed Young  Creation
//
using fanvasGui

@Js
class TextFieldTest : BaseTestWin
{
  protected override Widget build() {
    TextField {
      text = "Hello"
    }
  }
}