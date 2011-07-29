//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-07-29  Jed Young  Creation
//

@Js
class Image
{
  Uri uri

  new make(Uri uri) { this.uri = uri }

  native Void load(|This| f)
}

