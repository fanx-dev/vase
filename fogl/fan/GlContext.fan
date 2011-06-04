//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-5-29  Jed Young  Creation
//


class GlContext
{
  private GlEnumFactory enums := GlEnumFactory(this)

//////////////////////////////////////////////////////////////////////////
// Gen
//////////////////////////////////////////////////////////////////////////

  const GlEnum glDepthBufferBit := enums.glDepthBufferBit
  const GlEnum glStencilBufferBit := enums.glStencilBufferBit
  const GlEnum glColorBufferBit := enums.glColorBufferBit

// BeginMode
  const GlEnum glPoints := enums.glPoints
  const GlEnum glLines := enums.glLines
  const GlEnum glLineLoop := enums.glLineLoop
  const GlEnum glLineStrip := enums.glLineStrip
  const GlEnum glTriangles := enums.glTriangles
  const GlEnum glTriangleStrip := enums.glTriangleStrip
  const GlEnum glTriangleFan := enums.glTriangleFan

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
  const GlEnum glZero := enums.glZero
  const GlEnum glOne := enums.glOne
  const GlEnum glSrcColor := enums.glSrcColor
  const GlEnum glOneMinusSrcColor := enums.glOneMinusSrcColor
  const GlEnum glSrcAlpha := enums.glSrcAlpha
  const GlEnum glOneMinusSrcAlpha := enums.glOneMinusSrcAlpha
  const GlEnum glDstAlpha := enums.glDstAlpha
  const GlEnum glOneMinusDstAlpha := enums.glOneMinusDstAlpha

// BlendingFactorSrc
// ZERO
// ONE
  const GlEnum glDstColor := enums.glDstColor
  const GlEnum glOneMinusDstColor := enums.glOneMinusDstColor
  const GlEnum glSrcAlphaSaturate := enums.glSrcAlphaSaturate
// SRC_ALPHA
// ONE_MINUS_SRC_ALPHA
// DST_ALPHA
// ONE_MINUS_DST_ALPHA

// BlendEquationSeparate
  const GlEnum glFuncAdd := enums.glFuncAdd
  const GlEnum glBlendEquation := enums.glBlendEquation
  const GlEnum glBlendEquationRgb := enums.glBlendEquationRgb
  const GlEnum glBlendEquationAlpha := enums.glBlendEquationAlpha

// BlendSubtract
  const GlEnum glFuncSubtract := enums.glFuncSubtract
  const GlEnum glFuncReverseSubtract := enums.glFuncReverseSubtract

// Separate Blend Functions
  const GlEnum glBlendDstRgb := enums.glBlendDstRgb
  const GlEnum glBlendSrcRgb := enums.glBlendSrcRgb
  const GlEnum glBlendDstAlpha := enums.glBlendDstAlpha
  const GlEnum glBlendSrcAlpha := enums.glBlendSrcAlpha
  const GlEnum glConstantColor := enums.glConstantColor
  const GlEnum glOneMinusConstantColor := enums.glOneMinusConstantColor
  const GlEnum glConstantAlpha := enums.glConstantAlpha
  const GlEnum glOneMinusConstantAlpha := enums.glOneMinusConstantAlpha
  const GlEnum glBlendColor := enums.glBlendColor

// Buffer Objects
  const GlEnum glArrayBuffer := enums.glArrayBuffer
  const GlEnum glElementArrayBuffer := enums.glElementArrayBuffer
  const GlEnum glArrayBufferBinding := enums.glArrayBufferBinding
  const GlEnum glElementArrayBufferBinding := enums.glElementArrayBufferBinding

  const GlEnum glStreamDraw := enums.glStreamDraw
  const GlEnum glStaticDraw := enums.glStaticDraw
  const GlEnum glDynamicDraw := enums.glDynamicDraw

  const GlEnum glBufferSize := enums.glBufferSize
  const GlEnum glBufferUsage := enums.glBufferUsage

