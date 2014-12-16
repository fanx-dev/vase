//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-07-09  Jed Young  Creation
//

**
** Not a valid matrix operate
**
@Js
const class MatrixErr : Err
{
  new make(Str msg) : super(msg) {}
}

**************************************************************************
**************************************************************************

**
** Modeling a matrix
**
@Js
class Matrix
{
  ** value of matrix elements
  private Float[][] a

  ** num of rows
  Int m

  ** num of columns
  Int n

  ** name for debug
  Str? name

  **
  ** make matrix by given list, there is no copy.
  **
  new make(Float[][] list)
  {
    m = list.size

    //check dimensional
    n = list.first.size
    for (i := 1; i < m; ++i)
    {
      if (n != list[i].size)
      {
        throw MatrixErr("sawtooth matrix")
      }
    }
    a = list
  }

  **
  ** make a matrix that all elements is zero
  **
  new makeZero(Int am, Int an)
  {
    m = am
    n = an

    list := [,]
    for (i := 0; i < m; i++)
    {
      row := Float[,]
      row.fill(0f, n)
      list.add(row)
    }
    a = list
  }

  **
  ** set the value of r row and c column
  **
  Void set(Int r, Int c, Float value)
  {
    a[r][c] = value
  }

  **
  ** return the value at given location
  **
  Float get(Int r, Int c)
  {
    return a[r][c]
  }

  **
  ** return a one-dimensional list
  **
  Float[] flatten()
  {
    f := Float[,] { capacity = m * n }

    for (i := 0; i < n; i++)
      for (j := 0; j < m; j++)
        f.add(get(j, i))

    return f
  }

  **
  ** return a copy of this matrix
  **
  Matrix clone()
  {
    Matrix b := Matrix.makeZero(m, n)
    for (i := 0; i < m; i++)
    {
      for (j := 0; j < n; j++)
      {
        b.a[i][j] = this.get(i, j)
      }
    }
    return b
  }

  **
  ** unit Matrix
  **
  static Matrix makeIndentity(Int n)
  {
    Matrix b := Matrix.makeZero(n, n)
    for (i := 0; i < n; i++)
    {
      b.set(i, i, 1f)
    }
    return b
  }

  **
  ** approximately equal
  **
  Bool approx(Matrix other, Float? tolerance := 1e-10f)
  {
    if (m != other.m) return false
    if (n != other.n) return false
    if (!approxFloatList(this.a, other.a, tolerance)) return false
    return true
  }

  private Bool approxFloatList(Float[][] a, Float[][] b, Float? tolerance)
  {
    for (i := 0; i < m; i++)
    {
      for (j := 0; j < n; j++)
      {
        if (!a[i][j].approx(b[i][j], tolerance))
          return false
      }
    }
    return true
  }

//////////////////////////////////////////////////////////////////////////
// Obj
//////////////////////////////////////////////////////////////////////////

  override Int hash()
  {
    Int prime := 31
    Int result := 1
    result = prime * result + a.hash()
    result = prime * result + m
    result = prime * result + n
    return result
  }

  override Bool equals(Obj? obj)
  {
    if (this === obj) return true
    if (obj === null) return false
    if (this.typeof != obj.typeof) return false
    Matrix other := obj
    if (m != other.m) return false
    if (n != other.n) return false
    if (this.a != other.a) return false
    return true
  }

  override Str toStr()
  {
    Str s := name + ":\n"

    for (i := 0; i < m; i++)
    {
      for (j := 0; j < n; j++)
      {
        s += get(i, j).toLocale("0.0000") + "\t"
      }
      s += "\n"
    }
    return s
  }

//////////////////////////////////////////////////////////////////////////
// operate
//////////////////////////////////////////////////////////////////////////

  **
  ** transpose meaing exchange the row and column
  **
  Matrix transpose()
  {
    Matrix c := Matrix.makeZero(n, m)

    for (i := 0; i < n; i++)
      for (j := 0; j < m; j++)
        c.set(i, j, get(j, i))

    return c
  }

  **
  ** add with another matrix
  **
  @Operator
  Matrix plus(Matrix b)
  {
    Int m2 := b.m
    Int n2 := b.n
    if ((m != m2) || (n != n2)) throw MatrixErr("Dimension don't match")

    Matrix c := Matrix.makeZero(m, n)

    for (i := 0; i < m; i++)
      for (j := 0; j < n; j++)
        c.set(i, j, get(i, j) + b.get(i, j))

    return c
  }

  **
  ** multiply matrix by scalar
  **
  @Operator
  Matrix multFloat(Float k)
  {
    Matrix c := Matrix.makeZero(m, n)

    for (i := 0; i < m; i++)
      for (j := 0; j < n; j++)
        c.set(i, j, get(i, j) * k)

    return c
  }

