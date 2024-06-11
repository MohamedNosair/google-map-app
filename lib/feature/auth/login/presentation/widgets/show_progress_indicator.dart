import 'package:flutter/material.dart';

class ShowProgressIndicator extends StatelessWidget {
  const ShowProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const AlertDialog(
      backgroundColor: Colors.transparent,
      content: Center(
        child: CircularProgressIndicator(
          color: Colors.black,
        ),
      ),
    );
   
  }
}
