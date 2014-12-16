//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-05-29  Jed Young  Creation
//   2011-06-04  Jed Young  Using literal
//

**
** Define all OpenGL constant
**
@Js
const class GlEnum
{
  const Int val

  private new make(Int val){ this.val = val }

  GlEnum mix(GlEnum e){ GlEnum(this.val.or(e.val)) }

//////////////////////////////////////////////////////////////////////////
// Gen
//////////////////////////////////////////////////////////////////////////

  static const GlEnum depthBufferBit := GlEnum(0x00000100)
  static const GlEnum stencilBufferBit := GlEnum(0x00000400)
  static const GlEnum colorBufferBit := GlEnum(0x00004000)

// BeginMode
  static const GlEnum points := GlEnum(0x0000)
  static const GlEnum lines := GlEnum(0x0001)
  static const GlEnum lineLoop := GlEnum(0x0002)
  static const GlEnum lineStrip := GlEnum(0x0003)
  static const GlEnum triangles := GlEnum(0x0004)
  static const GlEnum triangleStrip := GlEnum(0x0005)
  static const GlEnum triangleFan := GlEnum(0x0006)

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
  static const GlEnum zero := GlEnum(0)
  static const GlEnum one := GlEnum(1)
  static const GlEnum srcColor := GlEnum(0x0300)
  static const GlEnum oneMinusSrcColor := GlEnum(0x0301)
  static const GlEnum srcAlpha := GlEnum(0x0302)
  static const GlEnum oneMinusSrcAlpha := GlEnum(0x0303)
  static const GlEnum dstAlpha := GlEnum(0x0304)
  static const GlEnum oneMinusDstAlpha := GlEnum(0x0305)

// BlendingFactorSrc
// ZERO
// ONE
  static const GlEnum dstColor := GlEnum(0x0306)
  static const GlEnum oneMinusDstColor := GlEnum(0x0307)
  static const GlEnum srcAlphaSaturate := GlEnum(0x0308)
// SRC_ALPHA
// ONE_MINUS_SRC_ALPHA
// DST_ALPHA
// ONE_MINUS_DST_ALPHA

// BlendEquationSeparate
  static const GlEnum funcAdd := GlEnum(0x8006)
  static const GlEnum blendEquation := GlEnum(0x8009)
// same as BLEND_EQUATION
  static const GlEnum blendEquationRgb := GlEnum(0x8009)
  static const GlEnum blendEquationAlpha := GlEnum(0x883D)

// BlendSubtract
  static const GlEnum funcSubtract := GlEnum(0x800A)
  static const GlEnum funcReverseSubtract := GlEnum(0x800B)

// Separate Blend Functions
  static const GlEnum blendDstRgb := GlEnum(0x80C8)
  static const GlEnum blendSrcRgb := GlEnum(0x80C9)
  static const GlEnum blendDstAlpha := GlEnum(0x80CA)
  static const GlEnum blendSrcAlpha := GlEnum(0x80CB)
  static const GlEnum constantColor := GlEnum(0x8001)
  static const GlEnum oneMinusConstantColor := GlEnum(0x8002)
  static const GlEnum constantAlpha := GlEnum(0x8003)
  static const GlEnum oneMinusConstantAlpha := GlEnum(0x8004)
  static const GlEnum blendColor := GlEnum(0x8005)

// Buffer Objects
  static const GlEnum arrayBuffer := GlEnum(0x8892)
  static const GlEnum elementArrayBuffer := GlEnum(0x8893)
  static const GlEnum arrayBufferBinding := GlEnum(0x8894)
  static const GlEnum elementArrayBufferBinding := GlEnum(0x8895)

  static const GlEnum streamDraw := GlEnum(0x88E0)
  static const GlEnum staticDraw := GlEnum(0x88E4)
  static const GlEnum dynamicDraw := GlEnum(0x88E8)

  static const GlEnum bufferSize := GlEnum(0x8764)
  static const GlEnum bufferUsage := GlEnum(0x8765)

  static const GlEnum currentVertexAttrib := GlEnum(0x8626)

// CullFaceMode
  static const GlEnum front := GlEnum(0x0404)
  static const GlEnum back := GlEnum(0x0405)
  static const GlEnum frontAndBack := GlEnum(0x0408)

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
  static const GlEnum cullFace := GlEnum(0x0B44)
  static const GlEnum blend := GlEnum(0x0BE2)
  static const GlEnum dither := GlEnum(0x0BD0)
  static const GlEnum stencilTest := GlEnum(0x0B90)
  static const GlEnum depthTest := GlEnum(0x0B71)
  static const GlEnum scissorTest := GlEnum(0x0C11)
  static const GlEnum polygonOffsetFill := GlEnum(0x8037)
  static const GlEnum sampleAlphaToCoverage := GlEnum(0x809E)
  static const GlEnum sampleCoverage := GlEnum(0x80A0)

// ErrorCode
  static const GlEnum noError := GlEnum(0)
  static const GlEnum invalidEnum := GlEnum(0x0500)
  static const GlEnum invalidValue := GlEnum(0x0501)
  static const GlEnum invalidOperation := GlEnum(0x0502)
  static const GlEnum outOfMemory := GlEnum(0x0505)

// FrontFaceDirection
  static const GlEnum cw := GlEnum(0x0900)
  static const GlEnum ccw := GlEnum(0x0901)

// GetPName
  static const GlEnum lineWidth := GlEnum(0x0B21)
  static const GlEnum aliasedPointSizeRange := GlEnum(0x846D)
  static const GlEnum aliasedLineWidthRange := GlEnum(0x846E)
  static const GlEnum cullFaceMode := GlEnum(0x0B45)
  static const GlEnum frontFace := GlEnum(0x0B46)
  static const GlEnum depthRange := GlEnum(0x0B70)
  static const GlEnum depthWritemask := GlEnum(0x0B72)
  static const GlEnum depthClearValue := GlEnum(0x0B73)
  static const GlEnum depthFunc := GlEnum(0x0B74)
  static const GlEnum stencilClearValue := GlEnum(0x0B91)
  static const GlEnum stencilFunc := GlEnum(0x0B92)
  static const GlEnum stencilFail := GlEnum(0x0B94)
  static const GlEnum stencilPassDepthFail := GlEnum(0x0B95)
  static const GlEnum stencilPassDepthPass := GlEnum(0x0B96)
  static const GlEnum stencilRef := GlEnum(0x0B97)
  static const GlEnum stencilValueMask := GlEnum(0x0B93)
  static const GlEnum stencilWritemask := GlEnum(0x0B98)
  static const GlEnum stencilBackFunc := GlEnum(0x8800)
  static const GlEnum stencilBackFail := GlEnum(0x8801)
  static const GlEnum stencilBackPassDepthFail := GlEnum(0x8802)
  static const GlEnum stencilBackPassDepthPass := GlEnum(0x8803)
  static const GlEnum stencilBackRef := GlEnum(0x8CA3)
  static const GlEnum stencilBackValueMask := GlEnum(0x8CA4)
  static const GlEnum stencilBackWritemask := GlEnum(0x8CA5)
  static const GlEnum viewport := GlEnum(0x0BA2)
  static const GlEnum scissorBox := GlEnum(0x0C10)
// SCISSOR_TEST
  static const GlEnum colorClearValue := GlEnum(0x0C22)
  static const GlEnum colorWritemask := GlEnum(0x0C23)
  static const GlEnum unpackAlignment := GlEnum(0x0CF5)
  static const GlEnum packAlignment := GlEnum(0x0D05)
  static const GlEnum maxTextureSize := GlEnum(0x0D33)
  static const GlEnum maxViewportDims := GlEnum(0x0D3A)
  static const GlEnum subpixelBits := GlEnum(0x0D50)
  static const GlEnum redBits := GlEnum(0x0D52)
  static const GlEnum greenBits := GlEnum(0x0D53)
  static const GlEnum blueBits := GlEnum(0x0D54)
  static const GlEnum alphaBits := GlEnum(0x0D55)
  static const GlEnum depthBits := GlEnum(0x0D56)
  static const GlEnum stencilBits := GlEnum(0x0D57)
  static const GlEnum polygonOffsetUnits := GlEnum(0x2A00)
// POLYGON_OFFSET_FILL
  static const GlEnum polygonOffsetFactor := GlEnum(0x8038)
  static const GlEnum textureBinding2d := GlEnum(0x8069)
  static const GlEnum sampleBuffers := GlEnum(0x80A8)
  static const GlEnum samples := GlEnum(0x80A9)
  static const GlEnum sampleCoverageValue := GlEnum(0x80AA)
  static const GlEnum sampleCoverageInvert := GlEnum(0x80AB)

// GetTextureParameter
// TEXTURE_MAG_FILTER
// TEXTURE_MIN_FILTER
// TEXTURE_WRAP_S
// TEXTURE_WRAP_T

  static const GlEnum numCompressedTextureFormats := GlEnum(0x86A2)
  static const GlEnum compressedTextureFormats := GlEnum(0x86A3)

// HintMode
  static const GlEnum dontCare := GlEnum(0x1100)
  static const GlEnum fastest := GlEnum(0x1101)
  static const GlEnum nicest := GlEnum(0x1102)

// HintTarget
  static const GlEnum generateMipmapHint := GlEnum(0x8192)

// DataType
  static const GlEnum byte := GlEnum(0x1400)
  static const GlEnum unsignedByte := GlEnum(0x1401)
  static const GlEnum short := GlEnum(0x1402)
  static const GlEnum unsignedShort := GlEnum(0x1403)
  static const GlEnum int := GlEnum(0x1404)
  static const GlEnum unsignedInt := GlEnum(0x1405)
  static const GlEnum float := GlEnum(0x1406)

// PixelFormat
  static const GlEnum depthComponent := GlEnum(0x1902)
  static const GlEnum alpha := GlEnum(0x1906)
  static const GlEnum rgb := GlEnum(0x1907)
  static const GlEnum rgba := GlEnum(0x1908)
  static const GlEnum luminance := GlEnum(0x1909)
  static const GlEnum luminanceAlpha := GlEnum(0x190A)

// PixelType
// UNSIGNED_BYTE
  static const GlEnum unsignedShort4444 := GlEnum(0x8033)
  static const GlEnum unsignedShort5551 := GlEnum(0x8034)
  static const GlEnum unsignedShort565 := GlEnum(0x8363)

// Shaders
  static const GlEnum fragmentShader := GlEnum(0x8B30)
  static const GlEnum vertexShader := GlEnum(0x8B31)
  static const GlEnum maxVertexAttribs := GlEnum(0x8869)
  static const GlEnum maxVertexUniformVectors := GlEnum(0x8DFB)
  static const GlEnum maxVaryingVectors := GlEnum(0x8DFC)
  static const GlEnum maxCombinedTextureImageUnits := GlEnum(0x8B4D)
  static const GlEnum maxVertexTextureImageUnits := GlEnum(0x8B4C)
  static const GlEnum maxTextureImageUnits := GlEnum(0x8872)
  static const GlEnum maxFragmentUniformVectors := GlEnum(0x8DFD)
  static const GlEnum shaderType := GlEnum(0x8B4F)
  static const GlEnum deleteStatus := GlEnum(0x8B80)
  static const GlEnum linkStatus := GlEnum(0x8B82)
  static const GlEnum validateStatus := GlEnum(0x8B83)
  static const GlEnum attachedShaders := GlEnum(0x8B85)
  static const GlEnum activeUniforms := GlEnum(0x8B86)
  static const GlEnum activeAttributes := GlEnum(0x8B89)
  static const GlEnum shadingLanguageVersion := GlEnum(0x8B8C)
  static const GlEnum currentProgram := GlEnum(0x8B8D)

// StencilFunction
  static const GlEnum never := GlEnum(0x0200)
  static const GlEnum less := GlEnum(0x0201)
  static const GlEnum equal := GlEnum(0x0202)
  static const GlEnum lequal := GlEnum(0x0203)
  static const GlEnum greater := GlEnum(0x0204)
  static const GlEnum notequal := GlEnum(0x0205)
  static const GlEnum gequal := GlEnum(0x0206)
  static const GlEnum always := GlEnum(0x0207)

// StencilOp
// ZERO
  static const GlEnum keep := GlEnum(0x1E00)
  static const GlEnum replace := GlEnum(0x1E01)
  static const GlEnum incr := GlEnum(0x1E02)
  static const GlEnum decr := GlEnum(0x1E03)
  static const GlEnum invert := GlEnum(0x150A)
  static const GlEnum incrWrap := GlEnum(0x8507)
  static const GlEnum decrWrap := GlEnum(0x8508)

// StringName
  static const GlEnum vendor := GlEnum(0x1F00)
  static const GlEnum renderer := GlEnum(0x1F01)
  static const GlEnum version := GlEnum(0x1F02)

// TextureMagFilter
  static const GlEnum nearest := GlEnum(0x2600)
  static const GlEnum linear := GlEnum(0x2601)

// TextureMinFilter
// NEAREST
// LINEAR
  static const GlEnum nearestMipmapNearest := GlEnum(0x2700)
  static const GlEnum linearMipmapNearest := GlEnum(0x2701)
  static const GlEnum nearestMipmapLinear := GlEnum(0x2702)
  static const GlEnum linearMipmapLinear := GlEnum(0x2703)

// TextureParameterName
  static const GlEnum textureMagFilter := GlEnum(0x2800)
  static const GlEnum textureMinFilter := GlEnum(0x2801)
  static const GlEnum textureWrapS := GlEnum(0x2802)
  static const GlEnum textureWrapT := GlEnum(0x2803)

// TextureTarget
  static const GlEnum texture2d := GlEnum(0x0DE1)
  static const GlEnum texture := GlEnum(0x1702)

  static const GlEnum textureCubeMap := GlEnum(0x8513)
  static const GlEnum textureBindingCubeMap := GlEnum(0x8514)
  static const GlEnum textureCubeMapPositiveX := GlEnum(0x8515)
  static const GlEnum textureCubeMapNegativeX := GlEnum(0x8516)
  static const GlEnum textureCubeMapPositiveY := GlEnum(0x8517)
  static const GlEnum textureCubeMapNegativeY := GlEnum(0x8518)
  static const GlEnum textureCubeMapPositiveZ := GlEnum(0x8519)
  static const GlEnum textureCubeMapNegativeZ := GlEnum(0x851A)
  static const GlEnum maxCubeMapTextureSize := GlEnum(0x851C)

// TextureUnit
  static const GlEnum texture0 := GlEnum(0x84C0)
  static const GlEnum texture1 := GlEnum(0x84C1)
  static const GlEnum texture2 := GlEnum(0x84C2)
  static const GlEnum texture3 := GlEnum(0x84C3)
  static const GlEnum texture4 := GlEnum(0x84C4)
  static const GlEnum texture5 := GlEnum(0x84C5)
  static const GlEnum texture6 := GlEnum(0x84C6)
  static const GlEnum texture7 := GlEnum(0x84C7)
  static const GlEnum texture8 := GlEnum(0x84C8)
  static const GlEnum texture9 := GlEnum(0x84C9)
  static const GlEnum texture10 := GlEnum(0x84CA)
  static const GlEnum texture11 := GlEnum(0x84CB)
  static const GlEnum texture12 := GlEnum(0x84CC)
  static const GlEnum texture13 := GlEnum(0x84CD)
  static const GlEnum texture14 := GlEnum(0x84CE)
  static const GlEnum texture15 := GlEnum(0x84CF)
  static const GlEnum texture16 := GlEnum(0x84D0)
  static const GlEnum texture17 := GlEnum(0x84D1)
  static const GlEnum texture18 := GlEnum(0x84D2)
  static const GlEnum texture19 := GlEnum(0x84D3)
  static const GlEnum texture20 := GlEnum(0x84D4)
  static const GlEnum texture21 := GlEnum(0x84D5)
  static const GlEnum texture22 := GlEnum(0x84D6)
  static const GlEnum texture23 := GlEnum(0x84D7)
  static const GlEnum texture24 := GlEnum(0x84D8)
  static const GlEnum texture25 := GlEnum(0x84D9)
  static const GlEnum texture26 := GlEnum(0x84DA)
  static const GlEnum texture27 := GlEnum(0x84DB)
  static const GlEnum texture28 := GlEnum(0x84DC)
  static const GlEnum texture29 := GlEnum(0x84DD)
  static const GlEnum texture30 := GlEnum(0x84DE)
  static const GlEnum texture31 := GlEnum(0x84DF)
  static const GlEnum activeTexture := GlEnum(0x84E0)

// TextureWrapMode
  static const GlEnum repeat := GlEnum(0x2901)
  static const GlEnum clampToEdge := GlEnum(0x812F)
  static const GlEnum mirroredRepeat := GlEnum(0x8370)

// Uniform Types
  static const GlEnum floatVec2 := GlEnum(0x8B50)
  static const GlEnum floatVec3 := GlEnum(0x8B51)
  static const GlEnum floatVec4 := GlEnum(0x8B52)
  static const GlEnum intVec2 := GlEnum(0x8B53)
  static const GlEnum intVec3 := GlEnum(0x8B54)
  static const GlEnum intVec4 := GlEnum(0x8B55)
  static const GlEnum bool := GlEnum(0x8B56)
  static const GlEnum boolVec2 := GlEnum(0x8B57)
  static const GlEnum boolVec3 := GlEnum(0x8B58)
  static const GlEnum boolVec4 := GlEnum(0x8B59)
  static const GlEnum floatMat2 := GlEnum(0x8B5A)
  static const GlEnum floatMat3 := GlEnum(0x8B5B)
  static const GlEnum floatMat4 := GlEnum(0x8B5C)
  static const GlEnum sampler2d := GlEnum(0x8B5E)
  static const GlEnum samplerCube := GlEnum(0x8B60)

// Vertex Arrays
  static const GlEnum vertexAttribArrayEnabled := GlEnum(0x8622)
  static const GlEnum vertexAttribArraySize := GlEnum(0x8623)
  static const GlEnum vertexAttribArrayStride := GlEnum(0x8624)
  static const GlEnum vertexAttribArrayType := GlEnum(0x8625)
  static const GlEnum vertexAttribArrayNormalized := GlEnum(0x886A)
  static const GlEnum vertexAttribArrayPointer := GlEnum(0x8645)
  static const GlEnum vertexAttribArrayBufferBinding := GlEnum(0x889F)

// Shader Source
  static const GlEnum compileStatus := GlEnum(0x8B81)

// Shader Precision-Specified Types
  static const GlEnum lowFloat := GlEnum(0x8DF0)
  static const GlEnum mediumFloat := GlEnum(0x8DF1)
  static const GlEnum highFloat := GlEnum(0x8DF2)
  static const GlEnum lowInt := GlEnum(0x8DF3)
  static const GlEnum mediumInt := GlEnum(0x8DF4)
  static const GlEnum highInt := GlEnum(0x8DF5)

// Framebuffer Object.
  static const GlEnum framebuffer := GlEnum(0x8D40)
  static const GlEnum renderbuffer := GlEnum(0x8D41)

  static const GlEnum rgba4 := GlEnum(0x8056)
  static const GlEnum rgb5A1 := GlEnum(0x8057)
  static const GlEnum rgb565 := GlEnum(0x8D62)
  static const GlEnum depthComponent16 := GlEnum(0x81A5)
  static const GlEnum stencilIndex := GlEnum(0x1901)
  static const GlEnum stencilIndex8 := GlEnum(0x8D48)
  static const GlEnum depthStencil := GlEnum(0x84F9)

  static const GlEnum renderbufferWidth := GlEnum(0x8D42)
  static const GlEnum renderbufferHeight := GlEnum(0x8D43)
  static const GlEnum renderbufferInternalFormat := GlEnum(0x8D44)
  static const GlEnum renderbufferRedSize := GlEnum(0x8D50)
  static const GlEnum renderbufferGreenSize := GlEnum(0x8D51)
  static const GlEnum renderbufferBlueSize := GlEnum(0x8D52)
  static const GlEnum renderbufferAlphaSize := GlEnum(0x8D53)
  static const GlEnum renderbufferDepthSize := GlEnum(0x8D54)
  static const GlEnum renderbufferStencilSize := GlEnum(0x8D55)

  static const GlEnum framebufferAttachmentObjectType := GlEnum(0x8CD0)
  static const GlEnum framebufferAttachmentObjectName := GlEnum(0x8CD1)
  static const GlEnum framebufferAttachmentTextureLevel := GlEnum(0x8CD2)
  static const GlEnum framebufferAttachmentTextureCubeMapFace := GlEnum(0x8CD3)

  static const GlEnum colorAttachment0 := GlEnum(0x8CE0)
  static const GlEnum depthAttachment := GlEnum(0x8D00)
  static const GlEnum stencilAttachment := GlEnum(0x8D20)
  static const GlEnum depthStencilAttachment := GlEnum(0x821A)

  static const GlEnum none := GlEnum(0)

  static const GlEnum framebufferComplete := GlEnum(0x8CD5)
  static const GlEnum framebufferIncompleteAttachment := GlEnum(0x8CD6)
  static const GlEnum framebufferIncompleteMissingAttachment := GlEnum(0x8CD7)
  static const GlEnum framebufferIncompleteDimensions := GlEnum(0x8CD9)
  static const GlEnum framebufferUnsupported := GlEnum(0x8CDD)

  static const GlEnum framebufferBinding := GlEnum(0x8CA6)
  static const GlEnum renderbufferBinding := GlEnum(0x8CA7)
  static const GlEnum maxRenderbufferSize := GlEnum(0x84E8)

  static const GlEnum invalidFramebufferOperation := GlEnum(0x0506)

// WebGL-specific enums
  static const GlEnum unpackFlipYWebgl := GlEnum(0x9240)
  static const GlEnum unpackPremultiplyAlphaWebgl := GlEnum(0x9241)
  static const GlEnum contextLostWebgl := GlEnum(0x9242)
  static const GlEnum unpackColorspaceConversionWebgl := GlEnum(0x9243)
  static const GlEnum browserDefaultWebgl := GlEnum(0x9244)
}