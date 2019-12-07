//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-08-20  Jed Young  Creation
//

fan.vaseWindow.ConstImage = fan.sys.Obj.$extend(fan.sys.Obj);
fan.vaseWindow.ConstImage.prototype.$ctor = function() {}

fan.vaseWindow.ConstImage.prototype.$typeof = function()
{
  return fan.vaseGraphics.ConstImage.$type;
}

fan.vaseWindow.ConstImage.prototype.m_image = null;
fan.vaseWindow.ConstImage.prototype.m_isLoaded = false;
fan.vaseWindow.ConstImage.prototype.m_uri = null;

fan.vaseWindow.ConstImage.prototype.m_size = null;
fan.vaseWindow.ConstImage.prototype.size = function() { return this.m_size; }

fan.vaseWindow.ConstImage.prototype.getImage = function(widget)
{
  return this.m_image;
}

fan.vaseWindow.ConstImage.prototype.isLoaded = function() { return this.m_isLoaded; }
fan.vaseWindow.ConstImage.prototype.isReady = function() { return this.m_isLoaded; }