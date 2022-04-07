//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-10-04  Jed Young  Creation
//

using vaseGraphics
using vaseWindow
using concurrent

**
** Represent a top level Widget
**
@Js
class Frame : ContentPane
{
  Str name = ""

  @Transient
  private WinView? view

  **
  ** current focus widget
  **
  @Transient
  private Widget? focusWidget { private set }

  @Transient
  private Widget? mouseHoverWidget
  
  @Transient
  private Widget? gestureFocusWidget

  **
  ** top layer is a overlay of root view
  **
  @Transient
  private WidgetGroup? topLayer

  **
  ** Used to toggle anti-aliasing on and off.
  **
  Bool antialias := true

  **
  ** Style support
  **
  @Transient
  StyleManager styleManager := StyleManager()

  **
  ** find the current style
  **
  Style findStyle(Widget widget) { styleManager.find(widget) }

  **
  ** animation manager
  **
  @Transient
  AnimManager animManager := AnimManager()

  Window? host() { view.host }

  **
  ** has modal dialog
  **
  @Transient
  private Int modal := 0
  private Widget? modalWidget

  **
  ** root background color
  **
  Brush background := Color.white

  @Transient
  private Int initState := 0

  **
  ** Shared dimension for layout
  **
  //@Transient
  //private Dimension sharedDimension := Dimension(0, 0)

  Bool autoScale = false

  **
  ** ctor
  **
  new make() {
    id = "frame"
    width = 0
    height = 0
    this.useRenderCache = false
    layout.height = Layout.matchParent
  }

  **
  ** Show View
  **
  Void show(Bool push := true)
  {
    win := Toolkit.cur.window(null)
    if (win == null) {
      view = WinView(this)
      Toolkit.cur.window(view, ["name":name])
    }
    else {
      view = win.view
      view.showFrame(this, push, push)
    }
  }

  Void pop() {
    view.popFrame
  }

  **
  ** get or make a widget that layout top of root view
  **
  WidgetGroup topOverlayer()
  {
    if (topLayer == null)
    {
      topLayer = Pane()
      topLayer.useRenderCache = false
      doAdd(topLayer)
    }
//    moveToTop(topLayerGroup)
    topLayer.layout.width = Layout.matchParent
    topLayer.layout.height = Layout.matchParent
    topLayer.width = this.width
    topLayer.height = this.height
    topLayer.x = 0
    topLayer.y = 0
    return topLayer
  }

  Void setModal(Int modal, Widget modalWidget) {
    if (modal == 0) {
      if (this.modalWidget === modalWidget) {
        this.modal = 0
      }
      return
    }
    this.modal = modal
    this.modalWidget = modalWidget
  }

//////////////////////////////////////////////////////////////////////////
// animation
//////////////////////////////////////////////////////////////////////////

  protected Void onUpdate() {
    if (animManager.updateFrame) {
//      echo("anim continue")
      host.repaint
    }
  }

  override Void detach(Bool doRelayout := true)
  {
    if (view?.oldFrame == this) {
      view.oldFrame = null
    }
    initState = -1
    //view = null
  }

  Bool isOpened() { initState == 1 }

  internal Void fireOnOpened() {
    isFirst := initState == 0
    initState = 1
    onMounted
    onOpened.fire(Event { data = isFirst })
  }

//////////////////////////////////////////////////////////////////////////
// frame
//////////////////////////////////////////////////////////////////////////

  **
  ** repaint the dirty region on later
  **
  override Void repaint(Rect? dirty := null)
  {
    renderCacheDirty = true
    //convert dirty coordinate system to realative to parent
    if (dirty != null) dirty = Rect(dirty.x + x, dirty.y + y, dirty.w, dirty.h)
    view?.host?.repaint(dirty)
  }

  override Void relayout() {
    super.relayout
    if (view != null) {
      view.layoutDirty = 1
      view.host?.repaint(null)
    }
  }

