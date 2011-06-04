//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-5-29  Jed Young  Creation
//

//************************************************************************
// GlEnumPeer
//************************************************************************

fan.fogl.GlEnumPeer = fan.sys.Obj.$extend(fan.sys.Obj);
fan.fogl.GlEnumPeer.prototype.$ctor = function(self) {}
fan.fogl.GlEnumPeer.prototype.value = null;

fan.fogl.GlEnumPeer.prototype.getValue = function(){ return this.value; }
fan.fogl.GlEnumPeer.prototype.setValue = function(v){ this.value = v; }

fan.fogl.GlEnumPeer.prototype.mix = function(self, e)
{
  var e2 = GlEnum.make();
  e2.peer.value = this.value | e.peer.value
  return e2;
}

//************************************************************************
// GlEnumFactoryPeer
//************************************************************************

fan.fogl.GlEnumFactoryPeer = fan.sys.Obj.$extend(fan.sys.Obj);
fan.fogl.GlEnumFactoryPeer.prototype.$ctor = function(self) {}

fan.fogl.GlEnumFactoryPeer.makeEnum(i)
{
  var e = GlEnum.make();
  e.peer.setValue(i);
  return e;
}

//////////////////////////////////////////////////////////////////////////
// Gen
//////////////////////////////////////////////////////////////////////////

fan.fogl.GlEnumFactoryPeer.prototype.glDepthBufferBit(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.DEPTH_BUFFER_BIT); }
fan.fogl.GlEnumFactoryPeer.prototype.glStencilBufferBit(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.STENCIL_BUFFER_BIT); }
fan.fogl.GlEnumFactoryPeer.prototype.glColorBufferBit(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.COLOR_BUFFER_BIT); }

// BeginMode
fan.fogl.GlEnumFactoryPeer.prototype.glPoints(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.POINTS); }
fan.fogl.GlEnumFactoryPeer.prototype.glLines(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.LINES); }
fan.fogl.GlEnumFactoryPeer.prototype.glLineLoop(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.LINE_LOOP); }
fan.fogl.GlEnumFactoryPeer.prototype.glLineStrip(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.LINE_STRIP); }
fan.fogl.GlEnumFactoryPeer.prototype.glTriangles(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.TRIANGLES); }
fan.fogl.GlEnumFactoryPeer.prototype.glTriangleStrip(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.TRIANGLE_STRIP); }
fan.fogl.GlEnumFactoryPeer.prototype.glTriangleFan(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.TRIANGLE_FAN); }

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
fan.fogl.GlEnumFactoryPeer.prototype.glZero(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.ZERO); }
fan.fogl.GlEnumFactoryPeer.prototype.glOne(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.ONE); }
fan.fogl.GlEnumFactoryPeer.prototype.glSrcColor(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.SRC_COLOR); }
fan.fogl.GlEnumFactoryPeer.prototype.glOneMinusSrcColor(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.ONE_MINUS_SRC_COLOR); }
fan.fogl.GlEnumFactoryPeer.prototype.glSrcAlpha(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.SRC_ALPHA); }
fan.fogl.GlEnumFactoryPeer.prototype.glOneMinusSrcAlpha(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.ONE_MINUS_SRC_ALPHA); }
fan.fogl.GlEnumFactoryPeer.prototype.glDstAlpha(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.DST_ALPHA); }
fan.fogl.GlEnumFactoryPeer.prototype.glOneMinusDstAlpha(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.ONE_MINUS_DST_ALPHA); }

// BlendingFactorSrc
// ZERO
// ONE
fan.fogl.GlEnumFactoryPeer.prototype.glDstColor(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.DST_COLOR); }
fan.fogl.GlEnumFactoryPeer.prototype.glOneMinusDstColor(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.ONE_MINUS_DST_COLOR); }
fan.fogl.GlEnumFactoryPeer.prototype.glSrcAlphaSaturate(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.SRC_ALPHA_SATURATE); }
// SRC_ALPHA
// ONE_MINUS_SRC_ALPHA
// DST_ALPHA
// ONE_MINUS_DST_ALPHA

// BlendEquationSeparate
fan.fogl.GlEnumFactoryPeer.prototype.glFuncAdd(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.FUNC_ADD); }
fan.fogl.GlEnumFactoryPeer.prototype.glBlendEquation(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.BLEND_EQUATION); }
fan.fogl.GlEnumFactoryPeer.prototype.glBlendEquationRgb(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.BLEND_EQUATION_RGB); }
fan.fogl.GlEnumFactoryPeer.prototype.glBlendEquationAlpha(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.BLEND_EQUATION_ALPHA); }

// BlendSubtract
fan.fogl.GlEnumFactoryPeer.prototype.glFuncSubtract(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.FUNC_SUBTRACT); }
fan.fogl.GlEnumFactoryPeer.prototype.glFuncReverseSubtract(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.FUNC_REVERSE_SUBTRACT); }

