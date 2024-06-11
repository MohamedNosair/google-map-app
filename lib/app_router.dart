import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_map/feature/auth/logic/cubit/phone_auth_cubit.dart';
import 'package:google_map/feature/auth/login/presentation/page/login_page.dart';
import 'package:google_map/feature/auth/otp/presentation/page/otp_page.dart';
import 'package:google_map/feature/map/presentation/map_page.dart';
import 'core/constant/strings.dart';

class AppRouter {
  PhoneAuthCubit? phoneAuthCubit;
  AppRouter() {
    phoneAuthCubit = PhoneAuthCubit();
  }
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case mapPage:
        return MaterialPageRoute(
          builder: (_) => const MapPage(),
        );

      case loginPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<PhoneAuthCubit>.value(
            value: phoneAuthCubit!,
            child: LoginPage(),
          ),
        );

      case otpPage:
        final phoneNumber = settings.arguments;
        return MaterialPageRoute(
          builder: (_) => BlocProvider<PhoneAuthCubit>.value(
            value: phoneAuthCubit!,
            child: OtpPage(phoneNumber : phoneNumber),
          ),
        );
    }
    return null;
  }
}
