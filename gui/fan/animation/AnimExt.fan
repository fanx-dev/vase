

using vaseGraphics

//////////////////////////////////////////////////////////////////////////
// Animation convenience
//////////////////////////////////////////////////////////////////////////

@Js
class AnimExt {
  static extension Animation fadeInAnim(Widget self, Int time := 300) {
    a := TweenAnimation {
      it.duration = time
      AlphaAnimChannel { to = 1f; from = 0f; },
    }
    a.bind(self)
    return a
  }
  static extension Animation fadeOutAnim(Widget self, Int time := 300, Bool detach := true) {
    a := TweenAnimation {
      it.duration = time
      AlphaAnimChannel { from = 1f; to = 0f; },
    }
    a.whenDone.add {
      if (detach) self.detach
      else self.visible = false
    }
    a.bind(self)
    return a
  }

  static extension Animation moveInAnim(Widget self, Direction orig, Int time := 300) {
    x := 0
    y := 0
    p := self.posOnWindow
    root := self.getRootView

    switch (orig) {
      case Direction.top:
        y = -(p.y + self.height).toInt
      case Direction.right:
        x = root.width - p.x.toInt
      case Direction.down:
        y = root.height - p.y.toInt
      case Direction.left:
        x = -(p.x + self.width).toInt
    }

    a := TweenAnimation {
      it.duration = time
      TranslateAnimChannel { to = Point.defVal; from = Point(x, y)},
    }
    a.bind(self)
    return a
  }

  static extension Animation moveOutAnim(Widget self, Direction orig, Int time := 300, Bool detach := true) {

    x := 0
    y := 0
    p := self.posOnWindow
    root := self.getRootView

    switch (orig) {
      case Direction.top:
        y = -(p.y + self.height).toInt
      case Direction.right:
        x = root.width - p.x.toInt
      case Direction.down:
        y = root.height - p.y.toInt
      case Direction.left:
        x = -(p.x + self.width).toInt
    }

    /*
    switch (orig) {
      Direction.top:
        y = -100
      Direction.right:
        x = 1000
      Direction.down:
        y = 1000
      Direction.left:
        x = -100
    }
    */

    a := TweenAnimation() {
      it.duration = time
      TranslateAnimChannel { from = Point.defVal; to = Point(x, y)},
    }
    a.whenDone.add {
      if (detach) self.detach
      else self.visible = false
    }
    a.bind(self)
    return a
  }

  static extension Animation shakeAnim(Widget self, Int time := 100, Int repeat := 10) {
    a := TweenAnimation() {
      it.repeat = repeat
      it.duration = time
      RotateAnimChannel { to = -5f; from = 5f },
    }
    a.bind(self)
    return a
  }

  static extension Animation shrinkAnim(Widget self, Int time := 300, Bool detach := true) {
//    if (p == null) {
//      p = Coord(0f, 0f)
//      self.posOnWindow(p)
//    }
//
//    self.mapToWidget(p)

    a := TweenAnimation() {
      it.duration = time
      ScaleAnimChannel { to = 0.1; from = 1.0 },
      //TranslateAnimChannel { to = Point(p.x.toInt, p.y.toInt); from = Point.defVal },
      AlphaAnimChannel { to = 0f; from = 1f; },
    }
    a.whenDone.add {
      if (detach) self.detach
      else self.visible = false
    }
    a.bind(self)
    return a
  }

  static extension Animation expandAnim(Widget self, Int time := 300) {
//    if (p == null) {
//      p = Coord(0f, 0f)
//      self.posOnWindow(p)
//    }
//
//    self.mapToWidget(p)

    a := TweenAnimation() {
      it.duration = time
      ScaleAnimChannel { from = 0.1; to = 1.0 },
      //TranslateAnimChannel { from = Point(p.x.toInt, p.y.toInt); to = Point.defVal },
      AlphaAnimChannel { to = 1f; from = 0f; },
    }
    a.bind(self)
    return a
  }

  static extension Animation scaleAnim(Widget self, Float from := 0.1f, Int time := 300) {
    a := TweenAnimation() {
      it.duration = time
      ScaleAnimChannel { it.from = from; to = 1.0f },
      //AlphaAnimChannel { to = 1f; from = 0f; },
    }
    a.bind(self)
    return a
  }

  static extension Animation offsetAnim(Widget self, Float offset := 5f, Int time := 300) {
    px := self.dpToPixel(offset.toInt)
    a := TweenAnimation() {
      it.duration = time
      TranslateAnimChannel { to = Point.defVal; from = Point(px, px)},
    }
    a.bind(self)
    return a
  }
}