//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-7-4  Jed Young  Creation
//

fan.fanvasWindow.WtkEditText = fan.sys.Obj.$extend(fan.fanvasWindow.WtkView);
fan.fanvasWindow.WtkEditText.prototype.$ctor = function() {}
fan.fanvasWindow.WtkEditText.prototype.$typeof = function() {
  return fan.fanvasWindow.WtkEditText.$type;
}

fan.fanvasWindow.WtkEditText.prototype.view = null;
fan.fanvasWindow.WtkEditText.prototype.elem = null;
fan.fanvasWindow.WtkEditText.prototype.elem = null;

fan.fanvasWindow.WtkEditText.prototype.text = function() {
  return this.elem.value;
}
fan.fanvasWindow.WtkEditText.prototype.text$ = function(text) {
  this.elem.value = text;
}
fan.fanvasWindow.WtkEditText.prototype.setEnabled = function(enabled) {
  this.elem.disabled = !enabled;
}
fan.fanvasWindow.WtkEditText.prototype.setBound = function(x, y, w, h) {
  this.elem.style.left = x + "px";
  this.elem.style.top = y + "px";
  this.elem.style.width = w + "px";
  this.elem.style.height = h + "px";
}
fan.fanvasWindow.WtkEditText.prototype.setInputType = function(type) {
  this.elem.inputType = type;
}
fan.fanvasWindow.WtkEditText.prototype.setSingleLine = function(singleLine) {
  this.elem.singleLine = singleLine;
}
fan.fanvasWindow.WtkEditText.prototype.setSelection = function(start, stop) {
  if (start < stop) {
    this.elem.select();
  } else {
    //TODO
  }
}
fan.fanvasWindow.WtkEditText.prototype.setTextColor = function(color) {
  this.elem.style.background = color.toCss();
}
fan.fanvasWindow.WtkEditText.prototype.setFont = function(font) {
  this.elem.style.font = fan.fanvasWindow.GfxUtil.fontToCss(font);
}
fan.fanvasWindow.WtkEditText.prototype.setBackgroundColor = function(color) {
  this.elem.style.color = color.toCss();
}

