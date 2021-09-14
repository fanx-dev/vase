//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2021-9-9  Jed Young  Creation
//
using vaseMath
using vaseGraphics

internal class NGraphics : Graphics
{
  private Int handle
  private GraphicsState[] stack = [,]

  **
  ** Current brush defines how text and shapes are filled.
  **
  override Brush brush = Color.black

  **
  ** Current pen defines how the shapes are stroked.
  **
  override Pen pen = Pen.defVal

  **
  ** Current font used for drawing text.
  **
  override Font? font

  **
  ** Used to toggle anti-aliasing on and off.
  **
  override Bool antialias = false

  **
  ** Current alpha value used to render text, images, and shapes.
  ** The value must be between 0 (transparent) and 255 (opaue).
  **
  override Int alpha = 255

  **
  ** current composition operation
  **
  override Composite composite = Composite.srcOver

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
  native override This drawImage(Image image, Int x, Int y)

  **
  ** Copy a rectangular region of the image to the graphics
  ** device.  If the source and destination don't have the
  ** same size, then the copy is resized.
  **
  native override This copyImage(Image image, Rect src, Rect dest)

  **
  ** Set the clipping area to the intersection of the
  ** current clipping region and the specified rectangle.
  ** Also see `clipBounds`.
  **
  override This clip(Rect r) {
    this.clipRect = this.clipRect.intersection(r);
    doClip(r)
    return this
  }
  private native Void doClip(Rect r)

  **
  ** Get the bounding rectangle of the current clipping area.
  ** Also see `clip`.
  **
  override Rect clipBounds() { clipRect }
  private Rect? clipRect

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
      it.clip = this.clipRect
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
    this.clipRect = state.clip
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
  native override This transform(Transform2D mat)

  **
  ** create a new clipping region by calculating the intersection of
  ** the current clipping region and the area described by the current path
  **
  native override This clipPath(GraphicsPath path)

  **
  ** All drawing operations are affected by the four global shadow attributes
  **
  native override This setShadow(Shadow? shadow)

  protected override Void finalize() { dispose }
}

internal class GraphicsState {
  Pen pen
  Brush brush
  Font? font
  Bool antialias
  Int alpha
  Transform2D transform
  Rect clip
  Composite composite
  new make(|This| f) { f(this) }
}