  const GlEnum glCurrentVertexAttrib := enums.glCurrentVertexAttrib

// CullFaceMode
  const GlEnum glFront := enums.glFront
  const GlEnum glBack := enums.glBack
  const GlEnum glFrontAndBack := enums.glFrontAndBack

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
  const GlEnum glCullFace := enums.glCullFace
  const GlEnum glBlend := enums.glBlend
  const GlEnum glDither := enums.glDither
  const GlEnum glStencilTest := enums.glStencilTest
  const GlEnum glDepthTest := enums.glDepthTest
  const GlEnum glScissorTest := enums.glScissorTest
  const GlEnum glPolygonOffsetFill := enums.glPolygonOffsetFill
  const GlEnum glSampleAlphaToCoverage := enums.glSampleAlphaToCoverage
  const GlEnum glSampleCoverage := enums.glSampleCoverage

// ErrorCode
  const GlEnum glNoError := enums.glNoError
  const GlEnum glInvalidEnum := enums.glInvalidEnum
  const GlEnum glInvalidValue := enums.glInvalidValue
  const GlEnum glInvalidOperation := enums.glInvalidOperation
  const GlEnum glOutOfMemory := enums.glOutOfMemory

// FrontFaceDirection
  const GlEnum glCw := enums.glCw
  const GlEnum glCcw := enums.glCcw

// GetPName
  const GlEnum glLineWidth := enums.glLineWidth
  const GlEnum glAliasedPointSizeRange := enums.glAliasedPointSizeRange
  const GlEnum glAliasedLineWidthRange := enums.glAliasedLineWidthRange
  const GlEnum glCullFaceMode := enums.glCullFaceMode
  const GlEnum glFrontFace := enums.glFrontFace
  const GlEnum glDepthRange := enums.glDepthRange
  const GlEnum glDepthWritemask := enums.glDepthWritemask
  const GlEnum glDepthClearValue := enums.glDepthClearValue
  const GlEnum glDepthFunc := enums.glDepthFunc
  const GlEnum glStencilClearValue := enums.glStencilClearValue
  const GlEnum glStencilFunc := enums.glStencilFunc
  const GlEnum glStencilFail := enums.glStencilFail
  const GlEnum glStencilPassDepthFail := enums.glStencilPassDepthFail
  const GlEnum glStencilPassDepthPass := enums.glStencilPassDepthPass
  const GlEnum glStencilRef := enums.glStencilRef
  const GlEnum glStencilValueMask := enums.glStencilValueMask
  const GlEnum glStencilWritemask := enums.glStencilWritemask
  const GlEnum glStencilBackFunc := enums.glStencilBackFunc
  const GlEnum glStencilBackFail := enums.glStencilBackFail
  const GlEnum glStencilBackPassDepthFail := enums.glStencilBackPassDepthFail
  const GlEnum glStencilBackPassDepthPass := enums.glStencilBackPassDepthPass
  const GlEnum glStencilBackRef := enums.glStencilBackRef
  const GlEnum glStencilBackValueMask := enums.glStencilBackValueMask
  const GlEnum glStencilBackWritemask := enums.glStencilBackWritemask
  const GlEnum glViewport := enums.glViewport
  const GlEnum glScissorBox := enums.glScissorBox
// SCISSOR_TEST
  const GlEnum glColorClearValue := enums.glColorClearValue
  const GlEnum glColorWritemask := enums.glColorWritemask
  const GlEnum glUnpackAlignment := enums.glUnpackAlignment
  const GlEnum glPackAlignment := enums.glPackAlignment
  const GlEnum glMaxTextureSize := enums.glMaxTextureSize
  const GlEnum glMaxViewportDims := enums.glMaxViewportDims
  const GlEnum glSubpixelBits := enums.glSubpixelBits
  const GlEnum glRedBits := enums.glRedBits
  const GlEnum glGreenBits := enums.glGreenBits
  const GlEnum glBlueBits := enums.glBlueBits
  const GlEnum glAlphaBits := enums.glAlphaBits
  const GlEnum glDepthBits := enums.glDepthBits
  const GlEnum glStencilBits := enums.glStencilBits
  const GlEnum glPolygonOffsetUnits := enums.glPolygonOffsetUnits
// POLYGON_OFFSET_FILL
  const GlEnum glPolygonOffsetFactor := enums.glPolygonOffsetFactor
  const GlEnum glTextureBinding2d := enums.glTextureBinding2d
  const GlEnum glSampleBuffers := enums.glSampleBuffers
  const GlEnum glSamples := enums.glSamples
  const GlEnum glSampleCoverageValue := enums.glSampleCoverageValue
  const GlEnum glSampleCoverageInvert := enums.glSampleCoverageInvert

// GetTextureParameter
// TEXTURE_MAG_FILTER
// TEXTURE_MIN_FILTER
// TEXTURE_WRAP_S
// TEXTURE_WRAP_T

