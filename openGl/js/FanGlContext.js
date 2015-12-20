//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-5-29  Jed Young  Creation
//


fan.fanvasOpenGl.FanGlContext = fan.sys.Obj.$extend(fan.sys.Obj);
fan.fanvasOpenGl.FanGlContext.prototype.$ctor = function(self) {}
fan.fanvasOpenGl.FanGlContext.prototype.gl = null;

fan.fanvasOpenGl.FanGlContext.prototype.$typeof = function() { return fan.fanvasOpenGl.FanGlContext.$type; }

//////////////////////////////////////////////////////////////////////////
// special
//////////////////////////////////////////////////////////////////////////

fan.fanvasOpenGl.FanGlContext.prototype.getContextAttributes = function(){ return this.gl.getContextAttributes(); }
fan.fanvasOpenGl.FanGlContext.prototype.isContextLost = function(){ return this.gl.isContextLost(); }
fan.fanvasOpenGl.FanGlContext.prototype.getSupportedExtensions = function(){ return this.gl.getSupportedExtensions(); }
fan.fanvasOpenGl.FanGlContext.prototype.getExtension = function(name){ return this.gl.getExtension(name); }
//fan.fanvasOpenGl.FanGlContext.prototype.bindTexture = function(target, texture){ this.gl.bindTexture(target.m_val, texture.peer.getValue()); }
fan.fanvasOpenGl.FanGlContext.prototype.bufferDataEmpty = function(target, size, usage){ this.gl.bufferData(target.m_val, size, usage.m_val); }
fan.fanvasOpenGl.FanGlContext.prototype.bufferData = function(target, data, usage){ this.gl.bufferData(target.m_val, data.peer.getValue(), usage.m_val); }
//fan.fanvasOpenGl.FanGlContext.prototype.bufferData = function(target, data, usage){ this.gl.bufferData(target.m_val, data.peer.getValue(), usage.m_val); }
fan.fanvasOpenGl.FanGlContext.prototype.bufferSubData = function(target, offset, data){ this.gl.bufferSubData(target.m_val, offset, data.peer.getValue()); }
//fan.fanvasOpenGl.FanGlContext.prototype.bufferSubData = function(target, offset, data){ this.gl.bufferSubData(target.m_val, offset, data.peer.getValue()); }
fan.fanvasOpenGl.FanGlContext.prototype.checkFramebufferStatus = function(target){ return this.gl.checkFramebufferStatus(target.m_val); }
fan.fanvasOpenGl.FanGlContext.prototype.getActiveAttrib = function(program, index){    var i = this.gl.getActiveAttrib(program.peer.getValue(), index);    var p = fan.fanvasOpenGl.GlActiveInfo.make();    p.peer.setValue(i);    return p;  }
fan.fanvasOpenGl.FanGlContext.prototype.getActiveUniform = function(program, index){    var i = this.gl.getActiveUniform(program.peer.getValue(), index);    var p = fan.fanvasOpenGl.GlActiveInfo.make();    p.peer.setValue(i);    return p;  }
fan.fanvasOpenGl.FanGlContext.prototype.getAttachedShaders = function(program){ return this.gl.getAttachedShaders(program.peer.getValue()); }
fan.fanvasOpenGl.FanGlContext.prototype.getParameter = function(pname){ return this.gl.getParameter(pname.m_val); }
fan.fanvasOpenGl.FanGlContext.prototype.getBufferParameter = function(target, pname){ return this.gl.getBufferParameter(target.m_val, pname.m_val); }
fan.fanvasOpenGl.FanGlContext.prototype.getError = function(){ return this.gl.getError(); }
fan.fanvasOpenGl.FanGlContext.prototype.getFramebufferAttachmentParameter = function(target, attachment, pname){ return this.gl.getFramebufferAttachmentParameter(target.m_val, attachment.m_val, pname.m_val); }
fan.fanvasOpenGl.FanGlContext.prototype.getProgramParameter = function(program, pname){ return this.gl.getProgramParameter(program.peer.getValue(), pname.m_val); }
fan.fanvasOpenGl.FanGlContext.prototype.getProgramInfoLog = function(program){ return this.gl.getProgramInfoLog(program.peer.getValue()); }
fan.fanvasOpenGl.FanGlContext.prototype.getRenderbufferParameter = function(target, pname){ return this.gl.getRenderbufferParameter(target.m_val, pname.m_val); }
fan.fanvasOpenGl.FanGlContext.prototype.getShaderParameter = function(shader, pname){ return this.gl.getShaderParameter(shader.peer.getValue(), pname.m_val); }
fan.fanvasOpenGl.FanGlContext.prototype.getShaderInfoLog = function(shader){ return this.gl.getShaderInfoLog(shader.peer.getValue()); }
fan.fanvasOpenGl.FanGlContext.prototype.getShaderSource = function(shader){ return this.gl.getShaderSource(shader.peer.getValue()); }
fan.fanvasOpenGl.FanGlContext.prototype.getTexParameter = function(target, pname){ return this.gl.getTexParameter(target.m_val, pname.m_val); }
fan.fanvasOpenGl.FanGlContext.prototype.getUniform = function(program, location){ return this.gl.getUniform(program.peer.getValue(), location.peer.getValue()); }
fan.fanvasOpenGl.FanGlContext.prototype.getVertexAttrib = function(index, pname){ return this.gl.getVertexAttrib(index, pname.m_val); }
fan.fanvasOpenGl.FanGlContext.prototype.getVertexAttribOffset = function(index, pname){ return this.gl.getVertexAttribOffset(index, pname.m_val); }
fan.fanvasOpenGl.FanGlContext.prototype.readPixels = function(x, y, width, height, format, type, pixels){ this.gl.readPixels(x, y, width, height, format.m_val, type.m_val, pixels.peer.getValue()); }

