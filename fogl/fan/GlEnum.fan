//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-5-29  Jed Young  Creation
//

const class GlEnum
{
  internal new make(){}

  native GlEnum mix(GlEnum e)
}

**************************************************************************
** GlEnumFactory
**************************************************************************

**
** Why need this? because the native fields cannot be const, static, or abstract.
**
internal class GlEnumFactory
{
  GlContext gl

  new make(GlContext gl) { this.gl = gl }


//////////////////////////////////////////////////////////////////////////
// Gen
//////////////////////////////////////////////////////////////////////////

  native GlEnum glDepthBufferBit()
  native GlEnum glStencilBufferBit()
  native GlEnum glColorBufferBit()

// BeginMode
  native GlEnum glPoints()
  native GlEnum glLines()
  native GlEnum glLineLoop()
  native GlEnum glLineStrip()
  native GlEnum glTriangles()
  native GlEnum glTriangleStrip()
  native GlEnum glTriangleFan()

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
  native GlEnum glZero()
  native GlEnum glOne()
  native GlEnum glSrcColor()
  native GlEnum glOneMinusSrcColor()
  native GlEnum glSrcAlpha()
  native GlEnum glOneMinusSrcAlpha()
  native GlEnum glDstAlpha()
  native GlEnum glOneMinusDstAlpha()

// BlendingFactorSrc
// ZERO
// ONE
  native GlEnum glDstColor()
  native GlEnum glOneMinusDstColor()
  native GlEnum glSrcAlphaSaturate()
// SRC_ALPHA
// ONE_MINUS_SRC_ALPHA
// DST_ALPHA
// ONE_MINUS_DST_ALPHA

// BlendEquationSeparate
  native GlEnum glFuncAdd()
  native GlEnum glBlendEquation()
  native GlEnum glBlendEquationRgb()
  native GlEnum glBlendEquationAlpha()

// BlendSubtract
  native GlEnum glFuncSubtract()
  native GlEnum glFuncReverseSubtract()

// Separate Blend Functions
  native GlEnum glBlendDstRgb()
  native GlEnum glBlendSrcRgb()
  native GlEnum glBlendDstAlpha()
  native GlEnum glBlendSrcAlpha()
  native GlEnum glConstantColor()
  native GlEnum glOneMinusConstantColor()
  native GlEnum glConstantAlpha()
  native GlEnum glOneMinusConstantAlpha()
  native GlEnum glBlendColor()

// Buffer Objects
  native GlEnum glArrayBuffer()
  native GlEnum glElementArrayBuffer()
  native GlEnum glArrayBufferBinding()
  native GlEnum glElementArrayBufferBinding()

  native GlEnum glStreamDraw()
  native GlEnum glStaticDraw()
  native GlEnum glDynamicDraw()

  native GlEnum glBufferSize()
  native GlEnum glBufferUsage()

  native GlEnum glCurrentVertexAttrib()

// CullFaceMode
  native GlEnum glFront()
  native GlEnum glBack()
  native GlEnum glFrontAndBack()

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
  native GlEnum glCullFace()
  native GlEnum glBlend()
  native GlEnum glDither()
  native GlEnum glStencilTest()
  native GlEnum glDepthTest()
  native GlEnum glScissorTest()
  native GlEnum glPolygonOffsetFill()
  native GlEnum glSampleAlphaToCoverage()
  native GlEnum glSampleCoverage()

// ErrorCode
  native GlEnum glNoError()
  native GlEnum glInvalidEnum()
  native GlEnum glInvalidValue()
  native GlEnum glInvalidOperation()
  native GlEnum glOutOfMemory()

// FrontFaceDirection
  native GlEnum glCw()
  native GlEnum glCcw()

// GetPName
  native GlEnum glLineWidth()
  native GlEnum glAliasedPointSizeRange()
  native GlEnum glAliasedLineWidthRange()
  native GlEnum glCullFaceMode()
  native GlEnum glFrontFace()
  native GlEnum glDepthRange()
  native GlEnum glDepthWritemask()
  native GlEnum glDepthClearValue()
  native GlEnum glDepthFunc()
  native GlEnum glStencilClearValue()
  native GlEnum glStencilFunc()
  native GlEnum glStencilFail()
  native GlEnum glStencilPassDepthFail()
  native GlEnum glStencilPassDepthPass()
  native GlEnum glStencilRef()
  native GlEnum glStencilValueMask()
  native GlEnum glStencilWritemask()
  native GlEnum glStencilBackFunc()
  native GlEnum glStencilBackFail()
  native GlEnum glStencilBackPassDepthFail()
  native GlEnum glStencilBackPassDepthPass()
  native GlEnum glStencilBackRef()
  native GlEnum glStencilBackValueMask()
  native GlEnum glStencilBackWritemask()
  native GlEnum glViewport()
  native GlEnum glScissorBox()
// SCISSOR_TEST
  native GlEnum glColorClearValue()
  native GlEnum glColorWritemask()
  native GlEnum glUnpackAlignment()
  native GlEnum glPackAlignment()
  native GlEnum glMaxTextureSize()
  native GlEnum glMaxViewportDims()
  native GlEnum glSubpixelBits()
  native GlEnum glRedBits()
  native GlEnum glGreenBits()
  native GlEnum glBlueBits()
  native GlEnum glAlphaBits()
  native GlEnum glDepthBits()
  native GlEnum glStencilBits()
  native GlEnum glPolygonOffsetUnits()
// POLYGON_OFFSET_FILL
  native GlEnum glPolygonOffsetFactor()
  native GlEnum glTextureBinding2d()
  native GlEnum glSampleBuffers()
  native GlEnum glSamples()
  native GlEnum glSampleCoverageValue()
  native GlEnum glSampleCoverageInvert()

// GetTextureParameter
// TEXTURE_MAG_FILTER
// TEXTURE_MIN_FILTER
// TEXTURE_WRAP_S
// TEXTURE_WRAP_T

