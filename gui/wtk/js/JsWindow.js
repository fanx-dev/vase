//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-7-4  Jed Young  Creation
//

fan.fgfxWtk.JsWindow = fan.sys.Obj.$extend(fan.sys.Obj);
fan.fgfxWtk.JsWindow.prototype.$ctor = function() {}
fan.fgfxWtk.JsWindow.prototype.list = new Array();

//////////////////////////////////////////////////////////////////////////
// cavans
//////////////////////////////////////////////////////////////////////////

fan.fgfxWtk.JsWindow.prototype.add = function(view)
{
  var nativeView = new fan.fgfxWtk.JsView();
  view.nativeView$(nativeView);
  var size = view.size();
  nativeView.view = view;
  nativeView.size = size;

  //create canvas
  var c = document.createElement("canvas");
  c.width  = size.m_w;
  c.height = size.m_h;

  nativeView.canvas = c;
  nativeView.bindEvent(c);
  c.setAttribute('tabindex','0');
  c.focus();
  this.list.push(view);
  return this;
}

fan.fgfxWtk.JsWindow.prototype.show = function(size)
{
  this.size = size;
  // check for alt root
  var rootId = fan.sys.Env.cur().vars().get("fwt.window.root")
  if (rootId == null) this.root = document.body;
  else
  {
    this.root = document.getElementById(rootId);
    if (this.root == null) throw fan.sys.ArgErr.make("No root found");
  }

  // mount shell we use to attach widgets to
  var shell = document.createElement("div")
  with (shell.style)
  {
    position   = this.root === document.body ? "fixed" : "absolute";
    top        = "0";
    left       = "0";
    width      = "100%";
    height     = "100%";
    background = "#fff";
  }
  this.root.appendChild(shell);

  for (var i=0; i<this.list.length; ++i) {
    var view = this.list[i];
    shell.appendChild(view.m_nativeView.canvas);

    //create graphics
    var g = new fan.fgfxWtk.Graphics();
    g.widget = view.m_nativeView;
    view.m_nativeView.graphics = g;
    fan.fgfxWtk.JsWindow.graphics = g;

    //init graphics
    var cx = view.m_nativeView.canvas.getContext("2d");
    var rect = new fan.fgfx2d.Rect.make(0,0, size.m_w, size.m_h);
    g.init(cx, rect);

    view.m_nativeView.needRepaint = false;
    view.m_nativeView.repaint();

    var event = fan.fgfxWtk.DisplayEvent.make(fan.fgfxWtk.DisplayEvent.m_opened);
    view.onDisplayEvent(event);
  }

  //Repaint handling
  var self = this;
  setInterval(function(){
    for (var i=0; i<self.list.length; ++i) {
      var view = self.list[i];
      if (!view.m_nativeView.needRepaint) return;
      view.m_nativeView.repaint();
      view.m_nativeView.needRepaint = false;
    }
  }, 50);
}

fan.fgfxWtk.JsWindow.prototype.invalid = function()
{
  this.needRepaint = true;
}