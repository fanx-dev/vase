//
// Copyright (c) 2009, Brian Frank and Andy Frank
// Licensed under the Academic Free License version 3.0
//
// History:
//   2 Jun 09  Andy Frank  Creation
//

// global variable to store a CanvasRenderingContext2D
fan.fwt.FwtEnvPeer.fontCx = null;

fan.fan2d.Font.prototype.fontHeight = function(font)
{
  // fudge this as 150% of size
  return Math.round((font.m_size-3) * 1.5);
}

fan.fan2d.Font.prototype.fontAscent = function(font)
{
  // fudge this as 100% of size
  return font.m_size-3;
}

fan.fan2d.Font.prototype.fontDescent = function(font)
{
  // fudge this as 30% of size
  return Math.round((font.m_size-3) * 0.3);
}

fan.fan2d.Font.prototype.fontLeading = function(font)
{
  // fudge this as 16% of size
  return Math.round((font.m_size-3) * 0.16);
}

fan.fan2d.Font.prototype.fontWidth = function(font, str)
{
  try
  {
    // use global var to store a context for computing string width
    if (fan.fwt.FwtEnvPeer.fontCx == null)
    {
      fan.fwt.FwtEnvPeer.fontCx = document.createElement("canvas").getContext("2d");
    }
    fan.fwt.FwtEnvPeer.fontCx.font = fan.fwt.WidgetPeer.fontToCss(font);
    return Math.round(fan.fwt.FwtEnvPeer.fontCx.measureText(str).width);
  }
  catch (err)
  {
    // fallback if canvas not supported
    return str.length * 7;
  }
}