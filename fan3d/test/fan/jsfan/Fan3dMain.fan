//
// Copyright (c) 2012, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-02-24  Jed Young  Creation
//

using fgfxOpenGl
using fgfxMath
using fgfxArray
using fgfx3d

class Fan3dMain : GlDisplay
{
  Scene? scene

  Void main()
  {
    prog := Program
    (
       Shader(Str<|varying vec4 vertColor;
                   attribute vec3 aVertexPosition;

                   uniform mat4 uMVMatrix;
                   uniform mat4 uPMatrix;

                   void main(void) {
                      gl_Position = uPMatrix * uMVMatrix * vec4(aVertexPosition, 1.0);
                      vertColor = vec4(0.8, 0.3, 0.9, 1.0);
                   }
                   |>)
        ,
       Shader(Str<|
                   #ifdef GL_ES
                   precision highp float;
                   #endif

                   varying vec4 vertColor;

                   void main(void) {
                      gl_FragColor = vertColor;
                   }
                   |>)
    )

    obj := Primitive
    {
      vertices = [
                    0.0f,  1.0f,  0.0f,
                   -1.0f, -1.0f,  0.0f,
                    1.0f, -1.0f,  0.0f,
                 ]
    }

    renderer := Renderer
    {
      width = w
      height = h
      projection = Transform3D.makePerspective(45f, w.toFloat/h.toFloat, 0.1f, 100.0f)
      program = prog
    }

    scene = Scene
    {
      root.add(obj)
      camera.transform.translate(-1.5f, 0.0f, -7.0f)
      it.renderer = renderer
    }

    open
  }

  override Void init(GlContext gl)
  {
    scene.init(gl)
  }

  override Void onPaint(GlContext gl)
  {
    scene.render(gl)
  }
}

