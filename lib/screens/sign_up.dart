import 'package:com.GLO365.glO365/comman_widget/outlinetextfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SignUp extends StatefulHookConsumerWidget {
  const SignUp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignInState();
}

class _SignInState extends ConsumerState<SignUp> {
  @override
  Widget build(BuildContext context) {
    final emailTextController = useTextEditingController();
    final userNameTextController = useTextEditingController();
    final passwordTextController = useTextEditingController();
    final confirmPasswordTextController = useTextEditingController();
    return Scaffold(
        body: Container(
      child: Column(children: [
        OutlineTextField(hintText: 'Email', controller: emailTextController),
        OutlineTextField(
            hintText: 'User Name', controller: userNameTextController),
        OutlineTextField(
            hintText: 'password', controller: passwordTextController),
        OutlineTextField(
            hintText: 'Confirm password',
            controller: confirmPasswordTextController),
      ]),
    ));
  }
}
