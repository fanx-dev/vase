//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-7-7  Jed Young  Creation
//


**
** Clipboard provides access to the system clipboard for data transfer.
** Access is via `Desktop.clipboard`.
**
@Js
abstract class Clipboard
{
  **
  ** Get the current clipboard contents as plain text or null
  ** if clipboard doesn't contain text data.
  **
  abstract Str? getText(|Str?| callback)

  **
  ** Set the clipboard contents to given plain text data.
  **
  abstract Void setText(Str data)
}

internal class NClipboard : Clipboard {
  native Str? getTextSync()
	override Str? getText(|Str?| callback) {
    t := getTextSync
    callback.call(t)
    return t
  }
	native override Void setText(Str data)
}
