// lib/authenticator.dart
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:jwt_auth_frog/user.dart';

class Authenticator {
  static const _users = {
    'john': User(
      id: '1',
      name: 'John',
      password: '123',
    ),
    'jack': User(
      id: '2',
      name: 'Jack',
      password: '321',
    ),
  };

  static const _passwords = {
    // ⚠️ Never store user's password in plain text, these values are in plain text
    // just for the sake of the tutorial.
    'john': '123',
    'jack': '321',
  };

  User? findByUsernameAndPassword({
    required String username,
    required String password,
  }) {
    final user = _users[username];

    if (user != null && _passwords[username] == password) {
      return user;
    }

    return null;
  }

  User? verifyToken(String token) {
    try {
      final payload = JWT.verify(
        token,
        SecretKey('123'),
      );

      final payloadData = payload.payload as Map<String, dynamic>;

      final username = payloadData['username'] as String;
      return _users[username];
    } catch (e) {
      return null;
    }
  }

  String generateToken({
    required String username,
    required User user,
  }) {
    final jwt = JWT(
      {
        'id': user.id,
        'name': user.name,
        'username': username,
      },
    );

    return jwt.sign(SecretKey('123'));
  }
}
