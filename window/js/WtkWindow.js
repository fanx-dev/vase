//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-7-4  Jed Young  Creation
//

fan.fanvasWindow.WtkWindow = fan.sys.Obj.$extend(fan.fanvasWindow.Window);
fan.fanvasWindow.WtkWindow.prototype.$ctor = function() {}
fan.fanvasWindow.WtkWindow.prototype.$typeof = function() {
  return fan.fanvasWindow.WtkWindow.$type;
}

fan.fanvasWindow.WtkWindow.prototype.m_view = null;
fan.fanvasWindow.WtkWindow.prototype.m_size = null;
fan.fanvasWindow.WtkWindow.prototype.elem = null;
fan.fanvasWindow.WtkWindow.prototype.needRepaint = true;
fan.fanvasWindow.WtkWindow.prototype.graphics = null;


//////////////////////////////////////////////////////////////////////////
// cavans
//////////////////////////////////////////////////////////////////////////

fan.fanvasWindow.WtkWindow.prototype.invalid = function()
{
  this.needRepaint = true;
}

//////////////////////////////////////////////////////////////////////////
// Event
//////////////////////////////////////////////////////////////////////////

fan.fanvasWindow.WtkWindow.prototype.bindEvent = function(elem)
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

fan.fanvasWindow.WtkWindow.prototype.addMotionEvent = function(elem, type, id)
{
  var view = this.m_view;
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

fan.fanvasWindow.WtkWindow.prototype.addKeyEvent = function(elem, type, id)
{
  var view = this.m_view;
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

fan.fanvasWindow.WtkWindow.prototype.focus = function() {
  this.elem.focus();
}

fan.fanvasWindow.WtkWindow.prototype.hasFocus = function() {
  return document.activeElement == this.elem;
}

fan.fanvasWindow.WtkWindow.prototype.pos = function() {
  var x = this.elem.offsetLeft;
  var y = this.elem.offsetTop;
  return fan.fanvasGraphics.Point.make(x, y);
}

fan.fanvasWindow.WtkWindow.prototype.repaint = function(r) {
  this.needRepaint = true;
}

fan.fanvasWindow.WtkWindow.prototype.repaintNow = function(r) {
  this.graphics.push();
  this.m_view.onPaint(this.graphics);
  this.graphics.pop();
}

fan.fanvasWindow.WtkWindow.prototype.size = function() {
  return this.m_size;
}

fan.fanvasWindow.WtkWindow.prototype.view = function() {
  return this.m_view;
}

////////////////////////////////////////////////////////////////////////
// Window
////////////////////////////////////////////////////////////////////////

//cotr
fan.fanvasWindow.WtkWindow.make = function(view) {  
  var nativeView = new fan.fanvasWindow.WtkWindow();
  view.host$(nativeView);
  nativeView.m_view = view;
  return nativeView;
}

fan.fanvasWindow.WtkWindow.prototype.createCanvas = function(shell, size) {
  if (this.elem) {
    shell.removeChild(this.elem);
  }

  if (!size) {
    size = this.m_view.getPrefSize(shell.offsetWidth, shell.offsetHeight);
  }
  //console.log(size)
  this.m_size = size;

  //create canvas
  var c = document.createElement("canvas");
  c.width  = size.m_w;
  c.height = size.m_h;

  this.elem = c;
  shell.appendChild(this.elem);
  this.bindEvent(c);
  c.setAttribute('tabindex','0');
  c.focus();

  //create fan graphics
  var g = new fan.fanvasWindow.WtkGraphics();
  g.widget = this;
  this.graphics = g;
  fan.fanvasWindow.WtkWindow.graphics = g;

  //init graphics
  var cx = this.elem.getContext("2d");
  var rect = new fan.fanvasGraphics.Rect.make(0,0, size.m_w, size.m_h);
  g.init(cx, rect);
}

fan.fanvasWindow.WtkWindow.prototype.show = function(size)
{
  // check for alt root
  var rootId = fan.std.Env.cur().vars().get("fwt.window.root")
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

  this.root.appendChild(shell);
  this.shell = shell;
  var self = this;
  fan.fanvasWindow.WtkWindow.instance = this;

  this.createCanvas(shell, size);
  // attach resize listener
  fan.fanvasWindow.GfxUtil.addEventListener(window, "resize", function() {
    self.createCanvas(shell, null);
    self.needRepaint = true;
  });

  //fire event
  var event = fan.fanvasWindow.WindowEvent.make(fan.fanvasWindow.WindowEvent.m_opened);
  this.m_view.onWindowEvent(event);

  //paint
  this.needRepaint = false;
  this.repaintNow();

  //Repaint handling
  setInterval(function(){
    if (!self.needRepaint) return;
    self.needRepaint = false;
    self.repaintNow();
  }, 50);
}

fan.fanvasWindow.WtkWindow.prototype.textInput = function(view) {
  if (!view.host()) {
    var jsEditText = new fan.fanvasWindow.WtkEditText();
    jsEditText.init(view);
    view.host$(jsEditText);
  }

  var jsEditText = view.host();
  if (!jsEditText.elem.parentNode) {
    this.shell.appendChild(jsEditText.elem);
  }
  
  jsEditText.update();
}
