// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:google_map/core/constant/color_app.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class TextOtpWidget extends StatelessWidget {
  TextOtpWidget({
    super.key,
    required this.phoneNumber,
    this.otpCode,
  });
  final phoneNumber;
  late final otpCode;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Verify your phone Number',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 20,
        ),
        RichText(
          text: TextSpan(
              text: 'enter your 6 digit code numbers sent to ',
              style: const TextStyle(
                fontSize: 18,
                height: 1.4,
                color: Colors.black,
              ),
              children: [
                TextSpan(
                  text: '$phoneNumber',
                  style: const TextStyle(
                    color: ColorsApp.mainColor,
                  ),
                ),
              ]),
        ),
        const SizedBox(
          height: 50,
        ),
        PinCodeTextField(
          appContext: context,
          autoFocus: true,
          keyboardType: TextInputType.number,
          length: 6,
          obscureText: false,
          cursorColor: Colors.black,
          animationType: AnimationType.scale,
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(5),
            fieldHeight: 50,
            fieldWidth: 40,
            borderWidth: 1,
            activeColor: ColorsApp.mainColor,
            inactiveColor: ColorsApp.mainColor,
            activeFillColor: ColorsApp.lightColor,
            inactiveFillColor: Colors.white,
            selectedColor: ColorsApp.mainColor,
            selectedFillColor: Colors.white,
          ),
          animationDuration: const Duration(milliseconds: 300),
          enableActiveFill: true,
          // errorAnimationController: errorController,
          // controller: textEditingController,
          onCompleted: (value) {
            otpCode = value;
          },
          onChanged: (value) {},
        )
      ],
    );
  }
}
