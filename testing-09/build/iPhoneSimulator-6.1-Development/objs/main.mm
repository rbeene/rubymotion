#import <UIKit/UIKit.h>

extern "C" {
    void rb_define_global_const(const char *, void *);
    void rb_rb2oc_exc_handler(void);
    void rb_exit(int);
    void RubyMotionInit(int argc, char **argv);
void MREP_7BC1ECC816FA4C76B07D5701BAEE6ED6(void *, void *);
void MREP_C2C1EF69E2304064A6E2BD94D66CBC1C(void *, void *);
void MREP_8C75F02A6CEF4850B6884114E8E52C8D(void *, void *);
void MREP_4CC81A13480F41C989CAD39A058E0F62(void *, void *);
void MREP_E9AB4C31195541869BB42EB96A858B7B(void *, void *);
}
@interface SpecLauncher : NSObject
@end

#include <dlfcn.h>

@implementation SpecLauncher

+ (id)launcher
{
    [UIApplication sharedApplication];

    // Enable simulator accessibility.
    // Thanks http://www.stewgleadow.com/blog/2011/10/14/enabling-accessibility-for-ios-applications/
    NSString *simulatorRoot = [[[NSProcessInfo processInfo] environment] objectForKey:@"IPHONE_SIMULATOR_ROOT"];
    if (simulatorRoot != nil) {
        void *appSupportLibrary = dlopen([[simulatorRoot stringByAppendingPathComponent:@"/System/Library/PrivateFrameworks/AppSupport.framework/AppSupport"] fileSystemRepresentation], RTLD_LAZY);
        CFStringRef (*copySharedResourcesPreferencesDomainForDomain)(CFStringRef domain) = (CFStringRef (*)(CFStringRef)) dlsym(appSupportLibrary, "CPCopySharedResourcesPreferencesDomainForDomain");

        if (copySharedResourcesPreferencesDomainForDomain != NULL) {
            CFStringRef accessibilityDomain = copySharedResourcesPreferencesDomainForDomain(CFSTR("com.apple.Accessibility"));

            if (accessibilityDomain != NULL) {
                CFPreferencesSetValue(CFSTR("ApplicationAccessibilityEnabled"), kCFBooleanTrue, accessibilityDomain, kCFPreferencesAnyUser, kCFPreferencesAnyHost);
                CFRelease(accessibilityDomain);
            }
        }
    }

    // Load the UIAutomation framework.
    dlopen("/Developer/Library/PrivateFrameworks/UIAutomation.framework/UIAutomation", RTLD_LOCAL);

    SpecLauncher *launcher = [[self alloc] init];
    [[NSNotificationCenter defaultCenter] addObserver:launcher selector:@selector(appLaunched:) name:UIApplicationDidBecomeActiveNotification object:nil];
    return launcher; 
}

- (void)appLaunched:(id)notification
{
    // Give a bit of time for the simulator to attach...
    [self performSelector:@selector(runSpecs) withObject:nil afterDelay:0.3];
}

- (void)runSpecs
{
MREP_7BC1ECC816FA4C76B07D5701BAEE6ED6(self, 0);
MREP_C2C1EF69E2304064A6E2BD94D66CBC1C(self, 0);
MREP_8C75F02A6CEF4850B6884114E8E52C8D(self, 0);
MREP_4CC81A13480F41C989CAD39A058E0F62(self, 0);
MREP_E9AB4C31195541869BB42EB96A858B7B(self, 0);
[NSClassFromString(@"Bacon") performSelector:@selector(run)];
}

@end
int
main(int argc, char **argv)
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    int retval = 0;
    try {
[SpecLauncher launcher];
        RubyMotionInit(argc, argv);
rb_define_global_const("RUBYMOTION_ENV", @"test");
rb_define_global_const("RUBYMOTION_VERSION", @"1.34");
        retval = UIApplicationMain(argc, argv, nil, @"AppDelegate");
        rb_exit(retval);
    }
    catch (...) {
	rb_rb2oc_exc_handler();
    }
    [pool release];
    return retval;
}
