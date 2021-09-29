#ifdef FR_VM
#include "pod_vaseClient_native.h"

void vaseClient_Storage_cur_v(fr_Env env, void *param, void *ret) {
    fr_Value retValue;


    retValue.h = vaseClient_Storage_cur(env);
    *((fr_Value*)ret) = retValue;
}

void vaseClient_HttpReq_send_v(fr_Env env, void *param, void *ret) {
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


    retValue.h = vaseClient_HttpReq_send(env, arg_0, arg_1, arg_2);
    *((fr_Value*)ret) = retValue;
}


#endif //FR_VM
