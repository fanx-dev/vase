//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-7-4  Jed Young  Creation
//

fan.fanWt.JsWindow = fan.sys.Obj.$extend(fan.sys.Obj);
fan.fanWt.JsWindow.prototype.$ctor = function() {}
fan.fanWt.JsWindow.prototype.view = null;
fan.fanWt.JsWindow.prototype.size = null;

fan.fanWt.JsWindow.graphics = null;

fan.fanWt.JsWindow.prototype.show = function(size)
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

  //create graphics
  var g = new fan.fanWt.Graphics();
  g.widget = this;
  this.graphics = g;
  fan.fanWt.JsWindow.graphics = g;

  //init graphics
  var cx = this.canvas.getContext("2d");
  var rect = new fan.fan2d.Rect.make(0,0, this.size.m_w, this.size.m_h);
  this.graphics.init(cx, rect);

  this.needRepaint = false;
  this.repaint();

  //Repaint handling
  var self = this;
  setInterval(function(){
    if (!self.needRepaint) return;
    self.repaint();
    self.needRepaint = false;
  }, 50);
}

fan.fanWt.JsWindow.prototype.focus = function() {
    //canvas.requestFocus();
}

fan.fanWt.JsWindow.prototype.hasFocus = function() {
    //return canvas.hasFocus();
}

fan.fanWt.JsWindow.prototype.pos = function() {
    //return Point.make(canvas.getX(), canvas.getY());
}

fan.fanWt.JsWindow.prototype.repaint = function(r) {
  this.view.onPaint(this.graphics);
}

fan.fanWt.JsWindow.prototype.repaintLater = function(r) {
  this.needRepaint = true;
}

fan.fanWt.JsWindow.prototype.size = function() {
  return this.size;
}

