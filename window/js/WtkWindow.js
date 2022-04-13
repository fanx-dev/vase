//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-7-4  Jed Young  Creation
//

fan.vaseWindow.WtkWindow = fan.sys.Obj.$extend(fan.sys.Obj);
fan.vaseWindow.WtkWindow.prototype.$ctor = function() {}
fan.vaseWindow.WtkWindow.prototype.$typeof = function() {
  return fan.vaseWindow.Window.$type;
}

fan.vaseWindow.WtkWindow.prototype.m_view = null;
fan.vaseWindow.WtkWindow.prototype.m_size = null;
fan.vaseWindow.WtkWindow.prototype.elem = null;
fan.vaseWindow.WtkWindow.prototype.needRepaint = true;
fan.vaseWindow.WtkWindow.prototype.graphics = null;


//////////////////////////////////////////////////////////////////////////
// cavans
//////////////////////////////////////////////////////////////////////////

fan.vaseWindow.WtkWindow.prototype.invalid = function()
{
  this.needRepaint = true;
}

//////////////////////////////////////////////////////////////////////////
// Event
//////////////////////////////////////////////////////////////////////////

fan.vaseWindow.WtkWindow.prototype.bindEvent = function(elem)
{
  //this.addEvent(this.elem, "mouseover",  fan.fwt.EventId.m_mouseEnter, self.onMouseEnter());
  //this.addEvent(this.elem, "mouseout",   fan.fwt.EventId.m_mouseExit,  self.onMouseExit());

  this.addMotionEvent(this.elem, "touchstart",  fan.vaseWindow.MotionEvent.m_pressed);
  this.addMotionEvent(this.elem, "touchmove",  fan.vaseWindow.MotionEvent.m_moved);
  this.addMotionEvent(this.elem, "touchend",    fan.vaseWindow.MotionEvent.m_released);

  this.addMotionEvent(this.elem, "mousedown",  fan.vaseWindow.MotionEvent.m_pressed);
  this.addMotionEvent(this.elem, "mousemove",  fan.vaseWindow.MotionEvent.m_moved);
  this.addMotionEvent(this.elem, "mouseup",    fan.vaseWindow.MotionEvent.m_released);
  this.addMotionEvent(this.elem, "mousewheel", fan.vaseWindow.MotionEvent.m_wheel);
  this.addKeyEvent(this.elem, "keydown",    fan.vaseWindow.KeyEvent.m_pressed);
  this.addKeyEvent(this.elem, "keyup",      fan.vaseWindow.KeyEvent.m_released);
  this.addKeyEvent(this.elem, "keypress",   fan.vaseWindow.KeyEvent.m_typed);
  //this.addEvent(this.elem, "blur",       fan.vaseWindow.InputEvent.m_blur);
  //this.addEvent(this.elem, "focus",      fan.vaseWindow.InputEvent.m_focus);
}

fan.vaseWindow.WtkWindow.toMotionEvent = function(e, typeStr, type) {
  var event = fan.vaseWindow.MotionEvent.make(type);
  if (e.identifier !== undefined) event.m_id = e.identifier;
  event.m_x = e.clientX;
  event.m_y = e.clientY;
  if (typeStr == "mousewheel")
  {
    event.m_delta = fan.vaseWindow.Event.toWheelDelta(e);
  }
  event.m_key = fan.vaseWindow.Event.toKey(e); 
  return event
}

