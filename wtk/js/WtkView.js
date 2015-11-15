//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-7-4  Jed Young  Creation
//

fan.fgfxWtk.WtkView = fan.sys.Obj.$extend(fan.sys.Obj);
fan.fgfxWtk.WtkView.prototype.$ctor = function() {}
fan.fgfxWtk.WtkView.prototype.$typeof = function() {
  return fan.fgfxWtk.WtkView.$type;
}

fan.fgfxWtk.WtkView.prototype.view = null;
fan.fgfxWtk.WtkView.prototype.m_size = null;
fan.fgfxWtk.WtkView.prototype.elem = null;
fan.fgfxWtk.WtkView.prototype.needRepaint = true;
fan.fgfxWtk.WtkView.prototype.graphics = null;

//////////////////////////////////////////////////////////////////////////
// cavans
//////////////////////////////////////////////////////////////////////////

fan.fgfxWtk.WtkView.prototype.invalid = function()
{
  this.needRepaint = true;
}

//////////////////////////////////////////////////////////////////////////
// Event
//////////////////////////////////////////////////////////////////////////

fan.fgfxWtk.WtkView.prototype.bindEvent = function(elem)
{
  //this.addEvent(this.elem, "mouseover",  fan.fwt.EventId.m_mouseEnter, self.onMouseEnter());
  //this.addEvent(this.elem, "mouseout",   fan.fwt.EventId.m_mouseExit,  self.onMouseExit());
  this.addMotionEvent(this.elem, "mousedown",  fan.fgfxWtk.MotionEvent.m_pressed);
  this.addMotionEvent(this.elem, "mousemove",  fan.fgfxWtk.MotionEvent.m_moved);
  this.addMotionEvent(this.elem, "mouseup",    fan.fgfxWtk.MotionEvent.m_released);
  this.addMotionEvent(this.elem, "mousewheel", fan.fgfxWtk.MotionEvent.m_wheel);
  this.addKeyEvent(this.elem, "keydown",    fan.fgfxWtk.KeyEvent.m_pressed);
  this.addKeyEvent(this.elem, "keyup",      fan.fgfxWtk.KeyEvent.m_released);
  this.addKeyEvent(this.elem, "keypress",   fan.fgfxWtk.KeyEvent.m_typed);
  //this.addEvent(this.elem, "blur",       fan.fgfxWtk.InputEvent.m_blur);
  //this.addEvent(this.elem, "focus",      fan.fgfxWtk.InputEvent.m_focus);
}

fan.fgfxWtk.WtkView.prototype.addMotionEvent = function(elem, type, id)
{
  var view = this.view;
  var mouseEvent = function(e)
  {
    //console.log(e);
    var event = fan.fgfxWtk.MotionEvent.make(id);
    //event.m_id = id;
    event.m_x = e.clientX;
    event.m_y = e.clientY;
    event.m_widget = this.elem;
    if (type == "mousewheel")
    {
      event.m_delta = fan.fgfxWtk.Event.toWheelDelta(e);
    }
    event.m_key = fan.fgfxWtk.Event.toKey(e);
    view.onMotionEvent(event);
  };
  fan.fgfxWtk.GfxUtil.addEventListener(elem, type, mouseEvent);
}

fan.fgfxWtk.WtkView.prototype.addKeyEvent = function(elem, type, id)
{
  var view = this.view;
  var mouseEvent = function(e)
  {
    //console.log(e);
    var event = fan.fgfxWtk.KeyEvent.make(id);
    //event.m_id = id;
    event.m_widget = this.elem;
    event.m_key = fan.fgfxWtk.Event.toKey(e);
    event.m_keyChar =  e.charCode || e.keyCode;
    view.onKeyEvent(event);
  };
  fan.fgfxWtk.GfxUtil.addEventListener(elem, type, mouseEvent);
}

//////////////////////////////////////////////////////////////////////////
//
//////////////////////////////////////////////////////////////////////////

fan.fgfxWtk.WtkView.prototype.focus = function() {
  this.elem.focus();
}

fan.fgfxWtk.WtkView.prototype.hasFocus = function() {
  return document.activeElement == this.elem;
}

fan.fgfxWtk.WtkView.prototype.pos = function() {
  var x = this.elem.offsetLeft;
  var y = this.elem.offsetTop;
  return fan.fgfxGraphics.Point.make(x, y);
}

fan.fgfxWtk.WtkView.prototype.repaint = function(r) {
  this.needRepaint = true;
}

fan.fgfxWtk.WtkView.prototype.repaintNow = function(r) {
  this.graphics.push();
  this.view.onPaint(this.graphics);
  this.graphics.pop();
}

fan.fgfxWtk.WtkView.prototype.size = function() {
  return this.m_size;
}

fan.fgfxWtk.WtkView.prototype.win = function() {
  return this.m_win;
}