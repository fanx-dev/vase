//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-5-31  Jed Young  Creation
//

package fan.fogl;

import fan.sys.*;

import static org.lwjgl.opengl.GL11.*;
import static org.lwjgl.opengl.GL12.*;
import static org.lwjgl.opengl.GL13.*;
import static org.lwjgl.opengl.GL14.*;
import static org.lwjgl.opengl.GL15.*;
import static org.lwjgl.opengl.GL20.*;
import static org.lwjgl.opengl.GL21.*;
import static org.lwjgl.opengl.GL30.*;
import static org.lwjgl.opengl.GL31.*;

class LwjglGlContext implements GlContext
{
//////////////////////////////////////////////////////////////////////////
// rename
//////////////////////////////////////////////////////////////////////////

  public int glCreateBuffer() { return glGenBuffers(); }
  public int glCreateFramebuffer() { return glGenFramebuffers(); }
  public int glCreateRenderbuffer() { return glGenRenderbuffers(); }
  public int glCreateTexture() { return glGenTextures(); }

  public void glDeleteBuffer(int i) { glDeleteBuffers(i); }
  public void glDeleteFramebuffer(int i) { glDeleteFramebuffers(i); }
  public void glDeleteRenderbuffer(int i) { glDeleteRenderbuffers(i); }
  public void glDeleteTexture(int i) { glDeleteTextures(i); }

//////////////////////////////////////////////////////////////////////////
// manual
//////////////////////////////////////////////////////////////////////////

  public void bufferData(GlEnum target, ArrayBuffer data, GlEnum usage)
  {
    java.nio.Buffer d = data.peer.getValue();
    if (d instanceof java.nio.FloatBuffer)
    {
      glBufferData((int)target.val, (java.nio.FloatBuffer)d, (int)usage.val);
    }
    else if (d instanceof java.nio.DoubleBuffer)
    {
      glBufferData((int)target.val, (java.nio.DoubleBuffer)d, (int)usage.val);
    }
    else if(d instanceof java.nio.IntBuffer)
    {
      glBufferData((int)target.val, (java.nio.IntBuffer)d, (int)usage.val);
    }
    else if(d instanceof java.nio.ShortBuffer)
    {
      glBufferData((int)target.val, (java.nio.ShortBuffer)d, (int)usage.val);
    }
    else if(d instanceof java.nio.ByteBuffer)
    {
      glBufferData((int)target.val, (java.nio.ByteBuffer)d, (int)usage.val);
    }
    else
    {
      throw UnsupportedErr.make("unsupported type");
    }
  }

  public long getShaderParameter(Shader shader, GlEnum pname)
  {
    return glGetShader(shader.peer.getValue(), (int)pname.val);
  }

  public String getShaderInfoLog(Shader shader)
  {
    return glGetShaderInfoLog(shader.peer.getValue(), 1024);
  }

  public long getProgramParameter(Program program, GlEnum pname)
  {
    return glGetProgram(program.peer.getValue(), (int)pname.val);
  }

  public void uniformMatrix4fv(UniformLocation location, boolean transpose, ArrayBuffer value)
  {
    java.nio.Buffer d = value.peer.getValue();
    if (d instanceof java.nio.FloatBuffer)
    {
      glUniformMatrix4(location.peer.getValue(), transpose, (java.nio.FloatBuffer)d);
    }
    else
    {
      throw UnsupportedErr.make("unsupported type");
    }
  }

//////////////////////////////////////////////////////////////////////////
// Texture
//////////////////////////////////////////////////////////////////////////

  public void bindTexture(GlEnum target, Texture texture)
  {
    if (texture != null)
      glBindTexture((int)target.val, texture.peer.getValue());
    else
      glBindTexture((int)target.val, 0);
  }

  public void texImage2D(GlEnum target, long level, GlEnum internalformat,
                         GlEnum format, GlEnum type, Image image)
  {
    java.nio.Buffer d = image.peer.getValue();

    int ta = (int)target.val;
    int l = (int)level;
    int i = (int)internalformat.val;
    int w = (int)image.width();
    int h = (int)image.height();
    int b = 0;
    int f = (int)format.val;
    int t = (int)type.val;

    texImage2D(ta, l, i, w, h, b, f, t, d);
  }

