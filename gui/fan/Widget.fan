//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-10-05  Jed Young  Creation
//

using vaseGraphics
using vaseWindow
using vaseMath

**
** Widget is the base class for all UI widgets.
**
@Js
@Serializable
abstract class Widget
{
  **
  ** The unique identifies of widget.
  **
  Str id := ""

  **
  ** A name for style
  **
  Str style := ""
  {
    set
    {
      oldVal := &style
      &style = it
      fireStateChange(oldVal, it, #style)
    }
  }

  **
  ** current transform as animation target
  **
  @Transient
  Transform2D? transform

  **
  ** current alpha as animation target
  ** range in [0,1]
  **
  @Transient
  Float? alpha

  **
  ** current render effect
  **
  //Effect? effect

  Bool clip := true

  **
  ** flag for using renderCache
  **
  protected Bool useRenderCache := false

  **
  ** render result cache in bitmap image
  **
  @Transient
  private Image? renderCacheImage

  **
  ** invalidate the renderCache bitmap image
  **
  @Transient
  protected Bool renderCacheDirty := true

  @Transient
  protected Int layoutDirty := 1

  Insets padding := Insets.defVal

  **
  ** out side bounder
  **
  Insets margin := Insets.defVal

  **
  ** Layout params
  **
  Layout layout := Layout()

  @Transient
  private Style? styleObj := null
  
  @Transient
  protected |Widget|? onClickCallback := null
  Void onClick(|Widget| c) { onClickCallback =  c }
  
  @Transient
  protected |Widget|? onLongPressCallback := null
  Void onLongPress(|Widget| c) { onLongPressCallback =  c }

//////////////////////////////////////////////////////////////////////////
// State
//////////////////////////////////////////////////////////////////////////

  **
  ** Controls whether this widget is visible or hidden.
  **
  Bool visible := true
  {
    set
    {
      oldVal := &visible
      &visible = it
      fireStateChange(oldVal, it, #visible)
    }
  }

  **
  ** Enabled is used to control whether this widget can
  ** accept user input.  Disabled controls are "grayed out".
  **
  Bool enabled := true

  @Transient
  protected Int x := 0

  @Transient
  protected Int y := 0

  @Transient
  protected Int width := 0

  @Transient
  protected Int height := 0

  **
  ** Size of this widget.
  **
//  @Transient
//  Size size {
//    get { return Size(width, height) }
//    set {
//      width = it.w
//      height = it.h
//    }
//  }

  **
  ** Position and size of this widget relative to its parent.
  ** If this a window, this is the position on the screen.
  **
/*
  @Transient
  Rect bounds
  {
    get { return Rect.make(x, y, width, height) }
    set {
      x = it.x
      y = it.y
      width = it.w
      height = it.h
    }
  }
*/

  protected Void fireStateChange(Obj? oldValue, Obj? newValue, Field? field) {
    if (oldValue == newValue) return
    e := StateChangedEvent (oldValue, newValue, field, this )
    onStateChanged.fire(e)
  }

  **
  ** Callback function when Widget state changed
  **
  once EventListeners onStateChanged() { EventListeners() }

//////////////////////////////////////////////////////////////////////////
// Widget Tree
//////////////////////////////////////////////////////////////////////////

  **
  ** Get this widget's parent or null if not mounted.
  **
  @Transient
  WidgetGroup? parent { private set }

  internal Void setParent(WidgetGroup? p) { parent = p }

  **
  ** Find widget by id in descendant
  **
  virtual Widget? findById(Str id) { if (this.id == id) return this; else return null }

  **
  ** process motion event
  **
  protected virtual Void motionEvent(MotionEvent e) {
    if (gestureFocusable && e.type == MotionEvent.pressed && !e.consumed) {
      getRootView?.gestureFocus(this)
      e.consume
    }
  }

  **
  ** process gesture event
  **
  protected virtual Void gestureEvent(GestureEvent e) {
    if (onClickCallback != null && e.type == GestureEvent.click) {
      //this.focus
      clicked
      e.consume
    }
    else if (onLongPressCallback != null && e.type == GestureEvent.longPress) {
      //this.focus
      onLongPressCallback.call(this)
      e.consume
    }
  }
  
  protected virtual Void clicked() {
    try {
      this.scaleAnim(0.95).start
      onClickCallback?.call(this)
    } catch (Err e) {
      e.trace
    }
  }

  **
  ** Post key event
  **
  protected virtual Void keyEvent(KeyEvent e) {}

  **
  ** Paints this component.
  **
  Void paint(Graphics g) {
    if (!visible) return
    if (width <= 0 || height <= 0) {
      return
    }

    if (clip) {
      g.clip(Rect(0, 0, width, height))
    }

    if (transform != null) {
      g.transform(transform)
    }
    if (alpha != null) {
      g.alpha = (alpha * 255).toInt
    }

    //if (effect != null) {
    //  g = effect.prepare(this, g)
    //}

    if (useRenderCache) {
      if (renderCacheImage == null || renderCacheImage.size.w != width || renderCacheImage.size.h != height) {
        renderCacheImage = Image.make(Size(width, height))
        renderCacheDirty = false
        cg := renderCacheImage.graphics
        cg.antialias = true
        doPaint(cg)
        cg.dispose
      }
      else if (renderCacheDirty) {
        renderCacheDirty = false
        cg := renderCacheImage.graphics
        cg.antialias = true
        //if (Toolkit.cur.name != "SWT") {
        //  cg.brush = Color.makeArgb(0, 0, 0, 0)
        //} else {
        //  cg.brush = Color.makeArgb(255, 255, 255, 255)
        //}
        //cg.clearRect(0, 0, width, height)
        doPaint(cg)
        cg.dispose
      }

      g.drawImage(renderCacheImage, 0, 0)
    } else {
      doPaint(g)
    }

    //if (effect != null) {
    //  effect.end |tg|{ doPaint(tg) }
    //}
  }

  Int dpToPixel(Int d) { DisplayMetrics.dpToPixel(d.toFloat) }
  Int pixelToDp(Int d) { DisplayMetrics.pixelToDp(d).toInt }

  protected Style getStyle() {
    if (styleObj == null) {
      styleObj = getRootView.findStyle(this)
    }
    return styleObj
  }

  Void setStyle(Style s) { styleObj = s }

  virtual Void resetStyle() {
    styleObj = null
  }

  protected virtual Void doPaint(Graphics g) {
    getStyle.paint(this, g)
    //debug
    if (debug) {
      //g.brush = Color.black
      //g.drawLine(0, 0, width, height)
      //g.drawLine(width, 0, 0, height)
      g.brush = Color.red
      g.pen = Pen { it.width = 1 }
      g.drawRect(1, 1, width-2, height-2)
    }
  }

  **
  ** Detach from parent
  **
  virtual Void detach(Bool doRelayout := true)
  {
    WidgetGroup? p := this.parent
    if (p == null) return
    p.remove(this, doRelayout)
  }

//////////////////////////////////////////////////////////////////////////
// layout
//////////////////////////////////////////////////////////////////////////

//  @Transient
//  private Int prefWidth := 100
//  @Transient
//  private Int prefHeight := 50
//  @Transient
//  private Bool prefSizeDirty := true

  **
  ** preferred size with margin
  **
  protected Size bufferedPrefSize(Int parentContentWidth := -1, Int parentContentHeight := -1) {
    size := prefSize(parentContentWidth, parentContentHeight)
    return Size(size.w+dpToPixel((margin.left + margin.right))
      , size.h+dpToPixel((margin.top + margin.bottom)))
  }

  **
  ** preferred size without margin
  **
  virtual Size prefSize(Int parentContentWidth := -1, Int parentContentHeight := -1) {
//    if (!prefSizeDirty) {
//      return result.set(prefWidth, prefHeight)
//    }
//    prefSizeDirty = false

    hintsWidth := parentContentWidth - dpToPixel((margin.left + margin.right))
    hintsHeight := parentContentHeight - dpToPixel((margin.top + margin.bottom))

    Int w := -1
    Int h := -1

    //using layout size
    w = (layout.prefWidth(this, hintsWidth, -1))
    h = (layout.prefHeight(this, hintsHeight, -1))

    //get layout fail
    if (w < 0 || h < 0) {
      s := prefContentSize(hintsWidth, hintsHeight)

      if (w < 0) {
        w = s.w + dpToPixel((padding.left + padding.right))
      }

      if (h < 0) {
        h = s.h + dpToPixel((padding.top + padding.bottom))
      }
    }

//    prefWidth = w
//    prefHeight = h
    return Size(w, h)
  }

  **
  ** preferred size of content without padding
  **
  protected virtual Size prefContentSize(Int hintsWidth := -1, Int hintsHeight := -1) {
    return Size(dpToPixel(50), dpToPixel(50))
  }

  Int contentWidth() {
    width - dpToPixel((padding.left + padding.right))
  }

  Int contentHeight() {
    height - dpToPixel((padding.top + padding.bottom))
  }

  Int bufferedWidth() {
    width + dpToPixel((margin.left + margin.right))
  }

  Int bufferedHeight() {
    height + dpToPixel((margin.top + margin.bottom))
  }

  Int paddingLeft() {
    dpToPixel(padding.left)
  }

  Int paddingTop() {
    dpToPixel(padding.top)
  }

  **
  ** layout the children
  **
  Void setLayout(Int x, Int y, Int w, Int h, Bool force) {
    this.x = x + dpToPixel(margin.left)
    this.y = y + dpToPixel(margin.top)
    this.width = w - dpToPixel((margin.left + margin.right))
    this.height = h - dpToPixel((margin.top + margin.bottom))

    //printInfo("layout: x$this.x, y$this.y, w$this.width, h$this.height")

    if (layoutDirty > 0 || force) {
      layoutChildren(force || layoutDirty>1)
    }
    layoutDirty = 0
  }

  **
  ** layout the children
  **
  protected virtual Void layoutChildren(Bool force) {}

  **
  ** Requset relayout this widget
  **
  virtual Void relayout() {
    this.layoutDirty = 1
    //this.prefSizeDirty = true
    this.renderCacheDirty = true
    this.parent?.relayout
  }

//////////////////////////////////////////////////////////////////////////
// rootView
//////////////////////////////////////////////////////////////////////////

  **
  ** relative coordinate
  **
  Bool contains(Int rx, Int ry) {
    if (rx < x || rx > x+width) {
      return false
    }
    if (ry < y || ry > y+height) {
      return false
    }
    return true
  }

  **
  ** Get the position of this widget relative to the window.
  ** If not on mounted on the screen then return null.
  **
  Bool posOnWindow(Coord result)
  {
    if (this is Frame) {
      result.set(0f, 0f)
      return true
    }
    if (parent == null) return false
    parentOnWid := parent.posOnWindow(result)
    if (parentOnWid == false) return false

    result.x += x
    result.y += y
    return true
  }

  **
  ** Translates absolute coordinates into coordinates in the coordinate space of this component.
  **
  Bool mapToRelative(Coord p)
  {
    x := p.x
    y := p.y
    posOW := parent.posOnWindow(p)
    if (posOW == false) return false

    p.x = x - p.x
    p.y = y - p.y
    return true
  }

  **
  **  Translates absolute coordinates into relative this widget
  **
  Bool mapToWidget(Coord p)
  {
    x := p.x
    y := p.y
    posOW := this.posOnWindow(p)
    if (posOW == false) return false

    p.x = x - p.x
    p.y = y - p.y
    return true
  }

  **
  ** Get this widget's parent View or null if not
  ** mounted under a View widget.
  **
  Frame? getRootView() {
    Widget? x := this
    while (x != null)
    {
      if (x is Frame) return (Frame)x
      x = x.parent
    }
    return null
  }

//////////////////////////////////////////////////////////////////////////
// repaint
//////////////////////////////////////////////////////////////////////////

  **
  ** Repaints the specified rectangle.
  **
  virtual Void repaint(Rect? dirty := null)
  {
    renderCacheDirty = true
    //convert dirty coordinate system to realative to parent
    if (dirty != null) dirty = Rect(dirty.x + x, dirty.y + y, dirty.w, dirty.h)
    this.parent?.repaint(dirty)
  }

//////////////////////////////////////////////////////////////////////////
// Focus
//////////////////////////////////////////////////////////////////////////

  Bool focusable := false
  Bool gestureFocusable := false

  **
  ** Return if this widget is the focused widget which
  ** is currently receiving all keyboard input.
  **
  virtual Bool hasFocus()
  {
    root := getRootView
    return root.isFocusWidiget(this)
  }

  **
  ** Attempt for this widget to take the keyboard focus.
  **
  virtual Void focus() {
    if (focusable) {
      getRootView.focusIt(this)
    }
  }

  **
  ** callback when lost focus or gains focus.
  **
  once EventListeners onFocusChanged() { EventListeners() }

  **
  ** Callback when mouse exits this widget's bounds.
  **
  protected virtual Void mouseExit() {}

  **
  ** Callback when mouse enters this widget's bounds.
  **
  protected virtual Void mouseEnter() {}

  **
  ** Callback this widget mounted.
  **
  protected virtual Void onMounted() {}


  @NoDoc
  protected static Bool debug() {
    if (Env.cur.runtime != "js" && Toolkit.cur.name != "Android") {
      return Widget#.pod.config("debug", "false") == "true"
    } else {
      return false
    }
  }
  
}