  const GlEnum glNumCompressedTextureFormats := enums.glNumCompressedTextureFormats
  const GlEnum glCompressedTextureFormats := enums.glCompressedTextureFormats

// HintMode
  const GlEnum glDontCare := enums.glDontCare
  const GlEnum glFastest := enums.glFastest
  const GlEnum glNicest := enums.glNicest

// HintTarget
  const GlEnum glGenerateMipmapHint := enums.glGenerateMipmapHint

// DataType
  const GlEnum glByte := enums.glByte
  const GlEnum glUnsignedByte := enums.glUnsignedByte
  const GlEnum glShort := enums.glShort
  const GlEnum glUnsignedShort := enums.glUnsignedShort
  const GlEnum glInt := enums.glInt
  const GlEnum glUnsignedInt := enums.glUnsignedInt
  const GlEnum glFloat := enums.glFloat

// PixelFormat
  const GlEnum glDepthComponent := enums.glDepthComponent
  const GlEnum glAlpha := enums.glAlpha
  const GlEnum glRgb := enums.glRgb
  const GlEnum glRgba := enums.glRgba
  const GlEnum glLuminance := enums.glLuminance
  const GlEnum glLuminanceAlpha := enums.glLuminanceAlpha

// PixelType
// UNSIGNED_BYTE
  const GlEnum glUnsignedShort4444 := enums.glUnsignedShort4444
  const GlEnum glUnsignedShort5551 := enums.glUnsignedShort5551
  const GlEnum glUnsignedShort565 := enums.glUnsignedShort565

// Shaders
  const GlEnum glFragmentShader := enums.glFragmentShader
  const GlEnum glVertexShader := enums.glVertexShader
  const GlEnum glMaxVertexAttribs := enums.glMaxVertexAttribs
  const GlEnum glMaxVertexUniformVectors := enums.glMaxVertexUniformVectors
  const GlEnum glMaxVaryingVectors := enums.glMaxVaryingVectors
  const GlEnum glMaxCombinedTextureImageUnits := enums.glMaxCombinedTextureImageUnits
  const GlEnum glMaxVertexTextureImageUnits := enums.glMaxVertexTextureImageUnits
  const GlEnum glMaxTextureImageUnits := enums.glMaxTextureImageUnits
  const GlEnum glMaxFragmentUniformVectors := enums.glMaxFragmentUniformVectors
  const GlEnum glShaderType := enums.glShaderType
  const GlEnum glDeleteStatus := enums.glDeleteStatus
  const GlEnum glLinkStatus := enums.glLinkStatus
  const GlEnum glValidateStatus := enums.glValidateStatus
  const GlEnum glAttachedShaders := enums.glAttachedShaders
  const GlEnum glActiveUniforms := enums.glActiveUniforms
  const GlEnum glActiveAttributes := enums.glActiveAttributes
  const GlEnum glShadingLanguageVersion := enums.glShadingLanguageVersion
  const GlEnum glCurrentProgram := enums.glCurrentProgram

// StencilFunction
  const GlEnum glNever := enums.glNever
  const GlEnum glLess := enums.glLess
  const GlEnum glEqual := enums.glEqual
  const GlEnum glLequal := enums.glLequal
  const GlEnum glGreater := enums.glGreater
  const GlEnum glNotequal := enums.glNotequal
  const GlEnum glGequal := enums.glGequal
  const GlEnum glAlways := enums.glAlways

// StencilOp
// ZERO
  const GlEnum glKeep := enums.glKeep
  const GlEnum glReplace := enums.glReplace
  const GlEnum glIncr := enums.glIncr
  const GlEnum glDecr := enums.glDecr
  const GlEnum glInvert := enums.glInvert
  const GlEnum glIncrWrap := enums.glIncrWrap
  const GlEnum glDecrWrap := enums.glDecrWrap

// StringName
  const GlEnum glVendor := enums.glVendor
  const GlEnum glRenderer := enums.glRenderer
  const GlEnum glVersion := enums.glVersion

// TextureMagFilter
  const GlEnum glNearest := enums.glNearest
  const GlEnum glLinear := enums.glLinear

// TextureMinFilter
// NEAREST
// LINEAR
  const GlEnum glNearestMipmapNearest := enums.glNearestMipmapNearest
  const GlEnum glLinearMipmapNearest := enums.glLinearMipmapNearest
  const GlEnum glNearestMipmapLinear := enums.glNearestMipmapLinear
  const GlEnum glLinearMipmapLinear := enums.glLinearMipmapLinear

// TextureParameterName
  const GlEnum glTextureMagFilter := enums.glTextureMagFilter
  const GlEnum glTextureMinFilter := enums.glTextureMinFilter
  const GlEnum glTextureWrapS := enums.glTextureWrapS
  const GlEnum glTextureWrapT := enums.glTextureWrapT

// TextureTarget
  const GlEnum glTexture2d := enums.glTexture2d
  const GlEnum glTexture := enums.glTexture

