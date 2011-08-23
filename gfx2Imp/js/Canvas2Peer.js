//
// Copyright (c) 2009, Brian Frank and Andy Frank
// Licensed under the Academic Free License version 3.0
//
// History:
//   12 Jun 09  Brian Frank  Creation
//

/**
 * CanvasPeer.
 */
fan.gfx2Imp.Canvas2Peer = fan.sys.Obj.$extend(fan.fwt.CanvasPeer);
fan.gfx2Imp.Canvas2Peer.prototype.$ctor = function(self) {}

fan.gfx2Imp.Canvas2Peer.prototype.sync = function(self)
{
  // short-circuit if not properly layed out
  var size = this.m_size
  if (size.m_w == 0 || size.m_h == 0) return;

  if (this.hasCanvas)
  {
    var div = this.elem;
    var c = div.firstChild;

    // remove old canvas if size is different
    if (c != null && (c.width != size.m_w || c.height != size.m_h))
    {
      div.removeChild(c);
      c = null;
    }

    // create new canvas if null
    if (c == null)
    {
      c = document.createElement("canvas");
      c.width  = size.m_w;
      c.height = size.m_h;
      div.appendChild(c);
    }

    // repaint canvas using Canvas.onPaint callback
    var g = new fan.gfx2Imp.Graphics2();
    g.widget = self;
    g.paint(c, self.bounds(), function() { self.onPaint(g); self.onPaint2(g); })
  }
  else
  {
    console.log("don't suppert canvas2d");
  }

  fan.fwt.WidgetPeer.prototype.sync.call(this, self);
}

