//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-10-05  Jed Young  Creation
//

using concurrent
using [java]android.content::Context

class AndroidEnv
{
  native static Void init(Context c)
}