  native GlEnum glNumCompressedTextureFormats()
  native GlEnum glCompressedTextureFormats()

// HintMode
  native GlEnum glDontCare()
  native GlEnum glFastest()
  native GlEnum glNicest()

// HintTarget
  native GlEnum glGenerateMipmapHint()

// DataType
  native GlEnum glByte()
  native GlEnum glUnsignedByte()
  native GlEnum glShort()
  native GlEnum glUnsignedShort()
  native GlEnum glInt()
  native GlEnum glUnsignedInt()
  native GlEnum glFloat()

// PixelFormat
  native GlEnum glDepthComponent()
  native GlEnum glAlpha()
  native GlEnum glRgb()
  native GlEnum glRgba()
  native GlEnum glLuminance()
  native GlEnum glLuminanceAlpha()

// PixelType
// UNSIGNED_BYTE
  native GlEnum glUnsignedShort4444()
  native GlEnum glUnsignedShort5551()
  native GlEnum glUnsignedShort565()

// Shaders
  native GlEnum glFragmentShader()
  native GlEnum glVertexShader()
  native GlEnum glMaxVertexAttribs()
  native GlEnum glMaxVertexUniformVectors()
  native GlEnum glMaxVaryingVectors()
  native GlEnum glMaxCombinedTextureImageUnits()
  native GlEnum glMaxVertexTextureImageUnits()
  native GlEnum glMaxTextureImageUnits()
  native GlEnum glMaxFragmentUniformVectors()
  native GlEnum glShaderType()
  native GlEnum glDeleteStatus()
  native GlEnum glLinkStatus()
  native GlEnum glValidateStatus()
  native GlEnum glAttachedShaders()
  native GlEnum glActiveUniforms()
  native GlEnum glActiveAttributes()
  native GlEnum glShadingLanguageVersion()
  native GlEnum glCurrentProgram()

// StencilFunction
  native GlEnum glNever()
  native GlEnum glLess()
  native GlEnum glEqual()
  native GlEnum glLequal()
  native GlEnum glGreater()
  native GlEnum glNotequal()
  native GlEnum glGequal()
  native GlEnum glAlways()

// StencilOp
// ZERO
  native GlEnum glKeep()
  native GlEnum glReplace()
  native GlEnum glIncr()
  native GlEnum glDecr()
  native GlEnum glInvert()
  native GlEnum glIncrWrap()
  native GlEnum glDecrWrap()

// StringName
  native GlEnum glVendor()
  native GlEnum glRenderer()
  native GlEnum glVersion()

// TextureMagFilter
  native GlEnum glNearest()
  native GlEnum glLinear()

// TextureMinFilter
// NEAREST
// LINEAR
  native GlEnum glNearestMipmapNearest()
  native GlEnum glLinearMipmapNearest()
  native GlEnum glNearestMipmapLinear()
  native GlEnum glLinearMipmapLinear()

// TextureParameterName
  native GlEnum glTextureMagFilter()
  native GlEnum glTextureMinFilter()
  native GlEnum glTextureWrapS()
  native GlEnum glTextureWrapT()

// TextureTarget
  native GlEnum glTexture2d()
  native GlEnum glTexture()

