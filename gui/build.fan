#! /usr/bin/env fan
//
// Copyright (c) 2010, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-08-28  Jed Young  Creation
//

using build

**
** Build flux/ pods
**
class Build : BuildGroup
{

  new make()
  {
    childrenScripts =
    [
      `../common/build.fan`,
      `fgfx2d/build.fan`,
      `wtk/build.fan`,
      `fgfxFwt/build.fan`,
      `widget/build.fan`,
      `android/build.fan`
    ]
  }

}