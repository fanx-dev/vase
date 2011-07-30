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

  public void clearColor(double r, double g, double b, double a)
  {
    glClearColor((float)r, (float)g, (float)b, (float)a);
  }

//////////////////////////////////////////////////////////////////////////
// common
//////////////////////////////////////////////////////////////////////////

  public void enable(GlEnum cap)
  {
    glEnable((int)cap.val);
  }

  public void viewport(long x, long y, long width, long height)
  {
    glViewport((int)x, (int)y, (int)width, (int)height);
  }

  public void clear(GlEnum mask)
  {
    glClear((int)mask.val);
  }

  public void vertexAttribPointer(long indx, long size, GlEnum type, boolean normalized, long stride, long offset)
  {
    glVertexAttribPointer((int)indx, (int)size, (int)type.val, normalized, (int)stride, offset);
  }

  public void drawArrays(GlEnum mode, long first, long count)
  {
    glDrawArrays((int)mode.val, (int)first, (int)count);
  }

  public void drawElements(GlEnum mode, long count, GlEnum type, long offset)
  {
    glDrawElements((int)mode.val, (int)count, (int)type.val, offset);
  }

//////////////////////////////////////////////////////////////////////////
// buffer
//////////////////////////////////////////////////////////////////////////

  public Buffer createBuffer()
  {
    int i = glGenBuffers();
    Buffer buf = Buffer.make();
    buf.peer.setValue(i);
    return buf;
  }

  public void bindBuffer(GlEnum target, Buffer buffer)
  {
    glBindBuffer((int)target.val, buffer.peer.getValue());
  }

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

//////////////////////////////////////////////////////////////////////////
// shader
//////////////////////////////////////////////////////////////////////////

  public Shader createShader(GlEnum type)
  {
    int i = glCreateShader((int)type.val);
    Shader shader = Shader.make();
    shader.peer.setValue(i);
    return shader;
  }

  public void shaderSource(Shader shader, String source)
  {
    glShaderSource(shader.peer.getValue(), source);
  }

  public void compileShader(Shader shader)
  {
    glCompileShader(shader.peer.getValue());
  }

  public boolean getShaderParameter(Shader shader, GlEnum pname)
  {
    int i = glGetShader(shader.peer.getValue(), (int)pname.val);
    return i != 0;
  }

  public String getShaderInfoLog(Shader shader)
  {
    return glGetShaderInfoLog(shader.peer.getValue(), 1024);
  }


  public Program createProgram()
  {
    int i = glCreateProgram();
    Program p = Program.make();
    p.peer.setValue(i);
    return p;
  }

  public void attachShader(Program program, Shader shader)
  {
    glAttachShader(program.peer.getValue(), shader.peer.getValue());
  }

  public void linkProgram(Program program)
  {
    glLinkProgram(program.peer.getValue());
  }

  public boolean getProgramParameter(Program program, GlEnum pname)
  {
    int i = glGetProgram(program.peer.getValue(), (int)pname.val);
    return i != 0;
  }

  public void validateProgram(Program program)
  {
    glValidateProgram(program.peer.getValue());
  }

  public void useProgram(Program program)
  {
    glUseProgram(program.peer.getValue());
  }

//////////////////////////////////////////////////////////////////////////
// uniform
//////////////////////////////////////////////////////////////////////////

  public UniformLocation getUniformLocation(Program program, String name)
  {
    int i = glGetUniformLocation(program.peer.getValue(), name);
    UniformLocation location = UniformLocation.make();
    location.peer.setValue(i);
    return location;
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

  public void uniform1i(UniformLocation location, long x)
  {
    glUniform1i(location.peer.getValue(), (int)x);
  }

//////////////////////////////////////////////////////////////////////////
// vertexShader
//////////////////////////////////////////////////////////////////////////

  public long getAttribLocation(Program program, String name)
  {
    return glGetAttribLocation(program.peer.getValue(), name);
  }

  public void enableVertexAttribArray(long index)
  {
    glEnableVertexAttribArray((int)index);
  }

//////////////////////////////////////////////////////////////////////////
// Texture
//////////////////////////////////////////////////////////////////////////

  public Texture createTexture()
  {
    int i = glGenTextures();
    Texture p = Texture.make();
    p.peer.setValue(i);
    return p;
  }

  public void bindTexture(GlEnum target, Texture texture)
  {
    if (texture != null)
      glBindTexture((int)target.val, texture.peer.getValue());
    else
      glBindTexture((int)target.val, 0);
  }

  public void pixelStorei(GlEnum pname, long param)
  {
    glPixelStorei((int)pname.val, (int)param);
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

  public void texParameterf(GlEnum target, GlEnum pname, double param)
  {
    glTexParameterf((int)target.val, (int)pname.val, (float)param);
  }

  public void texParameteri(GlEnum target, GlEnum pname, long param)
  {
    glTexParameteri((int)target.val, (int)pname.val, (int)param);
  }

  public void activeTexture(GlEnum texture)
  {
    glActiveTexture((int)texture.val);
  }
}