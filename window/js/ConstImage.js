//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-08-20  Jed Young  Creation
//

fan.fanvasWindow.ConstImage = fan.sys.Obj.$extend(fan.sys.Obj);
fan.fanvasWindow.ConstImage.prototype.$ctor = function() {}

fan.fanvasWindow.ConstImage.prototype.$typeof = function()
{
  return fan.fanvasGraphics.ConstImage.$type;
}

fan.fanvasWindow.ConstImage.prototype.m_image = null;
fan.fanvasWindow.ConstImage.prototype.m_isLoaded = false;
fan.fanvasWindow.ConstImage.prototype.m_uri = null;

fan.fanvasWindow.ConstImage.prototype.m_size = null;
fan.fanvasWindow.ConstImage.prototype.size = function() { return this.m_size; }

fan.fanvasWindow.ConstImage.prototype.getImage = function(widget)
{
  return this.m_image;
}

fan.fanvasWindow.ConstImage.prototype.isLoaded = function() { return this.m_isLoaded; }
fan.fanvasWindow.ConstImage.prototype.isReady = function() { return this.m_isLoaded; }