  public void texImage2DBuffer(GlEnum target, long level, GlEnum internalformat, long width, long height, long border,
                         GlEnum format, GlEnum type, ArrayBuffer pixels)
  {
    java.nio.Buffer d = pixels.peer.getValue();

    int ta = (int)target.val;
    int l = (int)level;
    int i = (int)internalformat.val;
    int w = (int)width;
    int h = (int)height;
    int b = (int)border;
    int f = (int)format.val;
    int t = (int)type.val;

    texImage2D(ta, l, i, w, h, b, f, t, d);
  }

  private void texImage2D(int ta, int l, int i, int w, int h, int b,
    int f, int t, java.nio.Buffer d)
  {
    if (d instanceof java.nio.FloatBuffer)
    {
      glTexImage2D(ta, l, i, w, h, b, f, t, (java.nio.FloatBuffer)d);
    }
    else if (d instanceof java.nio.DoubleBuffer)
    {
      glTexImage2D(ta, l, i, w, h, b, f, t, (java.nio.DoubleBuffer)d);
    }
    else if(d instanceof java.nio.IntBuffer)
    {
      glTexImage2D(ta, l, i, w, h, b, f, t, (java.nio.IntBuffer)d);
    }
    else if(d instanceof java.nio.ShortBuffer)
    {
      glTexImage2D(ta, l, i, w, h, b, f, t, (java.nio.ShortBuffer)d);
    }
    else if(d instanceof java.nio.ByteBuffer)
    {
      glTexImage2D(ta, l, i, w, h, b, f, t, (java.nio.ByteBuffer)d);
    }
    else
    {
      throw UnsupportedErr.make("unsupported type");
    }
  }

//////////////////////////////////////////////////////////////////////////
// special
//////////////////////////////////////////////////////////////////////////

//  public null getContextAttributes(){ return glGetContextAttributes(); }
//  public boolean isContextLost(){ return glIsContextLost(); }
//  public String[] getSupportedExtensions(){ return glGetSupportedExtensions(); }
//  public null getExtension(String name){ return glGetExtension(name); }
//  public void bindTexture(GlEnum target, Texture texture){ glBindTexture((int)target.val, texture.peer.getValue()); }
//  public void bufferData(GlEnum target, ArrayBuffer data, GlEnum usage){ glBufferData((int)target.val, data.peer.getValue(), (int)usage.val); }
//  public void bufferData(GlEnum target, ArrayBuffer data, GlEnum usage){ glBufferData((int)target.val, data.peer.getValue(), (int)usage.val); }
//  public void bufferData(GlEnum target, long size, GlEnum usage){ glBufferData((int)target.val, size, (int)usage.val); }
//  public void bufferSubData(GlEnum target, long offset, ArrayBuffer data){ glBufferSubData((int)target.val, offset, data.peer.getValue()); }
//  public void bufferSubData(GlEnum target, long offset, ArrayBuffer data){ glBufferSubData((int)target.val, offset, data.peer.getValue()); }
//  public GlEnum checkFramebufferStatus(GlEnum target){ return glCheckFramebufferStatus((int)target.val); }
//  public ActiveInfo getActiveAttrib(Program program, long index){
//    int i = glGetActiveAttrib(program.peer.getValue(), (int)index);
//    ActiveInfo p = ActiveInfo.make();
//    p.peer.setValue(i);
//    return p;
//  }
//  public ActiveInfo getActiveUniform(Program program, long index){
//    int i = glGetActiveUniform(program.peer.getValue(), (int)index);
//    ActiveInfo p = ActiveInfo.make();
//    p.peer.setValue(i);
//    return p;
//  }
//  public Shader[] getAttachedShaders(Program program){ return glGetAttachedShaders(program.peer.getValue()); }
//  public null getParameter(GlEnum pname){ return glGetParameter((int)pname.val); }
//  public null getBufferParameter(GlEnum target, GlEnum pname){ return glGetBufferParameter((int)target.val, (int)pname.val); }
//  public GlEnum getError(){ return glGetError(); }
//  public null getFramebufferAttachmentParameter(GlEnum target, GlEnum attachment, GlEnum pname){ return glGetFramebufferAttachmentParameter((int)target.val, (int)attachment.val, (int)pname.val); }
//  public null getProgramParameter(Program program, GlEnum pname){ return glGetProgramParameter(program.peer.getValue(), (int)pname.val); }
//  public String getProgramInfoLog(Program program){ return glGetProgramInfoLog(program.peer.getValue()); }
//  public null getRenderbufferParameter(GlEnum target, GlEnum pname){ return glGetRenderbufferParameter((int)target.val, (int)pname.val); }
//  public null getShaderParameter(Shader shader, GlEnum pname){ return glGetShaderParameter(shader.peer.getValue(), (int)pname.val); }
//  public String getShaderInfoLog(Shader shader){ return glGetShaderInfoLog(shader.peer.getValue()); }
//  public String getShaderSource(Shader shader){ return glGetShaderSource(shader.peer.getValue()); }
//  public null getTexParameter(GlEnum target, GlEnum pname){ return glGetTexParameter((int)target.val, (int)pname.val); }
//  public null getUniform(Program program, UniformLocation location){ return glGetUniform(program.peer.getValue(), location.peer.getValue()); }
//  public null getVertexAttrib(long index, GlEnum pname){ return glGetVertexAttrib((int)index, (int)pname.val); }
//  public long getVertexAttribOffset(long index, GlEnum pname){ return glGetVertexAttribOffset((int)index, (int)pname.val); }
//  public void readPixels(long x, long y, long width, long height, GlEnum format, GlEnum type, ArrayBuffer pixels){ glReadPixels((int)x, (int)y, (int)width, (int)height, (int)format.val, (int)type.val, pixels.peer.getValue()); }
//  public void texImage2D(GlEnum target, long level, GlEnum internalformat, long width, long height, long border, GlEnum format, GlEnum type, ArrayBuffer pixels){ glTexImage2D((int)target.val, (int)level, (int)internalformat.val, (int)width, (int)height, (int)border, (int)format.val, (int)type.val, pixels.peer.getValue()); }
//  public void texImage2D(GlEnum target, long level, GlEnum internalformat, GlEnum format, GlEnum type, null pixels){ glTexImage2D((int)target.val, (int)level, (int)internalformat.val, (int)format.val, (int)type.val, pixels); }
//  public void texImage2D(GlEnum target, long level, GlEnum internalformat, GlEnum format, GlEnum type, Image image){ glTexImage2D((int)target.val, (int)level, (int)internalformat.val, (int)format.val, (int)type.val, image.peer.image); }
//  public void texImage2D(GlEnum target, long level, GlEnum internalformat, GlEnum format, GlEnum type, null canvas){ glTexImage2D((int)target.val, (int)level, (int)internalformat.val, (int)format.val, (int)type.val, canvas); }
//  public void texImage2D(GlEnum target, long level, GlEnum internalformat, GlEnum format, GlEnum type, null video){ glTexImage2D((int)target.val, (int)level, (int)internalformat.val, (int)format.val, (int)type.val, video); }
//  public void texSubImage2D(GlEnum target, long level, long xoffset, long yoffset, long width, long height, GlEnum format, GlEnum type, ArrayBuffer pixels){ glTexSubImage2D((int)target.val, (int)level, (int)xoffset, (int)yoffset, (int)width, (int)height, (int)format.val, (int)type.val, pixels.peer.getValue()); }
//  public void texSubImage2D(GlEnum target, long level, long xoffset, long yoffset, GlEnum format, GlEnum type, null pixels){ glTexSubImage2D((int)target.val, (int)level, (int)xoffset, (int)yoffset, (int)format.val, (int)type.val, pixels); }
//  public void texSubImage2D(GlEnum target, long level, long xoffset, long yoffset, GlEnum format, GlEnum type, Image image){ glTexSubImage2D((int)target.val, (int)level, (int)xoffset, (int)yoffset, (int)format.val, (int)type.val, image.peer.image); }
//  public void texSubImage2D(GlEnum target, long level, long xoffset, long yoffset, GlEnum format, GlEnum type, null canvas){ glTexSubImage2D((int)target.val, (int)level, (int)xoffset, (int)yoffset, (int)format.val, (int)type.val, canvas); }
//  public void texSubImage2D(GlEnum target, long level, long xoffset, long yoffset, GlEnum format, GlEnum type, null video){ glTexSubImage2D((int)target.val, (int)level, (int)xoffset, (int)yoffset, (int)format.val, (int)type.val, video); }
//  public void uniform1fv(UniformLocation location, ArrayBuffer v){ glUniform1fv(location.peer.getValue(), v.peer.getValue()); }
//  public void uniform1fv(UniformLocation location, double[] v){ glUniform1fv(location.peer.getValue(), v); }
//  public void uniform1iv(UniformLocation location, ArrayBuffer v){ glUniform1iv(location.peer.getValue(), v.peer.getValue()); }
//  public void uniform1iv(UniformLocation location, long[] v){ glUniform1iv(location.peer.getValue(), v); }
//  public void uniform2fv(UniformLocation location, ArrayBuffer v){ glUniform2fv(location.peer.getValue(), v.peer.getValue()); }
//  public void uniform2fv(UniformLocation location, double[] v){ glUniform2fv(location.peer.getValue(), v); }
//  public void uniform2iv(UniformLocation location, ArrayBuffer v){ glUniform2iv(location.peer.getValue(), v.peer.getValue()); }
//  public void uniform2iv(UniformLocation location, long[] v){ glUniform2iv(location.peer.getValue(), v); }
//  public void uniform3fv(UniformLocation location, ArrayBuffer v){ glUniform3fv(location.peer.getValue(), v.peer.getValue()); }
//  public void uniform3fv(UniformLocation location, double[] v){ glUniform3fv(location.peer.getValue(), v); }
//  public void uniform3iv(UniformLocation location, ArrayBuffer v){ glUniform3iv(location.peer.getValue(), v.peer.getValue()); }
//  public void uniform3iv(UniformLocation location, long[] v){ glUniform3iv(location.peer.getValue(), v); }
//  public void uniform4fv(UniformLocation location, ArrayBuffer v){ glUniform4fv(location.peer.getValue(), v.peer.getValue()); }
//  public void uniform4fv(UniformLocation location, double[] v){ glUniform4fv(location.peer.getValue(), v); }
//  public void uniform4iv(UniformLocation location, ArrayBuffer v){ glUniform4iv(location.peer.getValue(), v.peer.getValue()); }
//  public void uniform4iv(UniformLocation location, long[] v){ glUniform4iv(location.peer.getValue(), v); }
//  public void uniformMatrix2fv(UniformLocation location, boolean transpose, ArrayBuffer value){ glUniformMatrix2fv(location.peer.getValue(), transpose, value.peer.getValue()); }
//  public void uniformMatrix2fv(UniformLocation location, boolean transpose, double[] value){ glUniformMatrix2fv(location.peer.getValue(), transpose, value); }
//  public void uniformMatrix3fv(UniformLocation location, boolean transpose, ArrayBuffer value){ glUniformMatrix3fv(location.peer.getValue(), transpose, value.peer.getValue()); }
//  public void uniformMatrix3fv(UniformLocation location, boolean transpose, double[] value){ glUniformMatrix3fv(location.peer.getValue(), transpose, value); }
//  public void uniformMatrix4fv(UniformLocation location, boolean transpose, ArrayBuffer value){ glUniformMatrix4fv(location.peer.getValue(), transpose, value.peer.getValue()); }
//  public void uniformMatrix4fv(UniformLocation location, boolean transpose, double[] value){ glUniformMatrix4fv(location.peer.getValue(), transpose, value); }
//  public void vertexAttrib1fv(long indx, ArrayBuffer values){ glVertexAttrib1fv((int)indx, values.peer.getValue()); }
//  public void vertexAttrib1fv(long indx, double[] values){ glVertexAttrib1fv((int)indx, values); }
//  public void vertexAttrib2fv(long indx, ArrayBuffer values){ glVertexAttrib2fv((int)indx, values.peer.getValue()); }
//  public void vertexAttrib2fv(long indx, double[] values){ glVertexAttrib2fv((int)indx, values); }
//  public void vertexAttrib3fv(long indx, ArrayBuffer values){ glVertexAttrib3fv((int)indx, values.peer.getValue()); }
//  public void vertexAttrib3fv(long indx, double[] values){ glVertexAttrib3fv((int)indx, values); }
//  public void vertexAttrib4fv(long indx, ArrayBuffer values){ glVertexAttrib4fv((int)indx, values.peer.getValue()); }
//  public void vertexAttrib4fv(long indx, double[] values){ glVertexAttrib4fv((int)indx, values); }

//////////////////////////////////////////////////////////////////////////
// Gen
//////////////////////////////////////////////////////////////////////////

