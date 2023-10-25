import 'package:url_launcher/url_launcher.dart';

whatsap(String url) async {
  final Uri url0 = Uri.parse(url);

  if (await canLaunchUrl(url0)) {
    try {
      await launchUrl(url0, mode: LaunchMode.externalNonBrowserApplication);
    } catch (e) {
      print(e);
    }
  } else {
    print("error");
  }
}
