//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-7-4  Jed Young  Creation
//

fan.vaseWindow.WtkEditText = fan.sys.Obj.$extend(fan.vaseWindow.TextInput);
fan.vaseWindow.WtkEditText.prototype.$ctor = function() {}
fan.vaseWindow.WtkEditText.prototype.$typeof = function() {
  return fan.vaseWindow.WtkEditText.$type;
}

fan.vaseWindow.WtkEditText.prototype.elem = null;

fan.vaseWindow.WtkEditText.make = function(inputType) {
  //view.host$(this);
  var field = null;
  if (inputType == fan.vaseWindow.TextInput.m_inputTypePassword) {
    field = document.createElement("input");
    field.type = "password";
  }
  else if (inputType == fan.vaseWindow.TextInput.m_inputTypeMultiLine) {
    field = document.createElement("textarea");
    field.rows = 2;
  }
  else {
    field = document.createElement("input");
    field.type = "text";
  }
  var self = new fan.vaseWindow.WtkEditText();
  self.elem = field;
  self.init(field);
  return self;
}

fan.vaseWindow.WtkEditText.prototype.init = function(field) {
  var view = this;
  field.style.position = "absolute";
  field.style.border = "0";
  field.style.outline = "0";

  fan.vaseWindow.GfxUtil.addEventListener(field, "input", function() {
    view.textChange(field.value);
  });

  this.addKeyEvent(field, "keydown",    fan.vaseWindow.KeyEvent.m_pressed);
  this.addKeyEvent(field, "keyup",      fan.vaseWindow.KeyEvent.m_released);
  this.addKeyEvent(field, "keypress",   fan.vaseWindow.KeyEvent.m_typed);

  fan.vaseWindow.GfxUtil.addEventListener(field, "compositionend", function(e) {
    var event = fan.vaseWindow.KeyEvent.make(fan.vaseWindow.KeyEvent.m_typed);
    event.m_widget = this.elem;

    //simulate java key event
    for (let i=0; i<e.data.length; ++i) {
      event.m_keyChar = e.data.charCodeAt(i);
      event.m_key = null;//fan.vaseWindow.Key.m_enter;
      view.onKeyEvent(event);
    }
  });
}

fan.vaseWindow.WtkEditText.prototype.addKeyEvent = function(elem, type, id)
{
  var view = this;
  var keyEvent = function(e)
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
  fan.vaseWindow.GfxUtil.addEventListener(elem, type, keyEvent);
}

fan.vaseWindow.WtkEditText.prototype.focus = function() {
  this.elem.focus();

  var elem = this.elem;
  setTimeout(function() {
    //elem.scrollIntoView(true);
    //console.log("scrollIntoView:"+elem);
    elem.scrollIntoViewIfNeeded();
  }, 200);
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

fan.vaseWindow.WtkEditText.prototype.setType = function( multiLine,  editable) {
  this.elem.disabled = !editable;
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
