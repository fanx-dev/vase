#ifdef FR_VM
#include "fni_ext.h"

void vaseClient_Storage_cur_v(fr_Env env, void *param, void *ret);
void vaseClient_HttpReq_send_v(fr_Env env, void *param, void *ret);

void vaseClient_register(fr_Fvm vm) {
    fr_registerMethod(vm, "vaseClient_Storage_cur", vaseClient_Storage_cur_v);
    fr_registerMethod(vm, "vaseClient_HttpReq_send", vaseClient_HttpReq_send_v);
}

#endif //FR_VM
