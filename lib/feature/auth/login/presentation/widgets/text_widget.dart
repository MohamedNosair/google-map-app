import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'what is your phone Number',
          style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(height: 20,),
        Text(
          'what is your phone Number',
          style: TextStyle(
            fontSize: 20,

          ),
        ),
      ],
    );
  }
}
