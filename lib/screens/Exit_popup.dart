import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

Future<bool> webViewExit(context, [InAppWebViewController? a]) async {
  if (await a?.canGoBack() ?? false) {
    await a!.goBack();
    return false;
  }

  else {
    // Navigator.of(context).pop();
    // return false;

    return await showDialogApna(context);
  }
}

Future<bool> showDialogApna(context) async {
  var canPop = await showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog.adaptive(
        title: const Text("Do you want to exit?"),
        actions: [
          TextButton(
            onPressed: () {
              print('Yes selected');
              // Navigator.of(context).pop(true);
              exit(0);
            },
            child: const Text("Yes"),
          ),
          TextButton(
            onPressed: () {
              print('No selected');
              Navigator.of(context).pop(false);
            },
            child: const Text("No"),
          ),
        ],
      );
    },
  );
  return canPop ?? false;
}
