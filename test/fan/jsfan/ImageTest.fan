//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-7-4  Jed Young  Creation
//

using fanvasGraphics
using fanvasFwt
using fanvasWindow

using fanvasMath
using fanvasArray

**
** Image Test
**
@Js
class ImageTest
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

    view := MyImageView()
    win := Toolkit.cur.build()
    win.add(view)

    win.show()
  }
}

@Js
class MyImageView : View
{
  Int i := 0

  override NativeView? host

  Image p := BufImage.fromUri(`fan://icons/x16/folder.png`) |p|
  {
    //image filter
    for (i:=0; i < p.size.w; ++i)
    {
      for (j:=0; j < p.size.h; ++j)
      {
        c := p.getPixel(i,j)
        //echo(c)
        c = c.and(0xffff0000)
        //echo(c)
        p.setPixel(i, j, c)
      }
    }
  }

  new make()
  {
  }

  override Void onPaint(Graphics g) {
    g.drawImage(p, 0, 0)
  }
}


