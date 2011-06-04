//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-05-29  Jed Young  Creation
//   2011-06-04  Jed Young  Using literal
//

const class GlEnum
{
  const Int val

  private new make(Int val){ this.val = val }

  GlEnum mix(GlEnum e){ GlEnum(this.val.or(e.val)) }

//////////////////////////////////////////////////////////////////////////
// Gen
//////////////////////////////////////////////////////////////////////////

  static const GlEnum glDepthBufferBit := GlEnum(0x00000100)
  static const GlEnum glStencilBufferBit := GlEnum(0x00000400)
  static const GlEnum glColorBufferBit := GlEnum(0x00004000)

// BeginMode
  static const GlEnum glPoints := GlEnum(0x0000)
  static const GlEnum glLines := GlEnum(0x0001)
  static const GlEnum glLineLoop := GlEnum(0x0002)
  static const GlEnum glLineStrip := GlEnum(0x0003)
  static const GlEnum glTriangles := GlEnum(0x0004)
  static const GlEnum glTriangleStrip := GlEnum(0x0005)
  static const GlEnum glTriangleFan := GlEnum(0x0006)

// AlphaFunction (not supported in ES20)
// NEVER
// LESS
// EQUAL
// LEQUAL
// GREATER
// NOTEQUAL
// GEQUAL
// ALWAYS

// BlendingFactorDest
  static const GlEnum glZero := GlEnum(0)
  static const GlEnum glOne := GlEnum(1)
  static const GlEnum glSrcColor := GlEnum(0x0300)
  static const GlEnum glOneMinusSrcColor := GlEnum(0x0301)
  static const GlEnum glSrcAlpha := GlEnum(0x0302)
  static const GlEnum glOneMinusSrcAlpha := GlEnum(0x0303)
  static const GlEnum glDstAlpha := GlEnum(0x0304)
  static const GlEnum glOneMinusDstAlpha := GlEnum(0x0305)

// BlendingFactorSrc
// ZERO
// ONE
  static const GlEnum glDstColor := GlEnum(0x0306)
  static const GlEnum glOneMinusDstColor := GlEnum(0x0307)
  static const GlEnum glSrcAlphaSaturate := GlEnum(0x0308)
// SRC_ALPHA
// ONE_MINUS_SRC_ALPHA
// DST_ALPHA
// ONE_MINUS_DST_ALPHA

// BlendEquationSeparate
  static const GlEnum glFuncAdd := GlEnum(0x8006)
  static const GlEnum glBlendEquation := GlEnum(0x8009)
// same as BLEND_EQUATION
  static const GlEnum glBlendEquationRgb := GlEnum(0x8009)
  static const GlEnum glBlendEquationAlpha := GlEnum(0x883D)

// BlendSubtract
  static const GlEnum glFuncSubtract := GlEnum(0x800A)
  static const GlEnum glFuncReverseSubtract := GlEnum(0x800B)

// Separate Blend Functions
  static const GlEnum glBlendDstRgb := GlEnum(0x80C8)
  static const GlEnum glBlendSrcRgb := GlEnum(0x80C9)
  static const GlEnum glBlendDstAlpha := GlEnum(0x80CA)
  static const GlEnum glBlendSrcAlpha := GlEnum(0x80CB)
  static const GlEnum glConstantColor := GlEnum(0x8001)
  static const GlEnum glOneMinusConstantColor := GlEnum(0x8002)
  static const GlEnum glConstantAlpha := GlEnum(0x8003)
  static const GlEnum glOneMinusConstantAlpha := GlEnum(0x8004)
  static const GlEnum glBlendColor := GlEnum(0x8005)

// Buffer Objects
  static const GlEnum glArrayBuffer := GlEnum(0x8892)
  static const GlEnum glElementArrayBuffer := GlEnum(0x8893)
  static const GlEnum glArrayBufferBinding := GlEnum(0x8894)
  static const GlEnum glElementArrayBufferBinding := GlEnum(0x8895)

  static const GlEnum glStreamDraw := GlEnum(0x88E0)
  static const GlEnum glStaticDraw := GlEnum(0x88E4)
  static const GlEnum glDynamicDraw := GlEnum(0x88E8)

  static const GlEnum glBufferSize := GlEnum(0x8764)
  static const GlEnum glBufferUsage := GlEnum(0x8765)

  static const GlEnum glCurrentVertexAttrib := GlEnum(0x8626)

// CullFaceMode
  static const GlEnum glFront := GlEnum(0x0404)
  static const GlEnum glBack := GlEnum(0x0405)
  static const GlEnum glFrontAndBack := GlEnum(0x0408)

// DepthFunction
// NEVER
// LESS
// EQUAL
// LEQUAL
// GREATER
// NOTEQUAL
// GEQUAL
// ALWAYS

// EnableCap
// TEXTURE_2D
  static const GlEnum glCullFace := GlEnum(0x0B44)
  static const GlEnum glBlend := GlEnum(0x0BE2)
  static const GlEnum glDither := GlEnum(0x0BD0)
  static const GlEnum glStencilTest := GlEnum(0x0B90)
  static const GlEnum glDepthTest := GlEnum(0x0B71)
  static const GlEnum glScissorTest := GlEnum(0x0C11)
  static const GlEnum glPolygonOffsetFill := GlEnum(0x8037)
  static const GlEnum glSampleAlphaToCoverage := GlEnum(0x809E)
  static const GlEnum glSampleCoverage := GlEnum(0x80A0)

// ErrorCode
  static const GlEnum glNoError := GlEnum(0)
  static const GlEnum glInvalidEnum := GlEnum(0x0500)
  static const GlEnum glInvalidValue := GlEnum(0x0501)
  static const GlEnum glInvalidOperation := GlEnum(0x0502)
  static const GlEnum glOutOfMemory := GlEnum(0x0505)

// FrontFaceDirection
  static const GlEnum glCw := GlEnum(0x0900)
  static const GlEnum glCcw := GlEnum(0x0901)

// GetPName
  static const GlEnum glLineWidth := GlEnum(0x0B21)
  static const GlEnum glAliasedPointSizeRange := GlEnum(0x846D)
  static const GlEnum glAliasedLineWidthRange := GlEnum(0x846E)
  static const GlEnum glCullFaceMode := GlEnum(0x0B45)
  static const GlEnum glFrontFace := GlEnum(0x0B46)
  static const GlEnum glDepthRange := GlEnum(0x0B70)
  static const GlEnum glDepthWritemask := GlEnum(0x0B72)
  static const GlEnum glDepthClearValue := GlEnum(0x0B73)
  static const GlEnum glDepthFunc := GlEnum(0x0B74)
  static const GlEnum glStencilClearValue := GlEnum(0x0B91)
  static const GlEnum glStencilFunc := GlEnum(0x0B92)
  static const GlEnum glStencilFail := GlEnum(0x0B94)
  static const GlEnum glStencilPassDepthFail := GlEnum(0x0B95)
  static const GlEnum glStencilPassDepthPass := GlEnum(0x0B96)
  static const GlEnum glStencilRef := GlEnum(0x0B97)
  static const GlEnum glStencilValueMask := GlEnum(0x0B93)
  static const GlEnum glStencilWritemask := GlEnum(0x0B98)
  static const GlEnum glStencilBackFunc := GlEnum(0x8800)
  static const GlEnum glStencilBackFail := GlEnum(0x8801)
  static const GlEnum glStencilBackPassDepthFail := GlEnum(0x8802)
  static const GlEnum glStencilBackPassDepthPass := GlEnum(0x8803)
  static const GlEnum glStencilBackRef := GlEnum(0x8CA3)
  static const GlEnum glStencilBackValueMask := GlEnum(0x8CA4)
  static const GlEnum glStencilBackWritemask := GlEnum(0x8CA5)
  static const GlEnum glViewport := GlEnum(0x0BA2)
  static const GlEnum glScissorBox := GlEnum(0x0C10)
// SCISSOR_TEST
  static const GlEnum glColorClearValue := GlEnum(0x0C22)
  static const GlEnum glColorWritemask := GlEnum(0x0C23)
  static const GlEnum glUnpackAlignment := GlEnum(0x0CF5)
  static const GlEnum glPackAlignment := GlEnum(0x0D05)
  static const GlEnum glMaxTextureSize := GlEnum(0x0D33)
  static const GlEnum glMaxViewportDims := GlEnum(0x0D3A)
  static const GlEnum glSubpixelBits := GlEnum(0x0D50)
  static const GlEnum glRedBits := GlEnum(0x0D52)
  static const GlEnum glGreenBits := GlEnum(0x0D53)
  static const GlEnum glBlueBits := GlEnum(0x0D54)
  static const GlEnum glAlphaBits := GlEnum(0x0D55)
  static const GlEnum glDepthBits := GlEnum(0x0D56)
  static const GlEnum glStencilBits := GlEnum(0x0D57)
  static const GlEnum glPolygonOffsetUnits := GlEnum(0x2A00)
// POLYGON_OFFSET_FILL
  static const GlEnum glPolygonOffsetFactor := GlEnum(0x8038)
  static const GlEnum glTextureBinding2d := GlEnum(0x8069)
  static const GlEnum glSampleBuffers := GlEnum(0x80A8)
  static const GlEnum glSamples := GlEnum(0x80A9)
  static const GlEnum glSampleCoverageValue := GlEnum(0x80AA)
  static const GlEnum glSampleCoverageInvert := GlEnum(0x80AB)

// GetTextureParameter
// TEXTURE_MAG_FILTER
// TEXTURE_MIN_FILTER
// TEXTURE_WRAP_S
// TEXTURE_WRAP_T

  static const GlEnum glNumCompressedTextureFormats := GlEnum(0x86A2)
  static const GlEnum glCompressedTextureFormats := GlEnum(0x86A3)

// HintMode
  static const GlEnum glDontCare := GlEnum(0x1100)
  static const GlEnum glFastest := GlEnum(0x1101)
  static const GlEnum glNicest := GlEnum(0x1102)

// HintTarget
  static const GlEnum glGenerateMipmapHint := GlEnum(0x8192)

// DataType
  static const GlEnum glByte := GlEnum(0x1400)
  static const GlEnum glUnsignedByte := GlEnum(0x1401)
  static const GlEnum glShort := GlEnum(0x1402)
  static const GlEnum glUnsignedShort := GlEnum(0x1403)
  static const GlEnum glInt := GlEnum(0x1404)
  static const GlEnum glUnsignedInt := GlEnum(0x1405)
  static const GlEnum glFloat := GlEnum(0x1406)

// PixelFormat
  static const GlEnum glDepthComponent := GlEnum(0x1902)
  static const GlEnum glAlpha := GlEnum(0x1906)
  static const GlEnum glRgb := GlEnum(0x1907)
  static const GlEnum glRgba := GlEnum(0x1908)
  static const GlEnum glLuminance := GlEnum(0x1909)
  static const GlEnum glLuminanceAlpha := GlEnum(0x190A)

// PixelType
// UNSIGNED_BYTE
  static const GlEnum glUnsignedShort4444 := GlEnum(0x8033)
  static const GlEnum glUnsignedShort5551 := GlEnum(0x8034)
  static const GlEnum glUnsignedShort565 := GlEnum(0x8363)

// Shaders
  static const GlEnum glFragmentShader := GlEnum(0x8B30)
  static const GlEnum glVertexShader := GlEnum(0x8B31)
  static const GlEnum glMaxVertexAttribs := GlEnum(0x8869)
  static const GlEnum glMaxVertexUniformVectors := GlEnum(0x8DFB)
  static const GlEnum glMaxVaryingVectors := GlEnum(0x8DFC)
  static const GlEnum glMaxCombinedTextureImageUnits := GlEnum(0x8B4D)
  static const GlEnum glMaxVertexTextureImageUnits := GlEnum(0x8B4C)
  static const GlEnum glMaxTextureImageUnits := GlEnum(0x8872)
  static const GlEnum glMaxFragmentUniformVectors := GlEnum(0x8DFD)
  static const GlEnum glShaderType := GlEnum(0x8B4F)
  static const GlEnum glDeleteStatus := GlEnum(0x8B80)
  static const GlEnum glLinkStatus := GlEnum(0x8B82)
  static const GlEnum glValidateStatus := GlEnum(0x8B83)
  static const GlEnum glAttachedShaders := GlEnum(0x8B85)
  static const GlEnum glActiveUniforms := GlEnum(0x8B86)
  static const GlEnum glActiveAttributes := GlEnum(0x8B89)
  static const GlEnum glShadingLanguageVersion := GlEnum(0x8B8C)
  static const GlEnum glCurrentProgram := GlEnum(0x8B8D)

// StencilFunction
  static const GlEnum glNever := GlEnum(0x0200)
  static const GlEnum glLess := GlEnum(0x0201)
  static const GlEnum glEqual := GlEnum(0x0202)
  static const GlEnum glLequal := GlEnum(0x0203)
  static const GlEnum glGreater := GlEnum(0x0204)
  static const GlEnum glNotequal := GlEnum(0x0205)
  static const GlEnum glGequal := GlEnum(0x0206)
  static const GlEnum glAlways := GlEnum(0x0207)

// StencilOp
// ZERO
  static const GlEnum glKeep := GlEnum(0x1E00)
  static const GlEnum glReplace := GlEnum(0x1E01)
  static const GlEnum glIncr := GlEnum(0x1E02)
  static const GlEnum glDecr := GlEnum(0x1E03)
  static const GlEnum glInvert := GlEnum(0x150A)
  static const GlEnum glIncrWrap := GlEnum(0x8507)
  static const GlEnum glDecrWrap := GlEnum(0x8508)

// StringName
  static const GlEnum glVendor := GlEnum(0x1F00)
  static const GlEnum glRenderer := GlEnum(0x1F01)
  static const GlEnum glVersion := GlEnum(0x1F02)

// TextureMagFilter
  static const GlEnum glNearest := GlEnum(0x2600)
  static const GlEnum glLinear := GlEnum(0x2601)

// TextureMinFilter
// NEAREST
// LINEAR
  static const GlEnum glNearestMipmapNearest := GlEnum(0x2700)
  static const GlEnum glLinearMipmapNearest := GlEnum(0x2701)
  static const GlEnum glNearestMipmapLinear := GlEnum(0x2702)
  static const GlEnum glLinearMipmapLinear := GlEnum(0x2703)

// TextureParameterName
  static const GlEnum glTextureMagFilter := GlEnum(0x2800)
  static const GlEnum glTextureMinFilter := GlEnum(0x2801)
  static const GlEnum glTextureWrapS := GlEnum(0x2802)
  static const GlEnum glTextureWrapT := GlEnum(0x2803)

// TextureTarget
  static const GlEnum glTexture2d := GlEnum(0x0DE1)
  static const GlEnum glTexture := GlEnum(0x1702)

  static const GlEnum glTextureCubeMap := GlEnum(0x8513)
  static const GlEnum glTextureBindingCubeMap := GlEnum(0x8514)
  static const GlEnum glTextureCubeMapPositiveX := GlEnum(0x8515)
  static const GlEnum glTextureCubeMapNegativeX := GlEnum(0x8516)
  static const GlEnum glTextureCubeMapPositiveY := GlEnum(0x8517)
  static const GlEnum glTextureCubeMapNegativeY := GlEnum(0x8518)
  static const GlEnum glTextureCubeMapPositiveZ := GlEnum(0x8519)
  static const GlEnum glTextureCubeMapNegativeZ := GlEnum(0x851A)
  static const GlEnum glMaxCubeMapTextureSize := GlEnum(0x851C)

// TextureUnit
  static const GlEnum glTexture0 := GlEnum(0x84C0)
  static const GlEnum glTexture1 := GlEnum(0x84C1)
  static const GlEnum glTexture2 := GlEnum(0x84C2)
  static const GlEnum glTexture3 := GlEnum(0x84C3)
  static const GlEnum glTexture4 := GlEnum(0x84C4)
  static const GlEnum glTexture5 := GlEnum(0x84C5)
  static const GlEnum glTexture6 := GlEnum(0x84C6)
  static const GlEnum glTexture7 := GlEnum(0x84C7)
  static const GlEnum glTexture8 := GlEnum(0x84C8)
  static const GlEnum glTexture9 := GlEnum(0x84C9)
  static const GlEnum glTexture10 := GlEnum(0x84CA)
  static const GlEnum glTexture11 := GlEnum(0x84CB)
  static const GlEnum glTexture12 := GlEnum(0x84CC)
  static const GlEnum glTexture13 := GlEnum(0x84CD)
  static const GlEnum glTexture14 := GlEnum(0x84CE)
  static const GlEnum glTexture15 := GlEnum(0x84CF)
  static const GlEnum glTexture16 := GlEnum(0x84D0)
  static const GlEnum glTexture17 := GlEnum(0x84D1)
  static const GlEnum glTexture18 := GlEnum(0x84D2)
  static const GlEnum glTexture19 := GlEnum(0x84D3)
  static const GlEnum glTexture20 := GlEnum(0x84D4)
  static const GlEnum glTexture21 := GlEnum(0x84D5)
  static const GlEnum glTexture22 := GlEnum(0x84D6)
  static const GlEnum glTexture23 := GlEnum(0x84D7)
  static const GlEnum glTexture24 := GlEnum(0x84D8)
  static const GlEnum glTexture25 := GlEnum(0x84D9)
  static const GlEnum glTexture26 := GlEnum(0x84DA)
  static const GlEnum glTexture27 := GlEnum(0x84DB)
  static const GlEnum glTexture28 := GlEnum(0x84DC)
  static const GlEnum glTexture29 := GlEnum(0x84DD)
  static const GlEnum glTexture30 := GlEnum(0x84DE)
  static const GlEnum glTexture31 := GlEnum(0x84DF)
  static const GlEnum glActiveTexture := GlEnum(0x84E0)

// TextureWrapMode
  static const GlEnum glRepeat := GlEnum(0x2901)
  static const GlEnum glClampToEdge := GlEnum(0x812F)
  static const GlEnum glMirroredRepeat := GlEnum(0x8370)

// Uniform Types
  static const GlEnum glFloatVec2 := GlEnum(0x8B50)
  static const GlEnum glFloatVec3 := GlEnum(0x8B51)
  static const GlEnum glFloatVec4 := GlEnum(0x8B52)
  static const GlEnum glIntVec2 := GlEnum(0x8B53)
  static const GlEnum glIntVec3 := GlEnum(0x8B54)
  static const GlEnum glIntVec4 := GlEnum(0x8B55)
  static const GlEnum glBool := GlEnum(0x8B56)
  static const GlEnum glBoolVec2 := GlEnum(0x8B57)
  static const GlEnum glBoolVec3 := GlEnum(0x8B58)
  static const GlEnum glBoolVec4 := GlEnum(0x8B59)
  static const GlEnum glFloatMat2 := GlEnum(0x8B5A)
  static const GlEnum glFloatMat3 := GlEnum(0x8B5B)
  static const GlEnum glFloatMat4 := GlEnum(0x8B5C)
  static const GlEnum glSampler2d := GlEnum(0x8B5E)
  static const GlEnum glSamplerCube := GlEnum(0x8B60)

// Vertex Arrays
  static const GlEnum glVertexAttribArrayEnabled := GlEnum(0x8622)
  static const GlEnum glVertexAttribArraySize := GlEnum(0x8623)
  static const GlEnum glVertexAttribArrayStride := GlEnum(0x8624)
  static const GlEnum glVertexAttribArrayType := GlEnum(0x8625)
  static const GlEnum glVertexAttribArrayNormalized := GlEnum(0x886A)
  static const GlEnum glVertexAttribArrayPointer := GlEnum(0x8645)
  static const GlEnum glVertexAttribArrayBufferBinding := GlEnum(0x889F)

// Shader Source
  static const GlEnum glCompileStatus := GlEnum(0x8B81)

// Shader Precision-Specified Types
  static const GlEnum glLowFloat := GlEnum(0x8DF0)
  static const GlEnum glMediumFloat := GlEnum(0x8DF1)
  static const GlEnum glHighFloat := GlEnum(0x8DF2)
  static const GlEnum glLowInt := GlEnum(0x8DF3)
  static const GlEnum glMediumInt := GlEnum(0x8DF4)
  static const GlEnum glHighInt := GlEnum(0x8DF5)

// Framebuffer Object.
  static const GlEnum glFramebuffer := GlEnum(0x8D40)
  static const GlEnum glRenderbuffer := GlEnum(0x8D41)

  static const GlEnum glRgba4 := GlEnum(0x8056)
  static const GlEnum glRgb5A1 := GlEnum(0x8057)
  static const GlEnum glRgb565 := GlEnum(0x8D62)
  static const GlEnum glDepthComponent16 := GlEnum(0x81A5)
  static const GlEnum glStencilIndex := GlEnum(0x1901)
  static const GlEnum glStencilIndex8 := GlEnum(0x8D48)
  static const GlEnum glDepthStencil := GlEnum(0x84F9)

  static const GlEnum glRenderbufferWidth := GlEnum(0x8D42)
  static const GlEnum glRenderbufferHeight := GlEnum(0x8D43)
  static const GlEnum glRenderbufferInternalFormat := GlEnum(0x8D44)
  static const GlEnum glRenderbufferRedSize := GlEnum(0x8D50)
  static const GlEnum glRenderbufferGreenSize := GlEnum(0x8D51)
  static const GlEnum glRenderbufferBlueSize := GlEnum(0x8D52)
  static const GlEnum glRenderbufferAlphaSize := GlEnum(0x8D53)
  static const GlEnum glRenderbufferDepthSize := GlEnum(0x8D54)
  static const GlEnum glRenderbufferStencilSize := GlEnum(0x8D55)

  static const GlEnum glFramebufferAttachmentObjectType := GlEnum(0x8CD0)
  static const GlEnum glFramebufferAttachmentObjectName := GlEnum(0x8CD1)
  static const GlEnum glFramebufferAttachmentTextureLevel := GlEnum(0x8CD2)
  static const GlEnum glFramebufferAttachmentTextureCubeMapFace := GlEnum(0x8CD3)

  static const GlEnum glColorAttachment0 := GlEnum(0x8CE0)
  static const GlEnum glDepthAttachment := GlEnum(0x8D00)
  static const GlEnum glStencilAttachment := GlEnum(0x8D20)
  static const GlEnum glDepthStencilAttachment := GlEnum(0x821A)

  static const GlEnum glNone := GlEnum(0)

  static const GlEnum glFramebufferComplete := GlEnum(0x8CD5)
  static const GlEnum glFramebufferIncompleteAttachment := GlEnum(0x8CD6)
  static const GlEnum glFramebufferIncompleteMissingAttachment := GlEnum(0x8CD7)
  static const GlEnum glFramebufferIncompleteDimensions := GlEnum(0x8CD9)
  static const GlEnum glFramebufferUnsupported := GlEnum(0x8CDD)

  static const GlEnum glFramebufferBinding := GlEnum(0x8CA6)
  static const GlEnum glRenderbufferBinding := GlEnum(0x8CA7)
  static const GlEnum glMaxRenderbufferSize := GlEnum(0x84E8)

  static const GlEnum glInvalidFramebufferOperation := GlEnum(0x0506)

// WebGL-specific enums
//UNPACK_FLIP_Y_WEBGL  = 0x9240;
//UNPACK_PREMULTIPLY_ALPHA_WEBGL = 0x9241;
//CONTEXT_LOST_WEBGL   = 0x9242;
//UNPACK_COLORSPACE_CONVERSION_WEBGL = 0x9243;
//BROWSER_DEFAULT_WEBGL= 0x9244;

}