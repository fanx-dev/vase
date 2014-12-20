//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-7-7  Jed Young  Creation
//

using fgfxGraphics
using fgfxWtk

**
** Canvas stub
**
@Js
class FwtCanvas : fwt::Canvas
{
  private FwtView fwtView
  //private gfx::Size? lastSize

  new make(FwtView fwtView)
  {
    this.fwtView = fwtView
    doubleBuffered = true
  }
  override Void onPaint(gfx::Graphics gc)
  {
    Graphics g := FwtToolkitEnv.toGraphics(gc)
    fwtView.view.onPaint(g)
    g.dispose
  }

  override gfx::Size prefSize(gfx::Hints hints := gfx::Hints.defVal) {
    s := fwtView.view.getPrefSize(600, 600)
    return gfx::Size(s.w, s.h)
  }

  internal Void bindEvent()
  {
    this.onMouseDown.add { postMotionEvent(it, MotionEvent.pressed) }
    this.onMouseMove.add { postMotionEvent(it, MotionEvent.moved) }
    this.onMouseUp.add { postMotionEvent(it, MotionEvent.released) }
    this.onMouseWheel.add { postMotionEvent(it, MotionEvent.wheel) }

    // I do not find the typed event in SWT
    this.onKeyDown.add { postKeyEvent(it, KeyEvent.pressed); postKeyEvent(it, KeyEvent.typed) }
    this.onKeyUp.add { postKeyEvent(it, KeyEvent.released) }

    this.onBlur.add { postDisplayEvent(it, DisplayEvent.lostFocus) }
    this.onFocus.add { postDisplayEvent(it, DisplayEvent.gainedFocus) }
  }

  private Void postMotionEvent(fwt::Event e, Int id)
  {
    MotionEvent ce := MotionEvent(id)
    ce.x = e.pos?.x
    ce.y = e.pos?.y
    ce.button = e.button
    ce.count = e.count
    ce.delta = e.delta?.y
    ce.rawEvent = e
    fwtView.view.onMotionEvent(ce)
  }

  private Void postKeyEvent(fwt::Event e, Int id)
  {
    KeyEvent ce := KeyEvent(id)
    ce.keyChar = e.keyChar
    //JS bug
    if (ce.keyChar == null)
    {
      ce.keyChar = e.key.primary->mask
    }
    ce.key = Key(e.key.toStr)
    fwtView.view.onKeyEvent(ce)
  }

  private Void postDisplayEvent(fwt::Event e, Int id)
  {
    DisplayEvent ce := DisplayEvent(id)
    fwtView.view.onDisplayEvent(ce)
  }
}

**
** Fwt Window
**
@Js
class FwtView : NativeView
{
  FwtCanvas canvas
  View view

  new make(View view)
  {
    this.view = view
    canvas = FwtCanvas(this)
    canvas.bindEvent
  }

  override Void repaint(Rect? dirty := null)
  {
    if (dirty == null) canvas.repaint
    else canvas.repaint(gfx::Rect(dirty.x, dirty.y, dirty.w, dirty.h))

    //Fix auto repaint
    fwt::Desktop.callLater(Duration(20*1000000), |->|{})
  }

  override Size size()
  {
    return Size.make(canvas.size.w, canvas.size.h)
  }
  override Point pos()
  {
    return Point(canvas.pos.x, canvas.pos.y)
  }

  override Bool hasFocus() { canvas.hasFocus }
  override Void focus() { canvas.focus }
}

**
** Fwt Window
**
@Js
class FwtWindow : Window
{
  internal fwt::Window fwtWin
  internal View[] list := [,]

  new make()
  {
    fwtWin = fwt::Window{}
  }

  override This add(View view)
  {
    nativeView := FwtView(view)
    view.nativeView = nativeView
    list.add(view)
    fwtWin.add(nativeView.canvas)
    return this
  }

  override Void show(Size? size := null)
  {
    Int titleBarHeight := 22
    if (size != null) {
      fwtWin.size = gfx::Size(size.w, size.h+titleBarHeight)
    } else {
      s := ((FwtView)list.first.nativeView).canvas.prefSize
      fwtWin.size = gfx::Size(s.w, s.h+titleBarHeight)
    }
    fwtWin.open
  }

  private Void postDisplayEvent(fwt::Event e, Int id)
  {
    DisplayEvent ce := DisplayEvent(id)

    list.each |view|
    {
      view.onDisplayEvent(ce)
    }
  }

  internal Void bindEvent()
  {
    fwtWin.onOpen.add { postDisplayEvent(it, DisplayEvent.opened) }
    fwtWin.onClose.add { postDisplayEvent(it, DisplayEvent.closing) }
    fwtWin.onActive.add { postDisplayEvent(it, DisplayEvent.activated) }
    fwtWin.onInactive.add { postDisplayEvent(it, DisplayEvent.deactivated) }
    fwtWin.onDeiconified.add { postDisplayEvent(it, DisplayEvent.deiconified) }
    fwtWin.onIconified.add { postDisplayEvent(it, DisplayEvent.iconified) }
  }
}