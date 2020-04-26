//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2015-12-5  Jed Young  Creation
//

using vaseGui

@Js
class LinearLayoutTest : BaseTestWin
{
  protected override Widget build() {
    VBox
    {
      it.id = "mainView"
      //it.spacing = 20
      //it.padding = Insets(50)
      //it.vertical = false
      it.margin = Insets(50)
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
        it.id = "btn2"
        it.text = "btn2"
        it.layout.weight = 1.0f
        it.layout.height = Layout.matchParent
        //it.layout.width = SizeType.fixed
        it.layout.width = 600f
      },
      Button
      {
        it.id = "btn3"
        it.text = "btn3"
        it.layout.width = Layout.matchParent
      },

    }
  }
}