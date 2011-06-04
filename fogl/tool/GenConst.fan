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

    printJava(inFile)
    printJs(inFile)
    printFantom(inFile)
    printFantom2(inFile)
  }

  private Void printJava(File inFile)
  {
    File outFile := File(path + `gen/const.java`)
    out := outFile.out
    inFile.eachLine |line| { print(out, line, 0) }
    out.close
  }

  private Void printJs(File inFile)
  {
    File outFile := File(path + `gen/const.js`)
    out := outFile.out
    inFile.eachLine |line| { print(out, line, 1) }
    out.close
  }

  private Void printFantom(File inFile)
  {
    File outFile := File(path + `gen/const.fan`)
    out := outFile.out
    inFile.eachLine |line| { print(out, line, 2) }
    out.close
  }

  private Void printFantom2(File inFile)
  {
    File outFile := File(path + `gen/const2.fan`)
    out := outFile.out
    inFile.eachLine |line| { print(out, line, 3) }
    out.close
  }

  private Void print(OutStream out, Str line, Int flag)
  {
    if (line.isSpace) { out.printLine; return }
    if (comment(out, line)) return

    i := line.index("=")
    key := line[0..<i]

    upperName := key.trim
    lowerName := lower(upperName)

    switch(flag)
    {
    case 0:
      out.printLine(java(upperName, lowerName))
    case 1:
      out.printLine(js(upperName, lowerName))
    case 2:
      out.printLine(fantom(upperName, lowerName))
    case 3:
      out.printLine(fantom2(upperName, lowerName))
    }
  }

  private Str java(Str upperName, Str lowerName)
  {
    "  GlEnum gl${lowerName}(GlEnumFactory self){ return makeEnum(GL_$upperName); }"
  }

  private Str js(Str upperName, Str lowerName)
  {
    namespace := "fan.fogl.GlEnumFactoryPeer"
    return "${namespace}.prototype.gl${lowerName}(self){ return ${namespace}.makeEnum(self.m_gl.$upperName); }"
  }

  private Str fantom(Str upperName, Str lowerName)
  {
    "  native GlEnum gl${lowerName}()"
  }

  private Str fantom2(Str upperName, Str lowerName)
  {
    "  const GlEnum gl${lowerName} := enums.gl${lowerName}"
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