fan.fanvasOpenGl.FanGlContext.prototype.texImage2DBuffer = function(target, level, internalformat, width, height, border, format, type, pixels){ this.gl.texImage2D(target.m_val, level, internalformat.m_val, width, height, border, format.m_val, type.m_val, pixels.peer.getValue()); }
fan.fanvasOpenGl.FanGlContext.prototype.texImage2DPixels = function(target, level, internalformat, format, type, pixels){ this.gl.texImage2D(target.m_val, level, internalformat.m_val, format.m_val, type.m_val, pixels); }
fan.fanvasOpenGl.FanGlContext.prototype.texImage2D = function(target, level, internalformat, format, type, image){ this.gl.texImage2D(target.m_val, level, internalformat.m_val, format.m_val, type.m_val, image.peer.image); }
fan.fanvasOpenGl.FanGlContext.prototype.texImage2DCanvas = function(target, level, internalformat, format, type, canvas){ this.gl.texImage2D(target.m_val, level, internalformat.m_val, format.m_val, type.m_val, canvas); }
fan.fanvasOpenGl.FanGlContext.prototype.texImage2DVideo = function(target, level, internalformat, format, type, video){ this.gl.texImage2D(target.m_val, level, internalformat.m_val, format.m_val, type.m_val, video); }
fan.fanvasOpenGl.FanGlContext.prototype.texSubImage2DBuffer = function(target, level, xoffset, yoffset, width, height, format, type, pixels){ this.gl.texSubImage2D(target.m_val, level, xoffset, yoffset, width, height, format.m_val, type.m_val, pixels.peer.getValue()); }
fan.fanvasOpenGl.FanGlContext.prototype.texSubImage2DPixels = function(target, level, xoffset, yoffset, format, type, pixels){ this.gl.texSubImage2D(target.m_val, level, xoffset, yoffset, format.m_val, type.m_val, pixels); }
fan.fanvasOpenGl.FanGlContext.prototype.texSubImage2D = function(target, level, xoffset, yoffset, format, type, image){ this.gl.texSubImage2D(target.m_val, level, xoffset, yoffset, format.m_val, type.m_val, image.peer.image); }
fan.fanvasOpenGl.FanGlContext.prototype.texSubImage2DCanvas = function(target, level, xoffset, yoffset, format, type, canvas){ this.gl.texSubImage2D(target.m_val, level, xoffset, yoffset, format.m_val, type.m_val, canvas); }
fan.fanvasOpenGl.FanGlContext.prototype.texSubImage2DVideo = function(target, level, xoffset, yoffset, format, type, video){ this.gl.texSubImage2D(target.m_val, level, xoffset, yoffset, format.m_val, type.m_val, video); }

