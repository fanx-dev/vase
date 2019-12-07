//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-7-4  Jed Young  Creation
//

fan.vaseWindow.WtkEditText = fan.sys.Obj.$extend(fan.vaseWindow.TextInputPeer);
fan.vaseWindow.WtkEditText.prototype.$ctor = function() {}
fan.vaseWindow.WtkEditText.prototype.$typeof = function() {
  return fan.vaseWindow.WtkEditText.$type;
}

fan.vaseWindow.WtkEditText.prototype.view = null;
fan.vaseWindow.WtkEditText.prototype.elem = null;

fan.vaseWindow.WtkEditText.prototype.make = function(view) {
  this.view = view;
  //view.host$(this);

  var field = document.createElement("input");
  field.type = "text";
  this.elem = field;
  this.init(field);
}

fan.vaseWindow.WtkEditText.prototype.init = function(field) {
  var view = this.view;
  field.style.position = "absolute";
  field.style.border = "0";
  field.style.outline = "0";

  fan.vaseWindow.GfxUtil.addEventListener(field, "input", function() {
    view.textChange(field.value);
  });

  this.addKeyEvent(field, "keydown",    fan.vaseWindow.KeyEvent.m_pressed);
  this.addKeyEvent(field, "keyup",      fan.vaseWindow.KeyEvent.m_released);
  this.addKeyEvent(field, "keypress",   fan.vaseWindow.KeyEvent.m_typed);
}

fan.vaseWindow.WtkEditText.prototype.addKeyEvent = function(elem, type, id)
{
  var view = this.view;
  var mouseEvent = function(e)
  {
    //console.log(e);
    var event = fan.vaseWindow.KeyEvent.make(id);
    //event.m_id = id;
    event.m_widget = this.elem;
    event.m_key = fan.vaseWindow.Event.toKey(e);
    event.m_keyChar =  e.charCode || e.keyCode;
    view.onKeyEvent(event);

    //console.log(event.m_consumed)

    if (event.m_consumed) {
      e.stopPropagation();
      e.preventDefault();
      e.cancelBubble = true;
    }
  };
  fan.vaseWindow.GfxUtil.addEventListener(elem, type, mouseEvent);
}
/*
fan.vaseWindow.WtkEditText.prototype.update = function(type) {
  var view = this.view;
  var pos = view.getPos();
  var size = view.getSize();
  
  this.elem.style.left = pos.m_x + "px";
  this.elem.style.top = pos.m_y + "px";
  this.elem.style.width = size.m_w + "px";
  this.elem.style.height = size.m_h + "px";
  this.elem.style.margin = 0;
  this.elem.style.padding = 0;

  this.elem.disabled = !view.editable();
  this.elem.inputType = view.inputType();
  this.elem.singleLine = view.singleLine();

  this.elem.style.background = view.backgroundColor().toCss();
  this.elem.style.color = view.textColor().toCss();
  this.elem.style.font = fan.vaseWindow.GfxUtil.fontToCss(view.font());

  this.elem.value = view.text();

  this.elem.focus();
}
*/
fan.vaseWindow.WtkEditText.prototype.focus = function() {
  this.elem.focus();
}

fan.vaseWindow.WtkEditText.prototype.setPos = function(x, y, w, h) {
  this.elem.style.left = x + "px";
  this.elem.style.top = y + "px";
  this.elem.style.width = w + "px";
  this.elem.style.height = h + "px";
  this.elem.style.margin = 0;
  this.elem.style.padding = 0;
}

fan.vaseWindow.WtkEditText.prototype.setStyle = function(font, textColor, backgroundColor) {
  this.elem.style.background = backgroundColor.toCss();
  this.elem.style.color = textColor.toCss();
  this.elem.style.font = fan.vaseWindow.GfxUtil.fontToCss(font);
}

fan.vaseWindow.WtkEditText.prototype.setText = function( text) {
  this.elem.value = text;
}

fan.vaseWindow.WtkEditText.prototype.setType = function( multiLine,  inputType,  editable) {
  if (multiLine <= 1) {
    if (this.elem.type != "text") {
      this.close();
      var field = document.createElement("input");
      field.type = "text";
      this.elem = field;
      this.init(field);
    }
  }
  else {
    if (this.elem.type == "text") {
      this.close();
      var field = document.createElement("textarea");
      field.rows = multiLine;
      this.elem = field;
      this.init(field);
    }
  }
  this.elem.disabled = !editable;
  this.elem.inputType = inputType;
}

fan.vaseWindow.WtkEditText.prototype.close = function() {
  if (this.elem.parentNode)
    this.elem.parentNode.removeChild(this.elem);
}

fan.vaseWindow.WtkEditText.prototype.select = function(start, end) {
  this.elem.setSelectionRange(start, end);
}

fan.vaseWindow.WtkEditText.prototype.caretPos = function() {
  return this.elem.selectionStart;
}
