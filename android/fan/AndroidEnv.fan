//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-10-05  Jed Young  Creation
//

using concurrent
using [java]android.content::Context
using [java]android.app::Activity
using [java]android.content::Intent

class AndroidEnv
{
  native static Void init(Activity c)
  native static Bool onBack(Activity c)
  native static Void onActivityResult(Activity c, Int requestCode, Int resultCode, Intent data)
}