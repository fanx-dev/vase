//
// Copyright (c) 2014, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2014-11-14  Jed Young  Creation
//

using vaseGraphics
using vaseWindow
using vaseMath


@Js
class BlurEffect : Effect {
  protected Image? bufImage
  protected Graphics? originalGraphics
  protected Bool gray := false

  protected Image tryMakeImage(Image? img, Size size) {
    //SWT not support clearRect
    if (Toolkit.cur.name == "SWT") {
      img = null
    }

    if (img != null) {
      if (img.size != size) {
        img = null
      }
    }
    if (img == null) {
      img = Image.make(size)
    }

    return img
  }

  override Graphics prepare(Widget widget, Graphics g) {
    bufImage = tryMakeImage(bufImage, Size(widget.width, widget.height))
    originalGraphics = g
    imageGraphics := bufImage.graphics
    imageGraphics.brush = Color.makeArgb(0, 0, 0, 0)
    imageGraphics.clearRect(0, 0, widget.width, widget.height)
    return imageGraphics
  }

  protected virtual Void filter(Image bufImage) {
    w := bufImage.size.w
    h := bufImage.size.h

    Int[][] matrix := [[0,0,0],[0,0,0],[0,0,0]]
    Int[] values := [,] { size = 9 }

    for (i:=0; i < w; ++i)
    {
      for (j:=0; j < h; ++j)
      {
        readPixel(bufImage, i, j, values)
        fillMatrix(matrix, values)
        c := avgMatrix(matrix)
        bufImage.setPixel(i, j, c)
      }
    }
  }

  private static Void readPixel(Image img, Int x, Int y, Int[]  pixels)
  {
    Int xStart := x - 1;
    Int yStart := y - 1;
    Int current := 0;
    w := img.size.w
    h := img.size.h
    for (i := xStart; i < 3 + xStart; i++)
    {
      for (j := yStart; j < 3 + yStart; j++)
      {
        tx := i;
        if (tx < 0) {
            tx = x;
        }
        else if (tx >= w) {
            tx = x;
        }

        ty := j;
        if (ty < 0) {
            ty = y;
        }
        else if (ty >= h) {
            ty = y;
        }
        pixels[current++] = img.getPixel(tx, ty)
      }
    }
  }

  private static Void fillMatrix(Int[][] matrix, Int[] values)
  {
      Int filled := 0
      for (i := 0; i < matrix.size; i++)
      {
          Int[] x := matrix[i]
          for (j := 0; j < x.size; j++)
          {
              x[j] = values[filled++]
          }
      }
  }

  private Int avgMatrix(Int[][] matrix)
  {
    r := 0
    g := 0
    b := 0
    a := 0
    for (i := 0; i < matrix.size; i++)
    {
      Int[] x := matrix[i];
      for (j := 0; j < x.size; j++)
      {
        Int c := x[j];
        r += Color.getR(c)
        g += Color.getG(c)
        b += Color.getB(c)
        a += Color.getA(c)
      }
    }

    a /= 9
    r /= 9
    g /= 9
    b /= 9
    if (gray) {
      p := (r+g+b)/3
      return Color.fromArgb(a, p, p, p)
    }

    return Color.fromArgb(a, r, g, b)
  }

  override Void end(|Graphics| paint) {
    filter(bufImage)
    originalGraphics.drawImage(bufImage, 0, 0)
  }
}