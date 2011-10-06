//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-10-05  Jed Young  Creation
//

using gfx
using gfx2
using gfx2Imp
using fwt

class FwtView : NativeView
{
  FwtCanvas canvas
  View view
  
  override Size size() { canvas.size }
  override Point pos() { canvas.pos }
  override Size displaySize() { Size(Desktop.bounds.w, Desktop.bounds.h) }
  
  override Void repaint(Rect? dirty := null) { canvas.repaint(dirty) }
  override Bool hasFocus() { canvas.hasFocus }
  override Void focus() { canvas.focus }
  
  override Void show(Size? size := null)
  {
    Window
    {
      content = canvas
      if (size != null)
      {
        it.size = size
      }
    }.open
  }
  
  new make(View view)
  {
    this.view = view
    this.canvas = FwtCanvas(view)
    this.canvas.onMouseDown.add |e|
    {
      p := MotionPointer { it.pos = e.pos; action = MotionAction.down }
      m := MotionEvent([p])
      view.touch(m)
    }
    
    this.canvas.onMouseMove.add |e|
    {
      if (e.button == null) return
      p := MotionPointer { it.pos = e.pos; action = MotionAction.move }
      m := MotionEvent([p])
      view.touch(m)
    }
    
    this.canvas.onMouseUp.add |e|
    {
      p := MotionPointer { it.pos = e.pos; action = MotionAction.up }
      m := MotionEvent([p])
      view.touch(m)
    }
    
    this.canvas.onKeyDown.add |e|
    {
      k := KeyEvent
      {
        it.keyChar = e.keyChar.toChar
        it.keyCode = e.key.primary->mask
        it.modifiers = e.key.modifiers->mask
        it.isDown = true
      }
    }
    
    this.canvas.onKeyUp.add |e|
    {
      k := KeyEvent
      {
        it.keyChar = e.keyChar.toChar
        it.keyCode = e.key.primary->mask
        it.modifiers = e.key.modifiers->mask
        it.isDown = false
      }
    }
  }
}

class FwtCanvas : Canvas2
{
  View view
  
  new make(View view)
  {
    this.view = view
  }
  
  override Void onPaint(Graphics g)
  {
    view.paint(g)
  }
}

class FwtViewFactory : NativeViewFactory
{
  override NativeView build(View view)
  {
    return FwtView(view)
  }
}