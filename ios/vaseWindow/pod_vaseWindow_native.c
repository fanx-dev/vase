#ifdef FR_VM
#include "pod_vaseWindow_native.h"

void vaseWindow_Sound_play_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 
    fr_Value value_1;
    fr_Int arg_1; 
    fr_Value value_2;
    fr_Obj arg_2; 
    fr_Value retValue;

    fr_getParam(env, param, &value_2, 2, NULL);
    arg_2 = value_2.h;

    fr_getParam(env, param, &value_1, 1, NULL);
    arg_1 = value_1.i;

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    retValue.b = vaseWindow_Sound_play(env, arg_0, arg_1, arg_2);
    *((fr_Value*)ret) = retValue;
}

void vaseWindow_Sound_pause_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    vaseWindow_Sound_pause(env, arg_0);
}

void vaseWindow_Sound_doLoad_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    vaseWindow_Sound_doLoad(env, arg_0);
}

void vaseWindow_Sound_finalize_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    vaseWindow_Sound_finalize(env, arg_0);
}

void vaseWindow_Speech_init_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    vaseWindow_Speech_init(env, arg_0);
}

void vaseWindow_Speech_speak_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 
    fr_Value value_1;
    fr_Obj arg_1; 
    fr_Value value_2;
    fr_Obj arg_2; 
    fr_Value retValue;

    fr_getParam(env, param, &value_2, 2, NULL);
    arg_2 = value_2.h;

    fr_getParam(env, param, &value_1, 1, NULL);
    arg_1 = value_1.h;

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    retValue.b = vaseWindow_Speech_speak(env, arg_0, arg_1, arg_2);
    *((fr_Value*)ret) = retValue;
}

void vaseWindow_Speech_finalize_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    vaseWindow_Speech_finalize(env, arg_0);
}

void vaseWindow_Video_play_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 
    fr_Value value_1;
    fr_Int arg_1; 
    fr_Value value_2;
    fr_Obj arg_2; 
    fr_Value retValue;

    fr_getParam(env, param, &value_2, 2, NULL);
    arg_2 = value_2.h;

    fr_getParam(env, param, &value_1, 1, NULL);
    arg_1 = value_1.i;

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    retValue.b = vaseWindow_Video_play(env, arg_0, arg_1, arg_2);
    *((fr_Value*)ret) = retValue;
}

void vaseWindow_Video_pause_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    vaseWindow_Video_pause(env, arg_0);
}

void vaseWindow_Video_doSetup_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 
    fr_Value value_1;
    fr_Obj arg_1; 

    fr_getParam(env, param, &value_1, 1, NULL);
    arg_1 = value_1.h;

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    vaseWindow_Video_doSetup(env, arg_0, arg_1);
}

void vaseWindow_Video_remove_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    vaseWindow_Video_remove(env, arg_0);
}

void vaseWindow_Video_finalize_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    vaseWindow_Video_finalize(env, arg_0);
}

void vaseWindow_NWindow_repaint_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 
    fr_Value value_1;
    fr_Obj arg_1; 

    fr_getParam(env, param, &value_1, 1, NULL);
    arg_1 = value_1.h;

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    vaseWindow_NWindow_repaint(env, arg_0, arg_1);
}

void vaseWindow_NWindow_show_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 
    fr_Value value_1;
    fr_Obj arg_1; 

    fr_getParam(env, param, &value_1, 1, NULL);
    arg_1 = value_1.h;

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    vaseWindow_NWindow_show(env, arg_0, arg_1);
}

void vaseWindow_NWindow_x_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 
    fr_Value retValue;

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    retValue.i = vaseWindow_NWindow_x(env, arg_0);
    *((fr_Value*)ret) = retValue;
}

void vaseWindow_NWindow_y_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 
    fr_Value retValue;

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    retValue.i = vaseWindow_NWindow_y(env, arg_0);
    *((fr_Value*)ret) = retValue;
}

void vaseWindow_NWindow_w_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 
    fr_Value retValue;

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    retValue.i = vaseWindow_NWindow_w(env, arg_0);
    *((fr_Value*)ret) = retValue;
}

void vaseWindow_NWindow_h_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 
    fr_Value retValue;

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    retValue.i = vaseWindow_NWindow_h(env, arg_0);
    *((fr_Value*)ret) = retValue;
}

void vaseWindow_NWindow_hasFocus_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 
    fr_Value retValue;

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    retValue.b = vaseWindow_NWindow_hasFocus(env, arg_0);
    *((fr_Value*)ret) = retValue;
}

void vaseWindow_NWindow_focus_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    vaseWindow_NWindow_focus(env, arg_0);
}

void vaseWindow_NWindow_fileDialog_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 
    fr_Value value_1;
    fr_Obj arg_1; 
    fr_Value value_2;
    fr_Obj arg_2; 
    fr_Value value_3;
    fr_Obj arg_3; 

    fr_getParam(env, param, &value_3, 3, NULL);
    arg_3 = value_3.h;

    fr_getParam(env, param, &value_2, 2, NULL);
    arg_2 = value_2.h;

    fr_getParam(env, param, &value_1, 1, NULL);
    arg_1 = value_1.h;

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    vaseWindow_NWindow_fileDialog(env, arg_0, arg_1, arg_2, arg_3);
}

