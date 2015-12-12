//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2015-12-5  Jed Young  Creation
//


@Js
class EdgeLayoutTest : BaseTestWin
{
  protected override Widget build() {
    EdgePane
    {
      it.id = "mainView"
      top = Button
      {
        it.id = "btn1"
        it.text = "top"
        //it.layoutParam.width = LayoutParam.wrapContent
      }
      left = Button
      {
        it.text = "left"
        //it.layoutParam.width = LayoutParam.wrapContent
      }
      right = Button
      {
        it.text = "right"
        //it.layoutParam.width = LayoutParam.wrapContent
      }
      bottom = Button
      {
        it.text = "bottom"
        //it.layoutParam.width = LayoutParam.wrapContent
      }
      center = Button
      {
        it.text = "center"
      }
    }
  }
}