fan.vaseWindow.WtkWindow.prototype.addMotionEvent = function(elem, typeStr, type)
{
  var view = this.m_view;
  var mouseEvent = function(e)
  {
    //console.log(e);
    var event;
    if (e.touches || e.changedTouches) {
      var ps = fan.sys.List.make(2)
      var map = {};

      for (var i=0; i<e.changedTouches.length; ++i) {
        var t = e.changedTouches[i];
        var te = fan.vaseWindow.WtkWindow.toMotionEvent(t, typeStr, type)
        ps.add(te);
        map[te.m_id] = te
      }

      for (var i=0; i<e.touches.length; ++i) {
        var t = e.touches[i];
        var te = fan.vaseWindow.WtkWindow.toMotionEvent(t, typeStr, type)
        
        if (te.m_id in map) continue;
        map[te.m_id] = te;
        ps.add(te);
      }
      
      event = ps.get(0);
      event.pointers$(ps);
    }
    else {
      event = fan.vaseWindow.WtkWindow.toMotionEvent(e, typeStr, type)
      //event.m_widget = this.elem;
    }

    view.onMotionEvent(event);

    // if (event.pointers()) {
    //   console.log(event.type(), event.pointers().size());
    // }
    // else {
    //   console.log(event.type(), "null");
    // }

    //if (event.m_consumed) {
      e.stopPropagation();
      if (typeStr != "mousewheel")  e.preventDefault();
      e.cancelBubble = true;
    //}
  };
  fan.vaseWindow.GfxUtil.addEventListener(elem, typeStr, mouseEvent);
}

fan.vaseWindow.WtkWindow.prototype.addKeyEvent = function(elem, typeStr, type)
{
  var view = this.m_view;
  var mouseEvent = function(e)
  {
    //console.log(e);
    var event = fan.vaseWindow.KeyEvent.make(type);
    //event.m_id = id;
    event.m_widget = this.elem;
    event.m_key = fan.vaseWindow.Event.toKey(e);
    event.m_keyChar =  e.charCode || e.keyCode;
    view.onKeyEvent(event);
  };
  fan.vaseWindow.GfxUtil.addEventListener(elem, typeStr, mouseEvent);
}

//////////////////////////////////////////////////////////////////////////
//
//////////////////////////////////////////////////////////////////////////

fan.vaseWindow.WtkWindow.prototype.focus = function() {
  this.elem.focus();
}

fan.vaseWindow.WtkWindow.prototype.hasFocus = function() {
  return document.activeElement == this.elem;
}

fan.vaseWindow.WtkWindow.prototype.pos = function() {
  var x = this.elem.offsetLeft;
  var y = this.elem.offsetTop;
  return fan.vaseGraphics.Point.make(x, y);
}

fan.vaseWindow.WtkWindow.prototype.repaint = function(r) {
  this.needRepaint = true;
  var self = this;
  if (requestAnimationFrame && !self.callback) {
    self.callback = function() { self.update(); }
    requestAnimationFrame(self.callback);
  }
}

fan.vaseWindow.WtkWindow.prototype.repaintNow = function(r) {
  this.graphics.push();
  this.m_view.onPaint(this.graphics);
  this.graphics.pop();
}

fan.vaseWindow.WtkWindow.prototype.size = function() {
  return this.m_size;
}

fan.vaseWindow.WtkWindow.prototype.view = function() {
  return this.m_view;
}

fan.vaseWindow.WtkWindow.prototype.update = function() {
  var self = this;
  self.callback = null;
  if (!self.needRepaint) return;
  self.needRepaint = false;
  self.repaintNow();
}

////////////////////////////////////////////////////////////////////////
// Window
////////////////////////////////////////////////////////////////////////

//cotr
fan.vaseWindow.WtkWindow.make = function(view) {  
  var nativeView = new fan.vaseWindow.WtkWindow();
  view.host$(nativeView);
  nativeView.m_view = view;
  return nativeView;
}