void vaseWindow_NWindow_finalize_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    vaseWindow_NWindow_finalize(env, arg_0);
}

void vaseWindow_NClipboard_getTextSync_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 
    fr_Value retValue;

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    retValue.h = vaseWindow_NClipboard_getTextSync(env, arg_0);
    *((fr_Value*)ret) = retValue;
}

void vaseWindow_NClipboard_setText_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 
    fr_Value value_1;
    fr_Obj arg_1; 

    fr_getParam(env, param, &value_1, 1, NULL);
    arg_1 = value_1.h;

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    vaseWindow_NClipboard_setText(env, arg_0, arg_1);
}

void vaseWindow_NEditText_init_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 
    fr_Value value_1;
    fr_Int arg_1; 
    fr_Value value_2;
    fr_Int arg_2; 
    fr_Value retValue;

    fr_getParam(env, param, &value_2, 2, NULL);
    arg_2 = value_2.i;

    fr_getParam(env, param, &value_1, 1, NULL);
    arg_1 = value_1.i;

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    retValue.i = vaseWindow_NEditText_init(env, arg_0, arg_1, arg_2);
    *((fr_Value*)ret) = retValue;
}

void vaseWindow_NEditText_close_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    vaseWindow_NEditText_close(env, arg_0);
}

void vaseWindow_NEditText_setPos_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 
    fr_Value value_1;
    fr_Int arg_1; 
    fr_Value value_2;
    fr_Int arg_2; 
    fr_Value value_3;
    fr_Int arg_3; 
    fr_Value value_4;
    fr_Int arg_4; 

    fr_getParam(env, param, &value_4, 4, NULL);
    arg_4 = value_4.i;

    fr_getParam(env, param, &value_3, 3, NULL);
    arg_3 = value_3.i;

    fr_getParam(env, param, &value_2, 2, NULL);
    arg_2 = value_2.i;

    fr_getParam(env, param, &value_1, 1, NULL);
    arg_1 = value_1.i;

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    vaseWindow_NEditText_setPos(env, arg_0, arg_1, arg_2, arg_3, arg_4);
}

void vaseWindow_NEditText_doSetStyle_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 
    fr_Value value_1;
    fr_Obj arg_1; 
    fr_Value value_2;
    fr_Int arg_2; 
    fr_Value value_3;
    fr_Int arg_3; 
    fr_Value value_4;
    fr_Int arg_4; 

    fr_getParam(env, param, &value_4, 4, NULL);
    arg_4 = value_4.i;

    fr_getParam(env, param, &value_3, 3, NULL);
    arg_3 = value_3.i;

    fr_getParam(env, param, &value_2, 2, NULL);
    arg_2 = value_2.i;

    fr_getParam(env, param, &value_1, 1, NULL);
    arg_1 = value_1.h;

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    vaseWindow_NEditText_doSetStyle(env, arg_0, arg_1, arg_2, arg_3, arg_4);
}

void vaseWindow_NEditText_setText_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 
    fr_Value value_1;
    fr_Obj arg_1; 

    fr_getParam(env, param, &value_1, 1, NULL);
    arg_1 = value_1.h;

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    vaseWindow_NEditText_setText(env, arg_0, arg_1);
}

void vaseWindow_NEditText_setType_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 
    fr_Value value_1;
    fr_Int arg_1; 
    fr_Value value_2;
    fr_Bool arg_2; 

    fr_getParam(env, param, &value_2, 2, NULL);
    arg_2 = value_2.b;

    fr_getParam(env, param, &value_1, 1, NULL);
    arg_1 = value_1.i;

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    vaseWindow_NEditText_setType(env, arg_0, arg_1, arg_2);
}

void vaseWindow_NEditText_focus_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    vaseWindow_NEditText_focus(env, arg_0);
}

void vaseWindow_NEditText_select_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 
    fr_Value value_1;
    fr_Int arg_1; 
    fr_Value value_2;
    fr_Int arg_2; 

    fr_getParam(env, param, &value_2, 2, NULL);
    arg_2 = value_2.i;

    fr_getParam(env, param, &value_1, 1, NULL);
    arg_1 = value_1.i;

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    vaseWindow_NEditText_select(env, arg_0, arg_1, arg_2);
}

void vaseWindow_NEditText_caretPos_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 
    fr_Value retValue;

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    retValue.i = vaseWindow_NEditText_caretPos(env, arg_0);
    *((fr_Value*)ret) = retValue;
}

void vaseWindow_NEditText_finalize_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    vaseWindow_NEditText_finalize(env, arg_0);
}

void vaseWindow_Toolkit_cur_v(fr_Env env, void *param, void *ret) {
    fr_Value retValue;


    retValue.h = vaseWindow_Toolkit_cur(env);
    *((fr_Value*)ret) = retValue;
}

void vaseWindow_NToolkit_window_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 
    fr_Value value_1;
    fr_Obj arg_1; 
    fr_Value retValue;

    fr_getParam(env, param, &value_1, 1, NULL);
    arg_1 = value_1.h;

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    retValue.h = vaseWindow_NToolkit_window(env, arg_0, arg_1);
    *((fr_Value*)ret) = retValue;
}

