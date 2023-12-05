import 'package:commerce_app/core/controllers/login/login_cubit.dart';
import 'package:commerce_app/core/controllers/onboarding/on_boarding_cubit.dart';
import 'package:commerce_app/core/controllers/register/register_cubit.dart';
import 'package:commerce_app/core/networking/api/api.dart';
import 'package:commerce_app/core/networking/cache/cache_helper.dart';
import 'package:commerce_app/core/managers/values.dart';
import 'package:commerce_app/screens/modules/login.dart';
import 'package:commerce_app/screens/modules/onboarding.dart';
import 'package:commerce_app/screens/modules/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Api.init();
  await CacheHelper.init();

  boarding = CacheHelper.get(key: 'Boarding');
  nationalId = CacheHelper.get(key: 'userId');
  token = CacheHelper.get(key: 'token');
  if (boarding == true) {
    if (!(nationalId == null) & !(token == null)) {
      nextScreen = LoginScreen();
    }
    nextScreen = RegisterScreen();
  } else {
    nextScreen = const OnBoardingScreen();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => OnBoardingCubit(),
        ),
        BlocProvider(
          create: (context) => RegisterCubit(),
        ),
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: nextScreen,
      ),
    );
  }
}