fan.vaseWindow.WtkWindow.prototype.createCanvas = function(shell, size) {
  // if (this.elem) {
  //   shell.removeChild(this.elem);
  // }

  if (size && this.m_size) {
    if (size.equlas(this.m_size)) return;
  }

  if (!size) {
    size = this.m_view.getPrefSize(shell.clientWidth, shell.clientHeight);
  }
  //console.log(size)
  this.m_size = size;

  //create canvas
  var c = document.createElement("canvas");
  var density = window.devicePixelRatio || 1;
  c.width  = size.m_w * density;
  c.height = size.m_h * density;
  c.style.width = size.m_w+"px";
  c.style.height = size.m_h +"px";

  if (this.elem) {
    shell.replaceChild(c, this.elem);
    this.elem = c;
    this.bindEvent(c);
    c.setAttribute('tabindex','0');
  }
  else {
    this.elem = c;
    shell.appendChild(this.elem);
    this.bindEvent(c);
    c.setAttribute('tabindex','0');
    c.focus();
  }

  //create fan graphics
  var g = new fan.vaseWindow.WtkGraphics();
  g.widget = this;
  this.graphics = g;
  fan.vaseWindow.WtkWindow.graphics = g;

  //init graphics
  var cx = this.elem.getContext("2d");
  cx.scale(density, density);
  var rect = new fan.vaseGraphics.Rect.make(0,0, size.m_w, size.m_h);
  g.init(cx, rect);
}

function hookLog() {
  // Reference to an output container, use 'pre' styling for JSON output
  var output = document.createElement('textarea');
  with (output.style)
  {
    zIndex=999;
    position   = "absolute";//this.root === document.body ? "fixed" : "absolute";
    top        = "0";
    left       = "0";
    width      = "300px";
    height     = "200px";
    background = "transparent";
    borderStyle = "none";
  }
  document.body.appendChild(output);
  // Reference to native method(s)
  var oldLog = console.log;
  console.log = function( ...items ) {
      // Call native method first
      oldLog.apply(this,items);
      output.innerHTML += items.join(' ') + '\n';
      var h = output.scrollHeight;
      output.scrollTop = h;
  };
}

fan.vaseWindow.WtkWindow.prototype.show = function(size)
{
  //hookLog();
  if (!requestAnimationFrame) {
    window.requestAnimationFrame = (function(){
      return  window.requestAnimationFrame       || 
              window.webkitRequestAnimationFrame || 
              window.mozRequestAnimationFrame    || 
              window.oRequestAnimationFrame      || 
              window.msRequestAnimationFrame     || 
              function( callback ){
                window.setTimeout(callback, 1000 / 60);
              };
    })();
  }

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
    position   = "absolute";//this.root === document.body ? "fixed" : "absolute";
    top        = "0";
    left       = "0";
    width      = "100%";
    height     = "100%";
    background = "#fff";
  }

  this.root.appendChild(shell);
  this.shell = shell;
  var self = this;
  fan.vaseWindow.WtkWindow.instance = this;

  this.createCanvas(shell, size);
  // attach resize listener
  fan.vaseWindow.GfxUtil.addEventListener(window, "resize", function() {
    self.createCanvas(shell, null);
    self.repaint();
  });

  //fire event
  var event = fan.vaseWindow.WindowEvent.make(fan.vaseWindow.WindowEvent.m_opened);
  this.m_view.onWindowEvent(event);

  //paint
  this.needRepaint = false;
  this.repaintNow();

  //Repaint handling
  // if (!requestAnimationFrame) {
  //   setInterval(function(){
  //     if (!self.needRepaint) return;
  //     self.needRepaint = false;
  //     self.repaintNow();
  //   }, 17);
  // }
  history.pushState(null, null, document.URL);
  window.addEventListener('popstate', function () {
      //history.pushState(null, null, document.URL);
      if (self.m_view.onBack()) history.pushState(null, null, document.URL);
  });
}

fan.vaseWindow.WtkWindow.prototype.textInput = function(inputType) {
    var jsEditText = fan.vaseWindow.WtkEditText.make(inputType);
    this.shell.appendChild(jsEditText.elem);
    return jsEditText;
}

fan.vaseWindow.WtkWindow.prototype.fileDialog = function(accept, callback, options)
{
  var field = document.createElement("input");
  field.type = "file";
  field.style.display = "none";
  field.accept = accept;
  field.multiple="multiple";
  field.addEventListener('change', function() {
    fileList = field.files;
    files = fan.sys.List.make();
    for (var i = 0; i<fileList.length; ++i) {
      files.add(fileList[i]);
    }
    callback.call(files);
  });
  field.click();
}

