//
// Copyright (c) 2012, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-02-24  Jed Young  Creation
//

@Js
class Shader
{
  Str src

  private new make(Str s) { src = s }

  static Shader fromStr(Str s) { Shader.make(s) }
}