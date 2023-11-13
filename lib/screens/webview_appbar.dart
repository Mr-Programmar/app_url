import 'package:com.GLO365.glO365/screens/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'Exit_popup.dart';

AppBar webViewappBar(
    BuildContext context, InAppWebViewController? webcontroller) {
  return AppBar(
    elevation: 5,
    toolbarHeight: 40,
    leadingWidth: 100,
    leading: Row(
      children: [
        IconButton(
            onPressed: () {
              webViewExit(context, webcontroller!);
            },
            icon: const Icon(
              CupertinoIcons.back,
            )),
        IconButton(
            onPressed: () async {
              if (await webcontroller!.canGoForward()) {
                webcontroller.goForward();
              } else {
                // Handle the case where the WebView cannot go forward
              }
            },
            icon: const Icon(
              CupertinoIcons.forward,
            )),
      ],
    ),
    actions: [
      IconButton(
          onPressed: () {
            webcontroller!.reload();
          },
          icon: const Icon(
            CupertinoIcons.refresh_bold,
          )),
      IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            CupertinoIcons.clear,
          )),
      IconButton(
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => Home()));
          },
          icon: const Icon(
            CupertinoIcons.home,
          )),
    ],
  );
}
