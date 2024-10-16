import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
   CustomButton({this.onTap,super.key,required this.text});
  final String text;
   VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return   GestureDetector(
      onTap: onTap,
      child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white
              ),
              child: Text(text),
            ),
    );
  }
}