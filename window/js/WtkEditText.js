//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-7-4  Jed Young  Creation
//

fan.fanvasWindow.WtkEditText = fan.sys.Obj.$extend(fan.fanvasWindow.TextInputPeer);
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

  fan.fanvasWindow.GfxUtil.addEventListener(field, "input", function() {
    view.textChange(field.value);
  });

  this.elem = field;
  return field;
}

fan.fanvasWindow.WtkEditText.prototype.update = function() {
  var view = this.view;
  this.elem.disabled = !view.enabled();

  var pos = view.getPos();
  var size = view.getSize();
  this.elem.style.left = pos.m_x + "px";
  this.elem.style.top = pos.m_y + "px";
  this.elem.style.width = size.m_w + "px";
  this.elem.style.height = size.m_h + "px";
  this.elem.style.margin = 0;
  this.elem.style.padding = 0;

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

