//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-5-31  Jed Young  Creation
//

package fan.fogl;

import fan.sys.*;

import static org.lwjgl.opengl.GL11.*;
import static org.lwjgl.opengl.GL12.*;
import static org.lwjgl.opengl.GL13.*;
import static org.lwjgl.opengl.GL14.*;
import static org.lwjgl.opengl.GL15.*;
import static org.lwjgl.opengl.GL20.*;
import static org.lwjgl.opengl.GL21.*;
import static org.lwjgl.opengl.GL30.*;
import static org.lwjgl.opengl.GL31.*;
import static org.lwjgl.opengl.ARBES2Compatibility.*;


class GlEnumFactoryPeer
{
  public static GlEnumFactoryPeer make(GlEnumFactory self)
  {
    return new GlEnumFactoryPeer();
  }

  public static GlEnum makeEnum(int i)
  {
    GlEnum e = GlEnum.make();
    e.peer.setValue(i);
    return e;
  }

//////////////////////////////////////////////////////////////////////////
// Gen
//////////////////////////////////////////////////////////////////////////

  GlEnum glDepthBufferBit(GlEnumFactory self){ return makeEnum(GL_DEPTH_BUFFER_BIT); }
  GlEnum glStencilBufferBit(GlEnumFactory self){ return makeEnum(GL_STENCIL_BUFFER_BIT); }
  GlEnum glColorBufferBit(GlEnumFactory self){ return makeEnum(GL_COLOR_BUFFER_BIT); }

// BeginMode
  GlEnum glPoints(GlEnumFactory self){ return makeEnum(GL_POINTS); }
  GlEnum glLines(GlEnumFactory self){ return makeEnum(GL_LINES); }
  GlEnum glLineLoop(GlEnumFactory self){ return makeEnum(GL_LINE_LOOP); }
  GlEnum glLineStrip(GlEnumFactory self){ return makeEnum(GL_LINE_STRIP); }
  GlEnum glTriangles(GlEnumFactory self){ return makeEnum(GL_TRIANGLES); }
  GlEnum glTriangleStrip(GlEnumFactory self){ return makeEnum(GL_TRIANGLE_STRIP); }
  GlEnum glTriangleFan(GlEnumFactory self){ return makeEnum(GL_TRIANGLE_FAN); }

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
  GlEnum glZero(GlEnumFactory self){ return makeEnum(GL_ZERO); }
  GlEnum glOne(GlEnumFactory self){ return makeEnum(GL_ONE); }
  GlEnum glSrcColor(GlEnumFactory self){ return makeEnum(GL_SRC_COLOR); }
  GlEnum glOneMinusSrcColor(GlEnumFactory self){ return makeEnum(GL_ONE_MINUS_SRC_COLOR); }
  GlEnum glSrcAlpha(GlEnumFactory self){ return makeEnum(GL_SRC_ALPHA); }
  GlEnum glOneMinusSrcAlpha(GlEnumFactory self){ return makeEnum(GL_ONE_MINUS_SRC_ALPHA); }
  GlEnum glDstAlpha(GlEnumFactory self){ return makeEnum(GL_DST_ALPHA); }
  GlEnum glOneMinusDstAlpha(GlEnumFactory self){ return makeEnum(GL_ONE_MINUS_DST_ALPHA); }

// BlendingFactorSrc
// ZERO
// ONE
  GlEnum glDstColor(GlEnumFactory self){ return makeEnum(GL_DST_COLOR); }
  GlEnum glOneMinusDstColor(GlEnumFactory self){ return makeEnum(GL_ONE_MINUS_DST_COLOR); }
  GlEnum glSrcAlphaSaturate(GlEnumFactory self){ return makeEnum(GL_SRC_ALPHA_SATURATE); }
// SRC_ALPHA
// ONE_MINUS_SRC_ALPHA
// DST_ALPHA
// ONE_MINUS_DST_ALPHA

// BlendEquationSeparate
  GlEnum glFuncAdd(GlEnumFactory self){ return makeEnum(GL_FUNC_ADD); }
  GlEnum glBlendEquation(GlEnumFactory self){ return makeEnum(GL_BLEND_EQUATION); }
  GlEnum glBlendEquationRgb(GlEnumFactory self){ return makeEnum(GL_BLEND_EQUATION_RGB); }
  GlEnum glBlendEquationAlpha(GlEnumFactory self){ return makeEnum(GL_BLEND_EQUATION_ALPHA); }

// BlendSubtract
  GlEnum glFuncSubtract(GlEnumFactory self){ return makeEnum(GL_FUNC_SUBTRACT); }
  GlEnum glFuncReverseSubtract(GlEnumFactory self){ return makeEnum(GL_FUNC_REVERSE_SUBTRACT); }

// Separate Blend Functions
  GlEnum glBlendDstRgb(GlEnumFactory self){ return makeEnum(GL_BLEND_DST_RGB); }
  GlEnum glBlendSrcRgb(GlEnumFactory self){ return makeEnum(GL_BLEND_SRC_RGB); }
  GlEnum glBlendDstAlpha(GlEnumFactory self){ return makeEnum(GL_BLEND_DST_ALPHA); }
  GlEnum glBlendSrcAlpha(GlEnumFactory self){ return makeEnum(GL_BLEND_SRC_ALPHA); }
  GlEnum glConstantColor(GlEnumFactory self){ return makeEnum(GL_CONSTANT_COLOR); }
  GlEnum glOneMinusConstantColor(GlEnumFactory self){ return makeEnum(GL_ONE_MINUS_CONSTANT_COLOR); }
  GlEnum glConstantAlpha(GlEnumFactory self){ return makeEnum(GL_CONSTANT_ALPHA); }
  GlEnum glOneMinusConstantAlpha(GlEnumFactory self){ return makeEnum(GL_ONE_MINUS_CONSTANT_ALPHA); }
  GlEnum glBlendColor(GlEnumFactory self){ return makeEnum(GL_BLEND_COLOR); }

// Buffer Objects
  GlEnum glArrayBuffer(GlEnumFactory self){ return makeEnum(GL_ARRAY_BUFFER); }
  GlEnum glElementArrayBuffer(GlEnumFactory self){ return makeEnum(GL_ELEMENT_ARRAY_BUFFER); }
  GlEnum glArrayBufferBinding(GlEnumFactory self){ return makeEnum(GL_ARRAY_BUFFER_BINDING); }
  GlEnum glElementArrayBufferBinding(GlEnumFactory self){ return makeEnum(GL_ELEMENT_ARRAY_BUFFER_BINDING); }

