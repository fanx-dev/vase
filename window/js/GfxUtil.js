//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-08-20  Jed Young  Creation
//

fan.fanvasWindow.GfxUtil = {}

fan.fanvasWindow.GfxUtil.fontToCss = function(font)
{
  var s = "";
  if (font.m_bold)   s += "bold ";
  if (font.m_italic) s += "italic ";
  s += font.m_size + "px ";
  s += font.m_$name;
  return s;
}

fan.fanvasWindow.GfxUtil.uriToImageSrc = function(uri)
{
  if ("fan" == uri.scheme)
    return fan.sys.UriPodBase + uri.host() + uri.pathStr()
  else
    return uri.toStr();
}

fan.fanvasWindow.GfxUtil.addEventListener = function(obj, type, func)
{
  // for IE
  if (!obj.addEventListener) {
    obj.attachEvent("on" + type, func);
  }
  else {
    obj.addEventListener(type, func, false);
  }
}

fan.fanvasWindow.GfxUtil.doJsPath = function(cx, path)
{
  var size = path.steps().size();
  cx.beginPath();
  for (var i =0; i < size; ++i)
  {
    var s = path.steps().get(i);

    if (s instanceof fan.fanvasGraphics.PathMoveTo)
    {
      cx.moveTo(s.m_x, s.m_y);
    }
    else if (s instanceof fan.fanvasGraphics.PathLineTo)
    {
      cx.lineTo(s.m_x, s.m_y);
    }
    else if (s instanceof fan.fanvasGraphics.PathQuadTo)
    {
      cx.quadraticCurveTo(s.m_cx, s.m_cy, s.m_x, s.m_y);
    }
    else if (s instanceof fan.fanvasGraphics.PathCubicTo)
    {
      cx.bezierCurveTo(s.m_cx1, s.m_cy1, s.m_cx2, s.m_cy2, s.m_x, s.m_y);
    }
    else if (s instanceof fan.fanvasGraphics.PathClose)
    {
      cx.closePath();
    }
    else
    {
      throw fan.sys.Err.make("unreachable");
    }
  }
}

fan.fanvasWindow.GfxUtil.doJsTransform = function(cx, trans)
{
  cx.transform(
       trans.get(0,0),
       trans.get(0,1),
       trans.get(1,0),
       trans.get(1,1),
       trans.get(2,0),
       trans.get(2,1)
     );
}