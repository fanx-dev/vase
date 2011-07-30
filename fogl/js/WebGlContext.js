//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-5-29  Jed Young  Creation
//


fan.fogl.WebGlContext = fan.sys.Obj.$extend(fan.sys.Obj);
fan.fogl.WebGlContext.prototype.$ctor = function(self) {}
fan.fogl.WebGlContext.prototype.gl = null;

//////////////////////////////////////////////////////////////////////////
// common
//////////////////////////////////////////////////////////////////////////

fan.fogl.WebGlContext.prototype.clearColor = function(r, g, b, a)
{
  this.gl.clearColor(r, g, b, a);
}

fan.fogl.WebGlContext.prototype.enable = function(cap)
{
  this.gl.enable(cap.m_val);
}

fan.fogl.WebGlContext.prototype.viewport = function(x, y, width, height)
{
  this.gl.viewport(x, y, width, height);
}

fan.fogl.WebGlContext.prototype.clear = function(mask)
{
  this.gl.clear(mask.m_val);
}

fan.fogl.WebGlContext.prototype.vertexAttribPointer = function(index, size, type, normalized, stride, offset)
{
  this.gl.vertexAttribPointer(index, size, type.m_val, normalized, stride, offset);
}

fan.fogl.WebGlContext.prototype.drawArrays = function(mode, first, count)
{
  this.gl.drawArrays(mode.m_val, first, count);
}

fan.fogl.WebGlContext.prototype.drawElements = function(mode, count, type, offset)
{
  this.gl.drawElements(mode.m_val, count, type.m_val, offset);
}

//////////////////////////////////////////////////////////////////////////
// buffer
//////////////////////////////////////////////////////////////////////////

fan.fogl.WebGlContext.prototype.createBuffer = function()
{
  var buf = fan.fogl.Buffer.make();
  buf.peer.setValue(this.gl.createBuffer());
  return buf;
}

fan.fogl.WebGlContext.prototype.bindBuffer = function(target, buffer)
{
  this.gl.bindBuffer(target.m_val, buffer.peer.getValue());
}

fan.fogl.WebGlContext.prototype.bufferData = function(target, data, usage)
{
  this.gl.bufferData(target.m_val, data.peer.getValue(), usage.m_val);
}

//////////////////////////////////////////////////////////////////////////
// shader
//////////////////////////////////////////////////////////////////////////

fan.fogl.WebGlContext.prototype.createShader = function(type)
{
  var i = this.gl.createShader(type.m_val);
  var shader = fan.fogl.Shader.make();
  shader.peer.setValue(i);
  return shader;
}

fan.fogl.WebGlContext.prototype.shaderSource = function(shader, source)
{
  this.gl.shaderSource(shader.peer.getValue(), source);
}

fan.fogl.WebGlContext.prototype.compileShader = function(shader)
{
  this.gl.compileShader(shader.peer.getValue());
}

fan.fogl.WebGlContext.prototype.getShaderParameter = function(shader, pname)
{
  return this.gl.getShaderParameter(shader.peer.getValue(), pname.m_val);
}

fan.fogl.WebGlContext.prototype.getShaderInfoLog = function(shader)
{
  return this.gl.getShaderInfoLog(shader.peer.getValue());
}

fan.fogl.WebGlContext.prototype.createProgram = function()
{
  var i = this.gl.createProgram();
  var program = fan.fogl.Program.make();
  program.peer.setValue(i);
  return program;
}

fan.fogl.WebGlContext.prototype.attachShader = function(program, shader)
{
  this.gl.attachShader(program.peer.getValue(), shader.peer.getValue());
}

fan.fogl.WebGlContext.prototype.linkProgram = function(program)
{
  this.gl.linkProgram(program.peer.getValue());
}

fan.fogl.WebGlContext.prototype.getProgramParameter = function(program, pname)
{
  return this.gl.getProgramParameter(program.peer.getValue(), pname.m_val);
}

fan.fogl.WebGlContext.prototype.validateProgram = function(program)
{
  this.gl.validateProgram(program.peer.getValue());
}

fan.fogl.WebGlContext.prototype.useProgram = function(program)
{
  this.gl.useProgram(program.peer.getValue());
}

//////////////////////////////////////////////////////////////////////////
// uniform
//////////////////////////////////////////////////////////////////////////

fan.fogl.WebGlContext.prototype.getUniformLocation = function(program, name)
{
  var i = this.gl.getUniformLocation(program.peer.getValue(), name);
  var location = fan.fogl.UniformLocation.make();
  location.peer.setValue(i);
  return location;
}

fan.fogl.WebGlContext.prototype.uniformMatrix4fv = function(location, transpose, value)
{
  this.gl.uniformMatrix4fv(location.peer.getValue(), transpose, value.peer.getValue());
}

fan.fogl.WebGlContext.prototype.uniform1i = function(location, x)
{
  this.gl.uniform1i(location.peer.getValue(), x);
}

//////////////////////////////////////////////////////////////////////////
// vertexShader
//////////////////////////////////////////////////////////////////////////

fan.fogl.WebGlContext.prototype.getAttribLocation = function(program, name)
{
  return this.gl.getAttribLocation(program.peer.getValue(), name);
}

fan.fogl.WebGlContext.prototype.enableVertexAttribArray = function(index)
{
  this.gl.enableVertexAttribArray(index);
}

//////////////////////////////////////////////////////////////////////////
// Texture
//////////////////////////////////////////////////////////////////////////

fan.fogl.WebGlContext.prototype.createTexture = function()
{
  var i = this.gl.createTexture();
  var tex = fan.fogl.Texture.make();
  tex.peer.setValue(i);
  return tex;
}

fan.fogl.WebGlContext.prototype.bindTexture = function(target, texture)
{
  if (texture)
    this.gl.bindTexture(target.m_val, texture.peer.getValue());
  else
    this.gl.bindTexture(target.m_val, null);
}
fan.fogl.WebGlContext.prototype.pixelStorei = function(pname, param)
{
  this.gl.pixelStorei(pname.m_val, param);
}
fan.fogl.WebGlContext.prototype.texImage2D = function(target, level, internalformat,
                                                      format, type, image)
{
  console.log(image);
  this.gl.texImage2D(target.m_val, level, internalformat.m_val, format.m_val, type.m_val, image.peer.image);
}

fan.fogl.WebGlContext.prototype.texImage2DBuffer = function(target, level, internalformat, width, height, border,
                         format, type, pixels)
{
  this.gl.texImage2D(target.m_val, level, internalformat.m_val, width, height, border, format.m_val, type.m_val, pixels);
}

fan.fogl.WebGlContext.prototype.texParameterf = function(target, pname, param)
{
  this.gl.texParameterf(target.m_val, pname.m_val, param);
}
fan.fogl.WebGlContext.prototype.texParameteri = function(target, pname, param)
{
  this.gl.texParameteri(target.m_val, pname.m_val, param);
}
fan.fogl.WebGlContext.prototype.activeTexture = function(texture)
{
  this.gl.activeTexture(texture.m_val);
}