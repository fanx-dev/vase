//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-5-29  Jed Young  Creation
//

@Js
mixin GlContext
{

//////////////////////////////////////////////////////////////////////////
// Common
//////////////////////////////////////////////////////////////////////////

  abstract Void clearColor(Float red, Float green, Float blue, Float alpha)

  abstract Void enable(GlEnum cap)

  abstract Void viewport(Int x, Int y, Int width, Int height)

  abstract Void clear(GlEnum mask)

  abstract Void vertexAttribPointer(Int indx, Int size, GlEnum type, Bool normalized, Int stride, Int offset)

  abstract Void drawArrays(GlEnum mode, Int first, Int count)
  abstract Void drawElements(GlEnum mode, Int count, GlEnum type, Int offset)

//////////////////////////////////////////////////////////////////////////
// Buffer
//////////////////////////////////////////////////////////////////////////

  abstract Buffer createBuffer()
  abstract Void bindBuffer(GlEnum target, Buffer buffer)
  abstract Void bufferData(GlEnum target, ArrayBuffer data, GlEnum usage)


//////////////////////////////////////////////////////////////////////////
// Shader
//////////////////////////////////////////////////////////////////////////

  abstract Shader createShader(GlEnum type)
  abstract Void shaderSource(Shader shader, Str source)
  abstract Void compileShader(Shader shader)
  abstract Bool getShaderParameter(Shader shader, GlEnum pname)
  abstract Str getShaderInfoLog(Shader shader)

  abstract Program createProgram()
  abstract Void attachShader(Program program, Shader shader)
  abstract Void linkProgram(Program program)
  abstract Bool getProgramParameter(Program program, GlEnum pname)
  abstract Void validateProgram(Program program);
  abstract Void useProgram(Program program)

//////////////////////////////////////////////////////////////////////////
// Uniform
//////////////////////////////////////////////////////////////////////////

  abstract UniformLocation getUniformLocation(Program program, Str name)
  abstract Void uniformMatrix4fv(UniformLocation location, Bool transpose, ArrayBuffer value)
  abstract Void uniform1i(UniformLocation location, Int x)

//////////////////////////////////////////////////////////////////////////
// VertexShader
//////////////////////////////////////////////////////////////////////////

  abstract Int getAttribLocation(Program program, Str name)
  abstract Void enableVertexAttribArray(Int index)

//////////////////////////////////////////////////////////////////////////
// Texture
//////////////////////////////////////////////////////////////////////////

  abstract Texture createTexture()
  abstract Void bindTexture(GlEnum target, Texture? texture)
  abstract Void pixelStorei(GlEnum pname, Int param)
  abstract Void texImage2D(GlEnum target, Int level, GlEnum internalformat,
                           GlEnum format, GlEnum type, Image image)
  abstract Void texImage2DBuffer(GlEnum target, Int level, GlEnum internalformat, Int width, Int height, Int border,
                           GlEnum format, GlEnum type, ArrayBuffer pixels)
  abstract Void texParameterf(GlEnum target, GlEnum pname, Float param)
  abstract Void texParameteri(GlEnum target, GlEnum pname, Int param)
  abstract Void activeTexture(GlEnum texture)


//////////////////////////////////////////////////////////////////////////
// unimplemented methods
//////////////////////////////////////////////////////////////////////////

//
//readonly attribute HTMLCanvasElement canvas;
//readonly attribute GLsizei drawingBufferWidth;
//readonly attribute GLsizei drawingBufferHeight;
//
//WebGLContextAttributes getContextAttributes();
//boolean isContextLost();
//
//DOMString[ ] getSupportedExtensions();
//object getExtension(DOMString name);
//
//void bindAttribLocation(WebGLProgram program, GLuint index, DOMString name);
//void bindFramebuffer(GLenum target, WebGLFramebuffer framebuffer);
//void bindRenderbuffer(GLenum target, WebGLRenderbuffer renderbuffer);
//void blendColor(GLclampf red, GLclampf green, GLclampf blue, GLclampf alpha);
//void blendEquation(GLenum mode);
//void blendEquationSeparate(GLenum modeRGB, GLenum modeAlpha);
//void blendFunc(GLenum sfactor, GLenum dfactor);
//void blendFuncSeparate(GLenum srcRGB, GLenum dstRGB,
//                       GLenum srcAlpha, GLenum dstAlpha);
//
//-void bufferData(GLenum target, GLsizeiptr size, GLenum usage);
//-void bufferData(GLenum target, ArrayBufferView data, GLenum usage);
//-void bufferData(GLenum target, ArrayBuffer data, GLenum usage);
//void bufferSubData(GLenum target, GLintptr offset, ArrayBufferView data);
//void bufferSubData(GLenum target, GLintptr offset, ArrayBuffer data);
//
//GLenum checkFramebufferStatus(GLenum target);
//void clearDepth(GLclampf depth);
//void clearStencil(GLint s);
//void colorMask(GLboolean red, GLboolean green, GLboolean blue, GLboolean alpha);
//
//void copyTexImage2D(GLenum target, GLint level, GLenum internalformat,
//                    GLint x, GLint y, GLsizei width, GLsizei height,
//                    GLint border);
//void copyTexSubImage2D(GLenum target, GLint level, GLint xoffset, GLint yoffset,
//                       GLint x, GLint y, GLsizei width, GLsizei height);
//
//WebGLFramebuffer createFramebuffer();
//WebGLRenderbuffer createRenderbuffer();
//
//void cullFace(GLenum mode);
//
//void deleteBuffer(WebGLBuffer buffer);
//void deleteFramebuffer(WebGLFramebuffer framebuffer);
//void deleteProgram(WebGLProgram program);
//void deleteRenderbuffer(WebGLRenderbuffer renderbuffer);
//void deleteShader(WebGLShader shader);
//void deleteTexture(WebGLTexture texture);
//
//void depthFunc(GLenum func);
//void depthMask(GLboolean flag);
//void depthRange(GLclampf zNear, GLclampf zFar);
//void detachShader(WebGLProgram program, WebGLShader shader);
//void disable(GLenum cap);
//void disableVertexAttribArray(GLuint index);
//-void drawElements(GLenum mode, GLsizei count, GLenum type, GLintptr offset);
//
//void finish();
//void flush();
//void framebufferRenderbuffer(GLenum target, GLenum attachment,
//                             GLenum renderbuffertarget,
//                             WebGLRenderbuffer renderbuffer);
//void framebufferTexture2D(GLenum target, GLenum attachment, GLenum textarget,
//                          WebGLTexture texture, GLint level);
//void frontFace(GLenum mode);
//
//void generateMipmap(GLenum target);
//
//WebGLActiveInfo getActiveAttrib(WebGLProgram program, GLuint index);
//WebGLActiveInfo getActiveUniform(WebGLProgram program, GLuint index);
//WebGLShader[ ] getAttachedShaders(WebGLProgram program);
//
//
//any getParameter(GLenum pname);
//any getBufferParameter(GLenum target, GLenum pname);
//
//GLenum getError();
//
//any getFramebufferAttachmentParameter(GLenum target, GLenum attachment,
//                                      GLenum pname);
//DOMString getProgramInfoLog(WebGLProgram program);
//any getRenderbufferParameter(GLenum target, GLenum pname);
//
//DOMString getShaderSource(WebGLShader shader);
//
//any getTexParameter(GLenum target, GLenum pname);
//
//any getUniform(WebGLProgram program, WebGLUniformLocation location);
//
//
//any getVertexAttrib(GLuint index, GLenum pname);
//
//GLsizeiptr getVertexAttribOffset(GLuint index, GLenum pname);
//
//void hint(GLenum target, GLenum mode);
//GLboolean isBuffer(WebGLBuffer buffer);
//GLboolean isEnabled(GLenum cap);
//GLboolean isFramebuffer(WebGLFramebuffer framebuffer);
//GLboolean isProgram(WebGLProgram program);
//GLboolean isRenderbuffer(WebGLRenderbuffer renderbuffer);
//GLboolean isShader(WebGLShader shader);
//GLboolean isTexture(WebGLTexture texture);
//void lineWidth(GLfloat width);
//void polygonOffset(GLfloat factor, GLfloat units);
//
//void readPixels(GLint x, GLint y, GLsizei width, GLsizei height,
//                GLenum format, GLenum type, ArrayBufferView pixels);
//
//void renderbufferStorage(GLenum target, GLenum internalformat,
//                         GLsizei width, GLsizei height);
//void sampleCoverage(GLclampf value, GLboolean invert);
//void scissor(GLint x, GLint y, GLsizei width, GLsizei height);
//
//
//void stencilFunc(GLenum func, GLint ref, GLuint mask);
//void stencilFuncSeparate(GLenum face, GLenum func, GLint ref, GLuint mask);
//void stencilMask(GLuint mask);
//void stencilMaskSeparate(GLenum face, GLuint mask);
//void stencilOp(GLenum fail, GLenum zfail, GLenum zpass);
//void stencilOpSeparate(GLenum face, GLenum fail, GLenum zfail, GLenum zpass);
//
//-void texImage2D(GLenum target, GLint level, GLenum internalformat,
//                GLsizei width, GLsizei height, GLint border, GLenum format,
//                GLenum type, ArrayBufferView pixels);
//void texImage2D(GLenum target, GLint level, GLenum internalformat,
//                GLenum format, GLenum type, ImageData pixels);
//-void texImage2D(GLenum target, GLint level, GLenum internalformat,
//                GLenum format, GLenum type, HTMLImageElement image);
//void texImage2D(GLenum target, GLint level, GLenum internalformat,
//                GLenum format, GLenum type, HTMLCanvasElement canvas);
//void texImage2D(GLenum target, GLint level, GLenum internalformat,
//                GLenum format, GLenum type, HTMLVideoElement video);
//
//
//void texSubImage2D(GLenum target, GLint level, GLint xoffset, GLint yoffset,
//                   GLsizei width, GLsizei height,
//                   GLenum format, GLenum type, ArrayBufferView pixels);
//void texSubImage2D(GLenum target, GLint level, GLint xoffset, GLint yoffset,
//                   GLenum format, GLenum type, ImageData pixels);
//void texSubImage2D(GLenum target, GLint level, GLint xoffset, GLint yoffset,
//                   GLenum format, GLenum type, HTMLImageElement image);
//void texSubImage2D(GLenum target, GLint level, GLint xoffset, GLint yoffset,
//                   GLenum format, GLenum type, HTMLCanvasElement canvas);
//void texSubImage2D(GLenum target, GLint level, GLint xoffset, GLint yoffset,
//                   GLenum format, GLenum type, HTMLVideoElement video);
//
//void uniform1f(WebGLUniformLocation location, GLfloat x);
//void uniform1fv(WebGLUniformLocation location, Float32Array v);
//void uniform1fv(WebGLUniformLocation location, float[] v);
//void uniform1i(WebGLUniformLocation location, GLint x);
//void uniform1iv(WebGLUniformLocation location, Int32Array v);
//void uniform1iv(WebGLUniformLocation location, long[] v);
//void uniform2f(WebGLUniformLocation location, GLfloat x, GLfloat y);
//void uniform2fv(WebGLUniformLocation location, Float32Array v);
//void uniform2fv(WebGLUniformLocation location, float[] v);
//void uniform2i(WebGLUniformLocation location, GLint x, GLint y);
//void uniform2iv(WebGLUniformLocation location, Int32Array v);
//void uniform2iv(WebGLUniformLocation location, long[] v);
//void uniform3f(WebGLUniformLocation location, GLfloat x, GLfloat y, GLfloat z);
//void uniform3fv(WebGLUniformLocation location, Float32Array v);
//void uniform3fv(WebGLUniformLocation location, float[] v);
//void uniform3i(WebGLUniformLocation location, GLint x, GLint y, GLint z);
//void uniform3iv(WebGLUniformLocation location, Int32Array v);
//void uniform3iv(WebGLUniformLocation location, long[] v);
//void uniform4f(WebGLUniformLocation location, GLfloat x, GLfloat y, GLfloat z, GLfloat w);
//void uniform4fv(WebGLUniformLocation location, Float32Array v);
//void uniform4fv(WebGLUniformLocation location, float[] v);
//void uniform4i(WebGLUniformLocation location, GLint x, GLint y, GLint z, GLint w);
//void uniform4iv(WebGLUniformLocation location, Int32Array v);
//void uniform4iv(WebGLUniformLocation location, long[] v);
//
//void uniformMatrix2fv(WebGLUniformLocation location, GLboolean transpose,
//                      Float32Array value);
//void uniformMatrix2fv(WebGLUniformLocation location, GLboolean transpose,
//                      float[] value);
//void uniformMatrix3fv(WebGLUniformLocation location, GLboolean transpose,
//                      Float32Array value);
//void uniformMatrix3fv(WebGLUniformLocation location, GLboolean transpose,
//                      float[] value);
//-void uniformMatrix4fv(WebGLUniformLocation location, GLboolean transpose,
//                      Float32Array value);
//-void uniformMatrix4fv(WebGLUniformLocation location, GLboolean transpose,
//                      float[] value);
//
//
//void vertexAttrib1f(GLuint indx, GLfloat x);
//void vertexAttrib1fv(GLuint indx, Float32Array values);
//void vertexAttrib1fv(GLuint indx, float[] values);
//void vertexAttrib2f(GLuint indx, GLfloat x, GLfloat y);
//void vertexAttrib2fv(GLuint indx, Float32Array values);
//void vertexAttrib2fv(GLuint indx, float[] values);
//void vertexAttrib3f(GLuint indx, GLfloat x, GLfloat y, GLfloat z);
//void vertexAttrib3fv(GLuint indx, Float32Array values);
//void vertexAttrib3fv(GLuint indx, float[] values);
//void vertexAttrib4f(GLuint indx, GLfloat x, GLfloat y, GLfloat z, GLfloat w);
//void vertexAttrib4fv(GLuint indx, Float32Array values);
//void vertexAttrib4fv(GLuint indx, float[] values);

}