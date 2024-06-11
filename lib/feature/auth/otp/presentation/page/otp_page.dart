// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_map/core/constant/strings.dart';
import 'package:google_map/feature/auth/logic/cubit/phone_auth_cubit.dart';
import 'package:google_map/feature/auth/login/presentation/widgets/show_progress_indicator.dart';
import 'package:google_map/feature/auth/otp/presentation/widget/text_widget.dart';

class OtpPage extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final phoneNumber;
  late String otpCode;
  OtpPage({super.key, required this.phoneNumber});

  Widget _buildPhoneVerificationBloc() {
    return BlocListener<PhoneAuthCubit, PhoneAuthState>(
      listenWhen: (previous, current) {
        return previous != current;
      },
      listener: (context, state) {
        if (state is LoadingState) {
          const ShowProgressIndicator();
        }
        if (State is PhoneOtpVerified) {
          Navigator.pop(context);
          Navigator.of(context).pushReplacementNamed(mapPage);
        }
        if (state is ErrorState) {
          String errorMsg = state.errorMsg;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                errorMsg,
              ),
              backgroundColor: Colors.red,
              duration: const Duration(
                seconds: 5,
              ),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextOtpWidget(
                phoneNumber: phoneNumber,
                otpCode: otpCode,
              ),
              const Spacer(),
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6))),
                  onPressed: () {
                    const ShowProgressIndicator();
                    _login(context);
                  },
                  child: const Text(
                    'Verify',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _login(BuildContext context) {
    BlocProvider.of<PhoneAuthCubit>(context).submitOtp(otpCode);
  }
}
