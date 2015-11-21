//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-7-4  Jed Young  Creation
//

fan.fanvasWindow.WtkView = fan.sys.Obj.$extend(fan.sys.Obj);
fan.fanvasWindow.WtkView.prototype.$ctor = function() {}
fan.fanvasWindow.WtkView.prototype.$typeof = function() {
  return fan.fanvasWindow.WtkView.$type;
}

fan.fanvasWindow.WtkView.prototype.view = null;
fan.fanvasWindow.WtkView.prototype.m_size = null;
fan.fanvasWindow.WtkView.prototype.elem = null;
fan.fanvasWindow.WtkView.prototype.needRepaint = true;
fan.fanvasWindow.WtkView.prototype.graphics = null;

//////////////////////////////////////////////////////////////////////////
// cavans
//////////////////////////////////////////////////////////////////////////

fan.fanvasWindow.WtkView.prototype.invalid = function()
{
  this.needRepaint = true;
}

//////////////////////////////////////////////////////////////////////////
// Event
//////////////////////////////////////////////////////////////////////////

fan.fanvasWindow.WtkView.prototype.bindEvent = function(elem)
{
  //this.addEvent(this.elem, "mouseover",  fan.fwt.EventId.m_mouseEnter, self.onMouseEnter());
  //this.addEvent(this.elem, "mouseout",   fan.fwt.EventId.m_mouseExit,  self.onMouseExit());
  this.addMotionEvent(this.elem, "mousedown",  fan.fanvasWindow.MotionEvent.m_pressed);
  this.addMotionEvent(this.elem, "mousemove",  fan.fanvasWindow.MotionEvent.m_moved);
  this.addMotionEvent(this.elem, "mouseup",    fan.fanvasWindow.MotionEvent.m_released);
  this.addMotionEvent(this.elem, "mousewheel", fan.fanvasWindow.MotionEvent.m_wheel);
  this.addKeyEvent(this.elem, "keydown",    fan.fanvasWindow.KeyEvent.m_pressed);
  this.addKeyEvent(this.elem, "keyup",      fan.fanvasWindow.KeyEvent.m_released);
  this.addKeyEvent(this.elem, "keypress",   fan.fanvasWindow.KeyEvent.m_typed);
  //this.addEvent(this.elem, "blur",       fan.fanvasWindow.InputEvent.m_blur);
  //this.addEvent(this.elem, "focus",      fan.fanvasWindow.InputEvent.m_focus);
}

fan.fanvasWindow.WtkView.prototype.addMotionEvent = function(elem, type, id)
{
  var view = this.view;
  var mouseEvent = function(e)
  {
    //console.log(e);
    var event = fan.fanvasWindow.MotionEvent.make(id);
    //event.m_id = id;
    event.m_x = e.clientX;
    event.m_y = e.clientY;
    event.m_widget = this.elem;
    if (type == "mousewheel")
    {
      event.m_delta = fan.fanvasWindow.Event.toWheelDelta(e);
    }
    event.m_key = fan.fanvasWindow.Event.toKey(e);
    view.onMotionEvent(event);
  };
  fan.fanvasWindow.GfxUtil.addEventListener(elem, type, mouseEvent);
}

fan.fanvasWindow.WtkView.prototype.addKeyEvent = function(elem, type, id)
{
  var view = this.view;
  var mouseEvent = function(e)
  {
    //console.log(e);
    var event = fan.fanvasWindow.KeyEvent.make(id);
    //event.m_id = id;
    event.m_widget = this.elem;
    event.m_key = fan.fanvasWindow.Event.toKey(e);
    event.m_keyChar =  e.charCode || e.keyCode;
    view.onKeyEvent(event);
  };
  fan.fanvasWindow.GfxUtil.addEventListener(elem, type, mouseEvent);
}

//////////////////////////////////////////////////////////////////////////
//
//////////////////////////////////////////////////////////////////////////

fan.fanvasWindow.WtkView.prototype.focus = function() {
  this.elem.focus();
}

fan.fanvasWindow.WtkView.prototype.hasFocus = function() {
  return document.activeElement == this.elem;
}

fan.fanvasWindow.WtkView.prototype.pos = function() {
  var x = this.elem.offsetLeft;
  var y = this.elem.offsetTop;
  return fan.fanvasGraphics.Point.make(x, y);
}

fan.fanvasWindow.WtkView.prototype.repaint = function(r) {
  this.needRepaint = true;
}

fan.fanvasWindow.WtkView.prototype.repaintNow = function(r) {
  this.graphics.push();
  this.view.onPaint(this.graphics);
  this.graphics.pop();
}

fan.fanvasWindow.WtkView.prototype.size = function() {
  return this.m_size;
}

fan.fanvasWindow.WtkView.prototype.win = function() {
  return this.m_win;
}