//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-07-15  Jed Young  Creation
//

using fanvasGraphics
using fanvasWindow

**
** CheckBox or RadioBox
**
@Js
class ToggleButton : ButtonBase
{
  Bool selected := false
  {
    set
    {
      e := StateChangedEvent (&selected, it, #selected, this )
      onStateChanged.fire(e)
      &selected = it
    }
  }
  
  new make() {
    text = "ToggleButton"
    layoutParam.width = LayoutParam.matchParent
  }

  protected override Void clicked() {
    super.clicked
    selected = !selected
    this.requestPaint
  }

  protected override Dimension prefContentSize(Dimension result) {
    size := super.prefContentSize(result)
    return result.set(size.w+(size.h*2), (size.h*1.3f).toInt)
  }
}

@Js
class RadioButton : ToggleButton {
  protected override Void clicked() {
    if (this.parent == null) {
      super.clicked
    }

    if (selected == true) {
      return
    }
    parent?.each |w| {
      if (w is RadioButton) {
        RadioButton r := w
        if (r.selected) {
          r.selected = false
          r.requestPaint
        }
      }
    }
    selected = true
    this.requestPaint
  }
}

@Js
class Switch : ToggleButton {
  Float animPostion := 0f
  
  protected override Void clicked() {
    super.clicked
    
    afrom := 0f
    ato := 1f
    if (!this.selected) {
      afrom = 1f
      ato = 0f
    }
    anim := Animation {
      FloatPropertyAnimChannel(this, #animPostion) { 
        from = afrom; to = ato 
        it.updateFunc = |->| {
          this.requestPaint
        }
      },
    }
    anim.whenDone.add {
      this.requestPaint
    }
    anim.duration = 200
    this.getRootView.animManager.add(anim)
    anim.start
    this.requestPaint
  }
}