  const GlEnum glTextureCubeMap := enums.glTextureCubeMap
  const GlEnum glTextureBindingCubeMap := enums.glTextureBindingCubeMap
  const GlEnum glTextureCubeMapPositiveX := enums.glTextureCubeMapPositiveX
  const GlEnum glTextureCubeMapNegativeX := enums.glTextureCubeMapNegativeX
  const GlEnum glTextureCubeMapPositiveY := enums.glTextureCubeMapPositiveY
  const GlEnum glTextureCubeMapNegativeY := enums.glTextureCubeMapNegativeY
  const GlEnum glTextureCubeMapPositiveZ := enums.glTextureCubeMapPositiveZ
  const GlEnum glTextureCubeMapNegativeZ := enums.glTextureCubeMapNegativeZ
  const GlEnum glMaxCubeMapTextureSize := enums.glMaxCubeMapTextureSize

// TextureUnit
  const GlEnum glTexture0 := enums.glTexture0
  const GlEnum glTexture1 := enums.glTexture1
  const GlEnum glTexture2 := enums.glTexture2
  const GlEnum glTexture3 := enums.glTexture3
  const GlEnum glTexture4 := enums.glTexture4
  const GlEnum glTexture5 := enums.glTexture5
  const GlEnum glTexture6 := enums.glTexture6
  const GlEnum glTexture7 := enums.glTexture7
  const GlEnum glTexture8 := enums.glTexture8
  const GlEnum glTexture9 := enums.glTexture9
  const GlEnum glTexture10 := enums.glTexture10
  const GlEnum glTexture11 := enums.glTexture11
  const GlEnum glTexture12 := enums.glTexture12
  const GlEnum glTexture13 := enums.glTexture13
  const GlEnum glTexture14 := enums.glTexture14
  const GlEnum glTexture15 := enums.glTexture15
  const GlEnum glTexture16 := enums.glTexture16
  const GlEnum glTexture17 := enums.glTexture17
  const GlEnum glTexture18 := enums.glTexture18
  const GlEnum glTexture19 := enums.glTexture19
  const GlEnum glTexture20 := enums.glTexture20
  const GlEnum glTexture21 := enums.glTexture21
  const GlEnum glTexture22 := enums.glTexture22
  const GlEnum glTexture23 := enums.glTexture23
  const GlEnum glTexture24 := enums.glTexture24
  const GlEnum glTexture25 := enums.glTexture25
  const GlEnum glTexture26 := enums.glTexture26
  const GlEnum glTexture27 := enums.glTexture27
  const GlEnum glTexture28 := enums.glTexture28
  const GlEnum glTexture29 := enums.glTexture29
  const GlEnum glTexture30 := enums.glTexture30
  const GlEnum glTexture31 := enums.glTexture31
  const GlEnum glActiveTexture := enums.glActiveTexture

// TextureWrapMode
  const GlEnum glRepeat := enums.glRepeat
  const GlEnum glClampToEdge := enums.glClampToEdge
  const GlEnum glMirroredRepeat := enums.glMirroredRepeat

// Uniform Types
  const GlEnum glFloatVec2 := enums.glFloatVec2
  const GlEnum glFloatVec3 := enums.glFloatVec3
  const GlEnum glFloatVec4 := enums.glFloatVec4
  const GlEnum glIntVec2 := enums.glIntVec2
  const GlEnum glIntVec3 := enums.glIntVec3
  const GlEnum glIntVec4 := enums.glIntVec4
  const GlEnum glBool := enums.glBool
  const GlEnum glBoolVec2 := enums.glBoolVec2
  const GlEnum glBoolVec3 := enums.glBoolVec3
  const GlEnum glBoolVec4 := enums.glBoolVec4
  const GlEnum glFloatMat2 := enums.glFloatMat2
  const GlEnum glFloatMat3 := enums.glFloatMat3
  const GlEnum glFloatMat4 := enums.glFloatMat4
  const GlEnum glSampler2d := enums.glSampler2d
  const GlEnum glSamplerCube := enums.glSamplerCube

// Vertex Arrays
  const GlEnum glVertexAttribArrayEnabled := enums.glVertexAttribArrayEnabled
  const GlEnum glVertexAttribArraySize := enums.glVertexAttribArraySize
  const GlEnum glVertexAttribArrayStride := enums.glVertexAttribArrayStride
  const GlEnum glVertexAttribArrayType := enums.glVertexAttribArrayType
  const GlEnum glVertexAttribArrayNormalized := enums.glVertexAttribArrayNormalized
  const GlEnum glVertexAttribArrayPointer := enums.glVertexAttribArrayPointer
  const GlEnum glVertexAttribArrayBufferBinding := enums.glVertexAttribArrayBufferBinding

// Shader Source
  const GlEnum glCompileStatus := enums.glCompileStatus

// Shader Precision-Specified Types
  const GlEnum glLowFloat := enums.glLowFloat
  const GlEnum glMediumFloat := enums.glMediumFloat
  const GlEnum glHighFloat := enums.glHighFloat
  const GlEnum glLowInt := enums.glLowInt
  const GlEnum glMediumInt := enums.glMediumInt
  const GlEnum glHighInt := enums.glHighInt

// Framebuffer Object.
  const GlEnum glFramebuffer := enums.glFramebuffer
  const GlEnum glRenderbuffer := enums.glRenderbuffer

