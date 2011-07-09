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

//////////////////////////////////////////////////////////////////////////
// common
//////////////////////////////////////////////////////////////////////////

fan.fogl.GlContextPeer.prototype.clearColor = function(self, r, g, b, a)
{
  this.gl.clearColor(r, g, b, a);
}

fan.fogl.GlContextPeer.prototype.enable = function(self, cap)
{
  this.gl.enable(cap.m_val);
}

fan.fogl.GlContextPeer.prototype.viewport = function(self, x, y, width, height)
{
  this.gl.viewport(x, y, width, height);
}

fan.fogl.GlContextPeer.prototype.clear = function(self, mask)
{
  this.gl.clear(mask.m_val);
}

fan.fogl.GlContextPeer.prototype.vertexAttribPointer = function(self, index, size, type, normalized, stride, offset)
{
  this.gl.vertexAttribPointer(index, size, type.m_val, normalized, stride, offset);
}

fan.fogl.GlContextPeer.prototype.drawArrays = function(self, mode, first, count)
{
  this.gl.drawArrays(mode.m_val, first, count);
}

//////////////////////////////////////////////////////////////////////////
// buffer
//////////////////////////////////////////////////////////////////////////

fan.fogl.GlContextPeer.prototype.createBuffer = function(self)
{
  var buf = fan.fogl.Buffer.make();
  buf.peer.setValue(this.gl.createBuffer());
  return buf;
}

fan.fogl.GlContextPeer.prototype.bindBuffer = function(self, target, buffer)
{
  this.gl.bindBuffer(target.m_val, buffer.peer.getValue());
}

fan.fogl.GlContextPeer.prototype.bufferData = function(self, target, data, usage)
{
  this.gl.bufferData(target.m_val, data.getData(), usage.m_val);
}

//////////////////////////////////////////////////////////////////////////
// shader
//////////////////////////////////////////////////////////////////////////

fan.fogl.GlContextPeer.prototype.createShader = function(self, type)
{
  var i = this.gl.createShader(type.m_val);
  var shader = fan.fogl.Shader.make();
  shader.peer.setValue(i);
  return shader;
}

fan.fogl.GlContextPeer.prototype.shaderSource = function(self, shader, source)
{
  this.gl.shaderSource(shader.peer.getValue(), source);
}

fan.fogl.GlContextPeer.prototype.compileShader = function(self, shader)
{
  this.gl.compileShader(shader.peer.getValue());
}

fan.fogl.GlContextPeer.prototype.getShaderParameter = function(self, shader, pname)
{
  return this.gl.getShaderParameter(shader.peer.getValue(), pname.m_val);
}

fan.fogl.GlContextPeer.prototype.getShaderInfoLog = function(self, shader)
{
  return this.gl.getShaderInfoLog(shader.peer.getValue());
}

fan.fogl.GlContextPeer.prototype.createProgram = function(self)
{
  var i = this.gl.createProgram();
  var program = fan.fogl.Program.make();
  program.peer.setValue(i);
  return program;
}

fan.fogl.GlContextPeer.prototype.attachShader = function(self, program, shader)
{
  this.gl.attachShader(program.peer.getValue(), shader.peer.getValue());
}

fan.fogl.GlContextPeer.prototype.linkProgram = function(self, program)
{
  this.gl.linkProgram(program.peer.getValue());
}

fan.fogl.GlContextPeer.prototype.getProgramParameter = function(self, program, pname)
{
  return this.gl.getProgramParameter(program.peer.getValue(), pname.m_val);
}

fan.fogl.GlContextPeer.prototype.validateProgram = function(self, program)
{
  this.gl.validateProgram(program.peer.getValue());
}

fan.fogl.GlContextPeer.prototype.useProgram = function(self, program)
{
  this.gl.useProgram(program.peer.getValue());
}

//////////////////////////////////////////////////////////////////////////
// uniform
//////////////////////////////////////////////////////////////////////////

fan.fogl.GlContextPeer.prototype.getUniformLocation = function(self, program, name)
{
  var i = this.gl.getUniformLocation(program.peer.getValue(), name);
  var location = fan.fogl.UniformLocation.make();
  location.peer.setValue(i);
  return location;
}

fan.fogl.GlContextPeer.prototype.uniformMatrix4fv = function(self, location, transpose, value)
{
  this.gl.uniformMatrix4fv(location.peer.getValue(), transpose, value.getData());
}

//////////////////////////////////////////////////////////////////////////
// vertexShader
//////////////////////////////////////////////////////////////////////////

fan.fogl.GlContextPeer.prototype.getAttribLocation = function(self, program, name)
{
  return this.gl.getAttribLocation(program.peer.getValue(), name);
}

fan.fogl.GlContextPeer.prototype.enableVertexAttribArray = function(self, index)
{
  this.gl.enableVertexAttribArray(index);
}


