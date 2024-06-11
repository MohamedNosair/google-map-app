import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_map/core/constant/strings.dart';
import 'package:google_map/feature/auth/logic/cubit/phone_auth_cubit.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  PhoneAuthCubit phoneAuthCubit = PhoneAuthCubit();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocProvider<PhoneAuthCubit>(
        create: (context) => phoneAuthCubit,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6))),
          onPressed: () async {
            await phoneAuthCubit.logOut();
            Navigator.of(context).pushReplacementNamed(loginPage);
          },
          child: const Text(
            'LogOut',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