  const GlEnum glRgba4 := enums.glRgba4
  const GlEnum glRgb5A1 := enums.glRgb5A1
  const GlEnum glRgb565 := enums.glRgb565
  const GlEnum glDepthComponent16 := enums.glDepthComponent16
  const GlEnum glStencilIndex := enums.glStencilIndex
  const GlEnum glStencilIndex8 := enums.glStencilIndex8
  const GlEnum glDepthStencil := enums.glDepthStencil

  const GlEnum glRenderbufferWidth := enums.glRenderbufferWidth
  const GlEnum glRenderbufferHeight := enums.glRenderbufferHeight
  const GlEnum glRenderbufferInternalFormat := enums.glRenderbufferInternalFormat
  const GlEnum glRenderbufferRedSize := enums.glRenderbufferRedSize
  const GlEnum glRenderbufferGreenSize := enums.glRenderbufferGreenSize
  const GlEnum glRenderbufferBlueSize := enums.glRenderbufferBlueSize
  const GlEnum glRenderbufferAlphaSize := enums.glRenderbufferAlphaSize
  const GlEnum glRenderbufferDepthSize := enums.glRenderbufferDepthSize
  const GlEnum glRenderbufferStencilSize := enums.glRenderbufferStencilSize

  const GlEnum glFramebufferAttachmentObjectType := enums.glFramebufferAttachmentObjectType
  const GlEnum glFramebufferAttachmentObjectName := enums.glFramebufferAttachmentObjectName
  const GlEnum glFramebufferAttachmentTextureLevel := enums.glFramebufferAttachmentTextureLevel
  const GlEnum glFramebufferAttachmentTextureCubeMapFace := enums.glFramebufferAttachmentTextureCubeMapFace

