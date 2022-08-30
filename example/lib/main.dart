import 'package:device_security_checker/device_security_checker.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/scheduler.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isRealDevice = false,
      isRootOrJailbreakDevice = false,
      isDevelopmentModeEnable = false,
      isSafeDevice = false;
  final DeviceSecurityChecker _deviceSecurityChecker = DeviceSecurityChecker();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    if (!mounted) return;
    isRealDevice = await _deviceSecurityChecker.isRealDevice();
    isRootOrJailbreakDevice =
        await _deviceSecurityChecker.isRootOrJailbreakDevice();
    isDevelopmentModeEnable =
        await _deviceSecurityChecker.isDevelopmentModeEnable();
    isSafeDevice = await _deviceSecurityChecker.isSafeDevice();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('isRealDevice: $isRealDevice'),
              const SizedBox(height: 8),
              Text('isRootOrJailbreakDevice: $isRootOrJailbreakDevice'),
              const SizedBox(height: 8),
              Text('isDevelopmentModeEnable: $isDevelopmentModeEnable'),
              const SizedBox(height: 8),
              Text('isSafeDevice: $isSafeDevice'),
            ],
          ),
        ),
      ),
    );
  }
}
