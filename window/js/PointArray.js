//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-7-4  Jed Young  Creation
//

fan.vaseWindow.PointArray = fan.sys.Obj.$extend(fan.sys.Obj);
fan.vaseWindow.PointArray.prototype.$ctor = function() {}
fan.vaseWindow.PointArray.prototype.$typeof = function()
{
  return fan.vaseGraphics.PointArray.$type;
}

fan.vaseWindow.PointArray.prototype.xArray = null;
fan.vaseWindow.PointArray.prototype.yArray = null;

fan.vaseWindow.PointArray.make = function(size)
{
  var p = new fan.vaseWindow.PointArray();
  p.xArray = new Array(size);
  p.yArray = new Array(size);
  p.m_size = size;
  return p;
}

fan.vaseWindow.PointArray.prototype.size = function() { return this.m_size; }

fan.vaseWindow.PointArray.prototype.getX = function(i) { return this.xArray[i]; }

fan.vaseWindow.PointArray.prototype.getY = function(i) { return this.yArray[i]; }

fan.vaseWindow.PointArray.prototype.setX = function(i, v) { return this.xArray[i] = v; }

fan.vaseWindow.PointArray.prototype.setY = function(i, v) { return this.yArray[i] = v; }