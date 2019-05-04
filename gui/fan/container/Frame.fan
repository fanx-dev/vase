//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-10-04  Jed Young  Creation
//

using fanvasGraphics
using fanvasWindow
using concurrent
using fanvasMath

**
** Represent a top level Widget
**
@Js
class Frame : ContentPane
{
  @Transient
  private WinView? view

  **
  ** current focus widget
  **
  @Transient
  private Widget? focusWidget { private set }

  @Transient
  private Widget? mouseOverWidget

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
  protected AnimManager animManager := AnimManager()

  Window? host() { view.host }

  **
  ** has modal dialog
  **
  @Transient
  Bool modal := false

  **
  ** root background color
  **
  Brush background := Color.white

  Bool inited := false

  **
  ** Shared dimension for layout
  **
  //@Transient
  //private Dimension sharedDimension := Dimension(0, 0)

  **
  ** ctor
  **
  new make() {
    id = "frame"
    width = 0
    height = 0
    this.useRenderCache = false
  }

  **
  ** Show View
  **
  Void show()
  {
    win := Toolkit.cur.window(null)
    if (win == null) {
      view = WinView(this)
      Toolkit.cur.window(view)
    }
    else {
      view = win.view
      view.pushFrame(this)
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
    topLayer.layoutParam.widthType = SizeType.matchParent
    topLayer.layoutParam.heightType = SizeType.matchParent
    topLayer.width = this.width
    topLayer.height = this.height
    topLayer.x = 0
    topLayer.y = 0
    return topLayer
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

  override Void detach()
  {
    if (view.oldFrame == this) {
      view.oldFrame = null
    }
    //view = null
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
    view.host?.repaint(dirty)
  }

  override Void relayout() {
    super.relayout
    view.layoutDirty = 1
    view.host?.repaint(null)
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
    g.transform(Transform2D.make.translate(content.x.toFloat, content.y.toFloat))
    content.paint(g)

    if (modal) {
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
      g.transform(Transform2D.make.translate(topLayer.x.toFloat, topLayer.y.toFloat))
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
      focusWidget = null
    }

    if (mouseOverWidget === w) {
      mouseOverWidget = null
    }

    if (topLayer === w.parent) {
      modal = false
    }
  }

  **
  ** request focus for widget
  **
  Void focusIt(Widget? w)
  {
    Event e := Event()
    e.data = false
    focusWidget?.onFocusChanged?.fire(e)

    this.focusWidget = w
    view.host.focus

    e.data = true
    focusWidget?.onFocusChanged?.fire(e)
  }

  **
  ** set for dealwith mouse exit and mouse enter
  **
  Void mouseCapture(Widget w)
  {
    if (mouseOverWidget === w) return
    mouseOverWidget?.mouseExit
    this.mouseOverWidget = w
    w.mouseEnter
  }

  **
  ** return true if host windows has focus
  **
  override Bool hasFocus() { view.host.hasFocus }

  Bool isFocusWidiget(Widget w) {
    if (!hasFocus()) return false
    return w === focusWidget
  }

  protected override Void gestureEvent(GestureEvent e) {
    if (modal) {
      topLayer.gestureEvent(e)
    } else {
      super.gestureEvent(e)
    }
  }

  override Void motionEvent(MotionEvent e) {
    e.relativeX = e.x
    e.relativeY = e.y

    //fire mouse out event
    if (mouseOverWidget != null) {
      p := Coord(e.x, e.y)
      b := mouseOverWidget.mapToRelative(p)
      if (!b || !mouseOverWidget.contains(p.x, p.y)) {
        mouseOverWidget.mouseExit
        mouseOverWidget = null
      }
    }

    onTouchEvent.fire(e)
    if (e.consumed) {
      return
    }

    if (modal) {
      topLayer.motionEvent(e)
    } else {
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

  **
  ** global motion event
  **
  @Transient
  EventListeners onTouchEvent := EventListeners()

}