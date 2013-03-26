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
void MREP_ACA72F3A40D14370847446A9BF7950F8(void *, void *);
void MREP_1F4102F3700F47B6854E0A41D7384175(void *, void *);
void MREP_66EB6E1CB4AA442BA7070921BC402433(void *, void *);
void MREP_2D68BEC2A46040A0811F3975A6C3CB25(void *, void *);
void MREP_450AA8DB3ACF4BECA9A4869788090156(void *, void *);
void MREP_DEC2D2CFFDE34D6D91F1FD817F8E082D(void *, void *);
void MREP_4D8CEF63D09F49599120927E0D37D320(void *, void *);
void MREP_6B8307D683A8402EBEADB10DF2DCA098(void *, void *);
void MREP_78549CE870D643E4AAEF56F4C7FF0C24(void *, void *);
void MREP_123F2DAB2630411594E912DAFFAA61A6(void *, void *);
void MREP_D9CE55E3D3184B0CB062B7BAFD6A57A3(void *, void *);
void MREP_84FC4C2A9C164AF09168E8AD72AD69D2(void *, void *);
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
MREP_ACA72F3A40D14370847446A9BF7950F8(self, 0);
MREP_1F4102F3700F47B6854E0A41D7384175(self, 0);
MREP_66EB6E1CB4AA442BA7070921BC402433(self, 0);
MREP_2D68BEC2A46040A0811F3975A6C3CB25(self, 0);
MREP_450AA8DB3ACF4BECA9A4869788090156(self, 0);
MREP_DEC2D2CFFDE34D6D91F1FD817F8E082D(self, 0);
MREP_4D8CEF63D09F49599120927E0D37D320(self, 0);
MREP_6B8307D683A8402EBEADB10DF2DCA098(self, 0);
MREP_78549CE870D643E4AAEF56F4C7FF0C24(self, 0);
MREP_123F2DAB2630411594E912DAFFAA61A6(self, 0);
MREP_D9CE55E3D3184B0CB062B7BAFD6A57A3(self, 0);
MREP_84FC4C2A9C164AF09168E8AD72AD69D2(self, 0);
	}
	catch (...) {
	    rb_rb2oc_exc_handler();
	}
	initialized = true;
    }
}
