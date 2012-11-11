//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-7-4  Jed Young  Creation
//

fan.fgfxWtk.JsView = fan.sys.Obj.$extend(fan.sys.Obj);
fan.fgfxWtk.JsView.prototype.$ctor = function() {}
fan.fgfxWtk.JsView.prototype.view = null;
fan.fgfxWtk.JsView.prototype.size = null;
fan.fgfxWtk.JsView.prototype.canvas = null;
fan.fgfxWtk.JsView.prototype.needRepaint = true;
fan.fgfxWtk.JsView.prototype.graphics = null;

//////////////////////////////////////////////////////////////////////////
// cavans
//////////////////////////////////////////////////////////////////////////

fan.fgfxWtk.JsView.prototype.invalid = function()
{
  this.needRepaint = true;
}

//////////////////////////////////////////////////////////////////////////
// Event
//////////////////////////////////////////////////////////////////////////

fan.fgfxWtk.JsView.prototype.bindEvent = function(elem)
{
  //this.addEvent(this.canvas, "mouseover",  fan.fwt.EventId.m_mouseEnter, self.onMouseEnter());
  //this.addEvent(this.canvas, "mouseout",   fan.fwt.EventId.m_mouseExit,  self.onMouseExit());
  this.addMotionEvent(this.canvas, "mousedown",  fan.fgfxWtk.MotionEvent.m_pressed);
  this.addMotionEvent(this.canvas, "mousemove",  fan.fgfxWtk.MotionEvent.m_moved);
  this.addMotionEvent(this.canvas, "mouseup",    fan.fgfxWtk.MotionEvent.m_released);
  this.addMotionEvent(this.canvas, "mousewheel", fan.fgfxWtk.MotionEvent.m_other);
  this.addKeyEvent(this.canvas, "keydown",    fan.fgfxWtk.KeyEvent.m_pressed);
  this.addKeyEvent(this.canvas, "keyup",      fan.fgfxWtk.KeyEvent.m_released);
  this.addKeyEvent(this.canvas, "keypress",   fan.fgfxWtk.KeyEvent.m_typed);
  //this.addEvent(this.canvas, "blur",       fan.fgfxWtk.InputEvent.m_blur);
  //this.addEvent(this.canvas, "focus",      fan.fgfxWtk.InputEvent.m_focus);
}

fan.fgfxWtk.JsView.prototype.addMotionEvent = function(elem, type, id)
{
  var view = this.view;
  var mouseEvent = function(e)
  {
    //console.log(e);
    var event = fan.fgfxWtk.MotionEvent.make(id);
    event.m_id = id;
    event.m_x = e.clientX;
    event.m_y = e.clientY;
    event.m_widget = this.canvas;
    if (type == "mousewheel")
    {
      event.m_delta = fan.fgfxWtk.Event.toWheelDelta(e);
    }
    event.m_key = fan.fgfxWtk.Event.toKey(e);
    view.onMotionEvent(event);
  };
  fan.fgfxWtk.GfxUtil.addEventListener(elem, type, mouseEvent);
}

fan.fgfxWtk.JsView.prototype.addKeyEvent = function(elem, type, id)
{
  var view = this.view;
  var mouseEvent = function(e)
  {
    //console.log(e);
    var event = fan.fgfxWtk.KeyEvent.make(id);
    event.m_id = id;
    event.m_widget = this.canvas;
    event.m_key = fan.fgfxWtk.Event.toKey(e);
    event.m_keyChar =  e.charCode || e.keyCode;
    view.onKeyEvent(event);
  };
  fan.fgfxWtk.GfxUtil.addEventListener(elem, type, mouseEvent);
}

//////////////////////////////////////////////////////////////////////////
//
//////////////////////////////////////////////////////////////////////////

fan.fgfxWtk.JsView.prototype.focus = function() {
  this.canvas.focus();
}

fan.fgfxWtk.JsView.prototype.hasFocus = function() {
  return document.activeElement == this.canvas;
}

fan.fgfxWtk.JsView.prototype.pos = function() {
  var x = this.canvas.offsetLeft;
  var y = this.canvas.offsetTop;
  return fan.fgfx2d.Point.make(x, y);
}

fan.fgfxWtk.JsView.prototype.repaint = function(r) {
  this.view.onPaint(this.graphics);
}

fan.fgfxWtk.JsView.prototype.repaintLater = function(r) {
  this.needRepaint = true;
}

fan.fgfxWtk.JsView.prototype.size = function() {
  return this.size;
}

