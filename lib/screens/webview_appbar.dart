import 'package:com.GLO365.glO365/screens/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/provider.dart';
import 'Exit_popup.dart';

AppBar webViewappBar(
    final ref,
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
          onPressed: () async{
            await showDialogApna(context);
          },
          icon: const Icon(
            CupertinoIcons.clear,
          )),
      IconButton(
          onPressed: () {
            ref.read(fireStoreServicesProvider).getUserData();
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => Home()));
          },
          icon: const Icon(
            CupertinoIcons.home,
          )),
    ],
  );
}
