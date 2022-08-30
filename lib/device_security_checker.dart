library device_security_checker;

import 'dart:io';

import 'abstracts/develop_mode_cheker.dart';
import 'abstracts/jailbreak_checker.dart';
import 'abstracts/real_device_checker.dart';
import 'abstracts/root_checker.dart';

import 'services/flutter_root_jailbreak_service.dart';
import 'services/safe_device_service.dart';

abstract class SecureDevice
    implements
        RootChecker,
        JailbreakChecker,
        RealDeviceChecker,
        DevelopModeChecker {
  Future<bool> isRootOrJailbreakDevice();
  Future<bool> isSafeDevice();
}

class DeviceSecurityChecker implements SecureDevice {
  static final _safeDeviceImp = SafeDeviceService();
  static final _flutterRootJailbreakService = FlutterRootJailbreakService();

  final _rootCheckers = <RootChecker>[
    _safeDeviceImp,
    _flutterRootJailbreakService
  ];

  final _jailbreakCheckers = <JailbreakChecker>[
    _safeDeviceImp,
    _flutterRootJailbreakService,
  ];

  final _realCheckers = <RealDeviceChecker>[_safeDeviceImp];

  final _developModeCheckers = <DevelopModeChecker>[
    _safeDeviceImp,
  ];

  @override
  Future<bool> isRootDevice() async => await _checkOneOfListIsTrue<RootChecker>(
      checkers: _rootCheckers,
      condition: (element) async => element.isRootDevice());

  @override
  Future<bool> isJailbreakDevice() async =>
      await _checkOneOfListIsTrue<JailbreakChecker>(
          checkers: _jailbreakCheckers,
          condition: (element) async => element.isJailbreakDevice());

  @override
  Future<bool> isRootOrJailbreakDevice() async {
    if (Platform.isAndroid) {
      return await isRootDevice();
    } else if (Platform.isIOS) {
      return await isJailbreakDevice();
    } else {
      throw Exception('UnSupported Platform');
    }
  }

  @override
  Future<bool> isRealDevice() async =>
      await _checkOneOfListIsTrue<RealDeviceChecker>(
          checkers: _realCheckers,
          condition: (element) async => element.isRealDevice());

  @override
  Future<bool> isDevelopmentModeEnable() async =>
      await _checkOneOfListIsTrue<DevelopModeChecker>(
          checkers: _developModeCheckers,
          condition: (element) async => element.isDevelopmentModeEnable());

  @override
  Future<bool> isSafeDevice() async =>
      !(await isRootOrJailbreakDevice()) &&
      await isRealDevice() &&
      !(await isDevelopmentModeEnable());

  Future<bool> _checkOneOfListIsTrue<T>(
      {required List<T> checkers,
      required Future<bool> Function(T e) condition}) async {
    for (final element in checkers) {
      final isTrue = await condition(element);
      if (isTrue) {
        return true;
      }
    }
    return false;
  }
}
