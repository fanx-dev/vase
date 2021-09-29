//
// Copyright (c) 2010, Brian Frank and Andy Frank
// Licensed under the Academic Free License version 3.0
//
// History:
//   10 Aug 19  Andy Frank  Creation
//

**
** Storage models a DOM Storage.
**
** See [pod doc]`pod-doc#win` for details.
**
@Js @NoPeer
abstract class Storage
{
  native static Storage cur()

//////////////////////////////////////////////////////////////////////////
// Access
//////////////////////////////////////////////////////////////////////////

  ** Return the number of items in storage.
  abstract Int size()

  ** Return the key value for this index. If the index is greater
  ** than or equal to 'size' returns null.
  abstract Str? key(Int index)

  ** Return Obj stored under this key, or null if key does not exist.
  @Operator
  abstract Obj? get(Str key, Bool text := true)

  ** Store value under this key.
  @Operator
  abstract Void set(Str key, Obj val)

  ** Remove value for this key. If no value for this key exists,
  ** this method does nothing.
  abstract Void remove(Str key)

  ** Remove all items from storage.  If store was empty, this
  ** method does nothing.
  abstract Void clear()
}

internal class FileStorage : Storage {
  private File storeDir

  new make(Str path) {
    storeDir = File.os(path)
  }

  protected static Str nameEncode(Str n) {
     BufCrypto.toBase64Uri(Buf.make().print(n))
  }
  protected static Str nameDecode(Str n) {
     BufCrypto.fromBase64(n).readAllStr
  }

  ** Return the number of items in storage.
  override Int size() { storeDir.list.size }

  ** Return the key value for this index. If the index is greater
  ** than or equal to 'size' returns null.
  override Str? key(Int index) {
    list :=  storeDir.list
    if (index < list.size) return nameDecode(list[index].name)
    return null
  }

  ** Return Obj stored under this key, or null if key does not exist.
  @Operator
  override Obj? get(Str key, Bool text := true) {
    file := storeDir + nameEncode(key).toUri
    if (!file.exists) return null;
    if (!text) {
        return file.readAllBuf
    }
    return file.readAllStr
  }

  ** Store value under this key.
  @Operator
  override Void set(Str key, Obj val) {
    out := (storeDir + nameEncode(key).toUri).out
    try {
      if (val is Buf) {
        out.writeBuf((Buf)val);
      }
      else {
        out.writeChars(val.toStr);
      }
    } finally {
      out.close();
    }
  }

  ** Remove value for this key. If no value for this key exists,
  ** this method does nothing.
  override Void remove(Str key) {
    file := storeDir + nameEncode(key).toUri
    file.delete
  }

  ** Remove all items from storage.  If store was empty, this
  ** method does nothing.
  override Void clear() {
    fs :=  storeDir.list
    fs.each |f| {
       f.delete
    }
  }
}