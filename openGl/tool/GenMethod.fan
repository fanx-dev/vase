#! /usr/bin/env fan
//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-07-31  Jed Young  Creation
//

**************************************************************************
** Param
**************************************************************************

class FParam
{
  Str? name
  Str? type

  static FParam parse(Str s)
  {
    fs := s.split(' ').map { it.trim }
    return FParam
    {
      type = fs.first->trim
      name = fs.last->trim
    }
  }

  override Str toStr()
  {
    "$type $name"
  }
}

**************************************************************************
** Method
**************************************************************************

class FMethod : FParam
{
  FParam[] params := [,]

  override Str toStr()
  {
    ps := params.join(",")
    return "$type $name($ps)"
  }
}

**************************************************************************
** Main
**************************************************************************

class Main
{
  Uri? path
  OutStream? outFan
  OutStream? outJava
  OutStream? outJs

  **
  ** fan D:/code/Hg/fan3d/fogl/tool/GenMethod.fan file:/D:/code/Hg/fan3d/fogl/tool/method.txt
  **
  Void main()
  {
    path = Env.cur.args[0].toUri
    File inFile := File(path)

    openOutStream

    // parse
    allStr := inFile.readAllStr

    okList := FMethod[,]
    errList := FMethod[,]
    allStr.split(';').each |s|
    {
      line := s.replace("\r", "").replace("\n", "").trim
      if (!line.isEmpty)
      {
        method := parse(line)
        if (check(method))
        {
          okList.add(method)
        }
        else
        {
          errList.add(method)
        }
      }
    }

    //find override
    for (i := 0; i < okList.size; i++)
    {
      curItem := okList[i]
      findOver := false
      for (j := i+1; j < okList.size; j++)
      {
        if (curItem.name == okList[j].name)
        {
          errList.add(okList[j])
          okList.removeAt(j)
          findOver = true
        }
      }
      if (findOver)
      {
        okList.remove(curItem)
        errList.add(curItem)
      }
    }

    // print
    okList.each
    {
      printFan(outFan, it)
      printJs(outJs, it)
      printJava(outJava, it)
    }

    errList.each { Env.cur.out.print("//"); printFan(Env.cur.out, it) }
    echo("*******Js")
    errList.each { printJs(Env.cur.out, it) }
    echo("*******Java")
    errList.each { Env.cur.out.print("//"); printJava(Env.cur.out, it) }

    closeOutStream
  }

  private Void openOutStream()
  {
    File outFanFile := File(path + `gen/method.fan`)
    outFan = outFanFile.out

    File outJavaFile := File(path + `gen/method.java`)
    outJava = outJavaFile.out

    File outJsFile := File(path + `gen/method.js`)
    outJs = outJsFile.out
  }

  private Void closeOutStream()
  {
    outFan.close
    outJava.close
    outJs.close
  }

//////////////////////////////////////////////////////////////////////////
// parse
//////////////////////////////////////////////////////////////////////////

  private FMethod parse(Str line)
  {
    i := line.index("(")
    front := line[0..<i].trim
    behind := line[i+1..-1].replace(")", "").trim

    fs := front.split(' ').map { it.trim }
    bs := behind.split(',').map { it.trim }

    method := FMethod(){ type = fs.first->trim; name = fs.last->trim }
    bs.each |Str s|
    {
      if (!s.isEmpty)
      {
        p := FParam.parse(s)
        method.params.add(p)
      }
    }
    return method
  }

  private Bool check(FMethod method)
  {
    if (specialMethod.contains(method.name)) return false
    if (toFanType(method) == null) return false
    if (hasSpecialType(method)) return false
    r := method.params.any
    {
      toFanType(it) == null
    }
    return !r
  }

  private Bool hasSpecialType(FMethod m)
  {
    ftype := toFanType(m)
    if (ftype != null && specialType.contains(ftype)) return true
    if (ftype != null && ftype.endsWith("[]")) return true
    r := m.params.any |s->Bool|
    {
      ftype = toFanType(s)
      if (ftype != null && specialType.contains(ftype)) return true
      if (ftype != null && ftype.endsWith("[]")) return true
      return false
    }
    return r
  }

//////////////////////////////////////////////////////////////////////////
// print
//////////////////////////////////////////////////////////////////////////

  private Void printFan(OutStream out, FMethod method)
  {
    type := toFanType(method)

    ps := method.params.map{ "${toFanType(it)} $it.name" }.join(", ")
    s :=  "  abstract $type $method.name($ps)"
    out.printLine(s)
  }

  private Void printJava(OutStream out, FMethod method)
  {
    jtype := toJavaType(method)

    ps := method.params.map{ "${toJavaType(it)} $it.name" }.join(", ")
    jps := method.params.map { toJavaParam(it) }.join(", ")
    s :=  "  public $jtype $method.name($ps)"
    upperName := "gl" + method.name.capitalize
    if (jtype == "void")
    {
      s += "{ ${upperName}($jps); }"
    }
    else
    {
      if(indexObj.contains(method.type))
      {
        s +=
         "{
              int i = ${upperName}($jps);
              ${jtype} p = ${jtype}.make();
              p.peer.setValue(i);
              return p;
            }"
      }
      else
      {
        s += "{ return ${upperName}($jps); }"
      }
    }
    out.printLine(s.replace("\n", ""))
  }

  private Void printJs(OutStream out, FMethod method)
  {
    type := toFanType(method)
    ps := method.params.map { it.name }.join(", ")
    jps := method.params.map { toJsParam(it) }.join(", ")
    s := "fan.fanvasOpenGl.WebGlContext.prototype.$method.name = function($ps)"
    upperName := "this.gl.${method.name}"

    if (method.type == "void")
    {
      s += "{ ${upperName}($jps); }"
    }
    else
    {
      if(indexObj.contains(method.type))
      {
        s +=
         "{
              var i = ${upperName}($jps);
              var p = fan.fanvasOpenGl.${type}.make();
              p.peer.setValue(i);
              return p;
            }"
      }
      else
      {
        s += "{ return ${upperName}($jps); }"
      }
    }

    out.printLine(s.replace("\n", ""))
  }

