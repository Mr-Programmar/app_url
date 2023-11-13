import 'package:com.GLO365.glO365/comman_widget/outlinetextfield.dart';
import 'package:com.GLO365.glO365/firebase/auth_service.dart';
import 'package:com.GLO365.glO365/provider/provider.dart';
import 'package:com.GLO365.glO365/screens/home.dart';
import 'package:com.GLO365.glO365/screens/sign_up.dart';
import 'package:com.GLO365.glO365/screens/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../comman_widget/primary_button.dart';


class SignIn extends StatefulHookConsumerWidget {
  const SignIn({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignInState();
}

class _SignInState extends ConsumerState<SignIn> {
  final _formKey = GlobalKey<FormState>();




  @override
  Widget build(BuildContext context) {
    final emailNameTextController = useTextEditingController();
    final passwordTextController = useTextEditingController();
    return SafeArea(

      child: Scaffold(


          body: Form(
            key: _formKey,
            child: Container(




              child: Center(
                child: SingleChildScrollView(
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    OutlineTextField(
                        validator: FormBuilderValidators.required(),
                        suffixIcon: const Icon(Icons.man),
                        hintText: 'Email',
                        controller: emailNameTextController),
                    const SizedBox(
                      height: 20,
                    ),
                    OutlineTextField(
                        validator: FormBuilderValidators.required(),
                        suffixIcon: Icon(Icons.remove_red_eye),
                        hintText: 'Password',
                        controller: passwordTextController),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Don\'t have an account?'),
                        SizedBox(width: 8.0),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SignUp()),
                            );
                          },
                          child: Text('Sign Up'),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    PrimaryButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          UserCredential? userCredential = await ref
                              .read(authServiceProvider)
                              .signInWithEmailAndPassword(
                                  context: context,
                                  email: emailNameTextController.text,
                                  password: passwordTextController.text);
                          // print(userCredential);
                          if (userCredential != null) {
                            ref.read(fireStoreServicesProvider).getUserData();

                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return Home();
                            }));

                            CustomSnackBar.show(context, "Welcome ",
                                color: Colors.green,
                                duration: Duration(seconds: 3));
                          }
                        }
                      },
                      name: 'Log in',
                    ),
                  ]),
                ),
              ),
            ),
          )),
    );
  }
}
