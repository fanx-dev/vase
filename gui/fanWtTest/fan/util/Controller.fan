//
// Copyright (c) 2010, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2010-12-22  Jed Young  Creation
//

using slanWeb

const class Controller : SlanWeblet
{
  override Obj? onInvoke(Str name, Obj?[]? args)
  {
    //you can open and close database connection at here
    //and check Http Referer
    //or check user authority
    echo("before")
    try
      return SlanWeblet.super.onInvoke(name, args)
    finally
      echo("finally")
  }

}