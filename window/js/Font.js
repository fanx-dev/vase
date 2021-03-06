//
// Copyright (c) 2009, Brian Frank and Andy Frank
// Licensed under the Academic Free License version 3.0
//
// History:
//   2 Jun 09  Andy Frank  Creation
//

// global variable to store a CanvasRenderingContext2D
fan.vaseGraphics.Font.fontCx = null;

fan.vaseGraphics.Font.prototype.height = function()
{
  // fudge this as 150% of size
  return Math.round((this.m_size-3) * 1.5);
}

fan.vaseGraphics.Font.prototype.ascent = function()
{
  // fudge this as 100% of size
  return this.m_size-3;
}

fan.vaseGraphics.Font.prototype.descent = function()
{
  // fudge this as 30% of size
  return Math.round((this.m_size-3) * 0.3);
}

fan.vaseGraphics.Font.prototype.leading = function()
{
  // fudge this as 16% of size
  return Math.round((this.m_size-3) * 0.16);
}

fan.vaseGraphics.Font.prototype.width = function(str)
{
  if (!str) return 0;
  try
  {
    // use global var to store a context for computing string width
    if (fan.vaseGraphics.Font.fontCx == null)
    {
      fan.vaseGraphics.Font.fontCx = document.createElement("canvas").getContext("2d");
    }
    fan.vaseGraphics.Font.fontCx.font = fan.vaseWindow.GfxUtil.fontToCss(this);
    return Math.round(fan.vaseGraphics.Font.fontCx.measureText(str).width);
  }
  catch (err)
  {
    // fallback if canvas not supported
    return str.length * 7;
  }
}