void vaseWindow_NToolkit_callLater_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 
    fr_Value value_1;
    fr_Int arg_1; 
    fr_Value value_2;
    fr_Obj arg_2; 

    fr_getParam(env, param, &value_2, 2, NULL);
    arg_2 = value_2.h;

    fr_getParam(env, param, &value_1, 1, NULL);
    arg_1 = value_1.i;

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    vaseWindow_NToolkit_callLater(env, arg_0, arg_1, arg_2);
}

void vaseWindow_NToolkit_dpi_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 
    fr_Value retValue;

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    retValue.i = vaseWindow_NToolkit_dpi(env, arg_0);
    *((fr_Value*)ret) = retValue;
}

void vaseWindow_NToolkit_openUri_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 
    fr_Value value_1;
    fr_Obj arg_1; 
    fr_Value value_2;
    fr_Obj arg_2; 
    fr_Value retValue;

    fr_getParam(env, param, &value_2, 2, NULL);
    arg_2 = value_2.h;

    fr_getParam(env, param, &value_1, 1, NULL);
    arg_1 = value_1.h;

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    retValue.b = vaseWindow_NToolkit_openUri(env, arg_0, arg_1, arg_2);
    *((fr_Value*)ret) = retValue;
}

void vaseWindow_NToolkit_resFilePath_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 
    fr_Value value_1;
    fr_Obj arg_1; 
    fr_Value value_2;
    fr_Obj arg_2; 
    fr_Value retValue;

    fr_getParam(env, param, &value_2, 2, NULL);
    arg_2 = value_2.h;

    fr_getParam(env, param, &value_1, 1, NULL);
    arg_1 = value_1.h;

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    retValue.h = vaseWindow_NToolkit_resFilePath(env, arg_0, arg_1, arg_2);
    *((fr_Value*)ret) = retValue;
}

void vaseWindow_NImage_getPixel_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 
    fr_Value value_1;
    fr_Int arg_1; 
    fr_Value value_2;
    fr_Int arg_2; 
    fr_Value retValue;

    fr_getParam(env, param, &value_2, 2, NULL);
    arg_2 = value_2.i;

    fr_getParam(env, param, &value_1, 1, NULL);
    arg_1 = value_1.i;

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    retValue.i = vaseWindow_NImage_getPixel(env, arg_0, arg_1, arg_2);
    *((fr_Value*)ret) = retValue;
}

void vaseWindow_NImage_setPixel_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 
    fr_Value value_1;
    fr_Int arg_1; 
    fr_Value value_2;
    fr_Int arg_2; 
    fr_Value value_3;
    fr_Int arg_3; 

    fr_getParam(env, param, &value_3, 3, NULL);
    arg_3 = value_3.i;

    fr_getParam(env, param, &value_2, 2, NULL);
    arg_2 = value_2.i;

    fr_getParam(env, param, &value_1, 1, NULL);
    arg_1 = value_1.i;

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    vaseWindow_NImage_setPixel(env, arg_0, arg_1, arg_2, arg_3);
}

void vaseWindow_NImage_save_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 
    fr_Value value_1;
    fr_Obj arg_1; 
    fr_Value value_2;
    fr_Obj arg_2; 

    fr_getParam(env, param, &value_2, 2, NULL);
    arg_2 = value_2.h;

    fr_getParam(env, param, &value_1, 1, NULL);
    arg_1 = value_1.h;

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    vaseWindow_NImage_save(env, arg_0, arg_1, arg_2);
}

void vaseWindow_NImage_createGraphics_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 
    fr_Value retValue;

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    retValue.h = vaseWindow_NImage_createGraphics(env, arg_0);
    *((fr_Value*)ret) = retValue;
}

void vaseWindow_NImage_dispose_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    vaseWindow_NImage_dispose(env, arg_0);
}

void vaseWindow_NImage_finalize_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    vaseWindow_NImage_finalize(env, arg_0);
}

void vaseWindow_NGfxEnv_initFont_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 
    fr_Value value_1;
    fr_Obj arg_1; 

    fr_getParam(env, param, &value_1, 1, NULL);
    arg_1 = value_1.h;

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    vaseWindow_NGfxEnv_initFont(env, arg_0, arg_1);
}

void vaseWindow_NGfxEnv_allocImage_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 
    fr_Value value_1;
    fr_Int arg_1; 
    fr_Value value_2;
    fr_Int arg_2; 
    fr_Value retValue;

    fr_getParam(env, param, &value_2, 2, NULL);
    arg_2 = value_2.i;

    fr_getParam(env, param, &value_1, 1, NULL);
    arg_1 = value_1.i;

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    retValue.h = vaseWindow_NGfxEnv_allocImage(env, arg_0, arg_1, arg_2);
    *((fr_Value*)ret) = retValue;
}

void vaseWindow_NGfxEnv_fromStream_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 
    fr_Value value_1;
    fr_Obj arg_1; 
    fr_Value retValue;

    fr_getParam(env, param, &value_1, 1, NULL);
    arg_1 = value_1.h;

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    retValue.h = vaseWindow_NGfxEnv_fromStream(env, arg_0, arg_1);
    *((fr_Value*)ret) = retValue;
}

