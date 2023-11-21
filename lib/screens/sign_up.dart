import 'package:com.GLO365.glO365/comman_widget/outlinetextfield.dart';
import 'package:com.GLO365.glO365/firebase/auth_service.dart';
import 'package:com.GLO365.glO365/screens/sign_in.dart';
import 'package:com.GLO365.glO365/screens/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../comman_widget/primary_button.dart';
import '../firebase/firestore_services.dart';
import '../provider/provider.dart';

class SignUp extends StatefulHookConsumerWidget {
  const SignUp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignInState();
}

class _SignInState extends ConsumerState<SignUp> {
  final _formKey = GlobalKey<FormState>();

  String? validatePasswordMatch(String? password, String? confirmPassword) {
    if (password == null || confirmPassword == null) {
      return 'Password and confirm password must not be empty.';
    }

    if (password != confirmPassword) {
      return 'Password and confirm password must match.';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final emailTextController = useTextEditingController();
    final userNameTextController = useTextEditingController();
    final userPhoneTextController = useTextEditingController();
    final passwordTextController = useTextEditingController();
    final confirmPasswordTextController = useTextEditingController();
    return SafeArea(
      child: Form(
        key: _formKey,
        child: Scaffold(
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 30,horizontal: 10),
          child: SingleChildScrollView(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              OutlineTextField(
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                  suffixIcon: Icon(Icons.person),
                  hintText: 'User Name',
                  controller: userNameTextController),
              OutlineTextField(
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                  suffixIcon: Icon(Icons.phone),
                  keyboardType: TextInputType.phone,
                  hintText: 'Phone Number',
                  controller: userPhoneTextController),
              OutlineTextField(
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.email(),
                    FormBuilderValidators.required(),
                  ]),
                  suffixIcon: Icon(Icons.email),
                  hintText: 'Email',
                  controller: emailTextController),
              // OutlineTextField(
              //     hintText: 'User Name', controller: userNameTextController),
              OutlineTextField(
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                  suffixIcon: Icon(Icons.password),
                  hintText: 'Password',
                  controller: passwordTextController),
              OutlineTextField(
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    (confirmPassword) => validatePasswordMatch(
                          passwordTextController.text,
                          confirmPassword,
                        )
                  ]),
                  suffixIcon: Icon(Icons.password),
                  hintText: 'Confirm password',
                  controller: confirmPasswordTextController),

              PrimaryButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    UserCredential? userCredential = await ref
                        .read(authServiceProvider)
                        .signUpWithEmailAndPassword(
                          context: context,
                          email: emailTextController.text.toString(),
                          password: passwordTextController.text.toString(),
                        );


                    bool dataSave= await     ref.read(fireStoreServicesProvider).saveDataOnFirebase(
                        name: userNameTextController.text,
                        email: emailTextController.text,
                        phone: userPhoneTextController.text,
                        password: passwordTextController.text);




                    if (userCredential != null && dataSave==true ) {
                      CustomSnackBar.show(
                          context, "User Created, Please Login Now",
                          color: Colors.green, duration: Duration(seconds: 10));




                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return SignIn();
                      }));


                    }
                  }




                },
                name: 'Sign Up',
              ),
            ]),
          ),
        )),
      ),
    );
  }
}
