//
// Copyright (c) 2012, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-02-24  Jed Young  Creation
//

using fgfxMath
using fgfxOpenGl
using fgfxArray

@Js
class Scene
{
  Camera camera := Camera()
  Light[] lights := Light[,]
  Group root := Group()
  Renderer? renderer

  Void init(GlContext gl)
  {
    renderer.gl = gl
    renderer.init(this)
  }

  Void render(GlContext gl)
  {
    renderer.gl = gl
    renderer.render(this)
  }
}