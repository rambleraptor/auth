import 'package:auth/accounts/controllers/image_controller.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('URL parses correctly', () {
    var tests = [
      "www.facebook.com",
      "http://www.facebook.com",
      "https://www.facebook.com",
      "https://com.facebook.com",
      "http://www.facebook.com/1/2/3"
    ];

    for (var url in tests) {
      expect(stripUrl(url), "facebook.com");
    }
  });
}
