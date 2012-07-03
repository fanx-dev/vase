//
// Copyright (c) 2009, Brian Frank and Andy Frank
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-07-02  Jed Young  Creation
//

using concurrent

**
** Composite
**
@Js
enum class Composite
{
  srcAtop,
  srcIn,
  srcOut,
  dstAtop,
  dstIn,
  dstOut,
  dstOver,
  lighter,
  copy,
  xor
}