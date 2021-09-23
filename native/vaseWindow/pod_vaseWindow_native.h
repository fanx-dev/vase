#include "fni_ext.h"
CF_BEGIN

fr_Obj vaseWindow_NClipboard_getTextSync(fr_Env env, fr_Obj self);
void vaseWindow_NClipboard_setText(fr_Env env, fr_Obj self, fr_Obj data);
void vaseWindow_NEditText_close(fr_Env env, fr_Obj self);
void vaseWindow_NEditText_setPos(fr_Env env, fr_Obj self, fr_Int x, fr_Int y, fr_Int w, fr_Int h);
void vaseWindow_NEditText_setStyle(fr_Env env, fr_Obj self, fr_Obj font, fr_Obj textColor, fr_Obj backgroundColor);
void vaseWindow_NEditText_setText(fr_Env env, fr_Obj self, fr_Obj text);
void vaseWindow_NEditText_setType(fr_Env env, fr_Obj self, fr_Int multiLine, fr_Bool editable);
void vaseWindow_NEditText_focus(fr_Env env, fr_Obj self);
void vaseWindow_NEditText_select(fr_Env env, fr_Obj self, fr_Int start, fr_Int end);
fr_Int vaseWindow_NEditText_caretPos(fr_Env env, fr_Obj self);
fr_Obj vaseWindow_Toolkit_cur(fr_Env env);
fr_Obj vaseWindow_NToolkit_window(fr_Env env, fr_Obj self, fr_Obj view);
void vaseWindow_NToolkit_callLater(fr_Env env, fr_Obj self, fr_Int delay, fr_Obj f);
fr_Int vaseWindow_NToolkit_dpi(fr_Env env, fr_Obj self);
fr_Bool vaseWindow_NToolkit_openUri(fr_Env env, fr_Obj self, fr_Obj uri, fr_Obj options);
void vaseWindow_NWindow_repaint(fr_Env env, fr_Obj self, fr_Obj dirty);
void vaseWindow_NWindow_show(fr_Env env, fr_Obj self, fr_Obj size);
fr_Int vaseWindow_NWindow_x(fr_Env env, fr_Obj self);
fr_Int vaseWindow_NWindow_y(fr_Env env, fr_Obj self);
fr_Int vaseWindow_NWindow_w(fr_Env env, fr_Obj self);
fr_Int vaseWindow_NWindow_h(fr_Env env, fr_Obj self);
fr_Bool vaseWindow_NWindow_hasFocus(fr_Env env, fr_Obj self);
void vaseWindow_NWindow_focus(fr_Env env, fr_Obj self);
void vaseWindow_NWindow_textInput(fr_Env env, fr_Obj self, fr_Obj edit);
void vaseWindow_NWindow_fileDialog(fr_Env env, fr_Obj self, fr_Obj accept, fr_Obj f, fr_Obj options);
void vaseWindow_NWindow_finalize(fr_Env env, fr_Obj self);
void vaseWindow_NFont_dispose(fr_Env env, fr_Obj self);
fr_Int vaseWindow_NFont_height(fr_Env env, fr_Obj self);
fr_Int vaseWindow_NFont_ascent(fr_Env env, fr_Obj self);
fr_Int vaseWindow_NFont_descent(fr_Env env, fr_Obj self);
fr_Int vaseWindow_NFont_width(fr_Env env, fr_Obj self, fr_Obj s);
void vaseWindow_NGfxEnv_initFont(fr_Env env, fr_Obj self, fr_Obj font);
fr_Obj vaseWindow_NGfxEnv_allocImage(fr_Env env, fr_Obj self, fr_Int w, fr_Int h);
fr_Obj vaseWindow_NGfxEnv_fromStream(fr_Env env, fr_Obj self, fr_Obj in);
fr_Bool vaseWindow_NGfxEnv_contains(fr_Env env, fr_Obj self, fr_Obj path, fr_Float x, fr_Float y);
void vaseWindow_NGfxEnv_finalize(fr_Env env, fr_Obj self);
void vaseWindow_NGraphics_init(fr_Env env, fr_Obj self);
void vaseWindow_NGraphics_setColor(fr_Env env, fr_Obj self, fr_Int a, fr_Int r, fr_Int g, fr_Int b);
void vaseWindow_NGraphics_setPattern(fr_Env env, fr_Obj self, fr_Obj pattern);
void vaseWindow_NGraphics_setGradient(fr_Env env, fr_Obj self, fr_Obj gradient);
void vaseWindow_NGraphics_setPen(fr_Env env, fr_Obj self, fr_Int width, fr_Int cap, fr_Int join, fr_Obj dash);
void vaseWindow_NGraphics_setFont(fr_Env env, fr_Obj self, fr_Obj font, fr_Int id, fr_Obj name, fr_Int size, fr_Int blur);
void vaseWindow_NGraphics_setAntialias(fr_Env env, fr_Obj self, fr_Bool antialias);
void vaseWindow_NGraphics_setAlpha(fr_Env env, fr_Obj self, fr_Int alpha);
void vaseWindow_NGraphics_setComposite(fr_Env env, fr_Obj self, fr_Int composite);
fr_Obj vaseWindow_NGraphics_drawLine(fr_Env env, fr_Obj self, fr_Int x1, fr_Int y1, fr_Int x2, fr_Int y2);
fr_Obj vaseWindow_NGraphics_drawPolyline(fr_Env env, fr_Obj self, fr_Obj ps);
fr_Obj vaseWindow_NGraphics_drawPolygon(fr_Env env, fr_Obj self, fr_Obj ps);
fr_Obj vaseWindow_NGraphics_fillPolygon(fr_Env env, fr_Obj self, fr_Obj ps);
fr_Obj vaseWindow_NGraphics_drawRect(fr_Env env, fr_Obj self, fr_Int x, fr_Int y, fr_Int w, fr_Int h);
fr_Obj vaseWindow_NGraphics_fillRect(fr_Env env, fr_Obj self, fr_Int x, fr_Int y, fr_Int w, fr_Int h);
fr_Obj vaseWindow_NGraphics_clearRect(fr_Env env, fr_Obj self, fr_Int x, fr_Int y, fr_Int w, fr_Int h);
fr_Obj vaseWindow_NGraphics_drawRoundRect(fr_Env env, fr_Obj self, fr_Int x, fr_Int y, fr_Int w, fr_Int h, fr_Int wArc, fr_Int hArc);
fr_Obj vaseWindow_NGraphics_fillRoundRect(fr_Env env, fr_Obj self, fr_Int x, fr_Int y, fr_Int w, fr_Int h, fr_Int wArc, fr_Int hArc);
fr_Obj vaseWindow_NGraphics_drawOval(fr_Env env, fr_Obj self, fr_Int x, fr_Int y, fr_Int w, fr_Int h);
fr_Obj vaseWindow_NGraphics_fillOval(fr_Env env, fr_Obj self, fr_Int x, fr_Int y, fr_Int w, fr_Int h);
fr_Obj vaseWindow_NGraphics_drawArc(fr_Env env, fr_Obj self, fr_Int x, fr_Int y, fr_Int w, fr_Int h, fr_Int startAngle, fr_Int arcAngle);
fr_Obj vaseWindow_NGraphics_fillArc(fr_Env env, fr_Obj self, fr_Int x, fr_Int y, fr_Int w, fr_Int h, fr_Int startAngle, fr_Int arcAngle);
fr_Obj vaseWindow_NGraphics_drawText(fr_Env env, fr_Obj self, fr_Obj s, fr_Int x, fr_Int y);
void vaseWindow_NGraphics_doDrawImage(fr_Env env, fr_Obj self, fr_Obj image, fr_Int srcX, fr_Int srcY, fr_Int srcW, fr_Int srcH, fr_Int dstX, fr_Int dstY, fr_Int dstW, fr_Int dstH);
void vaseWindow_NGraphics_doClip(fr_Env env, fr_Obj self, fr_Int x, fr_Int y, fr_Int w, fr_Int h);
void vaseWindow_NGraphics_pushNative(fr_Env env, fr_Obj self);
void vaseWindow_NGraphics_popNative(fr_Env env, fr_Obj self);
void vaseWindow_NGraphics_dispose(fr_Env env, fr_Obj self);
fr_Obj vaseWindow_NGraphics_drawPath(fr_Env env, fr_Obj self, fr_Obj path);
fr_Obj vaseWindow_NGraphics_fillPath(fr_Env env, fr_Obj self, fr_Obj path);
void vaseWindow_NGraphics_doTransform(fr_Env env, fr_Obj self, fr_Float a, fr_Float b, fr_Float c, fr_Float d, fr_Float e, fr_Float f);
fr_Obj vaseWindow_NGraphics_clipPath(fr_Env env, fr_Obj self, fr_Obj path);
fr_Obj vaseWindow_NGraphics_setShadow(fr_Env env, fr_Obj self, fr_Obj shadow);
fr_Int vaseWindow_NImage_getPixel(fr_Env env, fr_Obj self, fr_Int x, fr_Int y);
void vaseWindow_NImage_setPixel(fr_Env env, fr_Obj self, fr_Int x, fr_Int y, fr_Int p);
void vaseWindow_NImage_save(fr_Env env, fr_Obj self, fr_Obj out, fr_Obj format);
fr_Obj vaseWindow_NImage_createGraphics(fr_Env env, fr_Obj self);
void vaseWindow_NImage_dispose(fr_Env env, fr_Obj self);
void vaseWindow_NImage_finalize(fr_Env env, fr_Obj self);

CF_END