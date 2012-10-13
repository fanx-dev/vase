//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-7-4  Jed Young  Creation
//

fan.fgfxWtk.JsWindow = fan.sys.Obj.$extend(fan.sys.Obj);
fan.fgfxWtk.JsWindow.prototype.$ctor = function() {}
fan.fgfxWtk.JsWindow.prototype.view = null;
fan.fgfxWtk.JsWindow.prototype.size = null;

fan.fgfxWtk.JsWindow.graphics = null;


//////////////////////////////////////////////////////////////////////////
// cavans
//////////////////////////////////////////////////////////////////////////

fan.fgfxWtk.JsWindow.prototype.show = function(size)
{
  this.size = size;
  // check for alt root
  var rootId = fan.sys.Env.cur().vars().get("fwt.window.root")
  if (rootId == null) this.root = document.body;
  else
  {
    this.root = document.getElementById(rootId);
    if (this.root == null) throw fan.sys.ArgErr.make("No root found");
  }

  // mount shell we use to attach widgets to
  var shell = document.createElement("div")
  with (shell.style)
  {
    position   = this.root === document.body ? "fixed" : "absolute";
    top        = "0";
    left       = "0";
    width      = "100%";
    height     = "100%";
    background = "#fff";
  }

  //create canvas
  var c = document.createElement("canvas");
  c.width  = size.m_w;
  c.height = size.m_h;
  shell.appendChild(c);
  this.root.appendChild(shell);
  this.canvas = c;

  this.bindEvent(c);
  c.setAttribute('tabindex','0');
  c.focus();

  //create graphics
  var g = new fan.fgfxWtk.Graphics();
  g.widget = this;
  this.graphics = g;
  fan.fgfxWtk.JsWindow.graphics = g;

  //init graphics
  var cx = this.canvas.getContext("2d");
  var rect = new fan.fgfx2d.Rect.make(0,0, this.size.m_w, this.size.m_h);
  this.graphics.init(cx, rect);

  this.needRepaint = false;
  this.repaint();

  var event = fan.fgfxWtk.DisplayEvent.make(fan.fgfxWtk.DisplayEvent.m_opened);
  this.view.onDisplayEvent(event);

  //Repaint handling
  var self = this;
  setInterval(function(){
    if (!self.needRepaint) return;
    self.repaint();
    self.needRepaint = false;
  }, 50);
}

fan.fgfxWtk.JsWindow.prototype.invalid = function()
{
  this.needRepaint = true;
}

//////////////////////////////////////////////////////////////////////////
// Event
//////////////////////////////////////////////////////////////////////////

fan.fgfxWtk.JsWindow.prototype.bindEvent = function(elem)
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

fan.fgfxWtk.JsWindow.prototype.addMotionEvent = function(elem, type, id)
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

fan.fgfxWtk.JsWindow.prototype.addKeyEvent = function(elem, type, id)
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

fan.fgfxWtk.JsWindow.prototype.focus = function() {
  this.canvas.focus();
}

fan.fgfxWtk.JsWindow.prototype.hasFocus = function() {
  return document.activeElement == this.canvas;
}

fan.fgfxWtk.JsWindow.prototype.pos = function() {
  var x = this.canvas.offsetLeft;
  var y = this.canvas.offsetTop;
  return fan.fgfx2d.Point.make(x, y);
}

fan.fgfxWtk.JsWindow.prototype.repaint = function(r) {
  this.view.onPaint(this.graphics);
}

fan.fgfxWtk.JsWindow.prototype.repaintLater = function(r) {
  this.needRepaint = true;
}

fan.fgfxWtk.JsWindow.prototype.size = function() {
  return this.size;
}

