import 'dart:developer';

import 'package:auth/accounts/models/accounts.dart';
import 'package:base32/base32.dart';

MutableAccount parseTOTPString(String url) {
  log("URL: $url");
  Uri uri = Uri.parse(url);

  log("URI: $uri");
  log("URI Parameters: ${uri.queryParameters}");
  if (!uri.queryParameters.containsKey("issuer")) {
    throw UnsupportedError("issuer key must exist in url $url");
  }
  String issuer = Uri.decodeFull(uri.queryParameters["issuer"]!);
  log("Issuer: $issuer");

  if (!uri.queryParameters.containsKey("secret")) {
    throw UnsupportedError("issuer key must exist in url $url");
  }
  log("URI Parameters: ${uri.queryParameters}");
  log("Secret: ${uri.queryParameters["secret"]}");
  String secret =
      base32.decodeAsHexString(uri.queryParameters["secret"]!.toUpperCase());

  String decodedPath = Uri.decodeFull(uri.path);
  String username = decodedPath.split(":")[1];
  return MutableAccount(issuer: issuer, secret: secret, username: username);
}
