import 'package:safe_device/safe_device.dart';
import '../abstracts/develop_mode_cheker.dart';
import '../abstracts/jailbreak_checker.dart';
import '../abstracts/real_device_checker.dart';
import '../abstracts/root_checker.dart';

class SafeDeviceService
    implements
        RootChecker,
        JailbreakChecker,
        RealDeviceChecker,
        DevelopModeChecker {
  @override
  Future<bool> isRootDevice() async => await SafeDevice.isJailBroken;

  @override
  Future<bool> isJailbreakDevice() async => await SafeDevice.isJailBroken;

  @override
  Future<bool> isRealDevice() async => await SafeDevice.isRealDevice;

  @override
  Future<bool> isDevelopmentModeEnable() async =>
      await SafeDevice.isDevelopmentModeEnable;
}
