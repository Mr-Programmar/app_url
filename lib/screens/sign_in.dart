import 'dart:convert';

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
        backgroundColor: Colors.white,
          body: Form(
        key: _formKey,
        child: Stack(



            children: [
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.only(left: 15,top: 70),
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(color: Color(0xff1d2951)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                Text(
                  "Login",
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                    SizedBox(height: 10),
                    Text(
                      "Enter email and password",
                      style: TextStyle(


                          color: Colors.white),
                    ),
              ]),
            ),
          ),
          Positioned(
            top: 200,
            bottom: 0,
            right: 0,
            left: 0,

            child: Container(
            height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: SingleChildScrollView(
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  SizedBox(height: 10,),
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
        ]),
      )),
    );
  }
}
