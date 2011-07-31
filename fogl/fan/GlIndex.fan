//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-5-29  Jed Young  Creation
//

**
** GlIndex is a int value. like a resource handle.
**
@Js
const class GlIndex { internal native Obj? val() }

**
** The Buffer interface represents an OpenGL Buffer Object.
** The underlying object is created as if by calling glGenBuffers (OpenGL ES 2.0 §2.9, man page) ,
** bound as if by calling glBindBuffer (OpenGL ES 2.0 §2.9, man page) and
** destroyed as if by calling glDeleteBuffers (OpenGL ES 2.0 §2.9, man page) .
**
@Js
const class Buffer : GlIndex {}

**
** The WebGLFramebuffer interface represents an OpenGL Framebuffer Object.
** The underlying object is created as if by calling glGenFramebuffers (OpenGL ES 2.0 §4.4.1, man page) ,
** bound as if by calling glBindFramebuffer (OpenGL ES 2.0 §4.4.1, man page)
** and destroyed as if by calling glDeleteFramebuffers (OpenGL ES 2.0 §4.4.1, man page) .
**
@Js
const class Framebuffer : GlIndex {}

**
** The WebGLRenderbuffer interface represents an OpenGL Renderbuffer Object.
** The underlying object is created as if by calling glGenRenderbuffers (OpenGL ES 2.0 §4.4.3, man page) ,
** bound as if by calling glBindRenderbuffer (OpenGL ES 2.0 §4.4.3, man page)
** and destroyed as if by calling glDeleteRenderbuffers (OpenGL ES 2.0 §4.4.3, man page) .
**
@Js
const class Renderbuffer : GlIndex {}

**
** The Program interface represents an OpenGL Program Object.
** The underlying object is created as if by calling glCreateProgram (OpenGL ES 2.0 §2.10.3, man page) ,
** used as if by calling glUseProgram (OpenGL ES 2.0 §2.10.3, man page) and
** destroyed as if by calling glDeleteProgram (OpenGL ES 2.0 §2.10.3, man page) .
**
@Js
const class Program : GlIndex {}

**
** The Shader interface represents an OpenGL Shader Object.
** The underlying object is created as if by calling glCreateShader (OpenGL ES 2.0 §2.10.1, man page) ,
** attached to a Program as if by calling glAttachShader (OpenGL ES 2.0 §2.10.3, man page) and
** destroyed as if by calling glDeleteShader (OpenGL ES 2.0 §2.10.1, man page) .
**
@Js
const class Shader : GlIndex {}

**
** The UniformLocation interface represents the location of a uniform variable in a shader program.
**
@Js
const class UniformLocation : GlIndex {}

**
** The WebGLTexture interface represents an OpenGL Texture Object.
** The underlying object is created as if by calling glGenTextures (OpenGL ES 2.0 §3.7.13, man page) ,
** bound as if by calling glBindTexture (OpenGL ES 2.0 §3.7.13, man page)
** and destroyed as if by calling glDeleteTextures (OpenGL ES 2.0 §3.7.13, man page) .
**
@Js
const class Texture : GlIndex {}

@Js
const class ActiveInfo : GlIndex {}