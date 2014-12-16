//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-7-4  Jed Young  Creation
//

fan.fgfxWtk.PointArray = fan.sys.Obj.$extend(fan.sys.Obj);
fan.fgfxWtk.PointArray.prototype.$ctor = function() {}
fan.fgfxWtk.PointArray.prototype.$typeof = function()
{
  return fan.fgfxGraphics.PointArray.$type;
}

fan.fgfxWtk.PointArray.prototype.xArray = null;
fan.fgfxWtk.PointArray.prototype.yArray = null;

fan.fgfxWtk.PointArray.make = function(size)
{
  var p = new fan.fgfxWtk.PointArray();
  p.xArray = new Array(size);
  p.yArray = new Array(size);
  p.m_size = size;
  return p;
}

fan.fgfxWtk.PointArray.prototype.size = function() { return this.m_size; }

fan.fgfxWtk.PointArray.prototype.getX = function(i) { return this.xArray[i]; }

fan.fgfxWtk.PointArray.prototype.getY = function(i) { return this.yArray[i]; }

fan.fgfxWtk.PointArray.prototype.setX = function(i, v) { return this.xArray[i] = v; }

fan.fgfxWtk.PointArray.prototype.setY = function(i, v) { return this.yArray[i] = v; }