import 'package:dart_frog/dart_frog.dart';
import 'package:jwt_auth_frog/authenticator.dart';

Handler middleware(Handler handler) {
  return handler.use(
    provider<Authenticator>(
      (_) => Authenticator(),
    ),
  );
}
