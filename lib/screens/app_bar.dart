import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'Exit_popup.dart';

AppBar buildAppBar(
    BuildContext context, InAppWebViewController? webcontroller) {
  return AppBar(
    elevation: 5,
    toolbarHeight: 40,
    // leading: IconButton(
    //     onPressed: () {
    //       showExitPopup(context, webcontroller!);
    //     },
    //     icon: const Icon(
    //       CupertinoIcons.back,
    //     )),

    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 10),
        child: IconButton(
            onPressed: () {
              showDialogApna(context);
            },
            icon: const Icon(
              CupertinoIcons.clear,
            )),
      ),
    ],
  );
}
