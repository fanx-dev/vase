//
// Copyright (c) 2009, Brian Frank and Andy Frank
// Licensed under the Academic Free License version 3.0
//
// History:
//   2 Jun 09  Andy Frank  Creation
//

// global variable to store a CanvasRenderingContext2D
fan.fgfxGraphics.Font.fontCx = null;

fan.fgfxGraphics.Font.prototype.height = function()
{
  // fudge this as 150% of size
  return Math.round((this.m_size-3) * 1.5);
}

fan.fgfxGraphics.Font.prototype.ascent = function()
{
  // fudge this as 100% of size
  return this.m_size-3;
}

fan.fgfxGraphics.Font.prototype.descent = function()
{
  // fudge this as 30% of size
  return Math.round((this.m_size-3) * 0.3);
}

fan.fgfxGraphics.Font.prototype.leading = function()
{
  // fudge this as 16% of size
  return Math.round((this.m_size-3) * 0.16);
}

fan.fgfxGraphics.Font.prototype.width = function(str)
{
  if (!str) return 0;
  try
  {
    // use global var to store a context for computing string width
    if (fan.fgfxGraphics.Font.fontCx == null)
    {
      fan.fgfxGraphics.Font.fontCx = document.createElement("canvas").getContext("2d");
    }
    fan.fgfxGraphics.Font.fontCx.font = fan.fgfxGraphics.GfxUtil.fontToCss(this);
    return Math.round(fan.fgfxGraphics.Font.fontCx.measureText(str).width);
  }
  catch (err)
  {
    // fallback if canvas not supported
    return str.length * 7;
  }
}