  public void activeTexture(GlEnum texture){ glActiveTexture((int)texture.val); }
  public void attachShader(Program program, Shader shader){ glAttachShader(program.peer.getValue(), shader.peer.getValue()); }
  public void bindAttribLocation(Program program, long index, String name){ glBindAttribLocation(program.peer.getValue(), (int)index, name); }
  public void bindBuffer(GlEnum target, Buffer buffer){ glBindBuffer((int)target.val, buffer.peer.getValue()); }
  public void bindFramebuffer(GlEnum target, Framebuffer framebuffer){ glBindFramebuffer((int)target.val, framebuffer.peer.getValue()); }
  public void bindRenderbuffer(GlEnum target, Renderbuffer renderbuffer){ glBindRenderbuffer((int)target.val, renderbuffer.peer.getValue()); }
  public void blendColor(double red, double green, double blue, double alpha){ glBlendColor((float)red, (float)green, (float)blue, (float)alpha); }
  public void blendEquation(GlEnum mode){ glBlendEquation((int)mode.val); }
  public void blendEquationSeparate(GlEnum modeRGB, GlEnum modeAlpha){ glBlendEquationSeparate((int)modeRGB.val, (int)modeAlpha.val); }
  public void blendFunc(GlEnum sfactor, GlEnum dfactor){ glBlendFunc((int)sfactor.val, (int)dfactor.val); }
  public void blendFuncSeparate(GlEnum srcRGB, GlEnum dstRGB, GlEnum srcAlpha, GlEnum dstAlpha){ glBlendFuncSeparate((int)srcRGB.val, (int)dstRGB.val, (int)srcAlpha.val, (int)dstAlpha.val); }
  public void clear(GlEnum mask){ glClear((int)mask.val); }
  public void clearColor(double red, double green, double blue, double alpha){ glClearColor((float)red, (float)green, (float)blue, (float)alpha); }
  public void clearDepth(double depth){ glClearDepth((float)depth); }
  public void clearStencil(long s){ glClearStencil((int)s); }
  public void colorMask(boolean red, boolean green, boolean blue, boolean alpha){ glColorMask(red, green, blue, alpha); }
  public void compileShader(Shader shader){ glCompileShader(shader.peer.getValue()); }
  public void copyTexImage2D(GlEnum target, long level, GlEnum internalformat, long x, long y, long width, long height, long border){ glCopyTexImage2D((int)target.val, (int)level, (int)internalformat.val, (int)x, (int)y, (int)width, (int)height, (int)border); }
  public void copyTexSubImage2D(GlEnum target, long level, long xoffset, long yoffset, long x, long y, long width, long height){ glCopyTexSubImage2D((int)target.val, (int)level, (int)xoffset, (int)yoffset, (int)x, (int)y, (int)width, (int)height); }
  public Buffer createBuffer(){
    int i = glCreateBuffer();
    Buffer p = Buffer.make();
    p.peer.setValue(i);
    return p;
  }
  public Framebuffer createFramebuffer(){
    int i = glCreateFramebuffer();
    Framebuffer p = Framebuffer.make();
    p.peer.setValue(i);
    return p;
  }
  public Program createProgram(){
    int i = glCreateProgram();
    Program p = Program.make();
    p.peer.setValue(i);
    return p;
  }
  public Renderbuffer createRenderbuffer(){
    int i = glCreateRenderbuffer();
    Renderbuffer p = Renderbuffer.make();
    p.peer.setValue(i);
    return p;
  }
  public Shader createShader(GlEnum type){
    int i = glCreateShader((int)type.val);
    Shader p = Shader.make();
    p.peer.setValue(i);
    return p;
  }
  public Texture createTexture(){
    int i = glCreateTexture();
    Texture p = Texture.make();
    p.peer.setValue(i);
    return p;
  }
  public void cullFace(GlEnum mode){ glCullFace((int)mode.val); }
  public void deleteBuffer(Buffer buffer){ glDeleteBuffer(buffer.peer.getValue()); }
  public void deleteFramebuffer(Framebuffer framebuffer){ glDeleteFramebuffer(framebuffer.peer.getValue()); }
  public void deleteProgram(Program program){ glDeleteProgram(program.peer.getValue()); }
  public void deleteRenderbuffer(Renderbuffer renderbuffer){ glDeleteRenderbuffer(renderbuffer.peer.getValue()); }
  public void deleteShader(Shader shader){ glDeleteShader(shader.peer.getValue()); }
  public void deleteTexture(Texture texture){ glDeleteTexture(texture.peer.getValue()); }
  public void depthFunc(GlEnum func){ glDepthFunc((int)func.val); }
  public void depthMask(boolean flag){ glDepthMask(flag); }
  public void depthRange(double zNear, double zFar){ glDepthRange((float)zNear, (float)zFar); }
  public void detachShader(Program program, Shader shader){ glDetachShader(program.peer.getValue(), shader.peer.getValue()); }
  public void disable(GlEnum cap){ glDisable((int)cap.val); }
  public void disableVertexAttribArray(long index){ glDisableVertexAttribArray((int)index); }
  public void drawArrays(GlEnum mode, long first, long count){ glDrawArrays((int)mode.val, (int)first, (int)count); }
  public void drawElements(GlEnum mode, long count, GlEnum type, long offset){ glDrawElements((int)mode.val, (int)count, (int)type.val, offset); }
  public void enable(GlEnum cap){ glEnable((int)cap.val); }
  public void enableVertexAttribArray(long index){ glEnableVertexAttribArray((int)index); }
  public void finish(){ glFinish(); }
  public void flush(){ glFlush(); }
  public void framebufferRenderbuffer(GlEnum target, GlEnum attachment, GlEnum renderbuffertarget, Renderbuffer renderbuffer){ glFramebufferRenderbuffer((int)target.val, (int)attachment.val, (int)renderbuffertarget.val, renderbuffer.peer.getValue()); }
  public void framebufferTexture2D(GlEnum target, GlEnum attachment, GlEnum textarget, Texture texture, long level){ glFramebufferTexture2D((int)target.val, (int)attachment.val, (int)textarget.val, texture.peer.getValue(), (int)level); }
  public void frontFace(GlEnum mode){ glFrontFace((int)mode.val); }
  public void generateMipmap(GlEnum target){ glGenerateMipmap((int)target.val); }
  public long getAttribLocation(Program program, String name){ return glGetAttribLocation(program.peer.getValue(), name); }
  public UniformLocation getUniformLocation(Program program, String name){
    int i = glGetUniformLocation(program.peer.getValue(), name);
    UniformLocation p = UniformLocation.make();
    p.peer.setValue(i);
    return p;
  }
  public void hint(GlEnum target, GlEnum mode){ glHint((int)target.val, (int)mode.val); }
  public boolean isBuffer(Buffer buffer){ return glIsBuffer(buffer.peer.getValue()); }
  public boolean isEnabled(GlEnum cap){ return glIsEnabled((int)cap.val); }
  public boolean isFramebuffer(Framebuffer framebuffer){ return glIsFramebuffer(framebuffer.peer.getValue()); }
  public boolean isProgram(Program program){ return glIsProgram(program.peer.getValue()); }
  public boolean isRenderbuffer(Renderbuffer renderbuffer){ return glIsRenderbuffer(renderbuffer.peer.getValue()); }
  public boolean isShader(Shader shader){ return glIsShader(shader.peer.getValue()); }
  public boolean isTexture(Texture texture){ return glIsTexture(texture.peer.getValue()); }
  public void lineWidth(double width){ glLineWidth((float)width); }
  public void linkProgram(Program program){ glLinkProgram(program.peer.getValue()); }
  public void pixelStorei(GlEnum pname, long param){ glPixelStorei((int)pname.val, (int)param); }
  public void polygonOffset(double factor, double units){ glPolygonOffset((float)factor, (float)units); }
  public void renderbufferStorage(GlEnum target, GlEnum internalformat, long width, long height){ glRenderbufferStorage((int)target.val, (int)internalformat.val, (int)width, (int)height); }
  public void sampleCoverage(double value, boolean invert){ glSampleCoverage((float)value, invert); }
  public void scissor(long x, long y, long width, long height){ glScissor((int)x, (int)y, (int)width, (int)height); }
  public void shaderSource(Shader shader, String source){ glShaderSource(shader.peer.getValue(), source); }
  public void stencilFunc(GlEnum func, long ref, long mask){ glStencilFunc((int)func.val, (int)ref, (int)mask); }
  public void stencilFuncSeparate(GlEnum face, GlEnum func, long ref, long mask){ glStencilFuncSeparate((int)face.val, (int)func.val, (int)ref, (int)mask); }
  public void stencilMask(long mask){ glStencilMask((int)mask); }
  public void stencilMaskSeparate(GlEnum face, long mask){ glStencilMaskSeparate((int)face.val, (int)mask); }
  public void stencilOp(GlEnum fail, GlEnum zfail, GlEnum zpass){ glStencilOp((int)fail.val, (int)zfail.val, (int)zpass.val); }
  public void stencilOpSeparate(GlEnum face, GlEnum fail, GlEnum zfail, GlEnum zpass){ glStencilOpSeparate((int)face.val, (int)fail.val, (int)zfail.val, (int)zpass.val); }
  public void texParameterf(GlEnum target, GlEnum pname, double param){ glTexParameterf((int)target.val, (int)pname.val, (float)param); }
  public void texParameteri(GlEnum target, GlEnum pname, long param){ glTexParameteri((int)target.val, (int)pname.val, (int)param); }
  public void uniform1f(UniformLocation location, double x){ glUniform1f(location.peer.getValue(), (float)x); }
  public void uniform1i(UniformLocation location, long x){ glUniform1i(location.peer.getValue(), (int)x); }
  public void uniform2f(UniformLocation location, double x, double y){ glUniform2f(location.peer.getValue(), (float)x, (float)y); }
  public void uniform2i(UniformLocation location, long x, long y){ glUniform2i(location.peer.getValue(), (int)x, (int)y); }
  public void uniform3f(UniformLocation location, double x, double y, double z){ glUniform3f(location.peer.getValue(), (float)x, (float)y, (float)z); }
  public void uniform3i(UniformLocation location, long x, long y, long z){ glUniform3i(location.peer.getValue(), (int)x, (int)y, (int)z); }
  public void uniform4f(UniformLocation location, double x, double y, double z, double w){ glUniform4f(location.peer.getValue(), (float)x, (float)y, (float)z, (float)w); }
  public void uniform4i(UniformLocation location, long x, long y, long z, long w){ glUniform4i(location.peer.getValue(), (int)x, (int)y, (int)z, (int)w); }
  public void useProgram(Program program){ glUseProgram(program.peer.getValue()); }
  public void validateProgram(Program program){ glValidateProgram(program.peer.getValue()); }
  public void vertexAttrib1f(long indx, double x){ glVertexAttrib1f((int)indx, (float)x); }
  public void vertexAttrib2f(long indx, double x, double y){ glVertexAttrib2f((int)indx, (float)x, (float)y); }
  public void vertexAttrib3f(long indx, double x, double y, double z){ glVertexAttrib3f((int)indx, (float)x, (float)y, (float)z); }
  public void vertexAttrib4f(long indx, double x, double y, double z, double w){ glVertexAttrib4f((int)indx, (float)x, (float)y, (float)z, (float)w); }
  public void vertexAttribPointer(long indx, long size, GlEnum type, boolean normalized, long stride, long offset){ glVertexAttribPointer((int)indx, (int)size, (int)type.val, normalized, (int)stride, offset); }
  public void viewport(long x, long y, long width, long height){ glViewport((int)x, (int)y, (int)width, (int)height); }
}