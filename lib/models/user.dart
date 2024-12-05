import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  final String email;

  @HiveField(1)
  final String password; // Encrypted password

  User({required this.email, required this.password});

  get name => null;
}
