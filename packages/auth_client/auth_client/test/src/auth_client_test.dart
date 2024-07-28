// ignore_for_file: prefer_const_constructors

import 'package:auth_client/auth_client.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AuthClient', () {
    test('can be instantiated', () {
      expect(AuthClient(), isNotNull);
    });
  });
}
