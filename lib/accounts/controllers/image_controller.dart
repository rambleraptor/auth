import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

abstract class ImageController {
  Widget widgetForWebsite(String url);
}

class ImageFileController extends ImageController {
  @override
  Widget widgetForWebsite(String url) {
    String host = stripUrl(url);
    String fn = fileName(host);
    log("Fetching image for host $host with filename $fn");
    return SvgPicture.asset(
      fn,
      semanticsLabel: "$host Logo",
    );
  }

  String fileName(String url) {
    return "assets/twofactorauth/img/${url[0]}/$url.svg";
  }
}

String stripUrl(String url) {
  if (!url.startsWith('http')) {
    url = "http://$url";
  }
  final uri = Uri.parse(url);
  List<String> parts = uri.host.split('.');
  return parts.sublist(1).join('.');
}
