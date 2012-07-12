//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-7-4  Jed Young  Creation
//

fan.fanWt.PointArray = fan.sys.Obj.$extend(fan.fan2d.PointArray);
fan.fanWt.PointArray.prototype.$ctor = function() {}

fan.fanWt.PointArray.prototype.xArray = null;
fan.fanWt.PointArray.prototype.yArray = null;

fan.fanWt.PointArray = function(size)
{
  this.xArray = new Array(size);
  this.yArray = new Array(size);
}

fan.fanWt.PointArray.prototype.size = function() { return this.xArray.length; }

fan.fanWt.PointArray.prototype.getX = function(i) { return this.xArray[i]; }

fan.fanWt.PointArray.prototype.getY = function(i) { return this.yArray[i]; }

fan.fanWt.PointArray.prototype.setX = function(i, v) { return this.xArray[i] = v; }

fan.fanWt.PointArray.prototype.setY = function(i, v) { return this.yArray[i] = v; }