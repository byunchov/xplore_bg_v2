import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

import 'dart:io' show Platform;

import 'package:url_launcher/url_launcher_string.dart';

class UrlLauncherUtils {
  static Uri _createCoordLaunchUri(double latitude, double longitude, [String? label]) {
    Uri uri;

    if (kIsWeb) {
      uri = Uri.https(
          'www.google.com', '/maps/search/', {'api': '1', 'query': '$latitude,$longitude'});
    } else if (Platform.isAndroid) {
      var query = '$latitude,$longitude';

      if (label != null) query += '($label)';

      uri = Uri(scheme: 'geo', host: '0,0', queryParameters: {'q': query});
    } else if (Platform.isIOS) {
      var params = {'ll': '$latitude,$longitude'};

      if (label != null) params['q'] = label;

      uri = Uri.https('maps.apple.com', '/', params);
    } else {
      uri = Uri.https(
          'www.google.com', '/maps/search/', {'api': '1', 'query': '$latitude,$longitude'});
    }

    return uri;
  }

  static Future<bool> launchCoordinates(double latitude, double longitude, [String? label]) async {
    return await launchUrl(_createCoordLaunchUri(latitude, longitude, label));
  }

  static Future<bool> launchPhone(String phone) async {
    final phoneUri = Uri(scheme: 'tel', host: phone);
    log(phoneUri.toString());
    return await launchUrl(phoneUri);
  }

  static Future<bool> launchWebsite(String website) async {
    return await launchUrlString(website);
  }

  static Future<bool> launchMailTo(String email, {String? subject}) async {
    final emailUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {'subject': subject ?? 'XploreBG'},
    );
    log(emailUri.toString());
    return await launchUrl(emailUri);
  }
}