// Separate Blend Functions
fan.fogl.GlEnumFactoryPeer.prototype.glBlendDstRgb(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.BLEND_DST_RGB); }
fan.fogl.GlEnumFactoryPeer.prototype.glBlendSrcRgb(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.BLEND_SRC_RGB); }
fan.fogl.GlEnumFactoryPeer.prototype.glBlendDstAlpha(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.BLEND_DST_ALPHA); }
fan.fogl.GlEnumFactoryPeer.prototype.glBlendSrcAlpha(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.BLEND_SRC_ALPHA); }
fan.fogl.GlEnumFactoryPeer.prototype.glConstantColor(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.CONSTANT_COLOR); }
fan.fogl.GlEnumFactoryPeer.prototype.glOneMinusConstantColor(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.ONE_MINUS_CONSTANT_COLOR); }
fan.fogl.GlEnumFactoryPeer.prototype.glConstantAlpha(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.CONSTANT_ALPHA); }
fan.fogl.GlEnumFactoryPeer.prototype.glOneMinusConstantAlpha(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.ONE_MINUS_CONSTANT_ALPHA); }
fan.fogl.GlEnumFactoryPeer.prototype.glBlendColor(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.BLEND_COLOR); }

// Buffer Objects
fan.fogl.GlEnumFactoryPeer.prototype.glArrayBuffer(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.ARRAY_BUFFER); }
fan.fogl.GlEnumFactoryPeer.prototype.glElementArrayBuffer(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.ELEMENT_ARRAY_BUFFER); }
fan.fogl.GlEnumFactoryPeer.prototype.glArrayBufferBinding(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.ARRAY_BUFFER_BINDING); }
fan.fogl.GlEnumFactoryPeer.prototype.glElementArrayBufferBinding(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.ELEMENT_ARRAY_BUFFER_BINDING); }

fan.fogl.GlEnumFactoryPeer.prototype.glStreamDraw(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.STREAM_DRAW); }
fan.fogl.GlEnumFactoryPeer.prototype.glStaticDraw(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.STATIC_DRAW); }
fan.fogl.GlEnumFactoryPeer.prototype.glDynamicDraw(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.DYNAMIC_DRAW); }

fan.fogl.GlEnumFactoryPeer.prototype.glBufferSize(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.BUFFER_SIZE); }
fan.fogl.GlEnumFactoryPeer.prototype.glBufferUsage(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.BUFFER_USAGE); }

fan.fogl.GlEnumFactoryPeer.prototype.glCurrentVertexAttrib(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.CURRENT_VERTEX_ATTRIB); }

// CullFaceMode
fan.fogl.GlEnumFactoryPeer.prototype.glFront(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.FRONT); }
fan.fogl.GlEnumFactoryPeer.prototype.glBack(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.BACK); }
fan.fogl.GlEnumFactoryPeer.prototype.glFrontAndBack(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.FRONT_AND_BACK); }

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
fan.fogl.GlEnumFactoryPeer.prototype.glCullFace(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.CULL_FACE); }
fan.fogl.GlEnumFactoryPeer.prototype.glBlend(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.BLEND); }
fan.fogl.GlEnumFactoryPeer.prototype.glDither(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.DITHER); }
fan.fogl.GlEnumFactoryPeer.prototype.glStencilTest(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.STENCIL_TEST); }
fan.fogl.GlEnumFactoryPeer.prototype.glDepthTest(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.DEPTH_TEST); }
fan.fogl.GlEnumFactoryPeer.prototype.glScissorTest(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.SCISSOR_TEST); }
fan.fogl.GlEnumFactoryPeer.prototype.glPolygonOffsetFill(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.POLYGON_OFFSET_FILL); }
fan.fogl.GlEnumFactoryPeer.prototype.glSampleAlphaToCoverage(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.SAMPLE_ALPHA_TO_COVERAGE); }
fan.fogl.GlEnumFactoryPeer.prototype.glSampleCoverage(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.SAMPLE_COVERAGE); }

// ErrorCode
fan.fogl.GlEnumFactoryPeer.prototype.glNoError(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.NO_ERROR); }
fan.fogl.GlEnumFactoryPeer.prototype.glInvalidEnum(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.INVALID_ENUM); }
fan.fogl.GlEnumFactoryPeer.prototype.glInvalidValue(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.INVALID_VALUE); }
fan.fogl.GlEnumFactoryPeer.prototype.glInvalidOperation(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.INVALID_OPERATION); }
fan.fogl.GlEnumFactoryPeer.prototype.glOutOfMemory(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.OUT_OF_MEMORY); }

// FrontFaceDirection
fan.fogl.GlEnumFactoryPeer.prototype.glCw(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.CW); }
fan.fogl.GlEnumFactoryPeer.prototype.glCcw(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.CCW); }

