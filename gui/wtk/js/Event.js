//
// Copyright (c) 2009, Brian Frank and Andy Frank
// Licensed under the Academic Free License version 3.0
//
// History:
//   8 May 09  Andy Frank  Creation
//


//////////////////////////////////////////////////////////////////////////
// Widget/Element synchronization
//////////////////////////////////////////////////////////////////////////

fan.fgfxWtk.Event.prototype.sync = function(self, w, h)  // w,h override
{
  // sync event handlers
  this.checkEventListener(self, 0x001, "mouseover",  fan.fwt.EventId.m_mouseEnter, self.onMouseEnter());
  this.checkEventListener(self, 0x002, "mouseout",   fan.fwt.EventId.m_mouseExit,  self.onMouseExit());
  this.checkEventListener(self, 0x004, "mousedown",  fan.fwt.EventId.m_mouseDown,  self.onMouseDown());
  this.checkEventListener(self, 0x008, "mousemove",  fan.fwt.EventId.m_mouseMove,  self.onMouseMove());
  this.checkEventListener(self, 0x010, "mouseup",    fan.fwt.EventId.m_mouseUp,    self.onMouseUp());
//this.checkEventListener(self, 0x020, "mousehover", fan.fwt.EventId.m_mouseHover, self.onMouseHover());
  this.checkEventListener(self, 0x040, "mousewheel", fan.fwt.EventId.m_mouseWheel, self.onMouseWheel());
  this.checkEventListener(self, 0x080, "keydown",    fan.fwt.EventId.m_keyDown,    self.onKeyDown());
  this.checkEventListener(self, 0x100, "keyup",      fan.fwt.EventId.m_keyUp,      self.onKeyUp());
  this.checkEventListener(self, 0x200, "blur",       fan.fwt.EventId.m_blur,       self.onBlur());
  this.checkEventListener(self, 0x400, "focus",      fan.fwt.EventId.m_focus,      self.onFocus());

  // sync bounds
  with (this.elem.style)
  {
    if (w === undefined) w = this.m_size.m_w
    if (h === undefined) h = this.m_size.m_h;

    // TEMP fix for IE
    if (w < 0) w = 0;
    if (h < 0) h = 0;

    display = this.m_visible ? "block" : "none";
    left    = this.m_pos.m_x  + "px";
    top     = this.m_pos.m_y  + "px";
    width   = w + "px";
    height  = h + "px";
  }
}

fan.fgfxWtk.Event.prototype.checkEventListener = function(self, mask, type, evtId, listeners)
{
  if (this.eventMask == null) this.eventMask = 0;  // verify defined
  if ((this.eventMask & mask) > 0) return;         // already added
  if (listeners.isEmpty()) return;                 // nothing to add yet

  // attach and mark attached
  this.attachEventListener(self, type, evtId, listeners);
  this.eventMask |= mask;
}

//////////////////////////////////////////////////////////////////////////
// EventListeners
//////////////////////////////////////////////////////////////////////////

fan.fgfxWtk.Event.prototype.attachEventListener = function(self, type, evtId, listeners)
{
  var peer = this;
  var func = function(e)
  {
    // find pos relative to display
    var dis  = peer.posOnDisplay(self);
    var mx   = e.clientX - dis.m_x;
    var my   = e.clientY - dis.m_y;

    // cache event type
    var isClickEvent = evtId == fan.fwt.EventId.m_mouseDown ||
                       evtId == fan.fwt.EventId.m_mouseUp;
    var isWheelEvent = evtId == fan.fwt.EventId.m_mouseWheel;
    var isMouseEvent = type.indexOf("mouse") != -1;

    // create fwt::Event and invoke handler
    var evt = fan.fwt.Event.make();
    evt.m_id     = evtId;
    evt.m_pos    = fan.gfx.Point.make(mx, my);
    evt.m_widget = self;
    evt.m_key    = fan.fgfxWtk.Event.toKey(e);
    if (isClickEvent)
    {
      evt.m_button = e.button + 1;
      evt.m_count  = fan.fgfxWtk.Event.processMouseClicks(peer, evt);
    }
    if (isWheelEvent)
    {
      evt.m_button = 1;  // always set to middle button?
      evt.m_delta = fan.fgfxWtk.Event.toWheelDelta(e);
    }

    // invoke handlers
    var list = listeners.list();
    for (var i=0; i<list.m_size; i++)
    {
      list.get(i).call(evt);
      if (evt.m_consumed) break;
    }

    // prevent bubbling
    if (evt.m_consumed || isMouseEvent) e.stopPropagation();
    if (evt.m_consumed) e.preventDefault();
    return false;
  }

  // special handler for firefox
  if (type == "mousewheel" && fan.fwt.DesktopPeer.$isFirefox) type = "DOMMouseScroll";

  // add tabindex for key events
  if (type == "keydown" || type == "keyup") this.elem.tabIndex = 0;

  // attach event handler
  this.elem.addEventListener(type, func, false);
}

