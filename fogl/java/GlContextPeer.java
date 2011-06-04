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
import org.lwjgl.opengl.ARBShaderObjects;
import org.lwjgl.opengl.ARBVertexShader;

class GlContextPeer
{
  public static GlContextPeer make(GlContext self)
  {
    return new GlContextPeer();
  }

  public void clearColor(GlContext self, double r, double g, double b, long a)
  {
    glClearColor((float)r, (float)g, (float)b, (float)a);
  }

//////////////////////////////////////////////////////////////////////////
// common
//////////////////////////////////////////////////////////////////////////

  public void enable(GlContext self, GlEnum cap)
  {
    glEnable(cap.peer.getValue());
  }

  public void viewport(GlContext self, long x, long y, long width, long height)
  {
    glViewport((int)x, (int)y, (int)width, (int)height);
  }

  public void clear(GlContext self, GlEnum mask)
  {
    glClear(mask.peer.getValue());
  }

  public void vertexAttribPointer(GlContext self, long indx, long size, GlEnum type, boolean normalized, long stride, long offset)
  {
    glVertexAttribPointer((int)indx, (int)size, type.peer.getValue(), normalized, (int)stride, offset);
  }

  public void drawArrays(GlContext self, GlEnum mode, long first, long count)
  {
    glDrawArrays(mode.peer.getValue(), (int)first, (int)count);
  }

//////////////////////////////////////////////////////////////////////////
// buffer
//////////////////////////////////////////////////////////////////////////

  public Buffer createBuffer(GlContext self)
  {
    int i = glGenBuffers();
    Buffer buf = Buffer.make();
    buf.peer.setValue(i);
    return buf;
  }

  public void bindBuffer(GlContext self, GlEnum target, Buffer buffer)
  {
    glBindBuffer(target.peer.getValue(), buffer.peer.getValue());
  }

  public void bufferData(GlContext self, GlEnum target, ArrayBuffer data, GlEnum usage)
  {
    java.nio.Buffer d = data.getData();
    if (d instanceof java.nio.FloatBuffer)
    {
      glBufferData(target.peer.getValue(), (java.nio.FloatBuffer)d, usage.peer.getValue());
    }
    else if (d instanceof java.nio.DoubleBuffer)
    {
      glBufferData(target.peer.getValue(), (java.nio.DoubleBuffer)d, usage.peer.getValue());
    }
    else if(d instanceof java.nio.IntBuffer)
    {
      glBufferData(target.peer.getValue(), (java.nio.IntBuffer)d, usage.peer.getValue());
    }
    else if(d instanceof java.nio.ShortBuffer)
    {
      glBufferData(target.peer.getValue(), (java.nio.ShortBuffer)d, usage.peer.getValue());
    }
    else if(d instanceof java.nio.ByteBuffer)
    {
      glBufferData(target.peer.getValue(), (java.nio.ByteBuffer)d, usage.peer.getValue());
    }
    else
    {
      throw UnsupportedErr.make("unsupported type");
    }
  }

//////////////////////////////////////////////////////////////////////////
// shader
//////////////////////////////////////////////////////////////////////////

  public Shader createShader(GlContext self, GlEnum type)
  {
    int i = ARBShaderObjects.glCreateShaderObjectARB(type.peer.getValue());
    Shader shader = Shader.make();
    shader.peer.setValue(i);
    return shader;
  }

  public void shaderSource(GlContext self, Shader shader, String source)
  {
    ARBShaderObjects.glShaderSourceARB(shader.peer.getValue(), source);
  }

  public void compileShader(GlContext self, Shader shader)
  {
    ARBShaderObjects.glCompileShaderARB(shader.peer.getValue());
  }

  public long getShaderParameter(GlContext self, Shader shader, GlEnum pname)
  {
    int i = ARBShaderObjects.glGetObjectParameteriARB(shader.peer.getValue(), pname.peer.getValue());
    return i;
  }

  public String getShaderInfoLog(GlContext self, Shader shader)
  {
    return ARBShaderObjects.glGetInfoLogARB(shader.peer.getValue(), 1024);
  }


  public Program createProgram(GlContext self)
  {
    int i = ARBShaderObjects.glCreateProgramObjectARB();
    Program p = Program.make();
    p.peer.setValue(i);
    return p;
  }

  public void attachShader(GlContext self, Program program, Shader shader)
  {
    ARBShaderObjects.glAttachObjectARB(program.peer.getValue(), shader.peer.getValue());
  }

  public void linkProgram(GlContext self, Shader program)
  {
    ARBShaderObjects.glLinkProgramARB(program.peer.getValue());
  }

  public long getProgramParameter(GlContext self, Program program, GlEnum pname)
  {
    int i = ARBShaderObjects.glGetObjectParameteriARB(program.peer.getValue(), pname.peer.getValue());
    return i;
  }

  public void validateProgram(Program program)
  {
    ARBShaderObjects.glValidateProgramARB(program.peer.getValue());
  }

  public void useProgram(GlContext self, Program program)
  {
    ARBShaderObjects.glUseProgramObjectARB(program.peer.getValue());
  }

//////////////////////////////////////////////////////////////////////////
// uniform
//////////////////////////////////////////////////////////////////////////

  public UniformLocation getUniformLocation(GlContext self, Program program, String name)
  {
    int i = ARBShaderObjects.glGetUniformLocationARB(program.peer.getValue(), name);
    UniformLocation location = UniformLocation.make();
    location.peer.setValue(i);
    return location;
  }

  public void uniformMatrix4fv(GlContext self, UniformLocation location, boolean transpose, ArrayBuffer value)
  {
    java.nio.Buffer d = value.getData();
    if (d instanceof java.nio.FloatBuffer)
    {
      ARBShaderObjects.glUniformMatrix4ARB(location.peer.getValue(), transpose, (java.nio.FloatBuffer)d);
    }
    else
    {
      throw UnsupportedErr.make("unsupported type");
    }
  }

//////////////////////////////////////////////////////////////////////////
// vertexShader
//////////////////////////////////////////////////////////////////////////

  public long getAttribLocation(GlContext self, Program program, String name)
  {
    return ARBVertexShader.glGetAttribLocationARB(program.peer.getValue(), name);
  }

  public void enableVertexAttribArray(GlContext self, long index)
  {
    ARBVertexShader.glEnableVertexAttribArrayARB((int)index);
  }
}