// GetPName
fan.fogl.GlEnumFactoryPeer.prototype.glLineWidth(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.LINE_WIDTH); }
fan.fogl.GlEnumFactoryPeer.prototype.glAliasedPointSizeRange(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.ALIASED_POINT_SIZE_RANGE); }
fan.fogl.GlEnumFactoryPeer.prototype.glAliasedLineWidthRange(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.ALIASED_LINE_WIDTH_RANGE); }
fan.fogl.GlEnumFactoryPeer.prototype.glCullFaceMode(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.CULL_FACE_MODE); }
fan.fogl.GlEnumFactoryPeer.prototype.glFrontFace(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.FRONT_FACE); }
fan.fogl.GlEnumFactoryPeer.prototype.glDepthRange(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.DEPTH_RANGE); }
fan.fogl.GlEnumFactoryPeer.prototype.glDepthWritemask(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.DEPTH_WRITEMASK); }
fan.fogl.GlEnumFactoryPeer.prototype.glDepthClearValue(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.DEPTH_CLEAR_VALUE); }
fan.fogl.GlEnumFactoryPeer.prototype.glDepthFunc(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.DEPTH_FUNC); }
fan.fogl.GlEnumFactoryPeer.prototype.glStencilClearValue(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.STENCIL_CLEAR_VALUE); }
fan.fogl.GlEnumFactoryPeer.prototype.glStencilFunc(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.STENCIL_FUNC); }
fan.fogl.GlEnumFactoryPeer.prototype.glStencilFail(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.STENCIL_FAIL); }
fan.fogl.GlEnumFactoryPeer.prototype.glStencilPassDepthFail(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.STENCIL_PASS_DEPTH_FAIL); }
fan.fogl.GlEnumFactoryPeer.prototype.glStencilPassDepthPass(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.STENCIL_PASS_DEPTH_PASS); }
fan.fogl.GlEnumFactoryPeer.prototype.glStencilRef(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.STENCIL_REF); }
fan.fogl.GlEnumFactoryPeer.prototype.glStencilValueMask(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.STENCIL_VALUE_MASK); }
fan.fogl.GlEnumFactoryPeer.prototype.glStencilWritemask(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.STENCIL_WRITEMASK); }
fan.fogl.GlEnumFactoryPeer.prototype.glStencilBackFunc(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.STENCIL_BACK_FUNC); }
fan.fogl.GlEnumFactoryPeer.prototype.glStencilBackFail(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.STENCIL_BACK_FAIL); }
fan.fogl.GlEnumFactoryPeer.prototype.glStencilBackPassDepthFail(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.STENCIL_BACK_PASS_DEPTH_FAIL); }
fan.fogl.GlEnumFactoryPeer.prototype.glStencilBackPassDepthPass(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.STENCIL_BACK_PASS_DEPTH_PASS); }
fan.fogl.GlEnumFactoryPeer.prototype.glStencilBackRef(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.STENCIL_BACK_REF); }
fan.fogl.GlEnumFactoryPeer.prototype.glStencilBackValueMask(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.STENCIL_BACK_VALUE_MASK); }
fan.fogl.GlEnumFactoryPeer.prototype.glStencilBackWritemask(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.STENCIL_BACK_WRITEMASK); }
fan.fogl.GlEnumFactoryPeer.prototype.glViewport(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.VIEWPORT); }
fan.fogl.GlEnumFactoryPeer.prototype.glScissorBox(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.SCISSOR_BOX); }
// SCISSOR_TEST
fan.fogl.GlEnumFactoryPeer.prototype.glColorClearValue(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.COLOR_CLEAR_VALUE); }
fan.fogl.GlEnumFactoryPeer.prototype.glColorWritemask(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.COLOR_WRITEMASK); }
fan.fogl.GlEnumFactoryPeer.prototype.glUnpackAlignment(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.UNPACK_ALIGNMENT); }
fan.fogl.GlEnumFactoryPeer.prototype.glPackAlignment(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.PACK_ALIGNMENT); }
fan.fogl.GlEnumFactoryPeer.prototype.glMaxTextureSize(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.MAX_TEXTURE_SIZE); }
fan.fogl.GlEnumFactoryPeer.prototype.glMaxViewportDims(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.MAX_VIEWPORT_DIMS); }
fan.fogl.GlEnumFactoryPeer.prototype.glSubpixelBits(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.SUBPIXEL_BITS); }
fan.fogl.GlEnumFactoryPeer.prototype.glRedBits(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.RED_BITS); }
fan.fogl.GlEnumFactoryPeer.prototype.glGreenBits(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.GREEN_BITS); }
fan.fogl.GlEnumFactoryPeer.prototype.glBlueBits(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.BLUE_BITS); }
fan.fogl.GlEnumFactoryPeer.prototype.glAlphaBits(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.ALPHA_BITS); }
fan.fogl.GlEnumFactoryPeer.prototype.glDepthBits(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.DEPTH_BITS); }
fan.fogl.GlEnumFactoryPeer.prototype.glStencilBits(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.STENCIL_BITS); }
fan.fogl.GlEnumFactoryPeer.prototype.glPolygonOffsetUnits(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.POLYGON_OFFSET_UNITS); }
// POLYGON_OFFSET_FILL
fan.fogl.GlEnumFactoryPeer.prototype.glPolygonOffsetFactor(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.POLYGON_OFFSET_FACTOR); }
fan.fogl.GlEnumFactoryPeer.prototype.glTextureBinding2d(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.TEXTURE_BINDING_2D); }
fan.fogl.GlEnumFactoryPeer.prototype.glSampleBuffers(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.SAMPLE_BUFFERS); }
fan.fogl.GlEnumFactoryPeer.prototype.glSamples(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.SAMPLES); }
fan.fogl.GlEnumFactoryPeer.prototype.glSampleCoverageValue(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.SAMPLE_COVERAGE_VALUE); }
fan.fogl.GlEnumFactoryPeer.prototype.glSampleCoverageInvert(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.SAMPLE_COVERAGE_INVERT); }

