//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-5-29  Jed Young  Creation
//


fan.fogl.GlCanvasPeer = fan.sys.Obj.$extend(fan.fwt.CanvasPeer);
fan.fogl.GlCanvasPeer.prototype.$ctor = function(self) {}

fan.fogl.GlCanvasPeer.prototype.getCanvas = function()
{
  // short-circuit if not properly layed out
  var size = this.m_size
  if (size.m_w == 0 || size.m_h == 0) return;

  if (this.hasCanvas)
  {
    var div = this.elem;
    var c = div.firstChild;

    // remove old canvas if size is different
    if (c != null && (c.width != size.m_w || c.height != size.m_h))
    {
      div.removeChild(c);
      c = null;
    }

    // create new canvas if null
    if (c == null)
    {
      c = document.createElement("canvas");
      c.width  = size.m_w;
      c.height = size.m_h;
      div.appendChild(c);
    }

    this.initGL(c);

    return c;
  }
  else
  {
    console.log("don't suppert canvas2d");
    return null;
  }
}

fan.fogl.GlCanvasPeer.prototype.initGL = function(canvas)
{
  try
  {
    var gl = canvas.getContext("experimental-webgl");
    this.m_gl = new fan.fogl.WebGlContext();
    this.m_gl.gl = gl;
    //lastGl = gl;

    //self.gl.viewportWidth = canvas.width;
    //self.gl.viewportHeight = canvas.height;
  }
  catch(e){}

  if (!this.m_gl.gl) {
    alert("Could not initialise WebGL, sorry :-(");
  }
}

fan.fogl.GlCanvasPeer.prototype.gl = function(self)
{
  return this.m_gl;
}

fan.fogl.GlCanvasPeer.prototype.sync = function(self)
{
  var c = this.getCanvas();
  if (!c) return;

  if (this.m_gl) self.onGlPaint(this.m_gl);

  // repaint canvas using Canvas.onPaint callback
  var g = new fan.gfx2Imp.Graphics2();
  g.widget = self;
  try
  {
    g.paint(c, self.bounds(), function() { self.onPaint(g); self.onPaint2(g); })
  }
  catch(e)
  {
    //TODO
  }

  fan.fwt.WidgetPeer.prototype.sync.call(this, self);
}