  **
  ** multiply matrix by matrix
  **
  @Operator
  Matrix multMatrix(Matrix b)
  {
    m2 := b.m
    n2 := b.n
    if (n != m2) throw MatrixErr("Dimension don't match")
    Matrix c := Matrix.makeZero(m, n2)

    for (i := 0; i < m; i++)
    {
      for (j := 0; j < n2; j++)
      {
        Float value := 0f
        for (k := 0; k < n; k++)
        {
          value += get(i, k) * b.get(k, j)
        }
        c.set(i, j, value)
      }
    }

    return c
  }

  **
  ** invert matrix by Gauss algorithm
  **
  Matrix invert()
  {
    if (m != n) throw MatrixErr("Dimension don't match")

    Matrix b := Matrix.makeZero(m, n)
    Matrix a := this.clone

    Int i := 0
    Int j := 0
    Int row := 0
    Int k := 0

    Float max := 0f
    Float temp := 0f

    // unit matrix
    for (i = 0; i < n; i++)
    {
      b.set(i, i, 1f)
    }

    for (k = 0; k < n; k++)
    {
      max = 0f
      row = k
      // find max element, 'row' this max element position
      for (i = k; i < n; i++)
      {
        temp = (a.get(i, k)).abs
        if (max < temp)
        {
          max = temp
          row = i
        }

      }
      if (max == 0f)
      {
        throw MatrixErr("not exist invert matrix")
      }
      // exchange row k with 'row'
      if (row != k)
      {
        for (j = 0; j < n; j++)
        {
          temp = a.get(row, j)
          a.set(row, j, a.get(k, j))
          a.set(k, j, temp)

          temp = b.get(row, j)
          b.set(row, j, b.get(k, j))
          b.set(k, j, temp)
        }
      }

      // first element to 1
      for (j = k + 1; j < n; j++)
        a.set(k, j, (a.get(k, j) / a.get(k, k)))
      for (j = 0; j < n; j++)
        b.set(k, j, (b.get(k, j) / a.get(k, k)))

      a.set(k, k, 1f)

      // k column to 0
      // for a
      for (j = k + 1; j < n; j++)
      {
        for (i = 0; i < k; i++)
          a.set(i, j, a.get(i, j) - (a.get(i, k) * a.get(k, j)))
        for (i = k + 1; i < n; i++)
          a.set(i, j, a.get(i, j) - (a.get(i, k) * a.get(k, j)))
      }
      // for b
      for (j = 0; j < n; j++)
      {
        for (i = 0; i < k; i++)
          b.set(i, j, b.get(i, j) - (a.get(i, k) * b.get(k, j)))
        for (i = k + 1; i < n; i++)
          b.set(i, j, b.get(i, j) - (a.get(i, k) * b.get(k, j)))
      }
      for (i = 0; i < n; i++)
        a.set(i, k, 0f)
      a.set(k, k, 1f)
    }

    return b
  }

  **
  ** invert matrix by adjoint
  **
  Matrix invertByAdjoint()
  {
    Float d := determinant
    if (d == 0f) throw MatrixErr("not exist invert matrix")

    Matrix Ax := adjoint
    Matrix An := Ax.multFloat(1.0f / d)
    return An
  }

  **
  ** algebraic cofactor
  **
  Float cofactor(Int ai, Int aj)
  {
    if (m != n) throw MatrixErr("Dimension don't match")

    n2 := n - 1
    Matrix b := Matrix.makeZero(n2, n2)

    // left up
    for (Int i := 0; i < ai; i++)
    {
      for (Int j := 0; j < aj; j++)
      {
        b.set(i, j, get(i, j))
      }
    }

    // right down
    for (Int i := ai; i < n2; i++)
    {
      for (Int j := aj; j < n2; j++)
      {
        b.set(i, j, get(i + 1, j + 1))
      }
    }

    // right up
    for (Int i := 0; i < ai; i++)
    {
      for (Int j := aj; j < n2; j++)
      {
        b.set(i, j, get(i, j + 1))
      }
    }

    // left down
    for (Int i := ai; i < n2; i++)
    {
      for (Int j := 0; j < aj; j++)
      {
        b.set(i, j, get(i + 1, j))
      }
    }

    // sign
    if ((ai + aj) % 2 != 0)
    {
      for (Int i := 0; i < n2; i++)
      {
        b.set(i, 0, -b.get(i, 0))
      }
    }
    return b.determinant
  }

  **
  ** determinant of matrix
  **
  Float determinant()
  {
    if (m != n) throw MatrixErr("Dimension don't match")
    if (n == 1) return get(0, 0)

    Float d := 0f
    for (i := 0; i < n; i++)
    {
      d += get(1, i) * cofactor(1, i)
    }
    return d
  }

  **
  ** adjoint matrix
  **
  Matrix adjoint()
  {
    c := Matrix.makeZero(m, n)

    for (i := 0; i < m; i++)
      for (j := 0; j < n; j++)
        c.set(i, j, cofactor(j, i))

    return c
  }
}