// GetTextureParameter
// TEXTURE_MAG_FILTER
// TEXTURE_MIN_FILTER
// TEXTURE_WRAP_S
// TEXTURE_WRAP_T

fan.fogl.GlEnumFactoryPeer.prototype.glNumCompressedTextureFormats(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.NUM_COMPRESSED_TEXTURE_FORMATS); }
fan.fogl.GlEnumFactoryPeer.prototype.glCompressedTextureFormats(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.COMPRESSED_TEXTURE_FORMATS); }

// HintMode
fan.fogl.GlEnumFactoryPeer.prototype.glDontCare(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.DONT_CARE); }
fan.fogl.GlEnumFactoryPeer.prototype.glFastest(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.FASTEST); }
fan.fogl.GlEnumFactoryPeer.prototype.glNicest(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.NICEST); }

// HintTarget
fan.fogl.GlEnumFactoryPeer.prototype.glGenerateMipmapHint(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.GENERATE_MIPMAP_HINT); }

// DataType
fan.fogl.GlEnumFactoryPeer.prototype.glByte(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.BYTE); }
fan.fogl.GlEnumFactoryPeer.prototype.glUnsignedByte(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.UNSIGNED_BYTE); }
fan.fogl.GlEnumFactoryPeer.prototype.glShort(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.SHORT); }
fan.fogl.GlEnumFactoryPeer.prototype.glUnsignedShort(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.UNSIGNED_SHORT); }
fan.fogl.GlEnumFactoryPeer.prototype.glInt(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.INT); }
fan.fogl.GlEnumFactoryPeer.prototype.glUnsignedInt(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.UNSIGNED_INT); }
fan.fogl.GlEnumFactoryPeer.prototype.glFloat(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.FLOAT); }

// PixelFormat
fan.fogl.GlEnumFactoryPeer.prototype.glDepthComponent(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.DEPTH_COMPONENT); }
fan.fogl.GlEnumFactoryPeer.prototype.glAlpha(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.ALPHA); }
fan.fogl.GlEnumFactoryPeer.prototype.glRgb(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.RGB); }
fan.fogl.GlEnumFactoryPeer.prototype.glRgba(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.RGBA); }
fan.fogl.GlEnumFactoryPeer.prototype.glLuminance(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.LUMINANCE); }
fan.fogl.GlEnumFactoryPeer.prototype.glLuminanceAlpha(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.LUMINANCE_ALPHA); }

// PixelType
// UNSIGNED_BYTE
fan.fogl.GlEnumFactoryPeer.prototype.glUnsignedShort4444(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.UNSIGNED_SHORT_4_4_4_4); }
fan.fogl.GlEnumFactoryPeer.prototype.glUnsignedShort5551(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.UNSIGNED_SHORT_5_5_5_1); }
fan.fogl.GlEnumFactoryPeer.prototype.glUnsignedShort565(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.UNSIGNED_SHORT_5_6_5); }

// Shaders
fan.fogl.GlEnumFactoryPeer.prototype.glFragmentShader(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.FRAGMENT_SHADER); }
fan.fogl.GlEnumFactoryPeer.prototype.glVertexShader(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.VERTEX_SHADER); }
fan.fogl.GlEnumFactoryPeer.prototype.glMaxVertexAttribs(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.MAX_VERTEX_ATTRIBS); }
fan.fogl.GlEnumFactoryPeer.prototype.glMaxVertexUniformVectors(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.MAX_VERTEX_UNIFORM_VECTORS); }
fan.fogl.GlEnumFactoryPeer.prototype.glMaxVaryingVectors(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.MAX_VARYING_VECTORS); }
fan.fogl.GlEnumFactoryPeer.prototype.glMaxCombinedTextureImageUnits(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.MAX_COMBINED_TEXTURE_IMAGE_UNITS); }
fan.fogl.GlEnumFactoryPeer.prototype.glMaxVertexTextureImageUnits(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.MAX_VERTEX_TEXTURE_IMAGE_UNITS); }
fan.fogl.GlEnumFactoryPeer.prototype.glMaxTextureImageUnits(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.MAX_TEXTURE_IMAGE_UNITS); }
fan.fogl.GlEnumFactoryPeer.prototype.glMaxFragmentUniformVectors(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.MAX_FRAGMENT_UNIFORM_VECTORS); }
fan.fogl.GlEnumFactoryPeer.prototype.glShaderType(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.SHADER_TYPE); }
fan.fogl.GlEnumFactoryPeer.prototype.glDeleteStatus(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.DELETE_STATUS); }
fan.fogl.GlEnumFactoryPeer.prototype.glLinkStatus(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.LINK_STATUS); }
fan.fogl.GlEnumFactoryPeer.prototype.glValidateStatus(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.VALIDATE_STATUS); }
fan.fogl.GlEnumFactoryPeer.prototype.glAttachedShaders(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.ATTACHED_SHADERS); }
fan.fogl.GlEnumFactoryPeer.prototype.glActiveUniforms(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.ACTIVE_UNIFORMS); }
fan.fogl.GlEnumFactoryPeer.prototype.glActiveAttributes(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.ACTIVE_ATTRIBUTES); }
fan.fogl.GlEnumFactoryPeer.prototype.glShadingLanguageVersion(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.SHADING_LANGUAGE_VERSION); }
fan.fogl.GlEnumFactoryPeer.prototype.glCurrentProgram(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.CURRENT_PROGRAM); }

