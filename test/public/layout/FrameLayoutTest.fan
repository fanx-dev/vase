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
      Button
      {
        it.id = "btn1"
        it.text = "btn1"
        it.layoutParam.posX.offset = 800f
        it.layoutParam.posY.offset = 500f
        it.layoutParam.widthType = SizeType.wrapContent
      },
      Button
      {
        it.text = "btn2"
        //it.layoutParam.widthType = SizeType.wrapContent
      },
      Button
      {
        it.text = "btn3"
        it.layoutParam.widthType = SizeType.wrapContent
        it.layoutParam.posX.with { it.parent = 1.0f; it.anchor = 1f; it.offset = -20f }
        it.layoutParam.posY.with { it.parent = 1.0f; it.anchor = 1f; it.offset = -200f }
        //it.layoutParam.hAlign = Align.end
        //it.layoutParam.posX = 20f
        //it.layoutParam.posY = 200f
      },
      Button
      {
        it.text = "btn4"
        it.layoutParam.widthType = SizeType.wrapContent
        it.margin = Insets(220)
      },
    }
  }
}