  GlEnum glStreamDraw(GlEnumFactory self){ return makeEnum(GL_STREAM_DRAW); }
  GlEnum glStaticDraw(GlEnumFactory self){ return makeEnum(GL_STATIC_DRAW); }
  GlEnum glDynamicDraw(GlEnumFactory self){ return makeEnum(GL_DYNAMIC_DRAW); }

  GlEnum glBufferSize(GlEnumFactory self){ return makeEnum(GL_BUFFER_SIZE); }
  GlEnum glBufferUsage(GlEnumFactory self){ return makeEnum(GL_BUFFER_USAGE); }

  GlEnum glCurrentVertexAttrib(GlEnumFactory self){ return makeEnum(GL_CURRENT_VERTEX_ATTRIB); }

// CullFaceMode
  GlEnum glFront(GlEnumFactory self){ return makeEnum(GL_FRONT); }
  GlEnum glBack(GlEnumFactory self){ return makeEnum(GL_BACK); }
  GlEnum glFrontAndBack(GlEnumFactory self){ return makeEnum(GL_FRONT_AND_BACK); }

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
  GlEnum glCullFace(GlEnumFactory self){ return makeEnum(GL_CULL_FACE); }
  GlEnum glBlend(GlEnumFactory self){ return makeEnum(GL_BLEND); }
  GlEnum glDither(GlEnumFactory self){ return makeEnum(GL_DITHER); }
  GlEnum glStencilTest(GlEnumFactory self){ return makeEnum(GL_STENCIL_TEST); }
  GlEnum glDepthTest(GlEnumFactory self){ return makeEnum(GL_DEPTH_TEST); }
  GlEnum glScissorTest(GlEnumFactory self){ return makeEnum(GL_SCISSOR_TEST); }
  GlEnum glPolygonOffsetFill(GlEnumFactory self){ return makeEnum(GL_POLYGON_OFFSET_FILL); }
  GlEnum glSampleAlphaToCoverage(GlEnumFactory self){ return makeEnum(GL_SAMPLE_ALPHA_TO_COVERAGE); }
  GlEnum glSampleCoverage(GlEnumFactory self){ return makeEnum(GL_SAMPLE_COVERAGE); }

// ErrorCode
  GlEnum glNoError(GlEnumFactory self){ return makeEnum(GL_NO_ERROR); }
  GlEnum glInvalidEnum(GlEnumFactory self){ return makeEnum(GL_INVALID_ENUM); }
  GlEnum glInvalidValue(GlEnumFactory self){ return makeEnum(GL_INVALID_VALUE); }
  GlEnum glInvalidOperation(GlEnumFactory self){ return makeEnum(GL_INVALID_OPERATION); }
  GlEnum glOutOfMemory(GlEnumFactory self){ return makeEnum(GL_OUT_OF_MEMORY); }

// FrontFaceDirection
  GlEnum glCw(GlEnumFactory self){ return makeEnum(GL_CW); }
  GlEnum glCcw(GlEnumFactory self){ return makeEnum(GL_CCW); }

// GetPName
  GlEnum glLineWidth(GlEnumFactory self){ return makeEnum(GL_LINE_WIDTH); }
  GlEnum glAliasedPointSizeRange(GlEnumFactory self){ return makeEnum(GL_ALIASED_POINT_SIZE_RANGE); }
  GlEnum glAliasedLineWidthRange(GlEnumFactory self){ return makeEnum(GL_ALIASED_LINE_WIDTH_RANGE); }
  GlEnum glCullFaceMode(GlEnumFactory self){ return makeEnum(GL_CULL_FACE_MODE); }
  GlEnum glFrontFace(GlEnumFactory self){ return makeEnum(GL_FRONT_FACE); }
  GlEnum glDepthRange(GlEnumFactory self){ return makeEnum(GL_DEPTH_RANGE); }
  GlEnum glDepthWritemask(GlEnumFactory self){ return makeEnum(GL_DEPTH_WRITEMASK); }
  GlEnum glDepthClearValue(GlEnumFactory self){ return makeEnum(GL_DEPTH_CLEAR_VALUE); }
  GlEnum glDepthFunc(GlEnumFactory self){ return makeEnum(GL_DEPTH_FUNC); }
  GlEnum glStencilClearValue(GlEnumFactory self){ return makeEnum(GL_STENCIL_CLEAR_VALUE); }
  GlEnum glStencilFunc(GlEnumFactory self){ return makeEnum(GL_STENCIL_FUNC); }
  GlEnum glStencilFail(GlEnumFactory self){ return makeEnum(GL_STENCIL_FAIL); }
  GlEnum glStencilPassDepthFail(GlEnumFactory self){ return makeEnum(GL_STENCIL_PASS_DEPTH_FAIL); }
  GlEnum glStencilPassDepthPass(GlEnumFactory self){ return makeEnum(GL_STENCIL_PASS_DEPTH_PASS); }
  GlEnum glStencilRef(GlEnumFactory self){ return makeEnum(GL_STENCIL_REF); }
  GlEnum glStencilValueMask(GlEnumFactory self){ return makeEnum(GL_STENCIL_VALUE_MASK); }
  GlEnum glStencilWritemask(GlEnumFactory self){ return makeEnum(GL_STENCIL_WRITEMASK); }
  GlEnum glStencilBackFunc(GlEnumFactory self){ return makeEnum(GL_STENCIL_BACK_FUNC); }
  GlEnum glStencilBackFail(GlEnumFactory self){ return makeEnum(GL_STENCIL_BACK_FAIL); }
  GlEnum glStencilBackPassDepthFail(GlEnumFactory self){ return makeEnum(GL_STENCIL_BACK_PASS_DEPTH_FAIL); }
  GlEnum glStencilBackPassDepthPass(GlEnumFactory self){ return makeEnum(GL_STENCIL_BACK_PASS_DEPTH_PASS); }
  GlEnum glStencilBackRef(GlEnumFactory self){ return makeEnum(GL_STENCIL_BACK_REF); }
  GlEnum glStencilBackValueMask(GlEnumFactory self){ return makeEnum(GL_STENCIL_BACK_VALUE_MASK); }
  GlEnum glStencilBackWritemask(GlEnumFactory self){ return makeEnum(GL_STENCIL_BACK_WRITEMASK); }
  GlEnum glViewport(GlEnumFactory self){ return makeEnum(GL_VIEWPORT); }
  GlEnum glScissorBox(GlEnumFactory self){ return makeEnum(GL_SCISSOR_BOX); }
// SCISSOR_TEST
  GlEnum glColorClearValue(GlEnumFactory self){ return makeEnum(GL_COLOR_CLEAR_VALUE); }
  GlEnum glColorWritemask(GlEnumFactory self){ return makeEnum(GL_COLOR_WRITEMASK); }
  GlEnum glUnpackAlignment(GlEnumFactory self){ return makeEnum(GL_UNPACK_ALIGNMENT); }
  GlEnum glPackAlignment(GlEnumFactory self){ return makeEnum(GL_PACK_ALIGNMENT); }
  GlEnum glMaxTextureSize(GlEnumFactory self){ return makeEnum(GL_MAX_TEXTURE_SIZE); }
  GlEnum glMaxViewportDims(GlEnumFactory self){ return makeEnum(GL_MAX_VIEWPORT_DIMS); }
  GlEnum glSubpixelBits(GlEnumFactory self){ return makeEnum(GL_SUBPIXEL_BITS); }
  GlEnum glRedBits(GlEnumFactory self){ return makeEnum(GL_RED_BITS); }
  GlEnum glGreenBits(GlEnumFactory self){ return makeEnum(GL_GREEN_BITS); }
  GlEnum glBlueBits(GlEnumFactory self){ return makeEnum(GL_BLUE_BITS); }
  GlEnum glAlphaBits(GlEnumFactory self){ return makeEnum(GL_ALPHA_BITS); }
  GlEnum glDepthBits(GlEnumFactory self){ return makeEnum(GL_DEPTH_BITS); }
  GlEnum glStencilBits(GlEnumFactory self){ return makeEnum(GL_STENCIL_BITS); }
  GlEnum glPolygonOffsetUnits(GlEnumFactory self){ return makeEnum(GL_POLYGON_OFFSET_UNITS); }
// POLYGON_OFFSET_FILL
  GlEnum glPolygonOffsetFactor(GlEnumFactory self){ return makeEnum(GL_POLYGON_OFFSET_FACTOR); }
  GlEnum glTextureBinding2d(GlEnumFactory self){ return makeEnum(GL_TEXTURE_BINDING_2D); }
  GlEnum glSampleBuffers(GlEnumFactory self){ return makeEnum(GL_SAMPLE_BUFFERS); }
  GlEnum glSamples(GlEnumFactory self){ return makeEnum(GL_SAMPLES); }
  GlEnum glSampleCoverageValue(GlEnumFactory self){ return makeEnum(GL_SAMPLE_COVERAGE_VALUE); }
  GlEnum glSampleCoverageInvert(GlEnumFactory self){ return makeEnum(GL_SAMPLE_COVERAGE_INVERT); }

// GetTextureParameter
// TEXTURE_MAG_FILTER
// TEXTURE_MIN_FILTER
// TEXTURE_WRAP_S
// TEXTURE_WRAP_T