// StencilFunction
fan.fogl.GlEnumFactoryPeer.prototype.glNever(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.NEVER); }
fan.fogl.GlEnumFactoryPeer.prototype.glLess(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.LESS); }
fan.fogl.GlEnumFactoryPeer.prototype.glEqual(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.EQUAL); }
fan.fogl.GlEnumFactoryPeer.prototype.glLequal(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.LEQUAL); }
fan.fogl.GlEnumFactoryPeer.prototype.glGreater(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.GREATER); }
fan.fogl.GlEnumFactoryPeer.prototype.glNotequal(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.NOTEQUAL); }
fan.fogl.GlEnumFactoryPeer.prototype.glGequal(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.GEQUAL); }
fan.fogl.GlEnumFactoryPeer.prototype.glAlways(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.ALWAYS); }

// StencilOp
// ZERO
fan.fogl.GlEnumFactoryPeer.prototype.glKeep(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.KEEP); }
fan.fogl.GlEnumFactoryPeer.prototype.glReplace(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.REPLACE); }
fan.fogl.GlEnumFactoryPeer.prototype.glIncr(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.INCR); }
fan.fogl.GlEnumFactoryPeer.prototype.glDecr(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.DECR); }
fan.fogl.GlEnumFactoryPeer.prototype.glInvert(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.INVERT); }
fan.fogl.GlEnumFactoryPeer.prototype.glIncrWrap(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.INCR_WRAP); }
fan.fogl.GlEnumFactoryPeer.prototype.glDecrWrap(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.DECR_WRAP); }

// StringName
fan.fogl.GlEnumFactoryPeer.prototype.glVendor(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.VENDOR); }
fan.fogl.GlEnumFactoryPeer.prototype.glRenderer(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.RENDERER); }
fan.fogl.GlEnumFactoryPeer.prototype.glVersion(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.VERSION); }

// TextureMagFilter
fan.fogl.GlEnumFactoryPeer.prototype.glNearest(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.NEAREST); }
fan.fogl.GlEnumFactoryPeer.prototype.glLinear(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.LINEAR); }

// TextureMinFilter
// NEAREST
// LINEAR
fan.fogl.GlEnumFactoryPeer.prototype.glNearestMipmapNearest(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.NEAREST_MIPMAP_NEAREST); }
fan.fogl.GlEnumFactoryPeer.prototype.glLinearMipmapNearest(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.LINEAR_MIPMAP_NEAREST); }
fan.fogl.GlEnumFactoryPeer.prototype.glNearestMipmapLinear(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.NEAREST_MIPMAP_LINEAR); }
fan.fogl.GlEnumFactoryPeer.prototype.glLinearMipmapLinear(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.LINEAR_MIPMAP_LINEAR); }

// TextureParameterName
fan.fogl.GlEnumFactoryPeer.prototype.glTextureMagFilter(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.TEXTURE_MAG_FILTER); }
fan.fogl.GlEnumFactoryPeer.prototype.glTextureMinFilter(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.TEXTURE_MIN_FILTER); }
fan.fogl.GlEnumFactoryPeer.prototype.glTextureWrapS(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.TEXTURE_WRAP_S); }
fan.fogl.GlEnumFactoryPeer.prototype.glTextureWrapT(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.TEXTURE_WRAP_T); }

// TextureTarget
fan.fogl.GlEnumFactoryPeer.prototype.glTexture2d(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.TEXTURE_2D); }
fan.fogl.GlEnumFactoryPeer.prototype.glTexture(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.TEXTURE); }

