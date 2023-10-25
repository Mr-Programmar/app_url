import 'package:com.GLO365.glO365/screens/webview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../comman_widget/outlinetextfield.dart';

class EnterUrl extends StatefulHookConsumerWidget {
  const EnterUrl({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EnterUrlState();
}

class _EnterUrlState extends ConsumerState<EnterUrl> {
  @override
  Widget build(BuildContext context) {
    final urlGetController = useTextEditingController();
    // final webcontroller = ref.watch(webcontrollerprovider);
    return Scaffold(
      body: Column(
        children: [
          OutlineTextField(
            controller: urlGetController,
            hintText: 'Enter Url',
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (buildContext) {
                  return Webview(url: urlGetController.text);
                }));
              },
              child: const Text("Go")),
        ],
      ),
    );
  }
}