  GlEnum glNumCompressedTextureFormats(GlEnumFactory self){ return makeEnum(GL_NUM_COMPRESSED_TEXTURE_FORMATS); }
  GlEnum glCompressedTextureFormats(GlEnumFactory self){ return makeEnum(GL_COMPRESSED_TEXTURE_FORMATS); }

// HintMode
  GlEnum glDontCare(GlEnumFactory self){ return makeEnum(GL_DONT_CARE); }
  GlEnum glFastest(GlEnumFactory self){ return makeEnum(GL_FASTEST); }
  GlEnum glNicest(GlEnumFactory self){ return makeEnum(GL_NICEST); }

// HintTarget
  GlEnum glGenerateMipmapHint(GlEnumFactory self){ return makeEnum(GL_GENERATE_MIPMAP_HINT); }

// DataType
  GlEnum glByte(GlEnumFactory self){ return makeEnum(GL_BYTE); }
  GlEnum glUnsignedByte(GlEnumFactory self){ return makeEnum(GL_UNSIGNED_BYTE); }
  GlEnum glShort(GlEnumFactory self){ return makeEnum(GL_SHORT); }
  GlEnum glUnsignedShort(GlEnumFactory self){ return makeEnum(GL_UNSIGNED_SHORT); }
  GlEnum glInt(GlEnumFactory self){ return makeEnum(GL_INT); }
  GlEnum glUnsignedInt(GlEnumFactory self){ return makeEnum(GL_UNSIGNED_INT); }
  GlEnum glFloat(GlEnumFactory self){ return makeEnum(GL_FLOAT); }

// PixelFormat
  GlEnum glDepthComponent(GlEnumFactory self){ return makeEnum(GL_DEPTH_COMPONENT); }
  GlEnum glAlpha(GlEnumFactory self){ return makeEnum(GL_ALPHA); }
  GlEnum glRgb(GlEnumFactory self){ return makeEnum(GL_RGB); }
  GlEnum glRgba(GlEnumFactory self){ return makeEnum(GL_RGBA); }
  GlEnum glLuminance(GlEnumFactory self){ return makeEnum(GL_LUMINANCE); }
  GlEnum glLuminanceAlpha(GlEnumFactory self){ return makeEnum(GL_LUMINANCE_ALPHA); }

// PixelType
// UNSIGNED_BYTE
  GlEnum glUnsignedShort4444(GlEnumFactory self){ return makeEnum(GL_UNSIGNED_SHORT_4_4_4_4); }
  GlEnum glUnsignedShort5551(GlEnumFactory self){ return makeEnum(GL_UNSIGNED_SHORT_5_5_5_1); }
  GlEnum glUnsignedShort565(GlEnumFactory self){ return makeEnum(GL_UNSIGNED_SHORT_5_6_5); }

// Shaders
  GlEnum glFragmentShader(GlEnumFactory self){ return makeEnum(GL_FRAGMENT_SHADER); }
  GlEnum glVertexShader(GlEnumFactory self){ return makeEnum(GL_VERTEX_SHADER); }
  GlEnum glMaxVertexAttribs(GlEnumFactory self){ return makeEnum(GL_MAX_VERTEX_ATTRIBS); }
  GlEnum glMaxVertexUniformVectors(GlEnumFactory self){ return makeEnum(GL_MAX_VERTEX_UNIFORM_VECTORS); }
  GlEnum glMaxVaryingVectors(GlEnumFactory self){ return makeEnum(GL_MAX_VARYING_VECTORS); }
  GlEnum glMaxCombinedTextureImageUnits(GlEnumFactory self){ return makeEnum(GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS); }
  GlEnum glMaxVertexTextureImageUnits(GlEnumFactory self){ return makeEnum(GL_MAX_VERTEX_TEXTURE_IMAGE_UNITS); }
  GlEnum glMaxTextureImageUnits(GlEnumFactory self){ return makeEnum(GL_MAX_TEXTURE_IMAGE_UNITS); }
  GlEnum glMaxFragmentUniformVectors(GlEnumFactory self){ return makeEnum(GL_MAX_FRAGMENT_UNIFORM_VECTORS); }
  GlEnum glShaderType(GlEnumFactory self){ return makeEnum(GL_SHADER_TYPE); }
  GlEnum glDeleteStatus(GlEnumFactory self){ return makeEnum(GL_DELETE_STATUS); }
  GlEnum glLinkStatus(GlEnumFactory self){ return makeEnum(GL_LINK_STATUS); }
  GlEnum glValidateStatus(GlEnumFactory self){ return makeEnum(GL_VALIDATE_STATUS); }
  GlEnum glAttachedShaders(GlEnumFactory self){ return makeEnum(GL_ATTACHED_SHADERS); }
  GlEnum glActiveUniforms(GlEnumFactory self){ return makeEnum(GL_ACTIVE_UNIFORMS); }
  GlEnum glActiveAttributes(GlEnumFactory self){ return makeEnum(GL_ACTIVE_ATTRIBUTES); }
  GlEnum glShadingLanguageVersion(GlEnumFactory self){ return makeEnum(GL_SHADING_LANGUAGE_VERSION); }
  GlEnum glCurrentProgram(GlEnumFactory self){ return makeEnum(GL_CURRENT_PROGRAM); }

// StencilFunction
  GlEnum glNever(GlEnumFactory self){ return makeEnum(GL_NEVER); }
  GlEnum glLess(GlEnumFactory self){ return makeEnum(GL_LESS); }
  GlEnum glEqual(GlEnumFactory self){ return makeEnum(GL_EQUAL); }
  GlEnum glLequal(GlEnumFactory self){ return makeEnum(GL_LEQUAL); }
  GlEnum glGreater(GlEnumFactory self){ return makeEnum(GL_GREATER); }
  GlEnum glNotequal(GlEnumFactory self){ return makeEnum(GL_NOTEQUAL); }
  GlEnum glGequal(GlEnumFactory self){ return makeEnum(GL_GEQUAL); }
  GlEnum glAlways(GlEnumFactory self){ return makeEnum(GL_ALWAYS); }

// StencilOp
// ZERO
  GlEnum glKeep(GlEnumFactory self){ return makeEnum(GL_KEEP); }
  GlEnum glReplace(GlEnumFactory self){ return makeEnum(GL_REPLACE); }
  GlEnum glIncr(GlEnumFactory self){ return makeEnum(GL_INCR); }
  GlEnum glDecr(GlEnumFactory self){ return makeEnum(GL_DECR); }
  GlEnum glInvert(GlEnumFactory self){ return makeEnum(GL_INVERT); }
  GlEnum glIncrWrap(GlEnumFactory self){ return makeEnum(GL_INCR_WRAP); }
  GlEnum glDecrWrap(GlEnumFactory self){ return makeEnum(GL_DECR_WRAP); }

// StringName
  GlEnum glVendor(GlEnumFactory self){ return makeEnum(GL_VENDOR); }
  GlEnum glRenderer(GlEnumFactory self){ return makeEnum(GL_RENDERER); }
  GlEnum glVersion(GlEnumFactory self){ return makeEnum(GL_VERSION); }

// TextureMagFilter
  GlEnum glNearest(GlEnumFactory self){ return makeEnum(GL_NEAREST); }
  GlEnum glLinear(GlEnumFactory self){ return makeEnum(GL_LINEAR); }

// TextureMinFilter
// NEAREST
// LINEAR
  GlEnum glNearestMipmapNearest(GlEnumFactory self){ return makeEnum(GL_NEAREST_MIPMAP_NEAREST); }
  GlEnum glLinearMipmapNearest(GlEnumFactory self){ return makeEnum(GL_LINEAR_MIPMAP_NEAREST); }
  GlEnum glNearestMipmapLinear(GlEnumFactory self){ return makeEnum(GL_NEAREST_MIPMAP_LINEAR); }
  GlEnum glLinearMipmapLinear(GlEnumFactory self){ return makeEnum(GL_LINEAR_MIPMAP_LINEAR); }

// TextureParameterName
  GlEnum glTextureMagFilter(GlEnumFactory self){ return makeEnum(GL_TEXTURE_MAG_FILTER); }
  GlEnum glTextureMinFilter(GlEnumFactory self){ return makeEnum(GL_TEXTURE_MIN_FILTER); }
  GlEnum glTextureWrapS(GlEnumFactory self){ return makeEnum(GL_TEXTURE_WRAP_S); }
  GlEnum glTextureWrapT(GlEnumFactory self){ return makeEnum(GL_TEXTURE_WRAP_T); }

// TextureTarget
  GlEnum glTexture2d(GlEnumFactory self){ return makeEnum(GL_TEXTURE_2D); }
  GlEnum glTexture(GlEnumFactory self){ return makeEnum(GL_TEXTURE); }