fan.fanvasOpenGl.FanGlContext.prototype.uniform1fv = function(location, v){ this.gl.uniform1fv(location.peer.getValue(), v.peer.getValue()); }
//fan.fanvasOpenGl.FanGlContext.prototype.uniform1fv = function(location, v){ this.gl.uniform1fv(location.peer.getValue(), v); }
fan.fanvasOpenGl.FanGlContext.prototype.uniform1iv = function(location, v){ this.gl.uniform1iv(location.peer.getValue(), v.peer.getValue()); }
//fan.fanvasOpenGl.FanGlContext.prototype.uniform1iv = function(location, v){ this.gl.uniform1iv(location.peer.getValue(), v); }
fan.fanvasOpenGl.FanGlContext.prototype.uniform2fv = function(location, v){ this.gl.uniform2fv(location.peer.getValue(), v.peer.getValue()); }
//fan.fanvasOpenGl.FanGlContext.prototype.uniform2fv = function(location, v){ this.gl.uniform2fv(location.peer.getValue(), v); }
fan.fanvasOpenGl.FanGlContext.prototype.uniform2iv = function(location, v){ this.gl.uniform2iv(location.peer.getValue(), v.peer.getValue()); }
//fan.fanvasOpenGl.FanGlContext.prototype.uniform2iv = function(location, v){ this.gl.uniform2iv(location.peer.getValue(), v); }
fan.fanvasOpenGl.FanGlContext.prototype.uniform3fv = function(location, v){ this.gl.uniform3fv(location.peer.getValue(), v.peer.getValue()); }
//fan.fanvasOpenGl.FanGlContext.prototype.uniform3fv = function(location, v){ this.gl.uniform3fv(location.peer.getValue(), v); }
fan.fanvasOpenGl.FanGlContext.prototype.uniform3iv = function(location, v){ this.gl.uniform3iv(location.peer.getValue(), v.peer.getValue()); }
//fan.fanvasOpenGl.FanGlContext.prototype.uniform3iv = function(location, v){ this.gl.uniform3iv(location.peer.getValue(), v); }
fan.fanvasOpenGl.FanGlContext.prototype.uniform4fv = function(location, v){ this.gl.uniform4fv(location.peer.getValue(), v.peer.getValue()); }
//fan.fanvasOpenGl.FanGlContext.prototype.uniform4fv = function(location, v){ this.gl.uniform4fv(location.peer.getValue(), v); }
fan.fanvasOpenGl.FanGlContext.prototype.uniform4iv = function(location, v){ this.gl.uniform4iv(location.peer.getValue(), v.peer.getValue()); }
//fan.fanvasOpenGl.FanGlContext.prototype.uniform4iv = function(location, v){ this.gl.uniform4iv(location.peer.getValue(), v); }
fan.fanvasOpenGl.FanGlContext.prototype.uniformMatrix2fv = function(location, transpose, value){ this.gl.uniformMatrix2fv(location.peer.getValue(), transpose, value.peer.getValue()); }
//fan.fanvasOpenGl.FanGlContext.prototype.uniformMatrix2fv = function(location, transpose, value){ this.gl.uniformMatrix2fv(location.peer.getValue(), transpose, value); }
fan.fanvasOpenGl.FanGlContext.prototype.uniformMatrix3fv = function(location, transpose, value){ this.gl.uniformMatrix3fv(location.peer.getValue(), transpose, value.peer.getValue()); }
//fan.fanvasOpenGl.FanGlContext.prototype.uniformMatrix3fv = function(location, transpose, value){ this.gl.uniformMatrix3fv(location.peer.getValue(), transpose, value); }
fan.fanvasOpenGl.FanGlContext.prototype.uniformMatrix4fv = function(location, transpose, value){ this.gl.uniformMatrix4fv(location.peer.getValue(), transpose, value.peer.getValue()); }
//fan.fanvasOpenGl.FanGlContext.prototype.uniformMatrix4fv = function(location, transpose, value){ this.gl.uniformMatrix4fv(location.peer.getValue(), transpose, value); }
fan.fanvasOpenGl.FanGlContext.prototype.vertexAttrib1fv = function(indx, values){ this.gl.vertexAttrib1fv(indx, values.peer.getValue()); }
//fan.fanvasOpenGl.FanGlContext.prototype.vertexAttrib1fv = function(indx, values){ this.gl.vertexAttrib1fv(indx, values); }
fan.fanvasOpenGl.FanGlContext.prototype.vertexAttrib2fv = function(indx, values){ this.gl.vertexAttrib2fv(indx, values.peer.getValue()); }
//fan.fanvasOpenGl.FanGlContext.prototype.vertexAttrib2fv = function(indx, values){ this.gl.vertexAttrib2fv(indx, values); }
fan.fanvasOpenGl.FanGlContext.prototype.vertexAttrib3fv = function(indx, values){ this.gl.vertexAttrib3fv(indx, values.peer.getValue()); }
//fan.fanvasOpenGl.FanGlContext.prototype.vertexAttrib3fv = function(indx, values){ this.gl.vertexAttrib3fv(indx, values); }
fan.fanvasOpenGl.FanGlContext.prototype.vertexAttrib4fv = function(indx, values){ this.gl.vertexAttrib4fv(indx, values.peer.getValue()); }
//fan.fanvasOpenGl.FanGlContext.prototype.vertexAttrib4fv = function(indx, values){ this.gl.vertexAttrib4fv(indx, values); }

