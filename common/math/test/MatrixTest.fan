//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-07-09  Jed Young  Creation
//

internal class MatrixTest : Test
{
  Void testMatrixInvert()
  {
    Matrix a := Matrix.makeZero(3, 3)
    a.name = "a"
    a.set(0, 0, 5f)
    a.set(0, 1, 1f)
    a.set(0, 2, 1f)
    a.set(1, 0, -6f)
    a.set(1, 1, 2f)
    a.set(1, 2, 0f)
    a.set(2, 0, -5f)
    a.set(2, 1, -5f)
    a.set(2, 2, 0f)

    Matrix? b := null
    try
      b = a.invert
    catch (MatrixErr e)
      e.trace
    b.name = "b"

    Matrix c := b * a
    c.name = "a*b"

    Matrix d := a.invertByAdjoint
    d.name = "-a"

    echo(a)
    echo(b)
    echo(c)
    echo(d)

    verify(b.approx(d))

    Matrix u := Matrix.makeIndentity(c.m)
    verify(c.approx(u))
  }

}