  const GlEnum glColorAttachment0 := enums.glColorAttachment0
  const GlEnum glDepthAttachment := enums.glDepthAttachment
  const GlEnum glStencilAttachment := enums.glStencilAttachment
  const GlEnum glDepthStencilAttachment := enums.glDepthStencilAttachment

  const GlEnum glNone := enums.glNone

  const GlEnum glFramebufferComplete := enums.glFramebufferComplete
  const GlEnum glFramebufferIncompleteAttachment := enums.glFramebufferIncompleteAttachment
  const GlEnum glFramebufferIncompleteMissingAttachment := enums.glFramebufferIncompleteMissingAttachment
  const GlEnum glFramebufferIncompleteDimensions := enums.glFramebufferIncompleteDimensions
  const GlEnum glFramebufferUnsupported := enums.glFramebufferUnsupported

  const GlEnum glFramebufferBinding := enums.glFramebufferBinding
  const GlEnum glRenderbufferBinding := enums.glRenderbufferBinding
  const GlEnum glMaxRenderbufferSize := enums.glMaxRenderbufferSize

  const GlEnum glInvalidFramebufferOperation := enums.glInvalidFramebufferOperation

/* WebGL-specific enums
  const GlEnum glUnpackFlipYWebgl := enums.glUnpackFlipYWebgl
  const GlEnum glUnpackPremultiplyAlphaWebgl := enums.glUnpackPremultiplyAlphaWebgl
  const GlEnum glContextLostWebgl := enums.glContextLostWebgl
  const GlEnum glUnpackColorspaceConversionWebgl := enums.glUnpackColorspaceConversionWebgl
  const GlEnum glBrowserDefaultWebgl := enums.glBrowserDefaultWebgl
*/
//////////////////////////////////////////////////////////////////////////
// Common
//////////////////////////////////////////////////////////////////////////

  native Void clearColor(Float red, Float green, Float blue, Float alpha)

  native Void enable(GlEnum cap)

  native Void viewport(Int x, Int y, Int width, Int height)

  native Void clear(GlEnum mask)

  native Void vertexAttribPointer(Int indx, Int size, GlEnum type, Bool normalized, Int stride, Int offset)

  native Void drawArrays(GlEnum mode, Int first, Int count)

//////////////////////////////////////////////////////////////////////////
// Buffer
//////////////////////////////////////////////////////////////////////////

  native Buffer createBuffer()
  native Void bindBuffer(GlEnum target, Buffer buffer)
  native Void bufferData(GlEnum target, ArrayBuffer data, GlEnum usage)


//////////////////////////////////////////////////////////////////////////
// Shader
//////////////////////////////////////////////////////////////////////////

  native Shader createShader(GlEnum type)
  native Void shaderSource(Shader shader, Str source)
  native Void compileShader(Shader shader)
  native Int getShaderParameter(Shader shader, GlEnum pname)
  native Str getShaderInfoLog(Shader shader)

  native Program createProgram()
  native Void attachShader(Program program, Shader shader)
  native Void linkProgram(Shader program)
  native Int getProgramParameter(Program program, GlEnum pname)
  native Void validateProgram(Program program);
  native Void useProgram(Program program)

//////////////////////////////////////////////////////////////////////////
// Uniform
//////////////////////////////////////////////////////////////////////////

  native UniformLocation getUniformLocation(Program program, Str name)
  native Void uniformMatrix4fv(UniformLocation location, Bool transpose, ArrayBuffer value)

//////////////////////////////////////////////////////////////////////////
// VertexShader
//////////////////////////////////////////////////////////////////////////

  native Int getAttribLocation(Program program, Str name)
  native Void enableVertexAttribArray(Int index)
}