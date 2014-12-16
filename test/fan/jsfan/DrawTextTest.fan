//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-7-4  Jed Young  Creation
//

using fgfxGraphics
using fgfxWtk
using concurrent
using fgfxMath
using fgfxFwt

@Js
class DrawTextTest
{
  Bool initEnv() {
    if (Env.cur.runtime != "java") {
      ToolkitEnv.init
      return true
    }
    if (Env.cur.args.size > 0) {
      if (Env.cur.args.first == "AWT") {
        ToolkitEnv.init
        return true
      }
      else if (Env.cur.args.first == "SWT") {
        FwtToolkitEnv.init
        return true
      }
    }
    echo("AWT or SWT ?")
    return false
  }

  Void main()
  {
    if (!initEnv) return

    view := DrawTextTestView()
    win := Toolkit.cur.build()
    win.add(view)

    win.show(Size(400, 400))
  }
}

@Js
class DrawTextTestView : View
{
  override NativeView? nativeView

  new make()
  {
    Graphics g := p.graphics

    g.brush = Color.yellow
    g.fillRect(5,5,300,300)

    g.brush = Color.red
    g.fillRect(0,0,5,5)

    g.brush = Color.black
    x := 100
    y := 10
    g.drawText("Hello \nWorld", x, y)

    trans := Transform2D().rotate(0f, 0f, 0.5f)
    g.transform = trans
    g.drawText("Hello \nWorld", x, y)

    trans = Transform2D().rotate(x.toFloat, y.toFloat, 0.5f)
    g.transform = trans
    g.drawText("Hello \nWorld", x, y)

    g.dispose
  }

  BufImage? p := BufImage(Size(310,310))

  override Void onPaint(Graphics g) {
    g.drawImage(p, 10, 10)
  }
}


