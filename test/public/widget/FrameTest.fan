//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-7-4  Jed Young  Creation
//

using concurrent
using fanvasGraphics
using fanvasWindow
using fanvasGui

@Js
class FrameTest
{
  Frame? frame1
  Frame? frame2

  Void makeFrame1() {
    frame1 = Frame
    {
      padding = Insets(100)
      Button { id = "button"; text = "Hello Button" },
    }

    Button btn := frame1.findById("button")
    echo(btn)
    btn.onAction.add { echo("SHOW"); frame2.show }
  }

  Void makeFrame2() {
    frame2 = Frame {
        Button { id = "return"; text = "Return"; },
    }

    Button btn2 := frame2.findById("return")
    echo(btn2)
    btn2.onAction.add { echo("POP"); frame2.pop }
  }

  Void main() {
    makeFrame1
    makeFrame2

    frame1.show
  }
}