//////////////////////////////////////////////////////////////////////////
// manual
//////////////////////////////////////////////////////////////////////////

fan.fanvasOpenGl.FanGlContext.prototype.bindTexture = function(target, texture)
{
  if (texture)
    this.gl.bindTexture(target.m_val, texture.peer.getValue());
  else
    this.gl.bindTexture(target.m_val, null);
}

//////////////////////////////////////////////////////////////////////////
// Gen
//////////////////////////////////////////////////////////////////////////

fan.fanvasOpenGl.FanGlContext.prototype.activeTexture = function(texture){ this.gl.activeTexture(texture.m_val); }
fan.fanvasOpenGl.FanGlContext.prototype.attachShader = function(program, shader){ this.gl.attachShader(program.peer.getValue(), shader.peer.getValue()); }
fan.fanvasOpenGl.FanGlContext.prototype.bindAttribLocation = function(program, index, name){ this.gl.bindAttribLocation(program.peer.getValue(), index, name); }
fan.fanvasOpenGl.FanGlContext.prototype.bindBuffer = function(target, buffer){ this.gl.bindBuffer(target.m_val, buffer.peer.getValue()); }
fan.fanvasOpenGl.FanGlContext.prototype.bindFramebuffer = function(target, framebuffer){ this.gl.bindFramebuffer(target.m_val, framebuffer.peer.getValue()); }
fan.fanvasOpenGl.FanGlContext.prototype.bindRenderbuffer = function(target, renderbuffer){ this.gl.bindRenderbuffer(target.m_val, renderbuffer.peer.getValue()); }
fan.fanvasOpenGl.FanGlContext.prototype.blendColor = function(red, green, blue, alpha){ this.gl.blendColor(red, green, blue, alpha); }
fan.fanvasOpenGl.FanGlContext.prototype.blendEquation = function(mode){ this.gl.blendEquation(mode.m_val); }
fan.fanvasOpenGl.FanGlContext.prototype.blendEquationSeparate = function(modeRGB, modeAlpha){ this.gl.blendEquationSeparate(modeRGB.m_val, modeAlpha.m_val); }
fan.fanvasOpenGl.FanGlContext.prototype.blendFunc = function(sfactor, dfactor){ this.gl.blendFunc(sfactor.m_val, dfactor.m_val); }
fan.fanvasOpenGl.FanGlContext.prototype.blendFuncSeparate = function(srcRGB, dstRGB, srcAlpha, dstAlpha){ this.gl.blendFuncSeparate(srcRGB.m_val, dstRGB.m_val, srcAlpha.m_val, dstAlpha.m_val); }
fan.fanvasOpenGl.FanGlContext.prototype.clear = function(mask){ this.gl.clear(mask.m_val); }
fan.fanvasOpenGl.FanGlContext.prototype.clearColor = function(red, green, blue, alpha){ this.gl.clearColor(red, green, blue, alpha); }
fan.fanvasOpenGl.FanGlContext.prototype.clearDepth = function(depth){ this.gl.clearDepth(depth); }
fan.fanvasOpenGl.FanGlContext.prototype.clearStencil = function(s){ this.gl.clearStencil(s); }
fan.fanvasOpenGl.FanGlContext.prototype.colorMask = function(red, green, blue, alpha){ this.gl.colorMask(red, green, blue, alpha); }
fan.fanvasOpenGl.FanGlContext.prototype.compileShader = function(shader){ this.gl.compileShader(shader.peer.getValue()); }
fan.fanvasOpenGl.FanGlContext.prototype.copyTexImage2D = function(target, level, internalformat, x, y, width, height, border){ this.gl.copyTexImage2D(target.m_val, level, internalformat.m_val, x, y, width, height, border); }
fan.fanvasOpenGl.FanGlContext.prototype.copyTexSubImage2D = function(target, level, xoffset, yoffset, x, y, width, height){ this.gl.copyTexSubImage2D(target.m_val, level, xoffset, yoffset, x, y, width, height); }
fan.fanvasOpenGl.FanGlContext.prototype.createBuffer = function(){    var i = this.gl.createBuffer();    var p = fan.fanvasOpenGl.GlBuffer.make();    p.peer.setValue(i);    return p;  }
fan.fanvasOpenGl.FanGlContext.prototype.createFramebuffer = function(){    var i = this.gl.createFramebuffer();    var p = fan.fanvasOpenGl.GlFramebuffer.make();    p.peer.setValue(i);    return p;  }
fan.fanvasOpenGl.FanGlContext.prototype.createProgram = function(){    var i = this.gl.createProgram();    var p = fan.fanvasOpenGl.GlProgram.make();    p.peer.setValue(i);    return p;  }
fan.fanvasOpenGl.FanGlContext.prototype.createRenderbuffer = function(){    var i = this.gl.createRenderbuffer();    var p = fan.fanvasOpenGl.GlRenderbuffer.make();    p.peer.setValue(i);    return p;  }
fan.fanvasOpenGl.FanGlContext.prototype.createShader = function(type){    var i = this.gl.createShader(type.m_val);    var p = fan.fanvasOpenGl.GlShader.make();    p.peer.setValue(i);    return p;  }
fan.fanvasOpenGl.FanGlContext.prototype.createTexture = function(){    var i = this.gl.createTexture();    var p = fan.fanvasOpenGl.GlTexture.make();    p.peer.setValue(i);    return p;  }
fan.fanvasOpenGl.FanGlContext.prototype.cullFace = function(mode){ this.gl.cullFace(mode.m_val); }
fan.fanvasOpenGl.FanGlContext.prototype.deleteBuffer = function(buffer){ this.gl.deleteBuffer(buffer.peer.getValue()); }
fan.fanvasOpenGl.FanGlContext.prototype.deleteFramebuffer = function(framebuffer){ this.gl.deleteFramebuffer(framebuffer.peer.getValue()); }
fan.fanvasOpenGl.FanGlContext.prototype.deleteProgram = function(program){ this.gl.deleteProgram(program.peer.getValue()); }
fan.fanvasOpenGl.FanGlContext.prototype.deleteRenderbuffer = function(renderbuffer){ this.gl.deleteRenderbuffer(renderbuffer.peer.getValue()); }
fan.fanvasOpenGl.FanGlContext.prototype.deleteShader = function(shader){ this.gl.deleteShader(shader.peer.getValue()); }
fan.fanvasOpenGl.FanGlContext.prototype.deleteTexture = function(texture){ this.gl.deleteTexture(texture.peer.getValue()); }
fan.fanvasOpenGl.FanGlContext.prototype.depthFunc = function(func){ this.gl.depthFunc(func.m_val); }
fan.fanvasOpenGl.FanGlContext.prototype.depthMask = function(flag){ this.gl.depthMask(flag); }
fan.fanvasOpenGl.FanGlContext.prototype.depthRange = function(zNear, zFar){ this.gl.depthRange(zNear, zFar); }
fan.fanvasOpenGl.FanGlContext.prototype.detachShader = function(program, shader){ this.gl.detachShader(program.peer.getValue(), shader.peer.getValue()); }
fan.fanvasOpenGl.FanGlContext.prototype.disable = function(cap){ this.gl.disable(cap.m_val); }
fan.fanvasOpenGl.FanGlContext.prototype.disableVertexAttribArray = function(index){ this.gl.disableVertexAttribArray(index); }
fan.fanvasOpenGl.FanGlContext.prototype.drawArrays = function(mode, first, count){ this.gl.drawArrays(mode.m_val, first, count); }
fan.fanvasOpenGl.FanGlContext.prototype.drawElements = function(mode, count, type, offset){ this.gl.drawElements(mode.m_val, count, type.m_val, offset); }
fan.fanvasOpenGl.FanGlContext.prototype.enable = function(cap){ this.gl.enable(cap.m_val); }
fan.fanvasOpenGl.FanGlContext.prototype.enableVertexAttribArray = function(index){ this.gl.enableVertexAttribArray(index); }
fan.fanvasOpenGl.FanGlContext.prototype.finish = function(){ this.gl.finish(); }
fan.fanvasOpenGl.FanGlContext.prototype.flush = function(){ this.gl.flush(); }
fan.fanvasOpenGl.FanGlContext.prototype.framebufferRenderbuffer = function(target, attachment, renderbuffertarget, renderbuffer){ this.gl.framebufferRenderbuffer(target.m_val, attachment.m_val, renderbuffertarget.m_val, renderbuffer.peer.getValue()); }
fan.fanvasOpenGl.FanGlContext.prototype.framebufferTexture2D = function(target, attachment, textarget, texture, level){ this.gl.framebufferTexture2D(target.m_val, attachment.m_val, textarget.m_val, texture.peer.getValue(), level); }
fan.fanvasOpenGl.FanGlContext.prototype.frontFace = function(mode){ this.gl.frontFace(mode.m_val); }
fan.fanvasOpenGl.FanGlContext.prototype.generateMipmap = function(target){ this.gl.generateMipmap(target.m_val); }
fan.fanvasOpenGl.FanGlContext.prototype.getAttribLocation = function(program, name){ return this.gl.getAttribLocation(program.peer.getValue(), name); }
fan.fanvasOpenGl.FanGlContext.prototype.getUniformLocation = function(program, name){    var i = this.gl.getUniformLocation(program.peer.getValue(), name);    var p = fan.fanvasOpenGl.GlUniformLocation.make();    p.peer.setValue(i);    return p;  }
fan.fanvasOpenGl.FanGlContext.prototype.hint = function(target, mode){ this.gl.hint(target.m_val, mode.m_val); }
fan.fanvasOpenGl.FanGlContext.prototype.isBuffer = function(buffer){ return this.gl.isBuffer(buffer.peer.getValue()); }
fan.fanvasOpenGl.FanGlContext.prototype.isEnabled = function(cap){ return this.gl.isEnabled(cap.m_val); }
fan.fanvasOpenGl.FanGlContext.prototype.isFramebuffer = function(framebuffer){ return this.gl.isFramebuffer(framebuffer.peer.getValue()); }
fan.fanvasOpenGl.FanGlContext.prototype.isProgram = function(program){ return this.gl.isProgram(program.peer.getValue()); }
fan.fanvasOpenGl.FanGlContext.prototype.isRenderbuffer = function(renderbuffer){ return this.gl.isRenderbuffer(renderbuffer.peer.getValue()); }
fan.fanvasOpenGl.FanGlContext.prototype.isShader = function(shader){ return this.gl.isShader(shader.peer.getValue()); }
fan.fanvasOpenGl.FanGlContext.prototype.isTexture = function(texture){ return this.gl.isTexture(texture.peer.getValue()); }
fan.fanvasOpenGl.FanGlContext.prototype.lineWidth = function(width){ this.gl.lineWidth(width); }
fan.fanvasOpenGl.FanGlContext.prototype.linkProgram = function(program){ this.gl.linkProgram(program.peer.getValue()); }
fan.fanvasOpenGl.FanGlContext.prototype.pixelStorei = function(pname, param){ this.gl.pixelStorei(pname.m_val, param); }
fan.fanvasOpenGl.FanGlContext.prototype.polygonOffset = function(factor, units){ this.gl.polygonOffset(factor, units); }
fan.fanvasOpenGl.FanGlContext.prototype.renderbufferStorage = function(target, internalformat, width, height){ this.gl.renderbufferStorage(target.m_val, internalformat.m_val, width, height); }
fan.fanvasOpenGl.FanGlContext.prototype.sampleCoverage = function(value, invert){ this.gl.sampleCoverage(value, invert); }
fan.fanvasOpenGl.FanGlContext.prototype.scissor = function(x, y, width, height){ this.gl.scissor(x, y, width, height); }
fan.fanvasOpenGl.FanGlContext.prototype.shaderSource = function(shader, source){ this.gl.shaderSource(shader.peer.getValue(), source); }
fan.fanvasOpenGl.FanGlContext.prototype.stencilFunc = function(func, ref, mask){ this.gl.stencilFunc(func.m_val, ref, mask); }
fan.fanvasOpenGl.FanGlContext.prototype.stencilFuncSeparate = function(face, func, ref, mask){ this.gl.stencilFuncSeparate(face.m_val, func.m_val, ref, mask); }
fan.fanvasOpenGl.FanGlContext.prototype.stencilMask = function(mask){ this.gl.stencilMask(mask); }
fan.fanvasOpenGl.FanGlContext.prototype.stencilMaskSeparate = function(face, mask){ this.gl.stencilMaskSeparate(face.m_val, mask); }
fan.fanvasOpenGl.FanGlContext.prototype.stencilOp = function(fail, zfail, zpass){ this.gl.stencilOp(fail.m_val, zfail.m_val, zpass.m_val); }
fan.fanvasOpenGl.FanGlContext.prototype.stencilOpSeparate = function(face, fail, zfail, zpass){ this.gl.stencilOpSeparate(face.m_val, fail.m_val, zfail.m_val, zpass.m_val); }
fan.fanvasOpenGl.FanGlContext.prototype.texParameterf = function(target, pname, param){ this.gl.texParameterf(target.m_val, pname.m_val, param); }
fan.fanvasOpenGl.FanGlContext.prototype.texParameteri = function(target, pname, param){ this.gl.texParameteri(target.m_val, pname.m_val, param); }
fan.fanvasOpenGl.FanGlContext.prototype.uniform1f = function(location, x){ this.gl.uniform1f(location.peer.getValue(), x); }
fan.fanvasOpenGl.FanGlContext.prototype.uniform1i = function(location, x){ this.gl.uniform1i(location.peer.getValue(), x); }
fan.fanvasOpenGl.FanGlContext.prototype.uniform2f = function(location, x, y){ this.gl.uniform2f(location.peer.getValue(), x, y); }
fan.fanvasOpenGl.FanGlContext.prototype.uniform2i = function(location, x, y){ this.gl.uniform2i(location.peer.getValue(), x, y); }
fan.fanvasOpenGl.FanGlContext.prototype.uniform3f = function(location, x, y, z){ this.gl.uniform3f(location.peer.getValue(), x, y, z); }
fan.fanvasOpenGl.FanGlContext.prototype.uniform3i = function(location, x, y, z){ this.gl.uniform3i(location.peer.getValue(), x, y, z); }
fan.fanvasOpenGl.FanGlContext.prototype.uniform4f = function(location, x, y, z, w){ this.gl.uniform4f(location.peer.getValue(), x, y, z, w); }
fan.fanvasOpenGl.FanGlContext.prototype.uniform4i = function(location, x, y, z, w){ this.gl.uniform4i(location.peer.getValue(), x, y, z, w); }
fan.fanvasOpenGl.FanGlContext.prototype.useProgram = function(program){ this.gl.useProgram(program.peer.getValue()); }
fan.fanvasOpenGl.FanGlContext.prototype.validateProgram = function(program){ this.gl.validateProgram(program.peer.getValue()); }
fan.fanvasOpenGl.FanGlContext.prototype.vertexAttrib1f = function(indx, x){ this.gl.vertexAttrib1f(indx, x); }
fan.fanvasOpenGl.FanGlContext.prototype.vertexAttrib2f = function(indx, x, y){ this.gl.vertexAttrib2f(indx, x, y); }
fan.fanvasOpenGl.FanGlContext.prototype.vertexAttrib3f = function(indx, x, y, z){ this.gl.vertexAttrib3f(indx, x, y, z); }
fan.fanvasOpenGl.FanGlContext.prototype.vertexAttrib4f = function(indx, x, y, z, w){ this.gl.vertexAttrib4f(indx, x, y, z, w); }
fan.fanvasOpenGl.FanGlContext.prototype.vertexAttribPointer = function(indx, size, type, normalized, stride, offset){ this.gl.vertexAttribPointer(indx, size, type.m_val, normalized, stride, offset); }
fan.fanvasOpenGl.FanGlContext.prototype.viewport = function(x, y, width, height){ this.gl.viewport(x, y, width, height); }