  GlEnum glTextureCubeMap(GlEnumFactory self){ return makeEnum(GL_TEXTURE_CUBE_MAP); }
  GlEnum glTextureBindingCubeMap(GlEnumFactory self){ return makeEnum(GL_TEXTURE_BINDING_CUBE_MAP); }
  GlEnum glTextureCubeMapPositiveX(GlEnumFactory self){ return makeEnum(GL_TEXTURE_CUBE_MAP_POSITIVE_X); }
  GlEnum glTextureCubeMapNegativeX(GlEnumFactory self){ return makeEnum(GL_TEXTURE_CUBE_MAP_NEGATIVE_X); }
  GlEnum glTextureCubeMapPositiveY(GlEnumFactory self){ return makeEnum(GL_TEXTURE_CUBE_MAP_POSITIVE_Y); }
  GlEnum glTextureCubeMapNegativeY(GlEnumFactory self){ return makeEnum(GL_TEXTURE_CUBE_MAP_NEGATIVE_Y); }
  GlEnum glTextureCubeMapPositiveZ(GlEnumFactory self){ return makeEnum(GL_TEXTURE_CUBE_MAP_POSITIVE_Z); }
  GlEnum glTextureCubeMapNegativeZ(GlEnumFactory self){ return makeEnum(GL_TEXTURE_CUBE_MAP_NEGATIVE_Z); }
  GlEnum glMaxCubeMapTextureSize(GlEnumFactory self){ return makeEnum(GL_MAX_CUBE_MAP_TEXTURE_SIZE); }

// TextureUnit
  GlEnum glTexture0(GlEnumFactory self){ return makeEnum(GL_TEXTURE0); }
  GlEnum glTexture1(GlEnumFactory self){ return makeEnum(GL_TEXTURE1); }
  GlEnum glTexture2(GlEnumFactory self){ return makeEnum(GL_TEXTURE2); }
  GlEnum glTexture3(GlEnumFactory self){ return makeEnum(GL_TEXTURE3); }
  GlEnum glTexture4(GlEnumFactory self){ return makeEnum(GL_TEXTURE4); }
  GlEnum glTexture5(GlEnumFactory self){ return makeEnum(GL_TEXTURE5); }
  GlEnum glTexture6(GlEnumFactory self){ return makeEnum(GL_TEXTURE6); }
  GlEnum glTexture7(GlEnumFactory self){ return makeEnum(GL_TEXTURE7); }
  GlEnum glTexture8(GlEnumFactory self){ return makeEnum(GL_TEXTURE8); }
  GlEnum glTexture9(GlEnumFactory self){ return makeEnum(GL_TEXTURE9); }
  GlEnum glTexture10(GlEnumFactory self){ return makeEnum(GL_TEXTURE10); }
  GlEnum glTexture11(GlEnumFactory self){ return makeEnum(GL_TEXTURE11); }
  GlEnum glTexture12(GlEnumFactory self){ return makeEnum(GL_TEXTURE12); }
  GlEnum glTexture13(GlEnumFactory self){ return makeEnum(GL_TEXTURE13); }
  GlEnum glTexture14(GlEnumFactory self){ return makeEnum(GL_TEXTURE14); }
  GlEnum glTexture15(GlEnumFactory self){ return makeEnum(GL_TEXTURE15); }
  GlEnum glTexture16(GlEnumFactory self){ return makeEnum(GL_TEXTURE16); }
  GlEnum glTexture17(GlEnumFactory self){ return makeEnum(GL_TEXTURE17); }
  GlEnum glTexture18(GlEnumFactory self){ return makeEnum(GL_TEXTURE18); }
  GlEnum glTexture19(GlEnumFactory self){ return makeEnum(GL_TEXTURE19); }
  GlEnum glTexture20(GlEnumFactory self){ return makeEnum(GL_TEXTURE20); }
  GlEnum glTexture21(GlEnumFactory self){ return makeEnum(GL_TEXTURE21); }
  GlEnum glTexture22(GlEnumFactory self){ return makeEnum(GL_TEXTURE22); }
  GlEnum glTexture23(GlEnumFactory self){ return makeEnum(GL_TEXTURE23); }
  GlEnum glTexture24(GlEnumFactory self){ return makeEnum(GL_TEXTURE24); }
  GlEnum glTexture25(GlEnumFactory self){ return makeEnum(GL_TEXTURE25); }
  GlEnum glTexture26(GlEnumFactory self){ return makeEnum(GL_TEXTURE26); }
  GlEnum glTexture27(GlEnumFactory self){ return makeEnum(GL_TEXTURE27); }
  GlEnum glTexture28(GlEnumFactory self){ return makeEnum(GL_TEXTURE28); }
  GlEnum glTexture29(GlEnumFactory self){ return makeEnum(GL_TEXTURE29); }
  GlEnum glTexture30(GlEnumFactory self){ return makeEnum(GL_TEXTURE30); }
  GlEnum glTexture31(GlEnumFactory self){ return makeEnum(GL_TEXTURE31); }
  GlEnum glActiveTexture(GlEnumFactory self){ return makeEnum(GL_ACTIVE_TEXTURE); }

// TextureWrapMode
  GlEnum glRepeat(GlEnumFactory self){ return makeEnum(GL_REPEAT); }
  GlEnum glClampToEdge(GlEnumFactory self){ return makeEnum(GL_CLAMP_TO_EDGE); }
  GlEnum glMirroredRepeat(GlEnumFactory self){ return makeEnum(GL_MIRRORED_REPEAT); }

// Uniform Types
  GlEnum glFloatVec2(GlEnumFactory self){ return makeEnum(GL_FLOAT_VEC2); }
  GlEnum glFloatVec3(GlEnumFactory self){ return makeEnum(GL_FLOAT_VEC3); }
  GlEnum glFloatVec4(GlEnumFactory self){ return makeEnum(GL_FLOAT_VEC4); }
  GlEnum glIntVec2(GlEnumFactory self){ return makeEnum(GL_INT_VEC2); }
  GlEnum glIntVec3(GlEnumFactory self){ return makeEnum(GL_INT_VEC3); }
  GlEnum glIntVec4(GlEnumFactory self){ return makeEnum(GL_INT_VEC4); }
  GlEnum glBool(GlEnumFactory self){ return makeEnum(GL_BOOL); }
  GlEnum glBoolVec2(GlEnumFactory self){ return makeEnum(GL_BOOL_VEC2); }
  GlEnum glBoolVec3(GlEnumFactory self){ return makeEnum(GL_BOOL_VEC3); }
  GlEnum glBoolVec4(GlEnumFactory self){ return makeEnum(GL_BOOL_VEC4); }
  GlEnum glFloatMat2(GlEnumFactory self){ return makeEnum(GL_FLOAT_MAT2); }
  GlEnum glFloatMat3(GlEnumFactory self){ return makeEnum(GL_FLOAT_MAT3); }
  GlEnum glFloatMat4(GlEnumFactory self){ return makeEnum(GL_FLOAT_MAT4); }
  GlEnum glSampler2d(GlEnumFactory self){ return makeEnum(GL_SAMPLER_2D); }
  GlEnum glSamplerCube(GlEnumFactory self){ return makeEnum(GL_SAMPLER_CUBE); }

// Vertex Arrays
  GlEnum glVertexAttribArrayEnabled(GlEnumFactory self){ return makeEnum(GL_VERTEX_ATTRIB_ARRAY_ENABLED); }
  GlEnum glVertexAttribArraySize(GlEnumFactory self){ return makeEnum(GL_VERTEX_ATTRIB_ARRAY_SIZE); }
  GlEnum glVertexAttribArrayStride(GlEnumFactory self){ return makeEnum(GL_VERTEX_ATTRIB_ARRAY_STRIDE); }
  GlEnum glVertexAttribArrayType(GlEnumFactory self){ return makeEnum(GL_VERTEX_ATTRIB_ARRAY_TYPE); }
  GlEnum glVertexAttribArrayNormalized(GlEnumFactory self){ return makeEnum(GL_VERTEX_ATTRIB_ARRAY_NORMALIZED); }
  GlEnum glVertexAttribArrayPointer(GlEnumFactory self){ return makeEnum(GL_VERTEX_ATTRIB_ARRAY_POINTER); }
  GlEnum glVertexAttribArrayBufferBinding(GlEnumFactory self){ return makeEnum(GL_VERTEX_ATTRIB_ARRAY_BUFFER_BINDING); }

// Shader Source
  GlEnum glCompileStatus(GlEnumFactory self){ return makeEnum(GL_COMPILE_STATUS); }

// Shader Precision-Specified Types
  GlEnum glLowFloat(GlEnumFactory self){ return makeEnum(GL_LOW_FLOAT); }
  GlEnum glMediumFloat(GlEnumFactory self){ return makeEnum(GL_MEDIUM_FLOAT); }
  GlEnum glHighFloat(GlEnumFactory self){ return makeEnum(GL_HIGH_FLOAT); }
  GlEnum glLowInt(GlEnumFactory self){ return makeEnum(GL_LOW_INT); }
  GlEnum glMediumInt(GlEnumFactory self){ return makeEnum(GL_MEDIUM_INT); }
  GlEnum glHighInt(GlEnumFactory self){ return makeEnum(GL_HIGH_INT); }

// Framebuffer Object.
  GlEnum glFramebuffer(GlEnumFactory self){ return makeEnum(GL_FRAMEBUFFER); }
  GlEnum glRenderbuffer(GlEnumFactory self){ return makeEnum(GL_RENDERBUFFER); }

