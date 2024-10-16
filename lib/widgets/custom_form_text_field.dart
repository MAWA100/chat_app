import 'package:flutter/material.dart';

class CustomFormTextField extends StatelessWidget {
   CustomFormTextField({super.key,this.onChanged,required this.text,this.obscureText=false});
  final String? text;
  Function(String)?onChanged;
  bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText!,
      validator: (value) {
        if(value!.isEmpty) {
          return 'field is required';
        return null;
        }
        return null;
      },
      onChanged: onChanged,
            decoration: InputDecoration(
              enabledBorder:  OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(color: Colors.white))

             , border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white)),
                hintText:text ,
                hintStyle: const TextStyle(
                  color: Colors.white
                )

            ),
          );
  }
}