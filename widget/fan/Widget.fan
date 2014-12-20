//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-10-05  Jed Young  Creation
//

using fgfxGraphics
using fgfxWtk
using fgfxMath

**
** Widget is the base class for all UI widgets.
**
@Js
abstract class Widget
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
      e := StateChangedEvent (&styleClass, it, #styleClass, this )
      onStateChanged.fire(e)
      &styleClass = it
    }
  }


  Transform2D? transform
  Float? alpha
  Effect? effect
  
  Bool staticCache := true
  private BufImage? renderCache
  private Bool dirtyRenderCache := true

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
      e := StateChangedEvent (&visible, it, #visible, this )
      onStateChanged.fire(e)
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
      e := StateChangedEvent (&enabled, it, #enabled, this )
      onStateChanged.fire(e)
      &enabled = it
    }
  }

  Int x := 0 {
    protected set {
      e := StateChangedEvent (&x, it, #x, this )
      onStateChanged.fire(e)
      &x = it
    }
  }
  
  Int y := 0 {
    protected set {
      e := StateChangedEvent (&y, it, #y, this )
      onStateChanged.fire(e)
      &y = it
    }
  }
  
  Int width := 50 {
    protected set {
      e := StateChangedEvent (&width, it, #width, this )
      onStateChanged.fire(e)
      &width = it
    }
  }
  
  Int height := 50 {
    protected set {
      e := StateChangedEvent (&height, it, #height, this )
      onStateChanged.fire(e)
      &height = it
    }
  }

//  **
//  ** Size of this widget.
//  **
//  Size size := Size(50, 50) {
//    protected set {
//      e := StateChangedEvent (&size, it, #size, this )
//      onStateChanged.fire(e)
//      &size = it
//    }
//  }

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
  WidgetGroup? parent { private set }

  internal Void setParent(WidgetGroup? p) { parent = p }

  **
  ** Find widget by id in descendant
  **
  virtual Widget? findById(Str id) { if (this.id == id) return this; else return null }

  **
  ** Post mouse event
  **
  protected virtual Void touch(MotionEvent e) {}

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
      g.transform = g.transform.mult(transform)
    }
    if (alpha != null) {
      g.alpha = (alpha * 255).toInt
    }

    if (effect != null) {
      g = effect.prepare(this, g)
    }
    
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
        if (Toolkit.cur.name != "SWT") {
          cg.brush = Color.makeArgb(0, 0, 0, 0)
        } else {
          cg.brush = Color.makeArgb(0, 255, 255, 255)
        }
        cg.clearRect(0, 0, width, height)
        doPaint(cg)
        cg.dispose
      }
      
      g.drawImage(renderCache, 0, 0)
    } else {
      doPaint(g)
    }
    
    if (effect != null) {
      effect.end |tg|{ doPaint(tg) }
    }
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

  LayoutParam layoutParam := LayoutParam()
  Insets padding := Insets.defVal

  **
  ** Compute the preferred size of this widget by layoutParam
  **
  virtual Dimension measureSize(Int parentContentWidth, Int parentContentHeight, Dimension result) {
    hintsWidth := parentContentWidth - layoutParam.margin.left-layoutParam.margin.right
    hintsHeight := parentContentHeight - layoutParam.margin.top-layoutParam.margin.bottom
    
    Int w := -1
    Int h := -1
    
    //using layout size
    if (layoutParam.width == LayoutParam.matchParent && hintsWidth>0) {
      w = hintsWidth
    }
    
    if (layoutParam.height == LayoutParam.matchParent && hintsHeight>0) {
      h = hintsHeight
    }
    
    //layout size if ok
    if (w >0 && h >0) {
      return result.set(w, h)
    }
    
    size := prefSize(hintsWidth, hintsHeight, result)
    if (w > 0) {
      size.w = w
    }
    if (h > 0) {
      size.h = h
    }
    return size
  }

  **
  ** preferred size with margin
  **
  protected Dimension prefBufferedSize(Int parentContentWidth, Int parentContentHeight, Dimension result) {
    hintsWidth := parentContentWidth - layoutParam.margin.left-layoutParam.margin.right
    hintsHeight := parentContentHeight - layoutParam.margin.top-layoutParam.margin.bottom
    size := prefSize(hintsWidth, hintsHeight, result)
    return result.set(size.w+layoutParam.margin.left+layoutParam.margin.right
      , size.h+layoutParam.margin.top + layoutParam.margin.bottom)
  }

  **
  ** preferred size without margin
  **
  private Dimension prefSize(Int hintsWidth, Int hintsHeight, Dimension result) {
    Int w := -1
    Int h := -1
    
    //using layout size
    if (layoutParam.width > 0) {
      w = layoutParam.width
    }
    
    if (layoutParam.height > 0) {
      h = layoutParam.height
    }
    
    //layout size if ok
    if (w >0 && h >0) {
      return result.set(w, h)
    }
    
    //get preferred size
    s := prefContentSize(hintsWidth, hintsHeight, result)
    Int pw := s.w + padding.left + padding.right
    Int ph := s.h + padding.top + padding.bottom
    
    if (w < 0) {
      w = pw
    }
    
    if (h < 0) {
      h = ph
    }
    
    return result.set(w, h)
  }

  **
  ** preferred size of content without padding
  **
  protected virtual Dimension prefContentSize(Int hintsWidth, Int hintsHeight, Dimension result) { 
    result.w = width
    result.h = height
    return result
  }

  Int getContentWidth() {
    width - padding.left - padding.right
  }
  
  Int getBufferedWidth() {
    width + layoutParam.margin.left + layoutParam.margin.right
  }

  Int getContentHeight() {
    height - padding.top - padding.bottom
  }
  
  Int getBufferedHeight() {
    height + layoutParam.margin.top + layoutParam.margin.bottom
  }

  **
  ** Relayout this widget.
  **
  protected virtual This doLayout(Dimension result) { this }

  **
  ** Requset relayout this widget
  **
  virtual Void requestLayout() {
    getRootView?.requestLayout
  }

//////////////////////////////////////////////////////////////////////////
// rootView
//////////////////////////////////////////////////////////////////////////

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

  **
  ** a dp pixel size.
  ** scale dp to pixel
  **
  virtual Float dp() {
    Toolkit.cur.dpi.toFloat/320f
  }

  Int dpToPixel(Int d) { (d * dp).toInt }

  Int pixelToDp(Int p) { (p / dp).toInt }

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
    v := getRootView
    return v.hasFocus && v.focusWidget === this
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
}