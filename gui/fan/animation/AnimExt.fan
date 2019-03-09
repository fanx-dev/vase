

using fanvasGraphics

//////////////////////////////////////////////////////////////////////////
// Animation convenience
//////////////////////////////////////////////////////////////////////////

@Js
class AnimExt {
  static extension Animation fadeInAnim(Widget self, Int time := 500) {
    a := TweenAnimation {
      it.duration = time
      AlphaAnimChannel { to = 1f; from = 0f; },
    }
    a.bind(self)
    return a
  }
  static extension Animation fadeOutAnim(Widget self, Int time := 500, Bool detach := true) {
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

  static extension Animation moveInAnim(Widget self, Direction orig, Int time := 500) {
    x := 0
    y := 0
    p := Coord(0, 0)
    self.posOnWindow(p)
    root := self.getRootView

    switch (orig) {
      case Direction.top:
        y = -(p.y + self.height)
      case Direction.right:
        x = root.width - p.x
      case Direction.down:
        y = root.height - p.y
      case Direction.left:
        x = -(p.x + self.width)
    }

    a := TweenAnimation {
      it.duration = time
      TranslateAnimChannel { to = Point.defVal; from = Point(x, y)},
    }
    a.bind(self)
    return a
  }

  static extension Animation moveOutAnim(Widget self, Direction orig, Int time := 500, Bool detach := true) {

    x := 0
    y := 0
    p := Coord(0, 0)
    self.posOnWindow(p)
    root := self.getRootView

    switch (orig) {
      case Direction.top:
        y = -(p.y + self.height)
      case Direction.right:
        x = root.width - p.x
      case Direction.down:
        y = root.height - p.y
      case Direction.left:
        x = -(p.x + self.width)
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
      RotateAnimChannel { to = -0.1; from = 0.1 },
    }
    a.bind(self)
    return a
  }

  static extension Animation shrinkAnim(Widget self, Int time := 500, Coord? p := null, Bool detach := true) {
    if (p == null) {
      p = Coord(0, 0)
      self.posOnWindow(p)
    }

    self.mapToWidget(p)

    a := TweenAnimation() {
      it.duration = time
      ScaleAnimChannel { to = 0.0; from = 1.0 },
      TranslateAnimChannel { to = Point(p.x, p.y); from = Point.defVal },
    }
    a.whenDone.add {
      if (detach) self.detach
      else self.visible = false
    }
    a.bind(self)
    return a
  }

  static extension Animation expandAnim(Widget self, Int time := 500, Coord? p := null) {
    if (p == null) {
      p = Coord(0, 0)
      self.posOnWindow(p)
    }

    self.mapToWidget(p)

    a := TweenAnimation() {
      it.duration = time
      ScaleAnimChannel { from = 0.0; to = 1.0 },
      TranslateAnimChannel { from = Point(p.x, p.y); to = Point.defVal },
    }
    a.bind(self)
    return a
  }

  static extension Animation scaleAnim(Widget self, Float from := 0f, Int time := 500) {
    a := TweenAnimation() {
      it.duration = time
      ScaleAnimChannel { it.from = from; to = 1.0f },
    }
    a.bind(self)
    return a
  }
}