fan.fgfxWtk.Event.processMouseClicks = function(peer, e)
{
  // init mouse clicks if not defined
  if (peer.mouseClicks == null)
  {
    peer.mouseClicks = {
      last: new Date().getTime(),
      pos:  e.m_pos,
      cur:  1
    };
    return peer.mouseClicks.cur;
  }

  // only process on mousedown
  if (e.m_id != fan.fwt.EventId.m_mouseDown)
    return peer.mouseClicks.cur;

  // verify pos and frequency
  var now  = new Date().getTime();
  var diff = now - peer.mouseClicks.last;
  if (diff < 600 && peer.mouseClicks.pos.equals(e.m_pos))
  {
    // increment click count
    peer.mouseClicks.cur++;
  }
  else
  {
    // reset handler
    peer.mouseClicks.pos = e.m_pos;
    peer.mouseClicks.cur = 1;
  }

  // update ts and return result
  peer.mouseClicks.last = now;
  return peer.mouseClicks.cur;
}

fan.fgfxWtk.Event.toWheelDelta = function(e)
{
  var wx = 0;
  var wy = 0;

  if (e.wheelDeltaX != null)
  {
    // WebKit
    wx = -e.wheelDeltaX;
    wy = -e.wheelDeltaY;

    // Safari
    if (wx % 120 == 0) wx = wx / 40;
    if (wy % 120 == 0) wy = wy / 40;
  }
  else if (e.wheelDelta != null)
  {
    // IE
    wy = -e.wheelDelta;
    if (wy % 120 == 0) wy = wy / 40;
  }
  else if (e.detail != null)
  {
    // Firefox
    wx = e.axis == 1 ? e.detail : 0;
    wy = e.axis == 2 ? e.detail : 0;
  }

  // make sure we have ints and return
  wx = wx > 0 ? Math.ceil(wx) : Math.floor(wx);
  wy = wy > 0 ? Math.ceil(wy) : Math.floor(wy);
  return fan.gfx.Point.make(wx, wy);
}

fan.fgfxWtk.Event.toKey = function(event)
{
  // find primary key
  var key = null;
  if (event.keyCode != null && event.keyCode > 0)
  {
    // force alpha keys to lowercase so we map correctly
    var code = event.keyCode;
    if (code >= 65 && code <= 90) code += 32;
    key = fan.fgfxWtk.Event.keyCodeToKey(code);
  }

  if (event.shiftKey)   key = key==null ? fan.fwt.Key.m_shift : key.plus(fan.fwt.Key.m_shift);
  if (event.altKey)     key = key==null ? fan.fwt.Key.m_alt   : key.plus(fan.fwt.Key.m_alt);
  if (event.ctrlKey)    key = key==null ? fan.fwt.Key.m_ctrl  : key.plus(fan.fwt.Key.m_ctrl);
  // TODO FIXIT
  //if (event.commandKey) key = key.plus(Key.command);
  return key;
}

fan.fgfxWtk.Event.keyCodeToKey = function(keyCode)
{
  // TODO FIXIT: map rest of non-alpha keys
  switch (keyCode)
  {
    case 8:   return fan.fwt.Key.m_backspace;
    case 13:  return fan.fwt.Key.m_enter;
    case 32:  return fan.fwt.Key.m_space;
    case 37:  return fan.fwt.Key.m_left;
    case 38:  return fan.fwt.Key.m_up;
    case 39:  return fan.fwt.Key.m_right;
    case 40:  return fan.fwt.Key.m_down;
    case 46:  return fan.fwt.Key.m_$delete;
    case 91:  return fan.fwt.Key.m_command;  // left cmd
    case 93:  return fan.fwt.Key.m_command;  // right cmd
    case 186: return fan.fwt.Key.m_semicolon;
    case 188: return fan.fwt.Key.m_comma;
    case 190: return fan.fwt.Key.m_period;
    case 191: return fan.fwt.Key.m_slash;
    case 192: return fan.fwt.Key.m_backtick;
    case 219: return fan.fwt.Key.m_openBracket;
    case 220: return fan.fwt.Key.m_backSlash;
    case 221: return fan.fwt.Key.m_closeBracket;
    case 222: return fan.fwt.Key.m_quote;
    default: return fan.fwt.Key.fromMask(keyCode);
  }
}