//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2015-12-5  Jed Young  Creation
//
using fanvasGui

@Js
class TextAreaTest : BaseTestWin
{
  protected override Widget build() {
    TextArea {
      model = DefTextAreaModel(
                               """//
                                  // Copyright (c) 2011, chunquedong
                                  // Licensed under the Academic Free License version 3.0
                                  //



                                  // History:
                                  //   2011-7-4  Jed Young  Creation
                                  //""")
    }
  }
}