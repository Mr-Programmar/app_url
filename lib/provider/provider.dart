import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final webViewloadingProvider = StateProvider<bool>((ref) {
  return true;
});

final webcontrollerprovider = StateProvider<InAppWebViewController?>((ref) {
  return null;
});

final webViewProgressProvider = StateProvider<int>((ref) {
  return 0;
});