void vaseWindow_NGfxEnv_contains_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 
    fr_Value value_1;
    fr_Obj arg_1; 
    fr_Value value_2;
    fr_Float arg_2; 
    fr_Value value_3;
    fr_Float arg_3; 
    fr_Value retValue;

    fr_getParam(env, param, &value_3, 3, NULL);
    arg_3 = value_3.f;

    fr_getParam(env, param, &value_2, 2, NULL);
    arg_2 = value_2.f;

    fr_getParam(env, param, &value_1, 1, NULL);
    arg_1 = value_1.h;

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    retValue.b = vaseWindow_NGfxEnv_contains(env, arg_0, arg_1, arg_2, arg_3);
    *((fr_Value*)ret) = retValue;
}

void vaseWindow_NGfxEnv_finalize_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    vaseWindow_NGfxEnv_finalize(env, arg_0);
}

void vaseWindow_NFont_dispose_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    vaseWindow_NFont_dispose(env, arg_0);
}

void vaseWindow_NFont_ascent_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 
    fr_Value retValue;

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    retValue.i = vaseWindow_NFont_ascent(env, arg_0);
    *((fr_Value*)ret) = retValue;
}

void vaseWindow_NFont_descent_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 
    fr_Value retValue;

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    retValue.i = vaseWindow_NFont_descent(env, arg_0);
    *((fr_Value*)ret) = retValue;
}

void vaseWindow_NFont_leading_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 
    fr_Value retValue;

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    retValue.i = vaseWindow_NFont_leading(env, arg_0);
    *((fr_Value*)ret) = retValue;
}

void vaseWindow_NFont_width_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 
    fr_Value value_1;
    fr_Obj arg_1; 
    fr_Value retValue;

    fr_getParam(env, param, &value_1, 1, NULL);
    arg_1 = value_1.h;

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    retValue.i = vaseWindow_NFont_width(env, arg_0, arg_1);
    *((fr_Value*)ret) = retValue;
}

void vaseWindow_NFont_finalize_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    vaseWindow_NFont_finalize(env, arg_0);
}

void vaseWindow_NGraphics_init_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    vaseWindow_NGraphics_init(env, arg_0);
}

void vaseWindow_NGraphics_setColor_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 
    fr_Value value_1;
    fr_Int arg_1; 
    fr_Value value_2;
    fr_Int arg_2; 
    fr_Value value_3;
    fr_Int arg_3; 
    fr_Value value_4;
    fr_Int arg_4; 

    fr_getParam(env, param, &value_4, 4, NULL);
    arg_4 = value_4.i;

    fr_getParam(env, param, &value_3, 3, NULL);
    arg_3 = value_3.i;

    fr_getParam(env, param, &value_2, 2, NULL);
    arg_2 = value_2.i;

    fr_getParam(env, param, &value_1, 1, NULL);
    arg_1 = value_1.i;

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    vaseWindow_NGraphics_setColor(env, arg_0, arg_1, arg_2, arg_3, arg_4);
}

void vaseWindow_NGraphics_setPattern_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 
    fr_Value value_1;
    fr_Obj arg_1; 

    fr_getParam(env, param, &value_1, 1, NULL);
    arg_1 = value_1.h;

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    vaseWindow_NGraphics_setPattern(env, arg_0, arg_1);
}

void vaseWindow_NGraphics_setGradient_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 
    fr_Value value_1;
    fr_Obj arg_1; 

    fr_getParam(env, param, &value_1, 1, NULL);
    arg_1 = value_1.h;

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    vaseWindow_NGraphics_setGradient(env, arg_0, arg_1);
}

void vaseWindow_NGraphics_setPen_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 
    fr_Value value_1;
    fr_Int arg_1; 
    fr_Value value_2;
    fr_Int arg_2; 
    fr_Value value_3;
    fr_Int arg_3; 
    fr_Value value_4;
    fr_Obj arg_4; 

    fr_getParam(env, param, &value_4, 4, NULL);
    arg_4 = value_4.h;

    fr_getParam(env, param, &value_3, 3, NULL);
    arg_3 = value_3.i;

    fr_getParam(env, param, &value_2, 2, NULL);
    arg_2 = value_2.i;

    fr_getParam(env, param, &value_1, 1, NULL);
    arg_1 = value_1.i;

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    vaseWindow_NGraphics_setPen(env, arg_0, arg_1, arg_2, arg_3, arg_4);
}

void vaseWindow_NGraphics_setFont_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 
    fr_Value value_1;
    fr_Obj arg_1; 
    fr_Value value_2;
    fr_Int arg_2; 
    fr_Value value_3;
    fr_Obj arg_3; 
    fr_Value value_4;
    fr_Int arg_4; 
    fr_Value value_5;
    fr_Int arg_5; 

    fr_getParam(env, param, &value_5, 5, NULL);
    arg_5 = value_5.i;

    fr_getParam(env, param, &value_4, 4, NULL);
    arg_4 = value_4.i;

    fr_getParam(env, param, &value_3, 3, NULL);
    arg_3 = value_3.h;

    fr_getParam(env, param, &value_2, 2, NULL);
    arg_2 = value_2.i;

    fr_getParam(env, param, &value_1, 1, NULL);
    arg_1 = value_1.h;

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    vaseWindow_NGraphics_setFont(env, arg_0, arg_1, arg_2, arg_3, arg_4, arg_5);
}