  protected override Void doPaint(Graphics g) {
    //beginTime := Duration.nowTicks
    g.antialias = this.antialias
    g.brush = background
    g.fillRect(0, 0, width, height)
    //super.paint(g)

    //echo("$width $height")
    //-------------content
    g.push
    //g.clip(it.bounds)
    g.transform(Transform2D.makeTranslate(content.x.toFloat, content.y.toFloat))
    content.paint(g)

    if (modal > 1) {
      //g.brush = Color.fromArgb(100, 0, 0, 0)
      g.brush = Color.black
      g.alpha = 100
      g.fillRect(0, 0, width, height)
      //TODO restore this
      g.alpha = 255
    }
    g.pop

    //-------------topLayer
    if (topLayer != null) {
      g.push
      //g.clip(it.bounds)
      g.transform(Transform2D.makeTranslate(topLayer.x.toFloat, topLayer.y.toFloat))
      topLayer.paint(g)
      g.pop
    }
  }

//////////////////////////////////////////////////////////////////////////
// event
//////////////////////////////////////////////////////////////////////////

  ** call by detach widget
  internal Void onRemove(Widget w) {
    if (focusWidget === w) {
      clearFocus
    }

    if (mouseHoverWidget === w) {
      mouseHoverWidget = null
    }
    
    if (gestureFocusWidget === w) {
      gestureFocusWidget = null
    }

    if (modalWidget === w) {
      modal = 0
      modalWidget = null
    }
  }
  
  Void clearFocus() {
    focusIt(null)
    gestureFocusWidget = null
  }

  **
  ** request focus for widget
  **
  Void focusIt(Widget? w)
  {
    if (focusWidget === w) return
    //echo("focus:$focusWidget => $w")
    oldFocus := focusWidget
    this.focusWidget = w
    
    Event e := Event()
    if (oldFocus != null) { 
        e.data = false
        oldFocus?.onFocusChanged?.fire(e)
    }
    
    if (w != null) {
        view.host.focus
        e.data = true
        focusWidget?.onFocusChanged?.fire(e)
    }
  }
  
  Void gestureFocus(Widget w) {
    if (gestureFocusWidget === w) return
    gestureFocusWidget = w
  }

  **
  ** set for dealwith mouse exit and mouse enter
  **
  Void mouseHover(Widget w)
  {
    if (mouseHoverWidget === w) return
    mouseHoverWidget?.mouseExit
    this.mouseHoverWidget = w
    w.mouseEnter
  }

  **
  ** return true if host windows has focus
  **
  override Bool focused() { view.host.hasFocus }

  Bool isFocusedWidiget(Widget w) {
    if (!focused()) return false
    return w === focusWidget
  }

  protected override Void gestureEvent(GestureEvent e) {
    if (e.type == GestureEvent.drag
            || e.type == GestureEvent.drop || e.type == GestureEvent.multiTouch)
    {
      if (gestureFocusWidget != null) {
        e.relativeX = e.relativeX - this.x
        e.relativeY = e.relativeY - this.y
        gestureFocusWidget.gestureEvent(e)
      }
      return
    }
    
    if (modal > 0) {
      topLayer.gestureEvent(e)
    }

    if (modal < 2 && !e.consumed) {
      super.gestureEvent(e)
    }
  }

  override Void motionEvent(MotionEvent e) {
    e.relativeX = e.x
    e.relativeY = e.y

    //fire mouse out event
    if (mouseHoverWidget != null) {
      p := Coord(e.x.toFloat, e.y.toFloat)
      b := mouseHoverWidget.mapToRelative(p)
      if (!b || !mouseHoverWidget.contains(p.x.toInt, p.y.toInt)) {
        mouseHoverWidget.mouseExit
        mouseHoverWidget = null
      }
    }

    if (e.consumed) {
      return
    }

    if (modal > 0) {
      topLayer.motionEvent(e)
    }
    if (e.consumed) {
      return
    }
    if (modal == 1 && focusWidget != null) return
    
    if (modal < 2) {
        super.motionEvent(e)
    }
    //echo("type$e.type, x$e.x,y$e.y")
  }

  override Void keyEvent(KeyEvent e) {
    if (focusWidget == null) return
    if (focusWidget.enabled) focusWidget.keyEvent(e)
  }

  protected Void windowEvent(WindowEvent e)
  {
    onWindowStateChange.fire(e)
  }

  once EventListeners onWindowStateChange() { EventListeners() }

  **
  ** Callback function when window is opended.
  **
  once EventListeners onOpened() { EventListeners() }

  once EventListeners onClosing() { EventListeners() }
}