  GlEnum glRgba4(GlEnumFactory self){ return makeEnum(GL_RGBA4); }
  GlEnum glRgb5A1(GlEnumFactory self){ return makeEnum(GL_RGB5_A1); }
  GlEnum glRgb565(GlEnumFactory self){ return makeEnum(0x8D62); }//0x8D62
  GlEnum glDepthComponent16(GlEnumFactory self){ return makeEnum(GL_DEPTH_COMPONENT16); }
  GlEnum glStencilIndex(GlEnumFactory self){ return makeEnum(GL_STENCIL_INDEX); }
  GlEnum glStencilIndex8(GlEnumFactory self){ return makeEnum(GL_STENCIL_INDEX8); }
  GlEnum glDepthStencil(GlEnumFactory self){ return makeEnum(GL_DEPTH_STENCIL); }

  GlEnum glRenderbufferWidth(GlEnumFactory self){ return makeEnum(GL_RENDERBUFFER_WIDTH); }
  GlEnum glRenderbufferHeight(GlEnumFactory self){ return makeEnum(GL_RENDERBUFFER_HEIGHT); }
  GlEnum glRenderbufferInternalFormat(GlEnumFactory self){ return makeEnum(GL_RENDERBUFFER_INTERNAL_FORMAT); }
  GlEnum glRenderbufferRedSize(GlEnumFactory self){ return makeEnum(GL_RENDERBUFFER_RED_SIZE); }
  GlEnum glRenderbufferGreenSize(GlEnumFactory self){ return makeEnum(GL_RENDERBUFFER_GREEN_SIZE); }
  GlEnum glRenderbufferBlueSize(GlEnumFactory self){ return makeEnum(GL_RENDERBUFFER_BLUE_SIZE); }
  GlEnum glRenderbufferAlphaSize(GlEnumFactory self){ return makeEnum(GL_RENDERBUFFER_ALPHA_SIZE); }
  GlEnum glRenderbufferDepthSize(GlEnumFactory self){ return makeEnum(GL_RENDERBUFFER_DEPTH_SIZE); }
  GlEnum glRenderbufferStencilSize(GlEnumFactory self){ return makeEnum(GL_RENDERBUFFER_STENCIL_SIZE); }

