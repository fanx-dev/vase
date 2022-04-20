//
// Copyright (c) 2021, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2021-11-03  Jed Young  Creation
//

using vaseGraphics
using vaseWindow

@Js
class VideoView : Widget
{
  Uri uri := ``

  @Transient
  Video video

  @Transient
  private Bool inited := false

  new make() {
    video = Video()
  }

  protected override Void layoutChildren(Bool force) {
    root := getRootView
    if (!inited) {
      video.uri = this.uri

      root.onClosing.add {
        this.close
      }
    }
    p := this.posOnWindow
    video.x = p.x.toInt
    video.y = p.y.toInt
    video.w = this.width
    video.h = this.height
    video.setup(root.host)
    inited = true
  }

  Void close() {
    if (inited) {
      video.remove
    }
  }
}
