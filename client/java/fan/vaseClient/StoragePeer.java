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
  public static String baseStorePath = "./storage/";
  static Storage cur;

  public static Storage open(String path) {
    Storage storage = FileStorage.make(path);
    return storage;
  }

  static Storage cur() {
    if (cur == null) {
      cur = open(baseStorePath + "defaultStorage");
    }
    return cur;
  }
}
