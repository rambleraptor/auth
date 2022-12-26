import 'package:auth/accounts/models/accounts.dart';
import 'package:auth/accounts/models/url_parser.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('URL tests', () {
    String uri =
        "otpauth://totp/Inside%20Universal%20Forums%3Ablah?secret=QCM6K4BA23AH3NH5&issuer=Inside%20Universal%20Forums";

    MutableAccount ma = parseTOTPString(uri);
    expect(ma.secret, "8099e57020d6c07db4fd");
    expect(ma.issuer, "Inside Universal Forums");
    expect(ma.username, "blah");
  });
}