void vaseWindow_NGraphics_setAntialias_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 
    fr_Value value_1;
    fr_Bool arg_1; 

    fr_getParam(env, param, &value_1, 1, NULL);
    arg_1 = value_1.b;

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    vaseWindow_NGraphics_setAntialias(env, arg_0, arg_1);
}

void vaseWindow_NGraphics_setAlpha_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 
    fr_Value value_1;
    fr_Int arg_1; 

    fr_getParam(env, param, &value_1, 1, NULL);
    arg_1 = value_1.i;

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    vaseWindow_NGraphics_setAlpha(env, arg_0, arg_1);
}

void vaseWindow_NGraphics_setComposite_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 
    fr_Value value_1;
    fr_Int arg_1; 

    fr_getParam(env, param, &value_1, 1, NULL);
    arg_1 = value_1.i;

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    vaseWindow_NGraphics_setComposite(env, arg_0, arg_1);
}

void vaseWindow_NGraphics_drawLine_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 
    fr_Value value_1;
    fr_Int arg_1; 
    fr_Value value_2;
    fr_Int arg_2; 
    fr_Value value_3;
    fr_Int arg_3; 
    fr_Value value_4;
    fr_Int arg_4; 
    fr_Value retValue;

    fr_getParam(env, param, &value_4, 4, NULL);
    arg_4 = value_4.i;

    fr_getParam(env, param, &value_3, 3, NULL);
    arg_3 = value_3.i;

    fr_getParam(env, param, &value_2, 2, NULL);
    arg_2 = value_2.i;

    fr_getParam(env, param, &value_1, 1, NULL);
    arg_1 = value_1.i;

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    retValue.h = vaseWindow_NGraphics_drawLine(env, arg_0, arg_1, arg_2, arg_3, arg_4);
    *((fr_Value*)ret) = retValue;
}

void vaseWindow_NGraphics_drawPolyline_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 
    fr_Value value_1;
    fr_Obj arg_1; 
    fr_Value retValue;

    fr_getParam(env, param, &value_1, 1, NULL);
    arg_1 = value_1.h;

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    retValue.h = vaseWindow_NGraphics_drawPolyline(env, arg_0, arg_1);
    *((fr_Value*)ret) = retValue;
}

void vaseWindow_NGraphics_drawPolygon_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 
    fr_Value value_1;
    fr_Obj arg_1; 
    fr_Value retValue;

    fr_getParam(env, param, &value_1, 1, NULL);
    arg_1 = value_1.h;

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    retValue.h = vaseWindow_NGraphics_drawPolygon(env, arg_0, arg_1);
    *((fr_Value*)ret) = retValue;
}

void vaseWindow_NGraphics_fillPolygon_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 
    fr_Value value_1;
    fr_Obj arg_1; 
    fr_Value retValue;

    fr_getParam(env, param, &value_1, 1, NULL);
    arg_1 = value_1.h;

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    retValue.h = vaseWindow_NGraphics_fillPolygon(env, arg_0, arg_1);
    *((fr_Value*)ret) = retValue;
}

void vaseWindow_NGraphics_drawRect_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 
    fr_Value value_1;
    fr_Int arg_1; 
    fr_Value value_2;
    fr_Int arg_2; 
    fr_Value value_3;
    fr_Int arg_3; 
    fr_Value value_4;
    fr_Int arg_4; 
    fr_Value retValue;

    fr_getParam(env, param, &value_4, 4, NULL);
    arg_4 = value_4.i;

    fr_getParam(env, param, &value_3, 3, NULL);
    arg_3 = value_3.i;

    fr_getParam(env, param, &value_2, 2, NULL);
    arg_2 = value_2.i;

    fr_getParam(env, param, &value_1, 1, NULL);
    arg_1 = value_1.i;

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    retValue.h = vaseWindow_NGraphics_drawRect(env, arg_0, arg_1, arg_2, arg_3, arg_4);
    *((fr_Value*)ret) = retValue;
}

void vaseWindow_NGraphics_fillRect_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 
    fr_Value value_1;
    fr_Int arg_1; 
    fr_Value value_2;
    fr_Int arg_2; 
    fr_Value value_3;
    fr_Int arg_3; 
    fr_Value value_4;
    fr_Int arg_4; 
    fr_Value retValue;

    fr_getParam(env, param, &value_4, 4, NULL);
    arg_4 = value_4.i;

    fr_getParam(env, param, &value_3, 3, NULL);
    arg_3 = value_3.i;

    fr_getParam(env, param, &value_2, 2, NULL);
    arg_2 = value_2.i;

    fr_getParam(env, param, &value_1, 1, NULL);
    arg_1 = value_1.i;

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    retValue.h = vaseWindow_NGraphics_fillRect(env, arg_0, arg_1, arg_2, arg_3, arg_4);
    *((fr_Value*)ret) = retValue;
}

