#import <UIKit/UIKit.h>

extern "C" {
    void ruby_sysinit(int *, char ***);
    void ruby_init(void);
    void ruby_init_loadpath(void);
    void ruby_script(const char *);
    void ruby_set_argv(int, char **);
    void rb_vm_init_compiler(void);
    void rb_vm_init_jit(void);
    void rb_vm_aot_feature_provide(const char *, void *);
    void *rb_vm_top_self(void);
    void rb_rb2oc_exc_handler(void);
    void rb_exit(int);
void MREP_76D568DB6240420FAC23A6D10EC44699(void *, void *);
void MREP_C0EA0796B46D40C5B729F82FCA65CF87(void *, void *);
void MREP_82507A1357D2412B8B127BEBCA84400F(void *, void *);
void MREP_0F22CCB7BD764F2C9E69BEAAEE4F3FB6(void *, void *);
void MREP_B9F5541D7A28431797848B1F0DF8033B(void *, void *);
void MREP_D94EA6A4F2D44F9FA47290DA0EB8EE34(void *, void *);
void MREP_2325C25F785B428790C487092CD45814(void *, void *);
void MREP_B93816AFBCB440EE8B4E7A55910FDAED(void *, void *);
void MREP_022A3823A8644CD38F71F4793884E1C6(void *, void *);
void MREP_EE904B292DD94E40B6D3882C529D37B8(void *, void *);
void MREP_8E99B371BB3E486E9DB7E1EEE81487EA(void *, void *);
void MREP_B71C95F5C4B14B309D494A3E2143C6D2(void *, void *);
void MREP_AB28B61FFD9144A499DC9949C8468B62(void *, void *);
}

extern "C"
void
RubyMotionInit(int argc, char **argv)
{
    static bool initialized = false;
    if (!initialized) {
	ruby_init();
	ruby_init_loadpath();
        if (argc > 0) {
	    const char *progname = argv[0];
	    ruby_script(progname);
	}
	try {
	    void *self = rb_vm_top_self();
MREP_76D568DB6240420FAC23A6D10EC44699(self, 0);
MREP_C0EA0796B46D40C5B729F82FCA65CF87(self, 0);
MREP_82507A1357D2412B8B127BEBCA84400F(self, 0);
MREP_0F22CCB7BD764F2C9E69BEAAEE4F3FB6(self, 0);
MREP_B9F5541D7A28431797848B1F0DF8033B(self, 0);
MREP_D94EA6A4F2D44F9FA47290DA0EB8EE34(self, 0);
MREP_2325C25F785B428790C487092CD45814(self, 0);
MREP_B93816AFBCB440EE8B4E7A55910FDAED(self, 0);
MREP_022A3823A8644CD38F71F4793884E1C6(self, 0);
MREP_EE904B292DD94E40B6D3882C529D37B8(self, 0);
MREP_8E99B371BB3E486E9DB7E1EEE81487EA(self, 0);
MREP_B71C95F5C4B14B309D494A3E2143C6D2(self, 0);
MREP_AB28B61FFD9144A499DC9949C8468B62(self, 0);
	}
	catch (...) {
	    rb_rb2oc_exc_handler();
	}
	initialized = true;
    }
}
