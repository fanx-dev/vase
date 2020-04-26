//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2015-12-5  Jed Young  Creation
//
using vaseGui

@Js
class FrameLayoutTest : BaseTestWin
{
  protected override Widget build() {
    Pane
    {
      it.id = "mainView"
      layout.height = Layout.matchParent
      Button
      {
        it.id = "btn1"
        it.text = "btn1"
        it.layout.offsetX = 800f
        it.layout.offsetY = 500f
        it.layout.width = Layout.wrapContent
      },
      Button
      {
        it.text = "btn2"
        //it.layoutParam.widthType = SizeType.wrapContent
      },
      Button
      {
        it.text = "btn3"
        it.layout.width = Layout.wrapContent
        //it.layout.posX.with { it.parent = 1.0f; it.anchor = 1f; it.offset = -20f }
        //it.layout.posY.with { it.parent = 1.0f; it.anchor = 1f; it.offset = -200f }
        it.layout.hAlign = Align.end
        it.layout.vAlign = Align.end
        it.layout.offsetX = -20f
        it.layout.offsetY = -200f
      },
      Button
      {
        it.text = "btn4"
        it.layout.width = Layout.wrapContent
        it.margin = Insets(220)
      },
    }
  }
}