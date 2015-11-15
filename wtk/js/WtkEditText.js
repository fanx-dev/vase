//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-7-4  Jed Young  Creation
//

fan.fgfxWtk.WtkEditText = fan.sys.Obj.$extend(fan.fgfxWtk.WtkView);
fan.fgfxWtk.WtkEditText.prototype.$ctor = function() {}
fan.fgfxWtk.WtkEditText.prototype.$typeof = function() {
  return fan.fgfxWtk.WtkEditText.$type;
}

fan.fgfxWtk.WtkEditText.prototype.view = null;
fan.fgfxWtk.WtkEditText.prototype.elem = null;
fan.fgfxWtk.WtkEditText.prototype.elem = null;

fan.fgfxWtk.WtkEditText.prototype.text = function() {
  return this.elem.value;
}
fan.fgfxWtk.WtkEditText.prototype.text$ = function(text) {
  this.elem.value = text;
}
fan.fgfxWtk.WtkEditText.prototype.setEnabled = function(enabled) {
  this.elem.disabled = !enabled;
}
fan.fgfxWtk.WtkEditText.prototype.setBound = function(x, y, w, h) {
  this.elem.style.left = x + "px";
  this.elem.style.top = y + "px";
  this.elem.style.width = w + "px";
  this.elem.style.height = h + "px";
}
fan.fgfxWtk.WtkEditText.prototype.setInputType = function(type) {
  this.elem.inputType = type;
}
fan.fgfxWtk.WtkEditText.prototype.setSingleLine = function(singleLine) {
  this.elem.singleLine = singleLine;
}
fan.fgfxWtk.WtkEditText.prototype.setSelection = function(start, stop) {
  if (start < stop) {
    this.elem.select();
  } else {
    //TODO
  }
}
fan.fgfxWtk.WtkEditText.prototype.setTextColor = function(color) {
  this.elem.style.background = color.toCss();
}
fan.fgfxWtk.WtkEditText.prototype.setFont = function(font) {
  this.elem.style.font = fan.fgfxWtk.GfxUtil.fontToCss(font);
}
fan.fgfxWtk.WtkEditText.prototype.setBackgroundColor = function(color) {
  this.elem.style.color = color.toCss();
}

