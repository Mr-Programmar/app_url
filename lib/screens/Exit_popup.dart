import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

Future<bool> showExitPopup(context, [InAppWebViewController? a]) async {
  if (await a?.canGoBack() ?? false) {
    await a!.goBack();
    return false;
  } else {
    Navigator.of(context).pop();
    return false;

    // return await showDialogApna(context);
  }
}

Future<dynamic> showDialogApna(context) {
  if (Platform.isIOS) {
    return showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text("Do you want to exit?"),
          actions: [
            CupertinoDialogAction(
              onPressed: () {
                print('Yes selected');
                exit(0);
              },
              isDestructiveAction: true,
              child: const Text("Yes"), // Makes the button red
            ),
            CupertinoDialogAction(
              onPressed: () {
                print('No selected');
                Navigator.of(context).pop();
              },
              child: const Text("No"),
            ),
          ],
        );
      },
    );
  } else {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Do you want to exit?"),
          actions: [
            TextButton(
              onPressed: () {
                print('Yes selected');
                exit(0);
              },
              child: const Text("Yes"),
            ),
            TextButton(
              onPressed: () {
                print('No selected');
                Navigator.of(context).pop();
              },
              child: const Text("No"),
            ),
          ],
        );
      },
    );
  }
}
