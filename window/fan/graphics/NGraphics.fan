//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2021-9-9  Jed Young  Creation
//
using vaseGraphics

internal class NGraphics : Graphics
{
  private Int handle
  private Image? bitmap
  
  private GraphicsState[] stack = [,]


  new make(Int handle) {
    this.handle = handle
    init()
  }

  private native Void init()

  **
  ** Current brush defines how text and shapes are filled.
  **
  override Brush brush = Color.black {
    set {
      &brush = it
      if (it is Color) {
        c := (Color)it
        setColor(c.a, c.r, c.g, c.b)
      }
      else if (it is Pattern) {
        setPattern((Pattern)it)
      }
      else if (it is Gradient) {
        setGradient((Gradient)it)
      }
      else {
        throw UnsupportedErr("it.typeof")
      }
    }
  }
  private native Void setColor(Int a, Int r, Int g, Int b)
  private native Void setPattern(Pattern pattern)
  private native Void setGradient(Gradient gradient)

  **
  ** Current pen defines how the shapes are stroked.
  **
  override Pen pen = Pen.defVal {
    set {
      &pen = it
      setPen(it.width, it.cap, it.join, it.dash)
    }
  }
  private native Void setPen(Int width, Int cap, Int join, Int[]? dash)

  **
  ** Current font used for drawing text.
  **
  override Font? font { set {
    &font = it
    if (it != null) setFont(it, ((NFont)it).handle, it.name, it.size, 0) 
  } }
  private native Void setFont(Font font, Int id, Str name, Int size, Int blur)

  **
  ** Used to toggle anti-aliasing on and off.
  **
  override Bool antialias = false { set { &antialias = it; setAntialias(it) } }
  private native Void setAntialias(Bool antialias)

  **
  ** Current alpha value used to render text, images, and shapes.
  ** The value must be between 0 (transparent) and 255 (opaue).
  **
  override Int alpha = 255 { set { &alpha = it; setAlpha(it) } }
  private native Void setAlpha(Int alpha)

  **
  ** current composition operation
  **
  override Composite composite = Composite.srcOver { set { &composite = it; setComposite(it.ordinal) } }
  private native Void setComposite(Int composite)

  **
  ** Draw a line with the current pen and brush.
  **
  native override This drawLine(Int x1, Int y1, Int x2, Int y2)

  **
  ** Draw a polyline with the current pen and brush.
  **
  native override This drawPolyline(PointArray ps)

  **
  ** Draw a polygon with the current pen and brush.
  **
  native override This drawPolygon(PointArray ps)

  **
  ** Fill a polygon with the current brush.
  **
  native override This fillPolygon(PointArray ps)

  **
  ** Draw a rectangle with the current pen and brush.
  **
  native override This drawRect(Int x, Int y, Int w, Int h)

  **
  ** Fill a rectangle with the current brush.
  **
  native override This fillRect(Int x, Int y, Int w, Int h)

  **
  ** clear a rectangle with the current brush.
  **
  native override This clearRect(Int x, Int y, Int w, Int h)

  **
  ** Draw a rectangle with rounded corners with the current pen and brush.
  ** The ellipse of the corners is specified by wArc and hArc.
  **
  native override This drawRoundRect(Int x, Int y, Int w, Int h, Int wArc, Int hArc)

  **
  ** Fill a rectangle with rounded corners with the current brush.
  ** The ellipse of the corners is specified by wArc and hArc.
  **
  native override This fillRoundRect(Int x, Int y, Int w, Int h, Int wArc, Int hArc)

  **
  ** Draw an oval with the current pen and brush.  The
  ** oval is fit within the rectangle specified by x, y, w, h.
  **
  native override This drawOval(Int x, Int y, Int w, Int h)

  **
  ** Fill an oval with the current brush.  The oval is
  ** fit within the rectangle specified by x, y, w, h.
  **
  native override This fillOval(Int x, Int y, Int w, Int h)

  **
  ** Draw an arc with the current pen and brush.  The angles
  ** are measured in degrees with 0 degrees is 3 o'clock with
  ** a counter-clockwise arcAngle.  The origin of the arc is
  ** centered within x, y, w, h.
  **
  native override This drawArc(Int x, Int y, Int w, Int h, Int startAngle, Int arcAngle)

