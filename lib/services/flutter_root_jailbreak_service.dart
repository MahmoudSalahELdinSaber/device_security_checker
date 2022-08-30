import '../abstracts/jailbreak_checker.dart';
import '../abstracts/root_checker.dart';
import 'package:flutter_root_jailbreak/flutter_root_jailbreak.dart';

class FlutterRootJailbreakService implements RootChecker, JailbreakChecker {
  @override
  Future<bool> isRootDevice() async => await FlutterRootJailbreak.isRooted;

  @override
  Future<bool> isJailbreakDevice() async =>
      await FlutterRootJailbreak.isJailBroken;
}
