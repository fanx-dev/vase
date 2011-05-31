//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-5-29  Jed Young  Creation
//


fan.fogl.GlContextPeer = fan.sys.Obj.$extend(fan.sys.Obj);
fan.fogl.GlContextPeer.prototype.$ctor = function(self) {}
fan.fogl.GlContextPeer.prototype.gl = null;

fan.fogl.GlContextPeer.prototype.clearColor = function(self, r, g, b, a)
{
  this.gl.clearColor(r, g, b, a);
}

fan.fogl.GlContextPeer.prototype.enable = function(self, e)
{
  this.gl.enable(e.peer.m_val);
}

//////////////////////////////////////////////////////////////////////////
// buffer
//////////////////////////////////////////////////////////////////////////

fan.fogl.GlContextPeer.prototype.createBuffer = function(self)
{
  buf = Buffer.make();
  buf.peer.m_val = this.gl.createBuffer();
  return buf;
}

fan.fogl.GlContextPeer.prototype.bindBuffer = function(self, e, buf)
{
  this.gl.bindBuffer(e.peer.m_val, buf.peer.m_val);
}

fan.fogl.GlContextPeer.prototype.bufferData = function(self, e, array, e)
{
  this.gl.bufferData(e.peer.m_val, array.peer.m_val, e.peer.m_val);
}

fan.fogl.GlContextPeer.prototype.viewport = function(self, x, y, width, height)
{
  this.gl.viewport(x, y, width, height);
}

fan.fogl.GlContextPeer.prototype.clear = function(self, e)
{
  this.gl.clear(e.peer.m_val);
}

fan.fogl.GlContextPeer.prototype.vertexAttribPointer = function(self, index, size, type, normalized, stride, offset)
{
  this.gl.vertexAttribPointer(indx, size, type.val, normalized, stride, offset);
}

fan.fogl.GlContextPeer.prototype.drawArrays = function(self, mode, first, count)
{
  this.gl.drawArrays(mode.peer.m_val, first, count);
}