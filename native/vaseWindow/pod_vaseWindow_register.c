#include "fni_ext.h"

void vaseWindow_NWindow_repaint_v(fr_Env env, void *param, void *ret);
void vaseWindow_NWindow_show_v(fr_Env env, void *param, void *ret);
void vaseWindow_NWindow_x_v(fr_Env env, void *param, void *ret);
void vaseWindow_NWindow_y_v(fr_Env env, void *param, void *ret);
void vaseWindow_NWindow_w_v(fr_Env env, void *param, void *ret);
void vaseWindow_NWindow_h_v(fr_Env env, void *param, void *ret);
void vaseWindow_NWindow_hasFocus_v(fr_Env env, void *param, void *ret);
void vaseWindow_NWindow_focus_v(fr_Env env, void *param, void *ret);
void vaseWindow_NWindow_fileDialog_v(fr_Env env, void *param, void *ret);
void vaseWindow_NWindow_finalize_v(fr_Env env, void *param, void *ret);
void vaseWindow_NClipboard_getTextSync_v(fr_Env env, void *param, void *ret);
void vaseWindow_NClipboard_setText_v(fr_Env env, void *param, void *ret);
void vaseWindow_NEditText_init_v(fr_Env env, void *param, void *ret);
void vaseWindow_NEditText_close_v(fr_Env env, void *param, void *ret);
void vaseWindow_NEditText_setPos_v(fr_Env env, void *param, void *ret);
void vaseWindow_NEditText_doSetStyle_v(fr_Env env, void *param, void *ret);
void vaseWindow_NEditText_setText_v(fr_Env env, void *param, void *ret);
void vaseWindow_NEditText_setType_v(fr_Env env, void *param, void *ret);
void vaseWindow_NEditText_focus_v(fr_Env env, void *param, void *ret);
void vaseWindow_NEditText_select_v(fr_Env env, void *param, void *ret);
void vaseWindow_NEditText_caretPos_v(fr_Env env, void *param, void *ret);
void vaseWindow_NEditText_finalize_v(fr_Env env, void *param, void *ret);
void vaseWindow_Toolkit_cur_v(fr_Env env, void *param, void *ret);
void vaseWindow_NToolkit_window_v(fr_Env env, void *param, void *ret);
void vaseWindow_NToolkit_callLater_v(fr_Env env, void *param, void *ret);
void vaseWindow_NToolkit_dpi_v(fr_Env env, void *param, void *ret);
void vaseWindow_NToolkit_openUri_v(fr_Env env, void *param, void *ret);
void vaseWindow_NToolkit_resFilePath_v(fr_Env env, void *param, void *ret);
void vaseWindow_NImage_getPixel_v(fr_Env env, void *param, void *ret);
void vaseWindow_NImage_setPixel_v(fr_Env env, void *param, void *ret);
void vaseWindow_NImage_save_v(fr_Env env, void *param, void *ret);
void vaseWindow_NImage_createGraphics_v(fr_Env env, void *param, void *ret);
void vaseWindow_NImage_dispose_v(fr_Env env, void *param, void *ret);
void vaseWindow_NImage_finalize_v(fr_Env env, void *param, void *ret);
void vaseWindow_NGfxEnv_initFont_v(fr_Env env, void *param, void *ret);
void vaseWindow_NGfxEnv_allocImage_v(fr_Env env, void *param, void *ret);
void vaseWindow_NGfxEnv_fromStream_v(fr_Env env, void *param, void *ret);
void vaseWindow_NGfxEnv_contains_v(fr_Env env, void *param, void *ret);
void vaseWindow_NGfxEnv_finalize_v(fr_Env env, void *param, void *ret);
void vaseWindow_NFont_dispose_v(fr_Env env, void *param, void *ret);
void vaseWindow_NFont_ascent_v(fr_Env env, void *param, void *ret);
void vaseWindow_NFont_descent_v(fr_Env env, void *param, void *ret);
void vaseWindow_NFont_leading_v(fr_Env env, void *param, void *ret);
void vaseWindow_NFont_width_v(fr_Env env, void *param, void *ret);
void vaseWindow_NFont_finalize_v(fr_Env env, void *param, void *ret);
void vaseWindow_NGraphics_init_v(fr_Env env, void *param, void *ret);
void vaseWindow_NGraphics_setColor_v(fr_Env env, void *param, void *ret);
void vaseWindow_NGraphics_setPattern_v(fr_Env env, void *param, void *ret);
void vaseWindow_NGraphics_setGradient_v(fr_Env env, void *param, void *ret);
void vaseWindow_NGraphics_setPen_v(fr_Env env, void *param, void *ret);
void vaseWindow_NGraphics_setFont_v(fr_Env env, void *param, void *ret);
void vaseWindow_NGraphics_setAntialias_v(fr_Env env, void *param, void *ret);
void vaseWindow_NGraphics_setAlpha_v(fr_Env env, void *param, void *ret);
void vaseWindow_NGraphics_setComposite_v(fr_Env env, void *param, void *ret);
void vaseWindow_NGraphics_drawLine_v(fr_Env env, void *param, void *ret);
void vaseWindow_NGraphics_drawPolyline_v(fr_Env env, void *param, void *ret);
void vaseWindow_NGraphics_drawPolygon_v(fr_Env env, void *param, void *ret);
void vaseWindow_NGraphics_fillPolygon_v(fr_Env env, void *param, void *ret);
void vaseWindow_NGraphics_drawRect_v(fr_Env env, void *param, void *ret);
void vaseWindow_NGraphics_fillRect_v(fr_Env env, void *param, void *ret);
void vaseWindow_NGraphics_clearRect_v(fr_Env env, void *param, void *ret);
void vaseWindow_NGraphics_drawRoundRect_v(fr_Env env, void *param, void *ret);
void vaseWindow_NGraphics_fillRoundRect_v(fr_Env env, void *param, void *ret);
void vaseWindow_NGraphics_drawOval_v(fr_Env env, void *param, void *ret);
void vaseWindow_NGraphics_fillOval_v(fr_Env env, void *param, void *ret);
void vaseWindow_NGraphics_drawArc_v(fr_Env env, void *param, void *ret);
void vaseWindow_NGraphics_fillArc_v(fr_Env env, void *param, void *ret);
void vaseWindow_NGraphics_drawText_v(fr_Env env, void *param, void *ret);
void vaseWindow_NGraphics_doDrawImage_v(fr_Env env, void *param, void *ret);
void vaseWindow_NGraphics_doClip_v(fr_Env env, void *param, void *ret);
void vaseWindow_NGraphics_pushNative_v(fr_Env env, void *param, void *ret);
void vaseWindow_NGraphics_popNative_v(fr_Env env, void *param, void *ret);
void vaseWindow_NGraphics_dispose_v(fr_Env env, void *param, void *ret);
void vaseWindow_NGraphics_drawPath_v(fr_Env env, void *param, void *ret);
void vaseWindow_NGraphics_fillPath_v(fr_Env env, void *param, void *ret);
void vaseWindow_NGraphics_doTransform_v(fr_Env env, void *param, void *ret);
void vaseWindow_NGraphics_clipPath_v(fr_Env env, void *param, void *ret);
void vaseWindow_NGraphics_doSetShadow_v(fr_Env env, void *param, void *ret);

