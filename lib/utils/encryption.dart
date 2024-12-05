import 'package:encrypt/encrypt.dart';

class EncryptionHelper {
  static final _key = Key.fromUtf8('16charslongkey!!'); // Replace with secure key
  static final _iv = IV.fromLength(16);
  static final _encrypter = Encrypter(AES(_key));

  static String encrypt(String text) {
    return _encrypter.encrypt(text, iv: _iv).base64;
  }

  static String decrypt(String encryptedText) {
    return _encrypter.decrypt64(encryptedText, iv: _iv);
  }
}