void vaseWindow_NGraphics_clearRect_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 
    fr_Value value_1;
    fr_Int arg_1; 
    fr_Value value_2;
    fr_Int arg_2; 
    fr_Value value_3;
    fr_Int arg_3; 
    fr_Value value_4;
    fr_Int arg_4; 
    fr_Value retValue;

    fr_getParam(env, param, &value_4, 4, NULL);
    arg_4 = value_4.i;

    fr_getParam(env, param, &value_3, 3, NULL);
    arg_3 = value_3.i;

    fr_getParam(env, param, &value_2, 2, NULL);
    arg_2 = value_2.i;

    fr_getParam(env, param, &value_1, 1, NULL);
    arg_1 = value_1.i;

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    retValue.h = vaseWindow_NGraphics_clearRect(env, arg_0, arg_1, arg_2, arg_3, arg_4);
    *((fr_Value*)ret) = retValue;
}

void vaseWindow_NGraphics_drawRoundRect_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 
    fr_Value value_1;
    fr_Int arg_1; 
    fr_Value value_2;
    fr_Int arg_2; 
    fr_Value value_3;
    fr_Int arg_3; 
    fr_Value value_4;
    fr_Int arg_4; 
    fr_Value value_5;
    fr_Int arg_5; 
    fr_Value value_6;
    fr_Int arg_6; 
    fr_Value retValue;

    fr_getParam(env, param, &value_6, 6, NULL);
    arg_6 = value_6.i;

    fr_getParam(env, param, &value_5, 5, NULL);
    arg_5 = value_5.i;

    fr_getParam(env, param, &value_4, 4, NULL);
    arg_4 = value_4.i;

    fr_getParam(env, param, &value_3, 3, NULL);
    arg_3 = value_3.i;

    fr_getParam(env, param, &value_2, 2, NULL);
    arg_2 = value_2.i;

    fr_getParam(env, param, &value_1, 1, NULL);
    arg_1 = value_1.i;

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    retValue.h = vaseWindow_NGraphics_drawRoundRect(env, arg_0, arg_1, arg_2, arg_3, arg_4, arg_5, arg_6);
    *((fr_Value*)ret) = retValue;
}

void vaseWindow_NGraphics_fillRoundRect_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 
    fr_Value value_1;
    fr_Int arg_1; 
    fr_Value value_2;
    fr_Int arg_2; 
    fr_Value value_3;
    fr_Int arg_3; 
    fr_Value value_4;
    fr_Int arg_4; 
    fr_Value value_5;
    fr_Int arg_5; 
    fr_Value value_6;
    fr_Int arg_6; 
    fr_Value retValue;

    fr_getParam(env, param, &value_6, 6, NULL);
    arg_6 = value_6.i;

    fr_getParam(env, param, &value_5, 5, NULL);
    arg_5 = value_5.i;

    fr_getParam(env, param, &value_4, 4, NULL);
    arg_4 = value_4.i;

    fr_getParam(env, param, &value_3, 3, NULL);
    arg_3 = value_3.i;

    fr_getParam(env, param, &value_2, 2, NULL);
    arg_2 = value_2.i;

    fr_getParam(env, param, &value_1, 1, NULL);
    arg_1 = value_1.i;

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    retValue.h = vaseWindow_NGraphics_fillRoundRect(env, arg_0, arg_1, arg_2, arg_3, arg_4, arg_5, arg_6);
    *((fr_Value*)ret) = retValue;
}

void vaseWindow_NGraphics_drawOval_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 
    fr_Value value_1;
    fr_Int arg_1; 
    fr_Value value_2;
    fr_Int arg_2; 
    fr_Value value_3;
    fr_Int arg_3; 
    fr_Value value_4;
    fr_Int arg_4; 
    fr_Value retValue;

    fr_getParam(env, param, &value_4, 4, NULL);
    arg_4 = value_4.i;

    fr_getParam(env, param, &value_3, 3, NULL);
    arg_3 = value_3.i;

    fr_getParam(env, param, &value_2, 2, NULL);
    arg_2 = value_2.i;

    fr_getParam(env, param, &value_1, 1, NULL);
    arg_1 = value_1.i;

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    retValue.h = vaseWindow_NGraphics_drawOval(env, arg_0, arg_1, arg_2, arg_3, arg_4);
    *((fr_Value*)ret) = retValue;
}

void vaseWindow_NGraphics_fillOval_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 
    fr_Value value_1;
    fr_Int arg_1; 
    fr_Value value_2;
    fr_Int arg_2; 
    fr_Value value_3;
    fr_Int arg_3; 
    fr_Value value_4;
    fr_Int arg_4; 
    fr_Value retValue;

    fr_getParam(env, param, &value_4, 4, NULL);
    arg_4 = value_4.i;

    fr_getParam(env, param, &value_3, 3, NULL);
    arg_3 = value_3.i;

    fr_getParam(env, param, &value_2, 2, NULL);
    arg_2 = value_2.i;

    fr_getParam(env, param, &value_1, 1, NULL);
    arg_1 = value_1.i;

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    retValue.h = vaseWindow_NGraphics_fillOval(env, arg_0, arg_1, arg_2, arg_3, arg_4);
    *((fr_Value*)ret) = retValue;
}