  **
  ** Fill an arc with the current brush.  The angles are
  ** measured in degrees with 0 degrees is 3 o'clock with
  ** a counter-clockwise arcAngle.  The origin of the arc is
  ** centered within x, y, w, h.
  **
  native override This fillArc(Int x, Int y, Int w, Int h, Int startAngle, Int arcAngle)

  **
  ** Draw a the text string with the current brush and font.
  ** The x, y coordinate specifies the top left corner of
  ** the rectangular area where the text is to be drawn.
  **
  native override This drawText(Str s, Int x, Int y)

  **
  ** Draw a the image string with its top left corner at x,y.
  **
  override This drawImage(Image image, Int x, Int y) {
    size := image.size
    doDrawImage(image, 0, 0, size.w, size.h, x, y, size.w, size.h)
    return this
  }

  **
  ** Copy a rectangular region of the image to the graphics
  ** device.  If the source and destination don't have the
  ** same size, then the copy is resized.
  **
  override This copyImage(Image image, Rect src, Rect dst) {
    doDrawImage(image, src.x, src.y, src.w, src.h, dst.x, dst.y, dst.w, dst.h)
    return this
  }

  private native Void doDrawImage(Image image, Int srcX, Int srcY, Int srcW, Int srcH, Int dstX, Int dstY, Int dstW, Int dstH)

  **
  ** Set the clipping area to the intersection of the
  ** current clipping region and the specified rectangle.
  ** Also see `clipBounds`.
  **
  override This clip(Rect r) {
    if (clipBound == null) clipBound = r
    else this.clipBound = this.clipBound.intersection(r);
    doClip(r.x, r.y, r.w, r.h)
    return this
  }
  private native Void doClip(Int x, Int y, Int w, Int h)

  **
  ** Get the bounding rectangle of the current clipping area.
  ** Also see `clip`.
  **
  override Rect clipBounds() { clipBound }
  private Rect? clipBound

  **
  ** Push the current graphics state onto an internal
  ** stack.  Reset the state back to its current state
  ** via `pop`.
  **
  override Void push() {
    state := GraphicsState {
      it.pen = this.pen
      it.brush = this.brush
      it.font = this.font
      it.antialias = this.antialias
      it.alpha = this.alpha
      //it.transform = this.transform
      it.clip = this.clipBound
      it.composite = this.composite
    }
    stack.push(state)
    pushNative
  }
  private native Void pushNative()

  **
  ** Pop the graphics stack and reset the state to the
  ** the last push.
  **
  override Void pop() {
    popNative
    state := stack.pop
    this.pen = state.pen
    this.brush = state.brush
    this.font = state.font
    this.antialias = state.antialias
    this.alpha = state.alpha
    //this.transform = state.transform
    this.clipBound = state.clip
    this.composite = state.composite
  }
  private native Void popNative()

  **
  ** Free any operating system resources used by this instance.
  **
  native override Void dispose()

  **
  ** Draws the path described by the parameter.
  **
  native override This drawPath(GraphicsPath path)

  **
  ** Fills the path described by the parameter.
  **
  native override This fillPath(GraphicsPath path)

  **
  ** the transform that is currently being used
  **
  override This transform(Transform2D trans) {
    doTransform(
       trans.a,
       trans.b,
       trans.c,
       trans.d,
       trans.e,
       trans.f
     )
    return this
  }
  private native Void doTransform(Float a, Float b, Float c, Float d, Float e, Float f)

  **
  ** create a new clipping region by calculating the intersection of
  ** the current clipping region and the area described by the current path
  **
  native override This clipPath(GraphicsPath path)

  **
  ** All drawing operations are affected by the four global shadow attributes
  **
  override This setShadow(Shadow? shadow) {
    if (shadow != null) {
      doSetShadow(true, shadow.blur, shadow.offsetX, shadow.offsetY, shadow.color.a, shadow.color.r, shadow.color.g, shadow.color.b)
    }
    else {
      doSetShadow(false, 0, 0, 0, 0, 0, 0, 0)
    }
    return this
  }
  native private Void doSetShadow(Bool valide, Int blur, Int offsetX, Int offsetY, Int a, Int r, Int g, Int b)

  //protected override Void finalize() { dispose }
}

internal class GraphicsState {
  Pen pen
  Brush brush
  Font? font
  Bool antialias
  Int alpha
  Transform2D? transform
  Rect? clip
  Composite composite
  new make(|This| f) { f(this) }
}