//////////////////////////////////////////////////////////////////////////
// mapping
//////////////////////////////////////////////////////////////////////////

  const Str:Str fanToJavaMap :=
  [
    "Int" : "long",
    "Float" : "double",
    "Bool" : "boolean",
    "Void" : "void",
    "Str" : "String",
  ]

  const Str:Str jsToFanMap := Str:Str
  [
    "void" : "Void",
    "DOMString" : "Str",
    "boolean" : "Bool",
    "GLenum" : "GlEnum",
    "WebGLProgram" : "GlProgram",
    "ArrayBufferView" : "ArrayBuffer",
    "ArrayBuffer" : "ArrayBuffer",
    "GLint" : "Int",
    "GLsizei" : "Int",
    "WebGLBuffer" : "GlBuffer",
    "WebGLFramebuffer" : "GlFramebuffer",
    "WebGLRenderbuffer" : "GlRenderbuffer",
    "WebGLShader" : "GlShader",
    "WebGLTexture" : "GlTexture",
    "GLboolean" : "Bool",
    "GLclampf" : "Float",
    "GLuint" : "Int",
    "WebGLUniformLocation" : "GlUniformLocation",
    "GLboolean" : "Bool",
    "GLboolean" : "Bool",
    "GLfloat" : "Float",
    "WebGLActiveInfo" : "GlActiveInfo",
    "float" : "Float",
    "long" : "Int",
    "Float32Array" : "ArrayBuffer",
    "Int32Array" : "ArrayBuffer",
    "HTMLImageElement" : "Image",
    "GLbitfield" : "GlEnum",
    "GLintptr" : "Int",
    "GLsizeiptr" : "Int",
  ]

  const Str:Str coerceToJavaMap :=
  [
    "GLint" : "int",
    "GLuint" : "int",
    "GLsizei" : "int",
    "GLbyte" : "byte",
    "GLshort" : "short",
    "GLfloat" : "float",
    "GLclampf" : "float",
    "GLuint" : "int",
    "GLushort" : "short",
    "GLubyte" : "byte",
  ]

  const Str[] specialMethod :=
  [
    "bindTexture",
    "texImage2D",
    "getShaderInfoLog",
    "isContextLost",
    "checkFramebufferStatus",
    "getActiveAttrib",
    "getActiveUniform",
    "getError",
    "getProgramInfoLog",
    "getShaderSource",
    "getVertexAttribOffset",
    "bufferData",
  ]

  const Str[] specialType :=
  [
    "Image",
    "ArrayBuffer",
    "ArrayBufferView",
  ]

  const Str[] indexObj :=
  [
    "WebGLProgram",
    "WebGLShader",
    "WebGLBuffer",
    "WebGLFramebuffer",
    "WebGLRenderbuffer",
    "WebGLTexture",
    "WebGLUniformLocation",
    "WebGLActiveInfo",
  ]

  private Bool isEnum(FParam param)
  {
    fanType := toFanType(param)
    return (fanType == "GlEnum")
  }

  private Bool isBufferOrIndexObj(FParam param)
  {
    fanType := toFanType(param)
    return (fanType == "ArrayBuffer" || indexObj.contains(param.type))
  }

  private Str? toFanType(FParam param)
  {
    type := param.type
    ftype := jsToFanMap[type]
    if (ftype != null) return ftype

    if (type.endsWith("[]"))
    {
      rtype := type[0..-3]
      ftype = jsToFanMap[rtype]
      if (ftype != null) return ftype + "[]"
    }
    return null
  }

  private Str? toJavaType(FParam param)
  {
    ftype := toFanType(param)
    if (ftype == null) return null

    jtype := fanToJavaMap[ftype]
    if (jtype !=null) return jtype

    if (ftype.endsWith("[]"))
    {
      rtype := ftype[0..-3]
      jtype = fanToJavaMap[rtype]
      if (jtype != null) return jtype + "[]"
    }
    return ftype
  }

  private Str toJsParam(FParam param)
  {
    fanType := toFanType(param)
    if (isEnum(param)) return "${param.name}.m_val"
    if (isBufferOrIndexObj(param)) return "${param.name}.peer.getValue()"
    if (fanType == "Image") return "${param.name}.peer.image"
    return param.name
  }

  private Str toJavaParam(FParam param)
  {
    fanType := toFanType(param)
    if (isEnum(param)) return "(int)${param.name}.val"
    if (isBufferOrIndexObj(param)) return "${param.name}.peer.getValue()"
    if (fanType == "Image") return "${param.name}.peer.image"

    coerceType := coerceToJavaMap[param.type]
    if (coerceType != null) return "($coerceType)${param.name}"

    return param.name
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