void vaseWindow_NGraphics_drawArc_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 
    fr_Value value_1;
    fr_Int arg_1; 
    fr_Value value_2;
    fr_Int arg_2; 
    fr_Value value_3;
    fr_Int arg_3; 
    fr_Value value_4;
    fr_Int arg_4; 
    fr_Value value_5;
    fr_Int arg_5; 
    fr_Value value_6;
    fr_Int arg_6; 
    fr_Value retValue;

    fr_getParam(env, param, &value_6, 6, NULL);
    arg_6 = value_6.i;

    fr_getParam(env, param, &value_5, 5, NULL);
    arg_5 = value_5.i;

    fr_getParam(env, param, &value_4, 4, NULL);
    arg_4 = value_4.i;

    fr_getParam(env, param, &value_3, 3, NULL);
    arg_3 = value_3.i;

    fr_getParam(env, param, &value_2, 2, NULL);
    arg_2 = value_2.i;

    fr_getParam(env, param, &value_1, 1, NULL);
    arg_1 = value_1.i;

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    retValue.h = vaseWindow_NGraphics_drawArc(env, arg_0, arg_1, arg_2, arg_3, arg_4, arg_5, arg_6);
    *((fr_Value*)ret) = retValue;
}

void vaseWindow_NGraphics_fillArc_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 
    fr_Value value_1;
    fr_Int arg_1; 
    fr_Value value_2;
    fr_Int arg_2; 
    fr_Value value_3;
    fr_Int arg_3; 
    fr_Value value_4;
    fr_Int arg_4; 
    fr_Value value_5;
    fr_Int arg_5; 
    fr_Value value_6;
    fr_Int arg_6; 
    fr_Value retValue;

    fr_getParam(env, param, &value_6, 6, NULL);
    arg_6 = value_6.i;

    fr_getParam(env, param, &value_5, 5, NULL);
    arg_5 = value_5.i;

    fr_getParam(env, param, &value_4, 4, NULL);
    arg_4 = value_4.i;

    fr_getParam(env, param, &value_3, 3, NULL);
    arg_3 = value_3.i;

    fr_getParam(env, param, &value_2, 2, NULL);
    arg_2 = value_2.i;

    fr_getParam(env, param, &value_1, 1, NULL);
    arg_1 = value_1.i;

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    retValue.h = vaseWindow_NGraphics_fillArc(env, arg_0, arg_1, arg_2, arg_3, arg_4, arg_5, arg_6);
    *((fr_Value*)ret) = retValue;
}

void vaseWindow_NGraphics_drawText_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 
    fr_Value value_1;
    fr_Obj arg_1; 
    fr_Value value_2;
    fr_Int arg_2; 
    fr_Value value_3;
    fr_Int arg_3; 
    fr_Value retValue;

    fr_getParam(env, param, &value_3, 3, NULL);
    arg_3 = value_3.i;

    fr_getParam(env, param, &value_2, 2, NULL);
    arg_2 = value_2.i;

    fr_getParam(env, param, &value_1, 1, NULL);
    arg_1 = value_1.h;

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    retValue.h = vaseWindow_NGraphics_drawText(env, arg_0, arg_1, arg_2, arg_3);
    *((fr_Value*)ret) = retValue;
}

void vaseWindow_NGraphics_doDrawImage_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 
    fr_Value value_1;
    fr_Obj arg_1; 
    fr_Value value_2;
    fr_Int arg_2; 
    fr_Value value_3;
    fr_Int arg_3; 
    fr_Value value_4;
    fr_Int arg_4; 
    fr_Value value_5;
    fr_Int arg_5; 
    fr_Value value_6;
    fr_Int arg_6; 
    fr_Value value_7;
    fr_Int arg_7; 
    fr_Value value_8;
    fr_Int arg_8; 
    fr_Value value_9;
    fr_Int arg_9; 

    fr_getParam(env, param, &value_9, 9, NULL);
    arg_9 = value_9.i;

    fr_getParam(env, param, &value_8, 8, NULL);
    arg_8 = value_8.i;

    fr_getParam(env, param, &value_7, 7, NULL);
    arg_7 = value_7.i;

    fr_getParam(env, param, &value_6, 6, NULL);
    arg_6 = value_6.i;

    fr_getParam(env, param, &value_5, 5, NULL);
    arg_5 = value_5.i;

    fr_getParam(env, param, &value_4, 4, NULL);
    arg_4 = value_4.i;

    fr_getParam(env, param, &value_3, 3, NULL);
    arg_3 = value_3.i;

    fr_getParam(env, param, &value_2, 2, NULL);
    arg_2 = value_2.i;

    fr_getParam(env, param, &value_1, 1, NULL);
    arg_1 = value_1.h;

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    vaseWindow_NGraphics_doDrawImage(env, arg_0, arg_1, arg_2, arg_3, arg_4, arg_5, arg_6, arg_7, arg_8, arg_9);
}

