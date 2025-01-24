import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:platform_info/platform_info.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<void> init() async {
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await platform.when(
    android: FlutterDisplayMode.setHighRefreshRate,
  );
  await SystemChannels.textInput.invokeMethod('TextInput.hide');
}

Future<Box> getUserBox() async {
  //final encryptionKey = await getEncryptionKey();
  final userbox = await Hive.openBox(
    'user',
   // encryptionCipher: HiveAesCipher(encryptionKey),
  );
  return userbox;
}

Future<Uint8List> getEncryptionKey() async {
  const secureKey = 'Sun_mobility';
  var secureStorage = const FlutterSecureStorage();
  // if key not exists return null
  final fencryptionKey = await secureStorage.read(key: secureKey);
  if (fencryptionKey == null) {
    final key = Hive.generateSecureKey();
    await secureStorage.write(
      key: secureKey,
      value: base64UrlEncode(key),
    );
  }
  final key = await secureStorage.read(key: secureKey);
  final encryptionKey = base64Url.decode(key!);
  return encryptionKey;
}
