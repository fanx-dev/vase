//
// Copyright (c) 2010, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2010-9-22  Jed Young  Creation
//

using web
using slanWeb

**
** Index
**
const class Index : Controller
{
  Void index()
  {
    m->name = "gfx2"
    render
  }
}