void vaseWindow_NGraphics_doClip_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 
    fr_Value value_1;
    fr_Int arg_1; 
    fr_Value value_2;
    fr_Int arg_2; 
    fr_Value value_3;
    fr_Int arg_3; 
    fr_Value value_4;
    fr_Int arg_4; 

    fr_getParam(env, param, &value_4, 4, NULL);
    arg_4 = value_4.i;

    fr_getParam(env, param, &value_3, 3, NULL);
    arg_3 = value_3.i;

    fr_getParam(env, param, &value_2, 2, NULL);
    arg_2 = value_2.i;

    fr_getParam(env, param, &value_1, 1, NULL);
    arg_1 = value_1.i;

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    vaseWindow_NGraphics_doClip(env, arg_0, arg_1, arg_2, arg_3, arg_4);
}

void vaseWindow_NGraphics_pushNative_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    vaseWindow_NGraphics_pushNative(env, arg_0);
}

void vaseWindow_NGraphics_popNative_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    vaseWindow_NGraphics_popNative(env, arg_0);
}

void vaseWindow_NGraphics_dispose_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    vaseWindow_NGraphics_dispose(env, arg_0);
}

void vaseWindow_NGraphics_drawPath_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 
    fr_Value value_1;
    fr_Obj arg_1; 
    fr_Value retValue;

    fr_getParam(env, param, &value_1, 1, NULL);
    arg_1 = value_1.h;

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    retValue.h = vaseWindow_NGraphics_drawPath(env, arg_0, arg_1);
    *((fr_Value*)ret) = retValue;
}

void vaseWindow_NGraphics_fillPath_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 
    fr_Value value_1;
    fr_Obj arg_1; 
    fr_Value retValue;

    fr_getParam(env, param, &value_1, 1, NULL);
    arg_1 = value_1.h;

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    retValue.h = vaseWindow_NGraphics_fillPath(env, arg_0, arg_1);
    *((fr_Value*)ret) = retValue;
}

void vaseWindow_NGraphics_doTransform_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 
    fr_Value value_1;
    fr_Float arg_1; 
    fr_Value value_2;
    fr_Float arg_2; 
    fr_Value value_3;
    fr_Float arg_3; 
    fr_Value value_4;
    fr_Float arg_4; 
    fr_Value value_5;
    fr_Float arg_5; 
    fr_Value value_6;
    fr_Float arg_6; 

    fr_getParam(env, param, &value_6, 6, NULL);
    arg_6 = value_6.f;

    fr_getParam(env, param, &value_5, 5, NULL);
    arg_5 = value_5.f;

    fr_getParam(env, param, &value_4, 4, NULL);
    arg_4 = value_4.f;

    fr_getParam(env, param, &value_3, 3, NULL);
    arg_3 = value_3.f;

    fr_getParam(env, param, &value_2, 2, NULL);
    arg_2 = value_2.f;

    fr_getParam(env, param, &value_1, 1, NULL);
    arg_1 = value_1.f;

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    vaseWindow_NGraphics_doTransform(env, arg_0, arg_1, arg_2, arg_3, arg_4, arg_5, arg_6);
}

void vaseWindow_NGraphics_clipPath_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 
    fr_Value value_1;
    fr_Obj arg_1; 
    fr_Value retValue;

    fr_getParam(env, param, &value_1, 1, NULL);
    arg_1 = value_1.h;

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    retValue.h = vaseWindow_NGraphics_clipPath(env, arg_0, arg_1);
    *((fr_Value*)ret) = retValue;
}

void vaseWindow_NGraphics_doSetShadow_v(fr_Env env, void *param, void *ret) {
    fr_Value value_0;
    fr_Obj arg_0; 
    fr_Value value_1;
    fr_Bool arg_1; 
    fr_Value value_2;
    fr_Int arg_2; 
    fr_Value value_3;
    fr_Int arg_3; 
    fr_Value value_4;
    fr_Int arg_4; 
    fr_Value value_5;
    fr_Int arg_5; 
    fr_Value value_6;
    fr_Int arg_6; 
    fr_Value value_7;
    fr_Int arg_7; 
    fr_Value value_8;
    fr_Int arg_8; 

    fr_getParam(env, param, &value_8, 8, NULL);
    arg_8 = value_8.i;

    fr_getParam(env, param, &value_7, 7, NULL);
    arg_7 = value_7.i;

    fr_getParam(env, param, &value_6, 6, NULL);
    arg_6 = value_6.i;

    fr_getParam(env, param, &value_5, 5, NULL);
    arg_5 = value_5.i;

    fr_getParam(env, param, &value_4, 4, NULL);
    arg_4 = value_4.i;

    fr_getParam(env, param, &value_3, 3, NULL);
    arg_3 = value_3.i;

    fr_getParam(env, param, &value_2, 2, NULL);
    arg_2 = value_2.i;

    fr_getParam(env, param, &value_1, 1, NULL);
    arg_1 = value_1.b;

    fr_getParam(env, param, &value_0, 0, NULL);
    arg_0 = value_0.h;


    vaseWindow_NGraphics_doSetShadow(env, arg_0, arg_1, arg_2, arg_3, arg_4, arg_5, arg_6, arg_7, arg_8);
}


#endif //FR_VM
