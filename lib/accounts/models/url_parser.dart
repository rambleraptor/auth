import 'dart:convert';

import 'package:auth/accounts/models/accounts.dart';
import 'package:base32/base32.dart';

MutableAccount parseTOTPString(String url) {
  Uri uri = Uri.parse(url);
  if (!uri.queryParameters.containsKey("issuer")) {
    throw UnsupportedError("issuer key must exist in url $url");
  }
  String issuer = Uri.decodeFull(uri.queryParameters["issuer"]!);

  if (!uri.queryParameters.containsKey("secret")) {
    throw UnsupportedError("issuer key must exist in url $url");
  }
  String secret = base32.decodeAsHexString(uri.queryParameters["secret"]!);

  String decodedPath = Uri.decodeFull(uri.path);
  String username = decodedPath.split(":")[1];
  return MutableAccount(issuer: issuer, secret: secret, username: username);
}
