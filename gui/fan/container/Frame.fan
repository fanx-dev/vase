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

@Js
class ModalLayer : Pane {
    Int level
    Int backgroundAlpha = 0
    
    new make(Int level) {
        layout.width = Layout.matchParent
        layout.height = Layout.matchParent
        this.level = level
        if (level > 1) backgroundAlpha = 100
        if (level == 0) eventPass = true
    }
    
    protected override Void gestureEvent(GestureEvent e) {
        super.gestureEvent(e)
        if (e.consumed) return
        if (e.type == GestureEvent.click) {
            if (level > 1) return
            else {
                this.detach
                if (level > 0) e.consume
            }
        }
    }
    
    protected override Void doPaint(Rect clip, Graphics g) {
      if (backgroundAlpha > 0) {
        g.brush = Color.black
        g.alpha = backgroundAlpha
        g.fillRect(0, 0, width, height)
        //TODO restore this
        g.alpha = 255
      }
      super.doPaint(clip, g)
    }
}

**
** Represent a top level Widget
**
@Js
class Frame : Pane
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
  private Widget? dragFocusWidget { private set }

  @Transient
  private Widget? mouseHoverWidget

  Color background := Color.white
  
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
  ** get current top frame
  **
  static Frame? cur() {
    win := Toolkit.cur.window()
    if (win == null) return null
    WinView view := win.view
    return view.curFrame
  }


  @Transient
  private Int initState := 0


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
  WidgetGroup topOverlayer(Int modal = 1)
  {
    topLayer := ModalLayer(modal)
    this.add(topLayer)
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

  override Void detach(Bool doRelayout := true)
  {
    if (view?.oldFrame == this) {
      view.oldFrame = null
    }
    initState = -1
    //view = null
    this.onDetach
  }

  Bool isOpened() { initState == 1 }

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

  override Void relayout(Int dirty = 1) {
    super.relayout(dirty)
    if (view != null) {
      view.layoutDirty = dirty
      view.host?.repaint(null)
    }
  }

  protected override Void doPaint(Rect clip, Graphics g) {
    //beginTime := Duration.nowTicks
    g.antialias = antialias
    g.brush = background
    g.fillRect(0, 0, width, height)
    super.doPaint(clip, g)
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
    
    if (dragFocusWidget === w) {
      dragFocusWidget = null
    }
   
  }
  
  Void clearFocus() {
    focusIt(null)
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
  
  Void dragFocus(Widget? w) {
    if (dragFocusWidget === w) return
    dragFocusWidget = w
    clearFocus
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

  protected override Void onDrag(GestureEvent e){
    if (dragFocusWidget == null) return
    if (dragFocusWidget.enabled) dragFocusWidget.onDrag(e)
  }

  protected override Void postMotionEvent(MotionEvent e) {
    //fire mouse out event
    if (mouseHoverWidget != null) {
      ap := Coord(e.x.toFloat, e.y.toFloat)
      p := mouseHoverWidget.mapToRelative(ap)
      if (p == null || !mouseHoverWidget.contains(p.x.toInt, p.y.toInt)) {
        mouseHoverWidget.mouseExit
        mouseHoverWidget = null
      }
    }
    
    super.postMotionEvent(e)
  }
  
  protected override Void postGestureEvent(GestureEvent e) {
    if (e.type == GestureEvent.drop) {
        e.data = dragFocusWidget
    }
    super.postGestureEvent(e)
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
  
  protected override Void onOpen() {
    isFirst := initState == 0
    initState = 1
    onOpened.fire(Event { data = isFirst })
    super.onOpen
  }
  protected override Void onDetach() {
    onClosing.fire(null)
    super.onDetach
  }
  **
  ** Callback function when window is opended.
  **
  once EventListeners onOpened() { EventListeners() }

  once EventListeners onClosing() { EventListeners() }
}