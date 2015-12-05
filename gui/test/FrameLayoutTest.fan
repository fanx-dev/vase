//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2015-12-5  Jed Young  Creation
//


@Js
class FrameLayoutTest : BaseTestWin
{
  protected override Widget build() {
    FrameLayout
    {
      it.id = "mainView"
      Button
      {
        it.id = "btn1"
        it.text = "btn1"
        it.layoutParam.posX = 800
        it.layoutParam.posY = 500
        it.layoutParam.width = LayoutParam.wrapContent
      },
      Button
      {
        it.text = "btn2"
        it.layoutParam.width = LayoutParam.wrapContent
      },
      Button
      {
        it.text = "btn3"
        it.layoutParam.width = LayoutParam.wrapContent
        it.layoutParam.posX = -20
        it.layoutParam.posY = -200
      },
      Button
      {
        it.text = "btn4"
        it.layoutParam.width = LayoutParam.wrapContent
        it.layoutParam.margin = Insets(60)
      },
    }
  }
}