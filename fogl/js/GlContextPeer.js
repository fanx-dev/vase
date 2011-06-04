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
  this.gl.enable(cap.val);
}

fan.fogl.GlContextPeer.prototype.viewport = function(self, x, y, width, height)
{
  this.gl.viewport(x, y, width, height);
}

fan.fogl.GlContextPeer.prototype.clear = function(self, mask)
{
  this.gl.clear(mask.val);
}

fan.fogl.GlContextPeer.prototype.vertexAttribPointer = function(self, index, size, type, normalized, stride, offset)
{
  this.gl.vertexAttribPointer(indx, size, type.val, normalized, stride, offset);
}

fan.fogl.GlContextPeer.prototype.drawArrays = function(self, mode, first, count)
{
  this.gl.drawArrays(mode.val, first, count);
}

//////////////////////////////////////////////////////////////////////////
// buffer
//////////////////////////////////////////////////////////////////////////

fan.fogl.GlContextPeer.prototype.createBuffer = function(self)
{
  var buf = Buffer.make();
  buf.peer.setValue(this.gl.createBuffer());
  return buf;
}

fan.fogl.GlContextPeer.prototype.bindBuffer = function(self, target, buffer)
{
  this.gl.bindBuffer(target.val, buffer.peer.getValue());
}

fan.fogl.GlContextPeer.prototype.bufferData = function(self, target, data, usage)
{
  this.gl.bufferData(target.val, data.getData(), usage.val);
}

//////////////////////////////////////////////////////////////////////////
// shader
//////////////////////////////////////////////////////////////////////////

fan.fogl.GlContextPeer.prototype.createShader(self, type)
{
  var i = this.gl.createShader(type.peer.getValue());
  var shader = Shader.make();
  shader.peer.setValue(i);
  return shader;
}

fan.fogl.GlContextPeer.prototype.shaderSource(self, shader, source)
{
  this.gl.shaderSource(shader.peer.getValue(), source);
}

fan.fogl.GlContextPeer.prototype.compileShader(self, shader)
{
  this.gl.compileShader(shader.peer.getValue());
}

fan.fogl.GlContextPeer.prototype.getShaderParameter(self, shader, pname)
{
  return this.gl.getShaderParameter(shader.peer.getValue(), pname.val);
}

fan.fogl.GlContextPeer.prototype.getShaderInfoLog(self, shader)
{
  return this.gl.getShaderInfoLog(shader.peer.getValue());
}

fan.fogl.GlContextPeer.prototype.createProgram(self)
{
  var i = this.gl.createProgram();
  var program = Program.make();
  program.peer.setValue(i);
  return program;
}

fan.fogl.GlContextPeer.prototype.attachShader(self, program, shader)
{
  this.gl.attachShader(program.peer.getValue(), shader.peer.getValue());
}

fan.fogl.GlContextPeer.prototype.linkProgram(self, program)
{
  this.gl.linkProgram(program.peer.getValue());
}

fan.fogl.GlContextPeer.prototype.getProgramParameter(self, program, pname)
{
  return this.gl.getProgramParameter(program.peer.getValue(), pname.val);
}

fan.fogl.GlContextPeer.prototype.validateProgram(self, program)
{
  this.gl.validateProgram(program.peer.getValue());
}

fan.fogl.GlContextPeer.prototype.useProgram(self, program)
{
  this.gl.useProgram(program.peer.getValue());
}

//////////////////////////////////////////////////////////////////////////
// uniform
//////////////////////////////////////////////////////////////////////////

fan.fogl.GlContextPeer.prototype.getUniformLocation(self, program, name)
{
  var i = this.gl.getUniformLocation(program.peer.getValue(), name);
  var location = UniformLocation.make();
  location.peer.serValue(i);
  return location;
}

fan.fogl.GlContextPeer.prototype.uniformMatrix4fv(self, location, transpose, value)
{
  this.gl.uniformMatrix4fv(location.peer.getValue(), transpose, value.getData());
}

//////////////////////////////////////////////////////////////////////////
// vertexShader
//////////////////////////////////////////////////////////////////////////

fan.fogl.GlContextPeer.prototype.getAttribLocation(self, program, name)
{
  this.gl.getAttribLocation(program.peer.getValue(), name);
}

fan.fogl.GlContextPeer.prototype.enableVertexAttribArray(Int index)
{
  this.gl.enableVertexAttribArray(index);
}


