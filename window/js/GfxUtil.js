//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-08-20  Jed Young  Creation
//

fan.vaseWindow.GfxUtil = {}

fan.vaseWindow.GfxUtil.fontToCss = function(font)
{
  var s = "";
  if (font.m_bold)   s += "bold ";
  if (font.m_italic) s += "italic ";
  s += font.m_size + "px ";
  s += font.m_$name;
  return s;
}

fan.vaseWindow.GfxUtil.uriToImageSrc = function(uri)
{
  if ("fan" == uri.scheme())
    return "/pod/" + uri.host() + uri.pathStr()
  else
    return uri.toStr();
}

fan.vaseWindow.GfxUtil.addEventListener = function(obj, type, func)
{
  // for IE
  if (!obj.addEventListener) {
    obj.attachEvent("on" + type, func);
  }
  else {
    if (type == "mousewheel") {
      var passiveSupported = false;
      try {
          var options = Object.defineProperty({}, "passive", {
              get: function() {
                  passiveSupported = true;
              }
          });
          window.addEventListener("test", null, options);
      } catch(err) {}

      try {
        obj.addEventListener("mousewheel", func, passiveSupported ? { passive: false } : false)
      }
      catch(err) {
        obj.addEventListener("DOMMouseScroll", func, false);
        window.onmousewheel = document.onmousewheel = func;
      }
    }
    else {
      obj.addEventListener(type, func, false);
    }
  }
}

fan.vaseWindow.GfxUtil.doJsPath = function(cx, path)
{
  var size = path.steps().size();
  cx.beginPath();
  for (var i =0; i < size; ++i)
  {
    var s = path.steps().get(i);

    if (s instanceof fan.vaseGraphics.PathMoveTo)
    {
      cx.moveTo(s.m_x, s.m_y);
    }
    else if (s instanceof fan.vaseGraphics.PathLineTo)
    {
      cx.lineTo(s.m_x, s.m_y);
    }
    else if (s instanceof fan.vaseGraphics.PathQuadTo)
    {
      cx.quadraticCurveTo(s.m_cx, s.m_cy, s.m_x, s.m_y);
    }
    else if (s instanceof fan.vaseGraphics.PathCubicTo)
    {
      cx.bezierCurveTo(s.m_cx1, s.m_cy1, s.m_cx2, s.m_cy2, s.m_x, s.m_y);
    }
    else if (s instanceof fan.vaseGraphics.PathClose)
    {
      cx.closePath();
    }
    else if (s instanceof fan.vaseGraphics.PathArc) {
      var sa  = Math.PI / 180 * s.m_startAngle;
      var ea  = Math.PI / 180 * (s.m_startAngle + s.m_arcAngle);
      cx.arc(s.m_cx, s.m_cy, s.m_radius, sa, ea, true);
    }
    else
    {
      throw fan.sys.Err.make("unreachable");
    }
  }
}

fan.vaseWindow.GfxUtil.doJsTransform = function(cx, trans)
{
  cx.transform(
       trans.m_a,
       trans.m_b,
       trans.m_c,
       trans.m_d,
       trans.m_e,
       trans.m_f
     );
}