//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-07-15  Jed Young  Creation
//

using vaseGraphics
using vaseWindow

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
    layout.width = Layout.matchParent
  }

  protected override Void clicked() {
    super.clicked
    selected = !selected
    this.repaint
  }

  protected override Dimension prefContentSize() {
    size := super.prefContentSize()
    return Dimension(size.w+(size.h*2), (size.h*1.3f).toInt)
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
          r.repaint
        }
      }
    }
    selected = true
    this.repaint
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
          this.repaint
        }
      },
    }
    anim.whenDone.add {
      this.repaint
    }
    anim.duration = 200
    this.getRootView.animManager.add(anim)
    anim.start
    this.repaint
  }
}