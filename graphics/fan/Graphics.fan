//
// Copyright (c) 2008, Brian Frank and Andy Frank
// Licensed under the Academic Free License version 3.0
//
// History:
//   25 Jun 08  Brian Frank  Creation
//   2012-07-02 Jed Young Modify
//

**
** Graphics is used to draw 2D graphics.  Targets might include
** display devices, printers, SVG/Canvas, or PDF.
**
** See [Fwt]`fwt::pod-doc#painting` for details.
**
@Js
mixin Graphics
{

  **
  ** Current brush defines how text and shapes are filled.
  **
  abstract Brush brush

  **
  ** Current pen defines how the shapes are stroked.
  **
  abstract Pen pen

  **
  ** Current font used for drawing text.
  **
  abstract Font? font

  **
  ** Used to toggle anti-aliasing on and off.
  **
  abstract Bool antialias

  **
  ** Current alpha value used to render text, images, and shapes.
  ** The value must be between 0 (transparent) and 255 (opaue).
  **
  abstract Int alpha

  **
  ** Width of the stroke, default is 1.
  **
  abstract Float lineWidth

  **
  ** current composition operation
  **
  abstract Composite composite

  **
  ** Draw a line with the current pen and brush.
  **
  abstract This drawLine(Int x1, Int y1, Int x2, Int y2)

  **
  ** Draw a polyline with the current pen and brush.
  **
  abstract This drawPolyline(PointArray ps)

  **
  ** Draw a polygon with the current pen and brush.
  **
  abstract This drawPolygon(PointArray ps)

  **
  ** Fill a polygon with the current brush.
  **
  abstract This fillPolygon(PointArray ps)

  **
  ** Draw a rectangle with the current pen and brush.
  **
  abstract This drawRect(Int x, Int y, Int w, Int h)

  **
  ** Fill a rectangle with the current brush.
  **
  abstract This fillRect(Int x, Int y, Int w, Int h)

  **
  ** clear a rectangle color to 0.
  **
  abstract This clearRect(Int x, Int y, Int w, Int h)

  **
  ** Draw a rectangle with rounded corners with the current pen and brush.
  **
  abstract This drawRoundRect(Int x, Int y, Int w, Int h, Int xRadius, Int yRadius)

  **
  ** Fill a rectangle with rounded corners with the current brush.
  **
  abstract This fillRoundRect(Int x, Int y, Int w, Int h, Int xRadius, Int yRadius)

  **
  ** Draw an oval with the current pen and brush.  The
  ** oval is fit within the rectangle specified by x, y, w, h.
  **
  abstract This drawOval(Int x, Int y, Int w, Int h)

  **
  ** Fill an oval with the current brush.  The oval is
  ** fit within the rectangle specified by x, y, w, h.
  **
  abstract This fillOval(Int x, Int y, Int w, Int h)

  **
  ** Draw an arc with the current pen and brush.  The angles
  ** are measured in degrees with 0 degrees is 3 o'clock with
  ** a counter-clockwise arcAngle.  The origin of the arc is
  ** centered within x, y, w, h.
  **
  abstract This drawArc(Int x, Int y, Int w, Int h, Int startAngle, Int arcAngle)

  **
  ** Fill an arc with the current brush.  The angles are
  ** measured in degrees with 0 degrees is 3 o'clock with
  ** a counter-clockwise arcAngle.  The origin of the arc is
  ** centered within x, y, w, h.
  **
  abstract This fillArc(Int x, Int y, Int w, Int h, Int startAngle, Int arcAngle)

  **
  ** Draw a the text string with the current brush and font.
  ** The x, y coordinate specifies the baseline where the text is to be drawn.
  **
  abstract This drawText(Str s, Int x, Int y)

  abstract This drawTextOutline(Str s, Int x, Int y)

  **
  ** Draw a the image string with its top left corner at x,y.
  **
  abstract This drawImage(Image image, Int x, Int y)

  **
  ** Copy a rectangular region of the image to the graphics
  ** device.  If the source and destination don't have the
  ** same size, then the copy is resized.
  **
  abstract This copyImage(Image image, Rect src, Rect dest)

  **
  ** Set the clipping area to the intersection of the
  ** current clipping region and the specified rectangle.
  ** Also see `clipBounds`.
  **
  abstract This clip(Rect r)

  **
  ** Get the bounding rectangle of the current clipping area.
  ** Also see `clip`.
  **
  abstract Rect clipBounds()

  **
  ** Push the current graphics state onto an internal
  ** stack.  Reset the state back to its current state
  ** via `pop`.
  **
  abstract Void push()

  **
  ** Pop the graphics stack and reset the state to the
  ** the last push.
  **
  abstract Void pop()

  **
  ** Free any operating system resources used by this instance.
  **
  abstract Void dispose()

  **
  ** Draws the path described by the parameter.
  **
  abstract This drawPath(GraphicsPath path)

  **
  ** Fills the path described by the parameter.
  **
  abstract This fillPath(GraphicsPath path)

  **
  ** concat transform to currently
  **
  abstract This transform(Transform2D mat)

  **
  ** create a new clipping region by calculating the intersection of
  ** the current clipping region and the area described by the current path
  **
  abstract This clipPath(GraphicsPath path)

  **
  ** All drawing operations are affected by the four global shadow attributes
  **
  abstract This setShadow(Shadow? shadow)

}