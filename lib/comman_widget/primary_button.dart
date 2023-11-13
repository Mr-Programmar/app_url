import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PrimaryButton extends ConsumerWidget {
   PrimaryButton({

    required this.onPressed,
    required this.name,
    super.key,
  });


  final VoidCallback onPressed;
  String name;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 300,
      height: 70,
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      child: ElevatedButton(

          style: ElevatedButton.styleFrom(

          shape: RoundedRectangleBorder(

          borderRadius: BorderRadius.circular(20))),



          onPressed: onPressed, child: Text(name,style: TextStyle(fontSize: 20),)),
    );
  }
}