  native GlEnum glTextureCubeMap()
  native GlEnum glTextureBindingCubeMap()
  native GlEnum glTextureCubeMapPositiveX()
  native GlEnum glTextureCubeMapNegativeX()
  native GlEnum glTextureCubeMapPositiveY()
  native GlEnum glTextureCubeMapNegativeY()
  native GlEnum glTextureCubeMapPositiveZ()
  native GlEnum glTextureCubeMapNegativeZ()
  native GlEnum glMaxCubeMapTextureSize()

// TextureUnit
  native GlEnum glTexture0()
  native GlEnum glTexture1()
  native GlEnum glTexture2()
  native GlEnum glTexture3()
  native GlEnum glTexture4()
  native GlEnum glTexture5()
  native GlEnum glTexture6()
  native GlEnum glTexture7()
  native GlEnum glTexture8()
  native GlEnum glTexture9()
  native GlEnum glTexture10()
  native GlEnum glTexture11()
  native GlEnum glTexture12()
  native GlEnum glTexture13()
  native GlEnum glTexture14()
  native GlEnum glTexture15()
  native GlEnum glTexture16()
  native GlEnum glTexture17()
  native GlEnum glTexture18()
  native GlEnum glTexture19()
  native GlEnum glTexture20()
  native GlEnum glTexture21()
  native GlEnum glTexture22()
  native GlEnum glTexture23()
  native GlEnum glTexture24()
  native GlEnum glTexture25()
  native GlEnum glTexture26()
  native GlEnum glTexture27()
  native GlEnum glTexture28()
  native GlEnum glTexture29()
  native GlEnum glTexture30()
  native GlEnum glTexture31()
  native GlEnum glActiveTexture()

// TextureWrapMode
  native GlEnum glRepeat()
  native GlEnum glClampToEdge()
  native GlEnum glMirroredRepeat()

// Uniform Types
  native GlEnum glFloatVec2()
  native GlEnum glFloatVec3()
  native GlEnum glFloatVec4()
  native GlEnum glIntVec2()
  native GlEnum glIntVec3()
  native GlEnum glIntVec4()
  native GlEnum glBool()
  native GlEnum glBoolVec2()
  native GlEnum glBoolVec3()
  native GlEnum glBoolVec4()
  native GlEnum glFloatMat2()
  native GlEnum glFloatMat3()
  native GlEnum glFloatMat4()
  native GlEnum glSampler2d()
  native GlEnum glSamplerCube()

// Vertex Arrays
  native GlEnum glVertexAttribArrayEnabled()
  native GlEnum glVertexAttribArraySize()
  native GlEnum glVertexAttribArrayStride()
  native GlEnum glVertexAttribArrayType()
  native GlEnum glVertexAttribArrayNormalized()
  native GlEnum glVertexAttribArrayPointer()
  native GlEnum glVertexAttribArrayBufferBinding()

// Shader Source
  native GlEnum glCompileStatus()

// Shader Precision-Specified Types
  native GlEnum glLowFloat()
  native GlEnum glMediumFloat()
  native GlEnum glHighFloat()
  native GlEnum glLowInt()
  native GlEnum glMediumInt()
  native GlEnum glHighInt()

// Framebuffer Object.
  native GlEnum glFramebuffer()
  native GlEnum glRenderbuffer()

  native GlEnum glRgba4()
  native GlEnum glRgb5A1()
  native GlEnum glRgb565()
  native GlEnum glDepthComponent16()
  native GlEnum glStencilIndex()
  native GlEnum glStencilIndex8()
  native GlEnum glDepthStencil()

  native GlEnum glRenderbufferWidth()
  native GlEnum glRenderbufferHeight()
  native GlEnum glRenderbufferInternalFormat()
  native GlEnum glRenderbufferRedSize()
  native GlEnum glRenderbufferGreenSize()
  native GlEnum glRenderbufferBlueSize()
  native GlEnum glRenderbufferAlphaSize()
  native GlEnum glRenderbufferDepthSize()
  native GlEnum glRenderbufferStencilSize()

  native GlEnum glFramebufferAttachmentObjectType()
  native GlEnum glFramebufferAttachmentObjectName()
  native GlEnum glFramebufferAttachmentTextureLevel()
  native GlEnum glFramebufferAttachmentTextureCubeMapFace()

  native GlEnum glColorAttachment0()
  native GlEnum glDepthAttachment()
  native GlEnum glStencilAttachment()
  native GlEnum glDepthStencilAttachment()

  native GlEnum glNone()

  native GlEnum glFramebufferComplete()
  native GlEnum glFramebufferIncompleteAttachment()
  native GlEnum glFramebufferIncompleteMissingAttachment()
  native GlEnum glFramebufferIncompleteDimensions()
  native GlEnum glFramebufferUnsupported()

  native GlEnum glFramebufferBinding()
  native GlEnum glRenderbufferBinding()
  native GlEnum glMaxRenderbufferSize()

  native GlEnum glInvalidFramebufferOperation()

/* WebGL-specific enums
  native GlEnum glUnpackFlipYWebgl()
  native GlEnum glUnpackPremultiplyAlphaWebgl()
  native GlEnum glContextLostWebgl()
  native GlEnum glUnpackColorspaceConversionWebgl()
  native GlEnum glBrowserDefaultWebgl()
  */
}