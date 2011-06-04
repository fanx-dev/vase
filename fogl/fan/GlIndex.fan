//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-5-29  Jed Young  Creation
//

const class GlIndex { internal native Int val() }

**
** The Buffer interface represents an OpenGL Buffer Object.
** The underlying object is created as if by calling glGenBuffers (OpenGL ES 2.0 §2.9, man page) ,
** bound as if by calling glBindBuffer (OpenGL ES 2.0 §2.9, man page) and
** destroyed as if by calling glDeleteBuffers (OpenGL ES 2.0 §2.9, man page) .
**
const class Buffer : GlIndex {}

**
** The Program interface represents an OpenGL Program Object.
** The underlying object is created as if by calling glCreateProgram (OpenGL ES 2.0 §2.10.3, man page) ,
** used as if by calling glUseProgram (OpenGL ES 2.0 §2.10.3, man page) and
** destroyed as if by calling glDeleteProgram (OpenGL ES 2.0 §2.10.3, man page) .
**
const class Program : GlIndex {}

**
** The Shader interface represents an OpenGL Shader Object.
** The underlying object is created as if by calling glCreateShader (OpenGL ES 2.0 §2.10.1, man page) ,
** attached to a Program as if by calling glAttachShader (OpenGL ES 2.0 §2.10.3, man page) and
** destroyed as if by calling glDeleteShader (OpenGL ES 2.0 §2.10.1, man page) .
**
const class Shader : GlIndex {}

**
** The UniformLocation interface represents the location of a uniform variable in a shader program.
**
const class UniformLocation : GlIndex {}