#! /usr/bin/env fan
//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-06-04  Jed Young  Creation
//

class Main
{
  Uri? path

  **
  ** fan D:/code/Hg/fan3d/fogl/tool/GenConst.fan file:/D:/code/Hg/fan3d/fogl/tool/const.txt
  **
  Void main()
  {
    path = Env.cur.args[0].toUri
    File inFile := File(path)

    File outFile := File(path + `gen/const.fan`)
    out := outFile.out
    inFile.eachLine |line| { print(out, line) }
    out.close
  }

  private Void print(OutStream out, Str line)
  {
    if (line.isSpace) { out.printLine; return }
    if (comment(out, line)) return

    i := line.index("=")
    last := line.index(";")
    key := line[0..<i]
    value := line[i+1..<last].trim

    upperName := key.trim
    lowerName := lower(upperName)

    out.printLine(fantom(upperName, lowerName, value))
  }

  private Str fantom(Str upperName, Str lowerName, Str value)
  {
    "  static const GlEnum gl${lowerName} := GlEnum($value)"
  }

//////////////////////////////////////////////////////////////////////////
// util
//////////////////////////////////////////////////////////////////////////

  private Str lower(Str name)
  {
    strs := name.split('_')
    ns := strs.map { it.lower.capitalize }
    return ns.join
  }

  private Bool comment(OutStream out, Str line)
  {
    line = line.trim
    if (line.startsWith("/*") || line.startsWith("//"))
    {
      nline := line.replace("/*", "//").replace("*/", "")
      out.printLine(nline.trim)
      return true
    }
    else if(line.startsWith("//"))
    {
      out.printLine(line.trim)
      return true
    }
    return false
  }

}