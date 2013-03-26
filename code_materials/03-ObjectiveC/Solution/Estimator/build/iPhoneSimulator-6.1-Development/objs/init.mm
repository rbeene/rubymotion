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
void MREP_E02CA377F73F43A4920EF98290F1F519(void *, void *);
void MREP_B4C5B6B8CD924BB197981D0AE75D33C3(void *, void *);
void MREP_99DB513BD6874D56BD2623A3E933936A(void *, void *);
void MREP_1C4741ADC55A4D0CB288D0CF8A8861AD(void *, void *);
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
MREP_E02CA377F73F43A4920EF98290F1F519(self, 0);
MREP_B4C5B6B8CD924BB197981D0AE75D33C3(self, 0);
MREP_99DB513BD6874D56BD2623A3E933936A(self, 0);
MREP_1C4741ADC55A4D0CB288D0CF8A8861AD(self, 0);
	}
	catch (...) {
	    rb_rb2oc_exc_handler();
	}
	initialized = true;
    }
}
