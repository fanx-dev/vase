/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package fan.vaseClient;

import java.io.File;
import fanx.interop.*;

/**
 *
 * @author yangjiandong
 */
public class StoragePeer {
  public static String storePath = "./storage/";
  static Storage cur;

  public static StoragePeer make(Storage self) { return new StoragePeer(); }

  static Storage cur() {
    if (cur == null) {
      cur = Storage.make();
    }
    return cur;
  }

  long size(Storage self) {
    return new File(storePath).list().length;
  }

  static String nameEncode(String n) {
     return fan.std.BufCrypto.toBase64Uri(fan.std.Buf.make().print(n));
  }
  static String nameDecode(String n) {
     return fan.std.BufCrypto.fromBase64(n).readAllStr();
  }

  String key(Storage self, long index) {
    String[] list =  new File(storePath).list();
    if (index < list.length) return nameDecode(list[(int)index]);
    return null;
  }

  Object get(Storage self, String key, boolean text) {
    File file = new File(storePath, nameEncode(key));
    if (!file.exists()) return null;
    if (!text) {
        return Interop.toFan(file).readAllBuf();
    }
    return Interop.toFan(file).readAllStr();
  }

  void set(Storage self, String key, Object val) {
    fan.std.OutStream out = Interop.toFan(new File(storePath, nameEncode(key))).out();
    if (val instanceof fan.std.Buf) {
      out.writeBuf((fan.std.Buf)val);
    }
    else {
      out.writeChars(val.toString());
    }
    out.close();
  }

  void remove(Storage self, String key) {
    new File(storePath, nameEncode(key)).delete();
  }

  void clear(Storage self) {
    File[] fs = new File(storePath).listFiles();
    for (File f : fs) {
       f.delete();
    }
  }
}
