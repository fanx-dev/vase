//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-5-29  Jed Young  Creation
//


fan.fogl.GlDisplayPeer = fan.sys.Obj.$extend(fan.sys.Obj);
fan.fogl.GlDisplayPeer.prototype.$ctor = function(self) {}
fan.fogl.GlDisplayPeer.prototype.gl = null;

fan.fogl.GlDisplayPeer.prototype.initGL = function(self, canvas)
{
  try
  {
    var gl = canvas.getContext("experimental-webgl");
    this.gl = new fan.fogl.WebGlContext();
    this.gl.gl = gl;

    //self.gl.viewportWidth = canvas.width;
    //self.gl.viewportHeight = canvas.height;
  }
  catch(e){}

  if (!this.gl.gl) {
    alert("Could not initialise WebGL, sorry :-(");
  }
}

fan.fogl.GlDisplayPeer.prototype.repaint = function(self)
{
  self.onPaint(this.gl);
}

fan.fogl.GlDisplayPeer.prototype.open = function(self)
{
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

  this.initGL(self, c);
  self.init(this.gl);

  var loop = function() { self.repaint(); };
  setInterval(loop, 15);
}