fan.fogl.GlEnumFactoryPeer.prototype.glTextureCubeMap(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.TEXTURE_CUBE_MAP); }
fan.fogl.GlEnumFactoryPeer.prototype.glTextureBindingCubeMap(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.TEXTURE_BINDING_CUBE_MAP); }
fan.fogl.GlEnumFactoryPeer.prototype.glTextureCubeMapPositiveX(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.TEXTURE_CUBE_MAP_POSITIVE_X); }
fan.fogl.GlEnumFactoryPeer.prototype.glTextureCubeMapNegativeX(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.TEXTURE_CUBE_MAP_NEGATIVE_X); }
fan.fogl.GlEnumFactoryPeer.prototype.glTextureCubeMapPositiveY(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.TEXTURE_CUBE_MAP_POSITIVE_Y); }
fan.fogl.GlEnumFactoryPeer.prototype.glTextureCubeMapNegativeY(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.TEXTURE_CUBE_MAP_NEGATIVE_Y); }
fan.fogl.GlEnumFactoryPeer.prototype.glTextureCubeMapPositiveZ(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.TEXTURE_CUBE_MAP_POSITIVE_Z); }
fan.fogl.GlEnumFactoryPeer.prototype.glTextureCubeMapNegativeZ(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.TEXTURE_CUBE_MAP_NEGATIVE_Z); }
fan.fogl.GlEnumFactoryPeer.prototype.glMaxCubeMapTextureSize(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.MAX_CUBE_MAP_TEXTURE_SIZE); }

// TextureUnit
fan.fogl.GlEnumFactoryPeer.prototype.glTexture0(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.TEXTURE0); }
fan.fogl.GlEnumFactoryPeer.prototype.glTexture1(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.TEXTURE1); }
fan.fogl.GlEnumFactoryPeer.prototype.glTexture2(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.TEXTURE2); }
fan.fogl.GlEnumFactoryPeer.prototype.glTexture3(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.TEXTURE3); }
fan.fogl.GlEnumFactoryPeer.prototype.glTexture4(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.TEXTURE4); }
fan.fogl.GlEnumFactoryPeer.prototype.glTexture5(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.TEXTURE5); }
fan.fogl.GlEnumFactoryPeer.prototype.glTexture6(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.TEXTURE6); }
fan.fogl.GlEnumFactoryPeer.prototype.glTexture7(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.TEXTURE7); }
fan.fogl.GlEnumFactoryPeer.prototype.glTexture8(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.TEXTURE8); }
fan.fogl.GlEnumFactoryPeer.prototype.glTexture9(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.TEXTURE9); }
fan.fogl.GlEnumFactoryPeer.prototype.glTexture10(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.TEXTURE10); }
fan.fogl.GlEnumFactoryPeer.prototype.glTexture11(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.TEXTURE11); }
fan.fogl.GlEnumFactoryPeer.prototype.glTexture12(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.TEXTURE12); }
fan.fogl.GlEnumFactoryPeer.prototype.glTexture13(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.TEXTURE13); }
fan.fogl.GlEnumFactoryPeer.prototype.glTexture14(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.TEXTURE14); }
fan.fogl.GlEnumFactoryPeer.prototype.glTexture15(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.TEXTURE15); }
fan.fogl.GlEnumFactoryPeer.prototype.glTexture16(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.TEXTURE16); }
fan.fogl.GlEnumFactoryPeer.prototype.glTexture17(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.TEXTURE17); }
fan.fogl.GlEnumFactoryPeer.prototype.glTexture18(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.TEXTURE18); }
fan.fogl.GlEnumFactoryPeer.prototype.glTexture19(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.TEXTURE19); }
fan.fogl.GlEnumFactoryPeer.prototype.glTexture20(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.TEXTURE20); }
fan.fogl.GlEnumFactoryPeer.prototype.glTexture21(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.TEXTURE21); }
fan.fogl.GlEnumFactoryPeer.prototype.glTexture22(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.TEXTURE22); }
fan.fogl.GlEnumFactoryPeer.prototype.glTexture23(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.TEXTURE23); }
fan.fogl.GlEnumFactoryPeer.prototype.glTexture24(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.TEXTURE24); }
fan.fogl.GlEnumFactoryPeer.prototype.glTexture25(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.TEXTURE25); }
fan.fogl.GlEnumFactoryPeer.prototype.glTexture26(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.TEXTURE26); }
fan.fogl.GlEnumFactoryPeer.prototype.glTexture27(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.TEXTURE27); }
fan.fogl.GlEnumFactoryPeer.prototype.glTexture28(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.TEXTURE28); }
fan.fogl.GlEnumFactoryPeer.prototype.glTexture29(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.TEXTURE29); }
fan.fogl.GlEnumFactoryPeer.prototype.glTexture30(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.TEXTURE30); }
fan.fogl.GlEnumFactoryPeer.prototype.glTexture31(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.TEXTURE31); }
fan.fogl.GlEnumFactoryPeer.prototype.glActiveTexture(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.ACTIVE_TEXTURE); }

// TextureWrapMode
fan.fogl.GlEnumFactoryPeer.prototype.glRepeat(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.REPEAT); }
fan.fogl.GlEnumFactoryPeer.prototype.glClampToEdge(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.CLAMP_TO_EDGE); }
fan.fogl.GlEnumFactoryPeer.prototype.glMirroredRepeat(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.MIRRORED_REPEAT); }