  GlEnum glFramebufferAttachmentObjectType(GlEnumFactory self){ return makeEnum(GL_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE); }
  GlEnum glFramebufferAttachmentObjectName(GlEnumFactory self){ return makeEnum(GL_FRAMEBUFFER_ATTACHMENT_OBJECT_NAME); }
  GlEnum glFramebufferAttachmentTextureLevel(GlEnumFactory self){ return makeEnum(GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LEVEL); }
  GlEnum glFramebufferAttachmentTextureCubeMapFace(GlEnumFactory self){ return makeEnum(GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_CUBE_MAP_FACE); }

  GlEnum glColorAttachment0(GlEnumFactory self){ return makeEnum(GL_COLOR_ATTACHMENT0); }
  GlEnum glDepthAttachment(GlEnumFactory self){ return makeEnum(GL_DEPTH_ATTACHMENT); }
  GlEnum glStencilAttachment(GlEnumFactory self){ return makeEnum(GL_STENCIL_ATTACHMENT); }
  GlEnum glDepthStencilAttachment(GlEnumFactory self){ return makeEnum(GL_DEPTH_STENCIL_ATTACHMENT); }

  GlEnum glNone(GlEnumFactory self){ return makeEnum(GL_NONE); }

  GlEnum glFramebufferComplete(GlEnumFactory self){ return makeEnum(GL_FRAMEBUFFER_COMPLETE); }
  GlEnum glFramebufferIncompleteAttachment(GlEnumFactory self){ return makeEnum(GL_FRAMEBUFFER_INCOMPLETE_ATTACHMENT); }
  GlEnum glFramebufferIncompleteMissingAttachment(GlEnumFactory self){ return makeEnum(GL_FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT); }
  GlEnum glFramebufferIncompleteDimensions(GlEnumFactory self){ return makeEnum(org.lwjgl.opengl.EXTFramebufferObject.GL_FRAMEBUFFER_INCOMPLETE_DIMENSIONS_EXT); }
  GlEnum glFramebufferUnsupported(GlEnumFactory self){ return makeEnum(GL_FRAMEBUFFER_UNSUPPORTED); }

