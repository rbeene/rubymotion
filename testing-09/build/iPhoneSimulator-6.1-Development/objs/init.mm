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
void MREP_AC7A51AE13A34C628575D37BE6FF4A4C(void *, void *);
void MREP_482654A207034FFA9A0B97404286B4CE(void *, void *);
void MREP_08E4380481364F289EFB2BB737859A30(void *, void *);
void MREP_A39B4901C81D418FA63A39713DCB24A2(void *, void *);
void MREP_6B91720EB779499EA5BDF784CEEB7210(void *, void *);
void MREP_CD6809B7C84D4A16990CA097E1D173C6(void *, void *);
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
MREP_AC7A51AE13A34C628575D37BE6FF4A4C(self, 0);
MREP_482654A207034FFA9A0B97404286B4CE(self, 0);
MREP_08E4380481364F289EFB2BB737859A30(self, 0);
MREP_A39B4901C81D418FA63A39713DCB24A2(self, 0);
MREP_6B91720EB779499EA5BDF784CEEB7210(self, 0);
MREP_CD6809B7C84D4A16990CA097E1D173C6(self, 0);
	}
	catch (...) {
	    rb_rb2oc_exc_handler();
	}
	initialized = true;
    }
}
