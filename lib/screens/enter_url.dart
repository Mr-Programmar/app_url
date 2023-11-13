import 'package:com.GLO365.glO365/screens/splash%20Screen.dart';
import 'package:com.GLO365.glO365/screens/webview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../comman_widget/outlinetextfield.dart';
import '../main.dart';
import '../provider/provider.dart';
import 'Exit_popup.dart';

class EnterUrl extends StatefulHookConsumerWidget {
  const EnterUrl({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EnterUrlState();
}

class _EnterUrlState extends ConsumerState<EnterUrl> {
  final _formKey = GlobalKey<FormState>();
  var savedUrls;



  _saveUrl(String url) async {
    SharedPreferences prefs =  ref.read(sharedPrefencesProvider);
    savedUrls=prefs.getStringList('savedUrls');
    await prefs.setStringList('savedUrls', <String>[...?savedUrls,url]);




    print(prefs.getStringList('savedUrls'));
  }



  @override
  void initState() {



    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SharedPreferences prefs = ref.watch(sharedPrefencesProvider);
    TextEditingController urlGetController =
        useTextEditingController(text: prefs.getStringList('savedUrls')?.last );


    final userdata = ref.watch(userDataProvider);
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(userdata?['Name'] ?? ''),
              accountEmail: Text(userdata?['Email'] ?? ''),
              currentAccountPicture: const CircleAvatar(
                child: Icon(Icons.person),
              ),
            ),
            
            ListTile(
              title: const Text('Logout'),
              leading: const Icon(Icons.exit_to_app),
              onTap: () async {
                final auuthServiceProvider = ref.read(authServiceProvider);

                await auuthServiceProvider.signOut();

                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => AuthCheck()));
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text("Ellipse Cloud"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                showDialogApna(context);
              },
              icon: const Icon(
                CupertinoIcons.clear,
              )),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [





              OutlineTextField(
                onChanged: (a) {


                  urlGetController.text = a;


                },
                controller: urlGetController,
                hintText: 'Enter Url',
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.url(),
                  FormBuilderValidators.required(),
                ]),
              ),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _saveUrl(urlGetController.text);

                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (buildContext) {
                        return Webview(url: urlGetController.text);
                      }));
                    }
                  },
                  child: const Text("Go")),
            ],
          ),
        ),
      ),
    );
  }
}
