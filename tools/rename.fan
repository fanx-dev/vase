#! /usr/bin/env fan
//
// Copyright (c) 2010, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-08-28  Jed Young  Creation
//

using util

class Main : AbstractMain {
  @Opt { help = "path argument" }
  File path := homeDir.parent

  @Arg { help = "src arg" }
  Str? src

  @Arg { help = "dst arg" }
  Str? dst

  @Opt { help = "sure rename arg" }
  Bool replace := false

  override Int run() {
    echo("$src=>$dst")
    path.walk |file| {
      //if (file.pathStr.contains("."))
      if (file.ext == "fan" || file.ext == "js" || file.ext == "java") {
        content := file.readAllStr
        if (content.contains(src)) {
          echo(file.pathStr)
          if (replace) {
             content = content.replace(src, dst)
             file.out.writeChars(content).close
          }
        }
      }
    }
    return 0
  }
}