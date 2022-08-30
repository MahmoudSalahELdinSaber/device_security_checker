#import "DeviceSecurityCheckerPlugin.h"
#if __has_include(<device_security_checker/device_security_checker-Swift.h>)
#import <device_security_checker/device_security_checker-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "device_security_checker-Swift.h"
#endif

@implementation DeviceSecurityCheckerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftDeviceSecurityCheckerPlugin registerWithRegistrar:registrar];
}
@end