// Uniform Types
fan.fogl.GlEnumFactoryPeer.prototype.glFloatVec2(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.FLOAT_VEC2); }
fan.fogl.GlEnumFactoryPeer.prototype.glFloatVec3(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.FLOAT_VEC3); }
fan.fogl.GlEnumFactoryPeer.prototype.glFloatVec4(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.FLOAT_VEC4); }
fan.fogl.GlEnumFactoryPeer.prototype.glIntVec2(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.INT_VEC2); }
fan.fogl.GlEnumFactoryPeer.prototype.glIntVec3(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.INT_VEC3); }
fan.fogl.GlEnumFactoryPeer.prototype.glIntVec4(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.INT_VEC4); }
fan.fogl.GlEnumFactoryPeer.prototype.glBool(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.BOOL); }
fan.fogl.GlEnumFactoryPeer.prototype.glBoolVec2(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.BOOL_VEC2); }
fan.fogl.GlEnumFactoryPeer.prototype.glBoolVec3(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.BOOL_VEC3); }
fan.fogl.GlEnumFactoryPeer.prototype.glBoolVec4(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.BOOL_VEC4); }
fan.fogl.GlEnumFactoryPeer.prototype.glFloatMat2(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.FLOAT_MAT2); }
fan.fogl.GlEnumFactoryPeer.prototype.glFloatMat3(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.FLOAT_MAT3); }
fan.fogl.GlEnumFactoryPeer.prototype.glFloatMat4(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.FLOAT_MAT4); }
fan.fogl.GlEnumFactoryPeer.prototype.glSampler2d(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.SAMPLER_2D); }
fan.fogl.GlEnumFactoryPeer.prototype.glSamplerCube(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.SAMPLER_CUBE); }

// Vertex Arrays
fan.fogl.GlEnumFactoryPeer.prototype.glVertexAttribArrayEnabled(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.VERTEX_ATTRIB_ARRAY_ENABLED); }
fan.fogl.GlEnumFactoryPeer.prototype.glVertexAttribArraySize(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.VERTEX_ATTRIB_ARRAY_SIZE); }
fan.fogl.GlEnumFactoryPeer.prototype.glVertexAttribArrayStride(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.VERTEX_ATTRIB_ARRAY_STRIDE); }
fan.fogl.GlEnumFactoryPeer.prototype.glVertexAttribArrayType(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.VERTEX_ATTRIB_ARRAY_TYPE); }
fan.fogl.GlEnumFactoryPeer.prototype.glVertexAttribArrayNormalized(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.VERTEX_ATTRIB_ARRAY_NORMALIZED); }
fan.fogl.GlEnumFactoryPeer.prototype.glVertexAttribArrayPointer(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.VERTEX_ATTRIB_ARRAY_POINTER); }
fan.fogl.GlEnumFactoryPeer.prototype.glVertexAttribArrayBufferBinding(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.VERTEX_ATTRIB_ARRAY_BUFFER_BINDING); }

// Shader Source
fan.fogl.GlEnumFactoryPeer.prototype.glCompileStatus(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.COMPILE_STATUS); }

// Shader Precision-Specified Types
fan.fogl.GlEnumFactoryPeer.prototype.glLowFloat(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.LOW_FLOAT); }
fan.fogl.GlEnumFactoryPeer.prototype.glMediumFloat(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.MEDIUM_FLOAT); }
fan.fogl.GlEnumFactoryPeer.prototype.glHighFloat(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.HIGH_FLOAT); }
fan.fogl.GlEnumFactoryPeer.prototype.glLowInt(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.LOW_INT); }
fan.fogl.GlEnumFactoryPeer.prototype.glMediumInt(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.MEDIUM_INT); }
fan.fogl.GlEnumFactoryPeer.prototype.glHighInt(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.HIGH_INT); }

// Framebuffer Object.
fan.fogl.GlEnumFactoryPeer.prototype.glFramebuffer(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.FRAMEBUFFER); }
fan.fogl.GlEnumFactoryPeer.prototype.glRenderbuffer(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.RENDERBUFFER); }

fan.fogl.GlEnumFactoryPeer.prototype.glRgba4(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.RGBA4); }
fan.fogl.GlEnumFactoryPeer.prototype.glRgb5A1(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.RGB5_A1); }
fan.fogl.GlEnumFactoryPeer.prototype.glRgb565(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.RGB565); }
fan.fogl.GlEnumFactoryPeer.prototype.glDepthComponent16(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.DEPTH_COMPONENT16); }
fan.fogl.GlEnumFactoryPeer.prototype.glStencilIndex(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.STENCIL_INDEX); }
fan.fogl.GlEnumFactoryPeer.prototype.glStencilIndex8(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.STENCIL_INDEX8); }
fan.fogl.GlEnumFactoryPeer.prototype.glDepthStencil(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.DEPTH_STENCIL); }

