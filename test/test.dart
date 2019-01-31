import 'package:test_api/test_api.dart';
import 'package:flutter_auth0/src/utils.dart';

void main() {
  test('Get the code', () {
    print(codeChallenge(codeVerifier()));
  });
}