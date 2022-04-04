#include "fni_ext.h"
#include "pod_vaseWindow_native.h"

#import "VaseWindow.h"

@interface EditTextListener : UIResponder <UITextViewDelegate, UITextFieldDelegate>

@property(atomic,assign) fr_Obj neditText;

@end

extern float desityScale;

struct Window {
    VaseWindow* window;
    fr_Obj graphics;
};

struct EditTextHandle {
    UIView *textView;
    bool isTextField;
    EditTextListener *delegate;
};

static struct EditTextHandle* getEditTextHandle(fr_Env env, fr_Obj self) {
    static fr_Field f = NULL;
    if (f == NULL) f = fr_findField(env, fr_getObjType(env, self), "handle");
    fr_Value val;
    fr_getInstanceField(env, self, f, &val);
    struct EditTextHandle* raw = (struct EditTextHandle*)(val.i);
    return raw;
}

static void setEditTextHandle(fr_Env env, fr_Obj self, struct EditTextHandle* r) {
    static fr_Field f = NULL;
    if (f == NULL) f = fr_findField(env, fr_getObjType(env, self), "handle");
    fr_Value val;
    val.i = (fr_Int)r;
    fr_setInstanceField(env, self, f, &val);
}

NSString* fireTextChangeEvent(fr_Obj neditText, NSString *text) {
    static fr_Method paintM;
    static fr_Field viewF;
    fr_Env env = fr_getEnv(NULL, NULL);
    if (paintM == NULL) {
        fr_Type type = fr_getObjType(env, neditText);
        fr_Type viewType = fr_findType(env, "vaseWindow", "TextInput");
        paintM = fr_findMethod(env, viewType, "textChange");
        viewF = fr_findField(env, type, "textInput");
    }

    fr_Value value;
    fr_getInstanceField(env, neditText, viewF, &value);
    fr_Obj res = fr_callMethod(env, paintM, 2, value.h, fr_newStrUtf8(env, text.UTF8String)).h;
    const char *resStr = fr_getStrUtf8(env, res);
    if (resStr == NULL || strcmp(resStr, text.UTF8String) == 0) {
        return nil;
    }
    return [NSString stringWithUTF8String:resStr];
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

@interface EditTextListener ()

@end

@implementation EditTextListener

- (instancetype)init {
    self = [super init];
    return self;
}

- ( BOOL )textField:( UITextField  *)textField shouldChangeCharactersInRange:(NSRange )range replacementString:( NSString  *)string {
    return true;
}

- (void)textViewDidChange:(UITextView *)textView {
    NSString* t = fireTextChangeEvent(self.neditText, textView.text);
    if (t) {
        textView.text = t;
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return true;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    return true;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSString* t = fireTextChangeEvent(self.neditText, textField.text);
    if (t) {
        textField.text = t;
    }
}

@end
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void vaseWindow_NEditText_finalize(fr_Env env, fr_Obj self);

fr_Int vaseWindow_NEditText_init(fr_Env env, fr_Obj self, fr_Int inputType, fr_Int windowHandle) {
    struct Window* handle = (struct Window*)windowHandle;
    
    UIView *view;
    UITextField *textField;
    UITextView *textView;
    switch (inputType) {
        case 1://inputTypeText
            textField = [[UITextField alloc]init];
            view = textField;
            break;
        case 2://inputTypeIntNumber
            textField = [[UITextField alloc]init];
            view = textField;
            textField.keyboardType = UIKeyboardTypePhonePad;
            break;
        case 3://inputTypeFloatNumber
            textField = [[UITextField alloc]init];
            textField.keyboardType = UIKeyboardTypeDecimalPad;
            view = textField;
            break;
        case 4://inputTypePassword
            textField = [[UITextField alloc]init];
            view = textField;
            textField.secureTextEntry = YES;
            break;
        case 5://inputTypeMultiLine
            textView = [[UITextView alloc]init];
            view = textView;
            break;
        default:
            fr_throwUnsupported(env);
            return 0;
            break;
    }
    
    EditTextListener *listener = [[EditTextListener alloc]init];
    listener.neditText = fr_newGlobalRef(env, self);
    if (textField) {
        textField.delegate = listener;
        //[textField addTarget:listener action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        textField.returnKeyType = UIReturnKeyDone;
    }
    else {
        textView.delegate = listener;
    }
    
    [handle->window addSubview:view];
    //((VaseWindow*)handle->window).editView = view;
    
    struct EditTextHandle *et = (struct EditTextHandle*)calloc(1, sizeof(struct EditTextHandle));
    et->textView = view;
    et->isTextField = textField != nil;
    et->delegate = listener;
    
    fr_Type type = fr_getObjType(env, self);
    fr_registerDestructor(env, type, vaseWindow_NEditText_finalize);
    
    return (fr_Int)et;
}

void vaseWindow_NEditText_close(fr_Env env, fr_Obj self) {
    struct EditTextHandle* handle = getEditTextHandle(env, self);
    if (handle == NULL) return;
    
    [handle->textView removeFromSuperview];
    if (handle->isTextField) {
        UITextField *textView = (UITextField*)handle->textView;
        fireTextChangeEvent(self, textView.text);
        textView.delegate = nil;
    }
    else {
        UITextView *textView = (UITextView*)handle->textView;
        fireTextChangeEvent(self, textView.text);
        textView.delegate = nil;
    }
    fr_deleteGlobalRef(env, handle->delegate.neditText);
    handle->delegate.neditText = NULL;
    handle->textView = nil;
    handle->delegate = nil;
    
    
    free(handle);
    setEditTextHandle(env, self, NULL);
    return;
}
void vaseWindow_NEditText_setPos(fr_Env env, fr_Obj self, fr_Int x, fr_Int y, fr_Int w, fr_Int h) {
    struct EditTextHandle* handle = getEditTextHandle(env, self);
    handle->textView.frame = CGRectMake(x/desityScale, y/desityScale, w/desityScale, h/desityScale);
    return;
}
void vaseWindow_NEditText_doSetStyle(fr_Env env, fr_Obj self, fr_Obj fontName, fr_Int fontSize, fr_Int textColor, fr_Int backgroundColor) {
    struct EditTextHandle* handle = getEditTextHandle(env, self);

    int r = (backgroundColor >> 16) & 0xff;
    int g = (backgroundColor >> 8) & 0xff;
    int b = backgroundColor & 0xff;
    int a = (backgroundColor >> 24) & 0xff;
    [handle->textView setBackgroundColor:[UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a/255.0]];
    
    if (handle->isTextField) {
        UITextField *textView = (UITextField*)handle->textView;
        [textView setFont:[UIFont systemFontOfSize:fontSize/2]];
        
        int r = (textColor >> 16) & 0xff;
        int g = (textColor >> 8) & 0xff;
        int b = textColor & 0xff;
        int a = (textColor >> 24) & 0xff;
        [textView setTextColor:[UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a/255.0]];
    }
    else {
        UITextView *textView = (UITextView*)handle->textView;
        [textView setFont:[UIFont systemFontOfSize:fontSize/2]];
        
        int r = (textColor >> 16) & 0xff;
        int g = (textColor >> 8) & 0xff;
        int b = textColor & 0xff;
        int a = (textColor >> 24) & 0xff;
        [textView setTextColor:[UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a/255.0]];
    }
}
void vaseWindow_NEditText_setText(fr_Env env, fr_Obj self, fr_Obj text) {
    struct EditTextHandle* handle = getEditTextHandle(env, self);
    const char *str = fr_getStrUtf8(env, text);
    NSString *nstext = [NSString stringWithUTF8String:str];
    if (handle->isTextField) {
        UITextField *textView = (UITextField*)handle->textView;
        [textView setText:nstext];
    }
    else {
        UITextView *textView = (UITextView*)handle->textView;
        [textView setText:nstext];
    }
    return;
}
void vaseWindow_NEditText_setType(fr_Env env, fr_Obj self, fr_Int multiLine, fr_Bool editable) {
    struct EditTextHandle* handle = getEditTextHandle(env, self);
    if (handle->isTextField) {
        UITextField *textView = (UITextField*)handle->textView;
        [textView setEnabled:editable];
    }
    else {
        UITextView *textView = (UITextView*)handle->textView;
        [textView setEditable:editable];
    }
    return;
}
void vaseWindow_NEditText_focus(fr_Env env, fr_Obj self) {
    struct EditTextHandle* handle = getEditTextHandle(env, self);
    [handle->textView becomeFirstResponder];
    return;
}
void vaseWindow_NEditText_select(fr_Env env, fr_Obj self, fr_Int start, fr_Int end) {
    struct EditTextHandle* handle = getEditTextHandle(env, self);
    if (handle->isTextField) {
        UITextField *textView = (UITextField*)handle->textView;
        UITextPosition *from = [textView positionFromPosition:textView.beginningOfDocument offset:start];
        UITextPosition *to = [textView positionFromPosition:textView.beginningOfDocument offset:end];
        [textView setSelectedTextRange:[textView textRangeFromPosition:from toPosition:to]];
    }
    else {
        UITextView *textView = (UITextView*)handle->textView;
        UITextPosition *from = [textView positionFromPosition:textView.beginningOfDocument offset:start];
        UITextPosition *to = [textView positionFromPosition:textView.beginningOfDocument offset:end];
        [textView setSelectedTextRange:[textView textRangeFromPosition:from toPosition:to]];
    }
    return;
}
fr_Int vaseWindow_NEditText_caretPos(fr_Env env, fr_Obj self) {
    struct EditTextHandle* handle = getEditTextHandle(env, self);
    if (handle->isTextField) {
        UITextField *textView = (UITextField*)handle->textView;
        fr_Int offset = [textView offsetFromPosition:textView.beginningOfDocument toPosition:textView.selectedTextRange.start];
        return offset;
    }
    else {
        UITextView *textView = (UITextView*)handle->textView;
        fr_Int offset = [textView offsetFromPosition:textView.beginningOfDocument toPosition:textView.selectedTextRange.start];
        return offset;
    }
    return 0;
}
void vaseWindow_NEditText_finalize(fr_Env env, fr_Obj self) {
    vaseWindow_NEditText_close(env, self);
}
