import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../firebase/auth_service.dart';
import '../firebase/firestore_services.dart';

final webViewloadingProvider = StateProvider<bool>((ref) {
  return true;
});

final webcontrollerprovider = StateProvider<InAppWebViewController?>((ref) {
  return null;
});

final webViewProgressProvider = StateProvider<int>((ref) {
  return 0;
});
final flutter_bottem_Provider = StateProvider<int>((ref) {
return 0;});


final userDataProvider = StateProvider<Map?>((ref) {

  return null;

});


final fireStoreServicesProvider = Provider<FireStoreServices>((ref) {
  return FireStoreServices( ref);
});


final authServiceProvider = StateProvider<AuthService>((ref) {

  return AuthService();
});