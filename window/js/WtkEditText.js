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

fan.fanvasWindow.WtkEditText.prototype.init = function(view) {
  this.view = view;
  //view.host$(this);

  var field = document.createElement("input");
  field.type = "text";
  field.style.position = "absolute";

  this.elem = field;
  return field;
}

fan.fanvasWindow.WtkEditText.prototype.update = function() {
  this.elem.disabled = !view.enabled();

  var pos = view.pos();
  var size = view.pos();
  this.elem.style.left = pos.m_x + "px";
  this.elem.style.top = pos.m_y + "px";
  this.elem.style.width = size.m_w + "px";
  this.elem.style.height = size.m_h + "px";

  this.elem.inputType = view.inputType();
  this.elem.singleLine = view.singleLine();

  this.elem.style.background = view.backgroundColor().toCss();
  this.elem.style.color = view.textColor().toCss();
  this.elem.style.font = fan.fanvasWindow.GfxUtil.fontToCss(view.font());

  this.elem.value = view.text();

  this.elem.select();
}

fan.fanvasWindow.WtkEditText.prototype.close = function() {
  return this.elem.parentNode.removeChild(this.elem);
}

