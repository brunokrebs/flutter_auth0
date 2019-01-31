import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_auth0/bloc/auth_bloc.dart';
import 'package:flutter_auth0/bloc/app_provider.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:uni_links/uni_links.dart';

import 'package:flutter/services.dart' show PlatformException;

void launchURL(BuildContext context, {String url}) async {
  try {
    await launch(
      url,
      option: new CustomTabsOption(
        toolbarColor: Theme.of(context).primaryColor,
        enableDefaultShare: true,
        enableUrlBarHiding: true,
        showPageTitle: true,
        animation: new CustomTabsAnimation.slideIn(),
        extraCustomTabs: <String>[
          'org.mozilla.firefox',
          'com.microsoft.emmx',
        ],
      ),
    );
  } catch (e) {
    // An exception is thrown if browser app is not installed on Android device.
    debugPrint(e.toString());
  }
}

///To get the access code
Future<Null> getAuthCode(BuildContext context) async {
  StreamSubscription _sub;
  String initialLink;
  String accessCode;

  AuthBloc authBloc = AppProvider.of(context).authBloc;
  try {
    initialLink = await getInitialLink();
    _sub = getLinksStream().listen((String link) {
      initialLink = link;
      authBloc.input.add(initialLink);
    }, onError: (err) {
      // authBloc.input.add("error");
    }, onDone: () {
      _sub.cancel();
    });
  } on PlatformException {
    // Handle exception by warning the user their action did not succeed
    // return?
  }
  return accessCode;
}
