// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_map/core/constant/color_app.dart';
import 'package:google_map/core/constant/strings.dart';
import 'package:google_map/feature/auth/logic/cubit/phone_auth_cubit.dart';
import '../widgets/text_widget.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController textEditingController = TextEditingController();
  // late String phoneNumber;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: _formKey,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const TextWidget(),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 13,
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(color: ColorsApp.grey),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(6))),
                        child: Row(
                          children: [
                            Text(
                              '${generateCountryFlag()} +20',
                            ),
                            const Spacer(),
                            const Icon(Icons.keyboard_arrow_down_outlined)
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: ColorsApp.grey),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(6),
                          ),
                        ),
                        child: TextFormField(
                          autofocus: true,
                          style: const TextStyle(
                            fontSize: 14,
                            letterSpacing: 2.0,
                          ),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'phone Number',
                            hintStyle: TextStyle(color: Colors.black12),
                          ),
                          controller: textEditingController,
                          cursorColor: Colors.pink,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter yout phone number!';
                            } else if (value.length < 11) {
                              return 'Too short for a phone number!';
                            }
                            return null;
                          },
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(11),
                          ],
                          onSaved: (value) {
                            // phoneNumber = value!;
                            // print('phoneNumber$phoneNumber');
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    onPressed: () {
                      showProgressIndicator(context);
                      _register(context);
                    },
                    child: const Text(
                      'Next',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                buildPhoneNumberSubmittedBloc(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _register(context) async {
    if (!_formKey.currentState!.validate()) {
      Navigator.pop(context);
      return;
    } else {
      Navigator.pop(context);
      _formKey.currentState!.save();
      BlocProvider.of<PhoneAuthCubit>(context)
          .submitPhoneNumber(textEditingController.toString());
    }
  }

  void showProgressIndicator(BuildContext context) {
    AlertDialog alertDialog = const AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
        ),
      ),
    );

    showDialog(
      barrierColor: Colors.white.withOpacity(0),
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return alertDialog;
      },
    );
  }

  String generateCountryFlag() {
    String countryCode = 'eg';
    String flag = countryCode.toUpperCase().replaceAllMapped(RegExp(r'(A-Z)'),
        (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397));
    return flag;
  }

  Widget buildPhoneNumberSubmittedBloc() {
    return BlocListener<PhoneAuthCubit, PhoneAuthState>(
      listenWhen: (previous, current) {
        return previous != current;
      },
      listener: (context, state) {
        if (state is LoadingState) {
          return showProgressIndicator(context);
        }
        if (State is PhoneNumberSubmited) {
          Navigator.of(context).pushNamed(
            otpPage,
            arguments: textEditingController,
          );
        }
        if (state is ErrorState) {
          Navigator.pop(context);
          String errorMsg = (state).errorMsg;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                errorMsg,
              ),
              backgroundColor: Colors.black,
              duration: const Duration(
                seconds: 5,
              ),
            ),
          );
        }
      },
      child: Container(),
    );
  }
}
