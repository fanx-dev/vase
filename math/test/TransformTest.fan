//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-07-10  Jed Young  Creation
//

internal class TransformTest : Test
{
  Void testPerspective()
  {
    pMatrix := Transform3D.makePerspective(45f, 1f, 0.1f, 100.0f)
    expected := Matrix.make(
    [
       [2.4142136573791504f,  0f,                   0f,                      0f],
       [0f,                   2.4142136573791504f,  0f,                      0f],
       [0f,                   0f,                   -1.0020020008087158f,   -1f],
       [0f,                   0f,                    -0.20020020008087158f,  0f],
    ])

    verify(pMatrix.approx(expected.transpose, 0.00001f))
  }

  Void testTranslate()
  {
    mvMatrix := Transform3D().translate(-1.5f, 0.0f, -7.0f).matrix
    expected := Matrix.make(
    [
      [ 1f,   0f,  0f, 0f],
      [ 0f,   1f,  0f, 0f],
      [ 0f,   0f,  1f, 0f],
      [-1.5f, 0f, -7f, 1f],
    ])
    verify(mvMatrix.approx(expected.transpose))
  }

}