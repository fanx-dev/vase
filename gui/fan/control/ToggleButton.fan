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
class ToggleButton : Button
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
  
  internal Float animPostion := 0f

  new make() {
    text = "ToggleButton"
    layout.width = Layout.matchParent
    padding = Insets.defVal
    textAlign = Align.begin
  }
  
  protected Void startAnim() {
    afrom := 0f
    ato := 1f
    if (!this.selected) {
      afrom = 1f
      ato = 0f
    }
    anim := Animation {
      FloatPropertyAnimChannel(this, #animPostion) {
        from = afrom; to = ato
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

  protected override Void clicked() {
    super.clicked
    selected = !selected
    startAnim
    //this.repaint
  }

  protected override Size prefContentSize(Int hintsWidth := -1, Int hintsHeight := -1) {
    size := super.prefContentSize(hintsWidth, hintsHeight)
    return Size(size.w+(size.h*2), (size.h*1.3f).toInt)
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
    startAnim
    //this.repaint
  }
}
