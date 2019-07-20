//
// Copyright (c) 2009, Brian Frank and Andy Frank
// Licensed under the Academic Free License version 3.0
//
// History:
//   8 May 09  Andy Frank  Creation
//


fan.fanvasWindow.Event.toKey = function(event)
{
  // find primary key
  var key = null;
  if (event.keyCode != null && event.keyCode > 0)
  {
    // force alpha keys to lowercase so we map correctly
    var code = event.keyCode;
    //if (code >= 65 && code <= 90) code += 32;
    key = fan.fanvasWindow.Event.keyCodeToKey(code);
  }

  if (event.shiftKey)   key = key==null ? fan.fanvasWindow.Key.m_shift : key.plus(fan.fanvasWindow.Key.m_shift);
  if (event.altKey)     key = key==null ? fan.fanvasWindow.Key.m_alt   : key.plus(fan.fanvasWindow.Key.m_alt);
  if (event.ctrlKey)    key = key==null ? fan.fanvasWindow.Key.m_ctrl  : key.plus(fan.fanvasWindow.Key.m_ctrl);
  // TODO FIXIT
  //if (event.commandKey) key = key.plus(Key.command);
  return key;
}

fan.fanvasWindow.Event.keyCodeToKey = function(keyCode)
{
  // TODO FIXIT: map rest of non-alpha keys
  switch (keyCode)
  {
    case 8:   return fan.fanvasWindow.Key.m_backspace;
    case 13:  return fan.fanvasWindow.Key.m_enter;
    case 32:  return fan.fanvasWindow.Key.m_space;
    case 37:  return fan.fanvasWindow.Key.m_left;
    case 38:  return fan.fanvasWindow.Key.m_up;
    case 39:  return fan.fanvasWindow.Key.m_right;
    case 40:  return fan.fanvasWindow.Key.m_down;
    case 46:  return fan.fanvasWindow.Key.m_$delete;
    case 91:  return fan.fanvasWindow.Key.m_command;  // left cmd
    case 93:  return fan.fanvasWindow.Key.m_command;  // right cmd
    case 186: return fan.fanvasWindow.Key.m_semicolon;
    case 188: return fan.fanvasWindow.Key.m_comma;
    case 190: return fan.fanvasWindow.Key.m_period;
    case 191: return fan.fanvasWindow.Key.m_slash;
    case 192: return fan.fanvasWindow.Key.m_backtick;
    case 219: return fan.fanvasWindow.Key.m_openBracket;
    case 220: return fan.fanvasWindow.Key.m_backSlash;
    case 221: return fan.fanvasWindow.Key.m_closeBracket;
    case 222: return fan.fanvasWindow.Key.m_quote;
    default: return fan.fanvasWindow.Key.fromMask(keyCode);
  }
}

fan.fanvasWindow.Event.toWheelDelta = function(e)
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
  //return fan.gfx.Point.make(wx, wy);
  return wy
}