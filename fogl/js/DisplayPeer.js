//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-5-29  Jed Young  Creation
//


fan.fogl.DisplayPeer = fan.sys.Obj.$extend(fan.sys.Obj);
fan.fogl.DisplayPeer.prototype.$ctor = function(self) {}

function fan.fogl.DisplayPeer.prototype.initGL(self, canvas) {
    try {
        self.gl = canvas.getContext("experimental-webgl");
        //self.gl.viewportWidth = canvas.width;
        //self.gl.viewportHeight = canvas.height;
    } catch (e) {
    }
    if (!self.gl) {
        alert("Could not initialise WebGL, sorry :-(");
    }
}

fan.fogl.DisplayPeer.prototype.create = function(self)
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
  c = document.createElement("canvas");
  c.width  = 600;
  c.height = 500;
  shell.appendChild(c);

  initGL(self, c);
}

fan.fogl.DisplayPeer.prototype.repaint = function(self)
{
  cx = new fan.fogl.GlContext();
  cx.peer.gl = gl
  self.onPaint(cx);
}