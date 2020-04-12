//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2015-12-5  Jed Young  Creation
//

using vaseGui

@Js
class HBoxTest : BaseTestWin
{
  protected override Widget build() {
    VBox {
      HBox
      {
        it.id = "mainView"
        //it.spacing = 20
        //it.padding = Insets(50)
        //it.vertical = false
        //it.margin = Insets(50)
        Button
        {
          it.id = "btn1"
          it.text = "btn1"
          //it.layoutParam.widthType = SizeType.wrapContent
        },
        Button
        {
          it.id = "btn2"
          it.text = "btn2"
          //it.layoutParam.widthType = SizeType.wrapContent
        },
        Button
        {
          it.id = "btn3"
          it.text = "btn3"
          //it.layoutParam.widthType = SizeType.wrapContent
        },

      },
      HBox
      {
        align = Align.center
        //it.spacing = 20
        //it.padding = Insets(50)
        //it.vertical = false
        //it.margin = Insets(50)
        Button
        {
          it.text = "btn1"
          it.layoutParam.widthType = SizeType.wrapContent
        },
        Button
        {
          it.text = "btn2"
          it.layoutParam.widthType = SizeType.wrapContent
        },
        Button
        {
          it.text = "btn3"
          it.layoutParam.widthType = SizeType.wrapContent
        },
      }
    }
  }
}