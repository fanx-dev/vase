//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-10-05  Jed Young  Creation
//

using fanvasGraphics
using fanvasWindow
using fanvasMath

**
** Widget is the base class for all UI widgets.
**
@Js
@Serializable
abstract class Widget : DisplayMetrics
{
  **
  ** The unique identifies of widget.
  **
  Str id := ""

  **
  ** A name for style
  **
  Str styleClass := ""
  {
    set
    {
      fireStateChange(&styleClass, it, #styleClass)
      &styleClass = it
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

  **
  ** flag for using renderCache
  **
  Bool staticCache := true

  **
  ** render result cache in bitmap image
  **
  @Transient
  private BufImage? renderCache

  **
  ** invalidate the renderCache bitmap image
  **
  @Transient
  protected Bool dirtyRenderCache := true

  @Transient
  protected Bool layoutDirty := true

  Insets padding := Insets.defVal
  LayoutParam layoutParam := LayoutParam()

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
      fireStateChange(&visible, it, #visible)
      &visible = it
    }
  }

  **
  ** Enabled is used to control whether this widget can
  ** accept user input.  Disabled controls are "grayed out".
  **
  Bool enabled := true
  {
    set
    {
      fireStateChange(&enabled, it, #enabled)
      &enabled = it
    }
  }

  @Transient
  Int x := 0 {
    protected set {
      fireStateChange(&x, it, #x)
      &x = it
    }
  }

  @Transient
  Int y := 0 {
    protected set {
      fireStateChange(&y, it, #y)
      &y = it
    }
  }

  @Transient
  Int width := 50 {
    protected set {
      fireStateChange(&width, it, #width)
      &width = it
    }
  }

  @Transient
  Int height := 50 {
    protected set {
      fireStateChange(&height, it, #height)
      &height = it
    }
  }

  **
  ** Size of this widget.
  **
  @Transient
  Size size {
    get { return Size(width, height) }
    set {
      width = it.w
      height = it.h
    }
  }

  **
  ** Position and size of this widget relative to its parent.
  ** If this a window, this is the position on the screen.
  **
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

  protected Void fireStateChange(Obj? oldValue, Obj? newValue, Field? field) {
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
  protected virtual Void motionEvent(MotionEvent e) {}

  **
  ** process gesture event
  **
  protected virtual Void gestureEvent(GestureEvent e) {}

  **
  ** Post key event
  **
  protected virtual Void keyPress(KeyEvent e) {}

  **
  ** Paints this component.
  **
  Void paint(Graphics g) {
    if (!visible) return
    if (width <= 0 || height <= 0) {
      return
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

    if (staticCache) {
      if (renderCache == null || renderCache.size.w != width || renderCache.size.h != height) {
        renderCache = BufImage.make(Size(width, height))
        dirtyRenderCache = false
        cg := renderCache.graphics
        cg.antialias = true
        doPaint(cg)
        cg.dispose
      }
      else if (dirtyRenderCache) {
        dirtyRenderCache = false
        cg := renderCache.graphics
        cg.antialias = true
        //if (Toolkit.cur.name != "SWT") {
        //  cg.brush = Color.makeArgb(0, 0, 0, 0)
        //} else {
          cg.brush = Color.makeArgb(255, 255, 255, 255)
        //}
        cg.clearRect(0, 0, width, height)
        doPaint(cg)
        cg.dispose
      }

      g.drawImage(renderCache, 0, 0)
    } else {
      doPaint(g)
    }

    //if (effect != null) {
    //  effect.end |tg|{ doPaint(tg) }
    //}
  }

  protected virtual Void doPaint(Graphics g) {
    getRootView.findStyle(this).paint(this, g)
  }

  **
  ** Detach from parent
  **
  virtual Void detach()
  {
    WidgetGroup? p := this.parent
    if (p == null) return
    p.remove(this)
  }

//////////////////////////////////////////////////////////////////////////
// layout
//////////////////////////////////////////////////////////////////////////

  @Transient
  private Int prefWidth := 100
  @Transient
  private Int prefHeight := 50
  @Transient
  private Bool prefSizeDirty := true

  **
  ** Compute the preferred size of this widget by layoutParam
  **
  virtual Dimension canonicalPrefSize(Int parentContentWidth, Int parentContentHeight, Dimension result) {
    hintsWidth := parentContentWidth - layoutParam.margin.left-layoutParam.margin.right
    hintsHeight := parentContentHeight - layoutParam.margin.top-layoutParam.margin.bottom

    pref := prefSize(result)
    w := layoutParam.prefWidth(hintsWidth, pref.w)
    h := layoutParam.prefHeight(hintsHeight, pref.h)
    return result.set(w, h)
  }

  **
  ** preferred size with margin
  **
  protected Dimension bufferedPrefSize(Dimension result) {
    size := prefSize(result)
    return result.set(size.w+layoutParam.margin.left+layoutParam.margin.right
      , size.h+layoutParam.margin.top + layoutParam.margin.bottom)
  }

  **
  ** preferred size without margin
  **
  private Dimension prefSize(Dimension result) {
    if (!prefSizeDirty) {
      return result.set(prefWidth, prefHeight)
    }
    prefSizeDirty = false

    Int w := -1
    Int h := -1

    //using layout size
    w = layoutParam.prefWidth(-1, -1)
    h = layoutParam.prefHeight(-1, -1)

    //layout size if ok
    if (w < 0 || h < 0) {
      s := prefContentSize(result)

      if (w < 0) {
        w = s.w + padding.left + padding.right
      }

      if (h < 0) {
        h = s.h + padding.top + padding.bottom
      }
    }

    prefWidth = w
    prefHeight = h
    return result.set(w, h)
  }

  **
  ** preferred size of content without padding
  **
  protected virtual Dimension prefContentSize(Dimension result) {
    result.w = width
    result.h = height
    return result
  }

  Int contentWidth() {
    width - padding.left - padding.right
  }

  Int bufferedWidth() {
    width + layoutParam.margin.left + layoutParam.margin.right
  }

  Int contentHeight() {
    height - padding.top - padding.bottom
  }

  Int bufferedHeight() {
    height + layoutParam.margin.top + layoutParam.margin.bottom
  }

  **
  ** layout the children
  **
  Void layout(Int x, Int y, Int w, Int h, Dimension result, Bool force) {
    this.x = x
    this.y = y
    this.width = w
    this.height = h

    printInfo("layout: x$x, y$y, w$w, h$h")

    if (layoutDirty || force) {
      layoutChildren(result, force)
    }
    layoutDirty = false
  }

  **
  ** layout the children
  **
  protected virtual Void layoutChildren(Dimension result, Bool force) {}

  **
  ** Requset relayout this widget
  **
  virtual Void requestLayout() {
    this.layoutDirty = true
    this.prefSizeDirty = true
    this.dirtyRenderCache = true
    this.parent?.requestLayout
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
    if (this is RootView) {
      result.set(0, 0)
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
  RootView? getRootView() {
    Widget? x := this
    while (x != null)
    {
      if (x is RootView) return (RootView)x
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
  virtual Void requestPaint(Rect? dirty := null)
  {
    dirtyRenderCache = true
    if (dirty == null) dirty = this.bounds
    //convert dirty coordinate system to realative to parent
    else dirty = Rect(dirty.x + x, dirty.y + y, dirty.w, dirty.h)
    this.parent?.requestPaint(dirty)
  }

//////////////////////////////////////////////////////////////////////////
// Focus
//////////////////////////////////////////////////////////////////////////

  Bool isFocusable := true

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
    if (isFocusable) {
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

  **
  ** print debug info
  **
  Void printInfo(Str msg) {
    if (debug) {
      echo("$typeof.name,id=$id,bounds=$bounds:\t$msg")
    }
  }

  static Bool debug() {
    return Widget#.pod.config("debug", "false") == "true"
  }
}