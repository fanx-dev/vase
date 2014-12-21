//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-10-04  Jed Young  Creation
//

using fgfxGraphics
using fgfxWtk
using concurrent

**
** Represent a top level Widget
**
@Js
class RootView : FrameLayout, View
{
  **
  ** The reference of nativeView
  **
  override NativeView? nativeView

  **
  ** current focus widget
  **
  Widget? focusWidget { private set }
  private Widget? mouseOverWidget

  **
  ** top layer is a overlay of root view
  **
  private WidgetGroup? topLayerGroup

  **
  ** Used to toggle anti-aliasing on and off.
  **
  Bool antialias := true

  **
  ** Style support
  **
  StyleManager styleManager := StyleManager()

  **
  ** find the current style
  **
  Style findStyle(Widget widget) { styleManager.find(widget) }

  **
  ** double buffer
  **
  Bool doubleBuffered := false

  **
  ** animation manager
  **
  AnimManager animManager := AnimManager()

  private Int lastUpdateTime := 0

  **
  ** has modal dialog
  **
  Bool modal := false

  **
  ** root background color
  **
  Brush background := Color.white

  **
  ** marked need do layout
  **
  protected Bool layoutDirty := true

  **
  ** Shared dimension for layout
  **
  private Dimension sharedDimension := Dimension(0, 0)
  
  **
  ** gesture recognizer
  ** convert motion event to gesture event
  ** 
  Gesture gesture := Gesture()
  
  **
  ** global motion event
  ** 
  EventListeners onTouchEvent := EventListeners()

  new make() {
    id = "root"
    width = 0
    height = 0
    this.staticCache = false
    
    gesture.onGestureEvent.add |GestureEvent e|{
      e.relativeX = e.x
      e.relativeY = e.y
      this.gestureEvent(e)
    }
  }

//  override Void requestLayout() {
//    layoutDirty = true
//    requestPaint
//  }

  protected Void onUpdate() {
    if (lastUpdateTime == 0) {
      lastUpdateTime = Duration.nowTicks
    }
    now := Duration.nowTicks

    elapsedTime := ((now - lastUpdateTime) / 1000_000)

    // elapsedTime is millisecond.
    // elapsedTime is 0 cause a bug on updatee animation
    if (elapsedTime == 0) {
      if (animManager.hasAnimation) {
        this.requestPaint
      }
      return
    }

    if (animManager.update(elapsedTime)) {
//      echo("anim continue")
      requestPaint
    }

    lastUpdateTime = now
  }

  override Void onPaint(Graphics g) {
    //beginTime := Duration.nowTicks
    s := nativeView.size
    if (width != s.w || height != s.h) {
      layoutDirty = true
    }

    if (layoutDirty) {
      layoutDirty = false
      pos := nativeView.pos
      x = pos.x
      y = pos.y
      width = s.w
      height = s.h
      doLayout(sharedDimension)
    }

    onUpdate

    g.antialias = this.antialias
    g.brush = background
    g.fillRect(0, 0, width, height)
    super.paint(g)
  }

  virtual Void onResize(Int w, Int h) {
  }

  override Void onMotionEvent(MotionEvent e) {
    e.relativeX = e.x
    e.relativeY = e.y
    motionEvent(e)
  }

  override Void onKeyEvent(KeyEvent e) {
    keyPress(e)
  }

  override Void onDisplayEvent(DisplayEvent e)
  {
    if (e.type == DisplayEvent.opened) onOpened.fire(e)
    else if (e.type == DisplayEvent.activated) onActivated.fire(e)
    else onDisplayStateChange.fire(e)
  }

  once EventListeners onDisplayStateChange() { EventListeners() }

  **
  ** Callback function when window is opended.
  **
  once EventListeners onOpened() { EventListeners() }

  **
  ** Callback function when window becomes the active window on the desktop with focus.
  **
  once EventListeners onActivated() { EventListeners() }


  **
  ** post key event
  **
  override Void keyPress(KeyEvent e)
  {
    if (focusWidget == null) return
    if (focusWidget.enabled) focusWidget.keyPress(e)
  }

  **
  ** post touch event
  **
  protected override Void motionEvent(MotionEvent e)
  {
    onTouchEvent.fire(e)
    if (e.consumed) {
      return
    }
    
    if (!modal)
    {
      //fire mouse out event
      if (mouseOverWidget != null) {
        p := Coord(e.x, e.y)
        b := mouseOverWidget.mapToRelative(p)
        if (!b || !mouseOverWidget.contains(p.x, p.y)) {
          mouseOverWidget.mouseExit
          mouseOverWidget = null
        }
      }
      
      super.motionEvent(e)
    }
    else
    {
      focusWidget.motionEvent(e)
    }
    
    if (!e.consumed) {
      gesture.onEvent(e)
    }
  }

  **
  ** repaint the dirty region on later
  **
  override Void requestPaint(Rect? dirty := null)
  {
    super.requestPaint(dirty)
    if (dirty == null) dirty = this.bounds
    nativeView?.repaint(dirty)
  }

  override Size getPrefSize(Int hintsWidth, Int hintsHeight) {
    result := Dimension(0, 0)
    result = super.measureSize(hintsWidth, hintsHeight, result)
    return Size(result.w, result.h)
  }

  **
  ** Show View
  **
  Void show(Window? host := null, Size? size := null)
  {
    if (host == null)
      host = Toolkit.cur.build()
    host.add(this)
    onMounted
    host.show(size)
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
    nativeView.focus

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
  override Bool hasFocus() { nativeView.hasFocus }

  **
  ** get or make a widget that layout top of root view
  **
  WidgetGroup topOverlayer()
  {
    if (topLayerGroup == null)
    {
      topLayerGroup = FrameLayout()
      topLayerGroup.staticCache = false
    }
    moveToTop(topLayerGroup)
    topLayerGroup.layoutParam.width = this.width
    topLayerGroup.layoutParam.height = this.height
    topLayerGroup.width = this.width
    topLayerGroup.height = this.height
    topLayerGroup.x = 0
    topLayerGroup.y = 0
    return topLayerGroup
  }
}