  GlEnum glFramebufferBinding(GlEnumFactory self){ return makeEnum(GL_FRAMEBUFFER_BINDING); }
  GlEnum glRenderbufferBinding(GlEnumFactory self){ return makeEnum(GL_RENDERBUFFER_BINDING); }
  GlEnum glMaxRenderbufferSize(GlEnumFactory self){ return makeEnum(GL_MAX_RENDERBUFFER_SIZE); }

  GlEnum glInvalidFramebufferOperation(GlEnumFactory self){ return makeEnum(GL_INVALID_FRAMEBUFFER_OPERATION); }

/* WebGL-specific enums
  GlEnum glUnpackFlipYWebgl(GlEnumFactory self){ return makeEnum(GL_UNPACK_FLIP_Y_WEBGL); }
  GlEnum glUnpackPremultiplyAlphaWebgl(GlEnumFactory self){ return makeEnum(GL_UNPACK_PREMULTIPLY_ALPHA_WEBGL); }
  GlEnum glContextLostWebgl(GlEnumFactory self){ return makeEnum(GL_CONTEXT_LOST_WEBGL); }
  GlEnum glUnpackColorspaceConversionWebgl(GlEnumFactory self){ return makeEnum(GL_UNPACK_COLORSPACE_CONVERSION_WEBGL); }
  GlEnum glBrowserDefaultWebgl(GlEnumFactory self){ return makeEnum(GL_BROWSER_DEFAULT_WEBGL); }
*/
}