void vaseWindow_register(fr_Fvm vm) {
    fr_registerMethod(vm, "vaseWindow_NWindow_repaint", vaseWindow_NWindow_repaint_v);
    fr_registerMethod(vm, "vaseWindow_NWindow_show", vaseWindow_NWindow_show_v);
    fr_registerMethod(vm, "vaseWindow_NWindow_x", vaseWindow_NWindow_x_v);
    fr_registerMethod(vm, "vaseWindow_NWindow_y", vaseWindow_NWindow_y_v);
    fr_registerMethod(vm, "vaseWindow_NWindow_w", vaseWindow_NWindow_w_v);
    fr_registerMethod(vm, "vaseWindow_NWindow_h", vaseWindow_NWindow_h_v);
    fr_registerMethod(vm, "vaseWindow_NWindow_hasFocus", vaseWindow_NWindow_hasFocus_v);
    fr_registerMethod(vm, "vaseWindow_NWindow_focus", vaseWindow_NWindow_focus_v);
    fr_registerMethod(vm, "vaseWindow_NWindow_fileDialog", vaseWindow_NWindow_fileDialog_v);
    fr_registerMethod(vm, "vaseWindow_NWindow_finalize", vaseWindow_NWindow_finalize_v);
    fr_registerMethod(vm, "vaseWindow_NClipboard_getTextSync", vaseWindow_NClipboard_getTextSync_v);
    fr_registerMethod(vm, "vaseWindow_NClipboard_setText", vaseWindow_NClipboard_setText_v);
    fr_registerMethod(vm, "vaseWindow_NEditText_init", vaseWindow_NEditText_init_v);
    fr_registerMethod(vm, "vaseWindow_NEditText_close", vaseWindow_NEditText_close_v);
    fr_registerMethod(vm, "vaseWindow_NEditText_setPos", vaseWindow_NEditText_setPos_v);
    fr_registerMethod(vm, "vaseWindow_NEditText_doSetStyle", vaseWindow_NEditText_doSetStyle_v);
    fr_registerMethod(vm, "vaseWindow_NEditText_setText", vaseWindow_NEditText_setText_v);
    fr_registerMethod(vm, "vaseWindow_NEditText_setType", vaseWindow_NEditText_setType_v);
    fr_registerMethod(vm, "vaseWindow_NEditText_focus", vaseWindow_NEditText_focus_v);
    fr_registerMethod(vm, "vaseWindow_NEditText_select", vaseWindow_NEditText_select_v);
    fr_registerMethod(vm, "vaseWindow_NEditText_caretPos", vaseWindow_NEditText_caretPos_v);
    fr_registerMethod(vm, "vaseWindow_NEditText_finalize", vaseWindow_NEditText_finalize_v);
    fr_registerMethod(vm, "vaseWindow_Toolkit_cur", vaseWindow_Toolkit_cur_v);
    fr_registerMethod(vm, "vaseWindow_NToolkit_window", vaseWindow_NToolkit_window_v);
    fr_registerMethod(vm, "vaseWindow_NToolkit_callLater", vaseWindow_NToolkit_callLater_v);
    fr_registerMethod(vm, "vaseWindow_NToolkit_dpi", vaseWindow_NToolkit_dpi_v);
    fr_registerMethod(vm, "vaseWindow_NToolkit_openUri", vaseWindow_NToolkit_openUri_v);
    fr_registerMethod(vm, "vaseWindow_NToolkit_resFilePath", vaseWindow_NToolkit_resFilePath_v);
    fr_registerMethod(vm, "vaseWindow_NImage_getPixel", vaseWindow_NImage_getPixel_v);
    fr_registerMethod(vm, "vaseWindow_NImage_setPixel", vaseWindow_NImage_setPixel_v);
    fr_registerMethod(vm, "vaseWindow_NImage_save", vaseWindow_NImage_save_v);
    fr_registerMethod(vm, "vaseWindow_NImage_createGraphics", vaseWindow_NImage_createGraphics_v);
    fr_registerMethod(vm, "vaseWindow_NImage_dispose", vaseWindow_NImage_dispose_v);
    fr_registerMethod(vm, "vaseWindow_NImage_finalize", vaseWindow_NImage_finalize_v);
    fr_registerMethod(vm, "vaseWindow_NGfxEnv_initFont", vaseWindow_NGfxEnv_initFont_v);
    fr_registerMethod(vm, "vaseWindow_NGfxEnv_allocImage", vaseWindow_NGfxEnv_allocImage_v);
    fr_registerMethod(vm, "vaseWindow_NGfxEnv_fromStream", vaseWindow_NGfxEnv_fromStream_v);
    fr_registerMethod(vm, "vaseWindow_NGfxEnv_contains", vaseWindow_NGfxEnv_contains_v);
    fr_registerMethod(vm, "vaseWindow_NGfxEnv_finalize", vaseWindow_NGfxEnv_finalize_v);
    fr_registerMethod(vm, "vaseWindow_NFont_dispose", vaseWindow_NFont_dispose_v);
    fr_registerMethod(vm, "vaseWindow_NFont_ascent", vaseWindow_NFont_ascent_v);
    fr_registerMethod(vm, "vaseWindow_NFont_descent", vaseWindow_NFont_descent_v);
    fr_registerMethod(vm, "vaseWindow_NFont_leading", vaseWindow_NFont_leading_v);
    fr_registerMethod(vm, "vaseWindow_NFont_width", vaseWindow_NFont_width_v);
    fr_registerMethod(vm, "vaseWindow_NFont_finalize", vaseWindow_NFont_finalize_v);
    fr_registerMethod(vm, "vaseWindow_NGraphics_init", vaseWindow_NGraphics_init_v);
    fr_registerMethod(vm, "vaseWindow_NGraphics_setColor", vaseWindow_NGraphics_setColor_v);
    fr_registerMethod(vm, "vaseWindow_NGraphics_setPattern", vaseWindow_NGraphics_setPattern_v);
    fr_registerMethod(vm, "vaseWindow_NGraphics_setGradient", vaseWindow_NGraphics_setGradient_v);
    fr_registerMethod(vm, "vaseWindow_NGraphics_setPen", vaseWindow_NGraphics_setPen_v);
    fr_registerMethod(vm, "vaseWindow_NGraphics_setFont", vaseWindow_NGraphics_setFont_v);
    fr_registerMethod(vm, "vaseWindow_NGraphics_setAntialias", vaseWindow_NGraphics_setAntialias_v);
    fr_registerMethod(vm, "vaseWindow_NGraphics_setAlpha", vaseWindow_NGraphics_setAlpha_v);
    fr_registerMethod(vm, "vaseWindow_NGraphics_setComposite", vaseWindow_NGraphics_setComposite_v);
    fr_registerMethod(vm, "vaseWindow_NGraphics_drawLine", vaseWindow_NGraphics_drawLine_v);
    fr_registerMethod(vm, "vaseWindow_NGraphics_drawPolyline", vaseWindow_NGraphics_drawPolyline_v);
    fr_registerMethod(vm, "vaseWindow_NGraphics_drawPolygon", vaseWindow_NGraphics_drawPolygon_v);
    fr_registerMethod(vm, "vaseWindow_NGraphics_fillPolygon", vaseWindow_NGraphics_fillPolygon_v);
    fr_registerMethod(vm, "vaseWindow_NGraphics_drawRect", vaseWindow_NGraphics_drawRect_v);
    fr_registerMethod(vm, "vaseWindow_NGraphics_fillRect", vaseWindow_NGraphics_fillRect_v);
    fr_registerMethod(vm, "vaseWindow_NGraphics_clearRect", vaseWindow_NGraphics_clearRect_v);
    fr_registerMethod(vm, "vaseWindow_NGraphics_drawRoundRect", vaseWindow_NGraphics_drawRoundRect_v);
    fr_registerMethod(vm, "vaseWindow_NGraphics_fillRoundRect", vaseWindow_NGraphics_fillRoundRect_v);
    fr_registerMethod(vm, "vaseWindow_NGraphics_drawOval", vaseWindow_NGraphics_drawOval_v);
    fr_registerMethod(vm, "vaseWindow_NGraphics_fillOval", vaseWindow_NGraphics_fillOval_v);
    fr_registerMethod(vm, "vaseWindow_NGraphics_drawArc", vaseWindow_NGraphics_drawArc_v);
    fr_registerMethod(vm, "vaseWindow_NGraphics_fillArc", vaseWindow_NGraphics_fillArc_v);
    fr_registerMethod(vm, "vaseWindow_NGraphics_drawText", vaseWindow_NGraphics_drawText_v);
    fr_registerMethod(vm, "vaseWindow_NGraphics_doDrawImage", vaseWindow_NGraphics_doDrawImage_v);
    fr_registerMethod(vm, "vaseWindow_NGraphics_doClip", vaseWindow_NGraphics_doClip_v);
    fr_registerMethod(vm, "vaseWindow_NGraphics_pushNative", vaseWindow_NGraphics_pushNative_v);
    fr_registerMethod(vm, "vaseWindow_NGraphics_popNative", vaseWindow_NGraphics_popNative_v);
    fr_registerMethod(vm, "vaseWindow_NGraphics_dispose", vaseWindow_NGraphics_dispose_v);
    fr_registerMethod(vm, "vaseWindow_NGraphics_drawPath", vaseWindow_NGraphics_drawPath_v);
    fr_registerMethod(vm, "vaseWindow_NGraphics_fillPath", vaseWindow_NGraphics_fillPath_v);
    fr_registerMethod(vm, "vaseWindow_NGraphics_doTransform", vaseWindow_NGraphics_doTransform_v);
    fr_registerMethod(vm, "vaseWindow_NGraphics_clipPath", vaseWindow_NGraphics_clipPath_v);
    fr_registerMethod(vm, "vaseWindow_NGraphics_doSetShadow", vaseWindow_NGraphics_doSetShadow_v);
}
