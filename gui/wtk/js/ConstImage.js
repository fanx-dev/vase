//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-08-20  Jed Young  Creation
//

fan.fgfxWtk.ConstImage = fan.sys.Obj.$extend(fan.sys.Obj);
fan.fgfxWtk.ConstImage.prototype.$ctor = function() {}

fan.fgfxWtk.ConstImage.prototype.$typeof = function()
{
  return fan.fgfx2d.ConstImage.$type;
}

fan.fgfxWtk.ConstImage.prototype.m_image = null;
fan.fgfxWtk.ConstImage.prototype.m_isLoaded = false;
fan.fgfxWtk.ConstImage.prototype.m_uri = null;

fan.fgfxWtk.ConstImage.prototype.m_size = null;
fan.fgfxWtk.ConstImage.prototype.size = function() { return this.m_size; }

fan.fgfxWtk.ConstImage.prototype.getImage = function(widget)
{
  return this.m_image;
}

fan.fgfxWtk.ConstImage.prototype.isLoaded = function() { return this.m_isLoaded; }

