import 'package:hive/hive.dart';
import '../models/user.dart';
import '../utils/encryption.dart';

class AuthService {
  final _userBox = Hive.box('userBox');

  Future<void> registerUser(String email, String password) async {
    final encryptedPassword = EncryptionHelper.encrypt(password);
    final user = User(email: email, password: encryptedPassword);
    await _userBox.put(email, user);
  }

  User? loginUser(String email, String password) {
    final user = _userBox.get(email) as User?;
    if (user != null &&
        EncryptionHelper.decrypt(user.password) == password) {
      return user;
    }
    return null;
  }

  bool isUserLoggedIn() {
    return _userBox.values.isNotEmpty;
  }
}
