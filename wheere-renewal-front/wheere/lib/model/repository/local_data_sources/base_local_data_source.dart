import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class BaseLocalDataSource {
  static const storage = FlutterSecureStorage();

  static Future<String?> read({required String key}) async {
    return await storage.read(key: key);
  }

  static Future delete({String? key}) async {
    if(key == null) {
      await storage.deleteAll();
    } else {
      await storage.delete(key: key);
    }
  }

  static Future write({required String key, required String value}) async {
    await storage.write(key: key, value: value);
  }
}