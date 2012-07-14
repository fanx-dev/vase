//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-7-4  Jed Young  Creation
//

fan.fanWt.Window = fan.sys.Obj.$extend(fan.sys.Obj);
fan.fanWt.Window.prototype.$ctor = function() {}
fan.fanWt.Window.prototype.view = null;
fan.fanWt.Window.prototype.size = null;

fan.fanWt.Window.prototype.show = function(size)
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
  c.width  = self.m_w;
  c.height = self.m_h;
  shell.appendChild(c);
  this.root.appendChild(shell);
  this.canvas = c;

  repaint();
}

fan.fanWt.Window.prototype.focus = function() {
    //canvas.requestFocus();
}

fan.fanWt.Window.prototype.hasFocus = function() {
    //return canvas.hasFocus();
}

fan.fanWt.Window.prototype.pos = function() {
    //return Point.make(canvas.getX(), canvas.getY());
}

fan.fanWt.Window.prototype.repaint = function(r) {
  var g = new fan.fan2d.Graphics();
  g.widget = this;
  g.paint(this.canvas, null, function() { g.widget.onPaint(g) });
}

fan.fanWt.Window.prototype.repaintLater = function(r) {
    //canvas.repaint(1000);
}

fan.fanWt.Window.prototype.size = function() {
  return this.size;
}