fan.fogl.GlEnumFactoryPeer.prototype.glRenderbufferWidth(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.RENDERBUFFER_WIDTH); }
fan.fogl.GlEnumFactoryPeer.prototype.glRenderbufferHeight(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.RENDERBUFFER_HEIGHT); }
fan.fogl.GlEnumFactoryPeer.prototype.glRenderbufferInternalFormat(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.RENDERBUFFER_INTERNAL_FORMAT); }
fan.fogl.GlEnumFactoryPeer.prototype.glRenderbufferRedSize(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.RENDERBUFFER_RED_SIZE); }
fan.fogl.GlEnumFactoryPeer.prototype.glRenderbufferGreenSize(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.RENDERBUFFER_GREEN_SIZE); }
fan.fogl.GlEnumFactoryPeer.prototype.glRenderbufferBlueSize(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.RENDERBUFFER_BLUE_SIZE); }
fan.fogl.GlEnumFactoryPeer.prototype.glRenderbufferAlphaSize(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.RENDERBUFFER_ALPHA_SIZE); }
fan.fogl.GlEnumFactoryPeer.prototype.glRenderbufferDepthSize(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.RENDERBUFFER_DEPTH_SIZE); }
fan.fogl.GlEnumFactoryPeer.prototype.glRenderbufferStencilSize(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.RENDERBUFFER_STENCIL_SIZE); }

fan.fogl.GlEnumFactoryPeer.prototype.glFramebufferAttachmentObjectType(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE); }
fan.fogl.GlEnumFactoryPeer.prototype.glFramebufferAttachmentObjectName(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.FRAMEBUFFER_ATTACHMENT_OBJECT_NAME); }
fan.fogl.GlEnumFactoryPeer.prototype.glFramebufferAttachmentTextureLevel(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.FRAMEBUFFER_ATTACHMENT_TEXTURE_LEVEL); }
fan.fogl.GlEnumFactoryPeer.prototype.glFramebufferAttachmentTextureCubeMapFace(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.FRAMEBUFFER_ATTACHMENT_TEXTURE_CUBE_MAP_FACE); }

fan.fogl.GlEnumFactoryPeer.prototype.glColorAttachment0(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.COLOR_ATTACHMENT0); }
fan.fogl.GlEnumFactoryPeer.prototype.glDepthAttachment(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.DEPTH_ATTACHMENT); }
fan.fogl.GlEnumFactoryPeer.prototype.glStencilAttachment(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.STENCIL_ATTACHMENT); }
fan.fogl.GlEnumFactoryPeer.prototype.glDepthStencilAttachment(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.DEPTH_STENCIL_ATTACHMENT); }

fan.fogl.GlEnumFactoryPeer.prototype.glNone(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.NONE); }

fan.fogl.GlEnumFactoryPeer.prototype.glFramebufferComplete(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.FRAMEBUFFER_COMPLETE); }
fan.fogl.GlEnumFactoryPeer.prototype.glFramebufferIncompleteAttachment(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.FRAMEBUFFER_INCOMPLETE_ATTACHMENT); }
fan.fogl.GlEnumFactoryPeer.prototype.glFramebufferIncompleteMissingAttachment(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT); }
fan.fogl.GlEnumFactoryPeer.prototype.glFramebufferIncompleteDimensions(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.FRAMEBUFFER_INCOMPLETE_DIMENSIONS); }
fan.fogl.GlEnumFactoryPeer.prototype.glFramebufferUnsupported(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.FRAMEBUFFER_UNSUPPORTED); }

fan.fogl.GlEnumFactoryPeer.prototype.glFramebufferBinding(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.FRAMEBUFFER_BINDING); }
fan.fogl.GlEnumFactoryPeer.prototype.glRenderbufferBinding(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.RENDERBUFFER_BINDING); }
fan.fogl.GlEnumFactoryPeer.prototype.glMaxRenderbufferSize(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.MAX_RENDERBUFFER_SIZE); }

fan.fogl.GlEnumFactoryPeer.prototype.glInvalidFramebufferOperation(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.INVALID_FRAMEBUFFER_OPERATION); }

// WebGL-specific enums
fan.fogl.GlEnumFactoryPeer.prototype.glUnpackFlipYWebgl(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.UNPACK_FLIP_Y_WEBGL); }
fan.fogl.GlEnumFactoryPeer.prototype.glUnpackPremultiplyAlphaWebgl(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.UNPACK_PREMULTIPLY_ALPHA_WEBGL); }
fan.fogl.GlEnumFactoryPeer.prototype.glContextLostWebgl(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.CONTEXT_LOST_WEBGL); }
fan.fogl.GlEnumFactoryPeer.prototype.glUnpackColorspaceConversionWebgl(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.UNPACK_COLORSPACE_CONVERSION_WEBGL); }
fan.fogl.GlEnumFactoryPeer.prototype.glBrowserDefaultWebgl(self){ return fan.fogl.GlEnumFactoryPeer.makeEnum(self.m_gl.BROWSER_DEFAULT_WEBGL); }