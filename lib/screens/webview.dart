import 'package:com.GLO365.glO365/provider/provider.dart';
import 'package:com.GLO365.glO365/screens/snackbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_media_downloader/flutter_media_downloader.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'Exit_popup.dart';
import 'open_other_apps.dart';

class Webview extends StatefulHookConsumerWidget {
  Webview({required this.url, Key? key}) : super(key: key);

  String? url;

  @override
  ConsumerState createState() => _WebviewState();
}

class _WebviewState extends ConsumerState<Webview> {
  bool isKeyboardVisible = false;

  InAppWebViewController? webViewController;
  PullToRefreshController? pullToRefreshController;

  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
    crossPlatform: InAppWebViewOptions(
      useShouldOverrideUrlLoading: true,
      // userAgent: "https://www.remove.bg/",
      mediaPlaybackRequiresUserGesture: false,
      allowFileAccessFromFileURLs: true,
      useOnDownloadStart: true,
      javaScriptCanOpenWindowsAutomatically: true,
      javaScriptEnabled: true,
      supportZoom: true,

      allowUniversalAccessFromFileURLs: true,
    ),
    android: AndroidInAppWebViewOptions(useHybridComposition: true),
    ios: IOSInAppWebViewOptions(allowsInlineMediaPlayback: true),
  );

  @override
  void initState() {
    super.initState();

    pullToRefreshController = kIsWeb
        ? null
        : PullToRefreshController(
            options: PullToRefreshOptions(
              color: Colors.blue,
              enabled: true,
            ),
            onRefresh: () async {
              setState(() {
                webViewController?.reload();
              });
            });

    // Add listener to keyboard visibility changes
    KeyboardVisibilityController().onChange.listen((bool isVisible) {
      setState(() {
        isKeyboardVisible = isVisible;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var progress = useState(0.0);
    return WillPopScope(
      onWillPop: () => showExitPopup(context, webViewController!),
      child: SafeArea(
        child: Scaffold(
          body: Stack(children: [
            Column(children: [
              Expanded(
                child: InAppWebView(
                  onWebViewCreated: (InAppWebViewController controller) {
                    webViewController = controller;
                    ref.read(webcontrollerprovider.notifier).state =
                        webViewController;
                  },
                  initialUrlRequest: URLRequest(url: Uri.parse(widget.url!)),
                  initialOptions: options,
                  pullToRefreshController: pullToRefreshController,
                  onProgressChanged: (controller, progresss) {
                    ref.read(webViewProgressProvider.notifier).state =
                        progresss;

                    print(
                        "--------OnProgrss Change--${ref.read(webViewProgressProvider.notifier).state}");
                    // if (progresss == 100) {
                    //   pullToRefreshController?.endRefreshing();
                    // }

                    progress.value = progresss / 100;
                  },
                  onLoadStop: (controller, url) async {
                    print("---OnLoadStop-----");
                    ref.read(webViewloadingProvider.notifier).state = false;
                  },
                  onLoadStart: (controller, url) {
                    print("---OnLoadStart-----");
                  },
                  onLoadError: (controller, url, code, message) {
                    print(
                        "----------------loadError----------------------------$message");
                    print(
                        "---------------------loadError---------------------$code");
                    print(
                        "---------------------loadError---------------------$url");

                    CustomSnackBar.show(context, message, color: Colors.red);
                  },
                  onConsoleMessage: (controller, consoleMessage) {
                    print(
                        "-----------------------------onconsole messgae----------------$consoleMessage");
                  },
                  onLoadHttpError: (controller, UUri, innt, SString) {
                    print(
                        "-----------------------httpError---------------------$UUri");
                    print(
                        "----------------------httpError----------------------$innt");
                    print(
                        "-----------------------httpError---------------------$SString");
                  },
                  onDownloadStartRequest:
                      (controller, downloadStartRequest) async {
                    print("-------onDownloadStartRequest--------");
                    final url = downloadStartRequest.url;
                    print(
                        "=====================================================$url");

                    if (!url.hasEmptyPath) {
                      CustomSnackBar.show(context, "Downloading Start Soon",
                          color: Colors.green);
                    }

                    MediaDownload().downloadMedia(
                      context,
                      "$url",
                    );
                  },
                  shouldOverrideUrlLoading:
                      (controller, navigationAction) async {
                    print("--------shouldoverridingLoading---");

                    var uri = navigationAction.request.url!;
                    if (uri.toString().startsWith("whatsapp://")) {
                      whatsap(uri.toString());

                      return NavigationActionPolicy.CANCEL;
                    }

                    return NavigationActionPolicy.ALLOW;
                  },
                ),
              ),
              if (isKeyboardVisible)
                SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
            ]),
            progress.value < 1.0
                ? LinearProgressIndicator(
                    value: progress.value,
                  )
                : Container(),
          ]),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }
}
