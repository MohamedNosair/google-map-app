part of 'phone_auth_cubit.dart';

sealed class PhoneAuthState {}

final class PhoneAuthInitial extends PhoneAuthState {}

class LoadingState extends PhoneAuthState {}

class ErrorState extends PhoneAuthState {
  final String errorMsg;

  ErrorState({required this.errorMsg});
}

class PhoneNumberSubmited extends PhoneAuthState {}

class PhoneOtpVerified extends PhoneAuthState {}
