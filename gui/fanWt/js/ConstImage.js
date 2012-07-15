//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-08-20  Jed Young  Creation
//

fan.fanWt.ConstImage = fan.sys.Obj.$extend(fan.sys.Obj);
fan.fanWt.ConstImage.prototype.$ctor = function() {}

fan.fanWt.ConstImage.prototype.$typeof = function()
{
  return fan.fan2d.ConstImage.$type;
}

fan.fanWt.ConstImage.prototype.m_image = null;
fan.fanWt.ConstImage.prototype.m_isLoaded = false;
fan.fanWt.ConstImage.prototype.m_uri = null;

fan.fanWt.ConstImage.prototype.m_size = null;
fan.fanWt.ConstImage.prototype.size = function() { return this.m_size; }

fan.fanWt.ConstImage.prototype.getImage = function(widget)
{
  return this.m_image;
}

fan.fanWt.ConstImage.prototype.isLoaded = function() { return this.m_isLoaded; }

