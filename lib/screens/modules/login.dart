import 'package:commerce_app/core/controllers/login/login_cubit.dart';
import 'package:commerce_app/core/managers/navigation.dart';
import 'package:commerce_app/core/networking/config/appthem.dart';
import 'package:commerce_app/core/networking/widgets/botton.dart';
import 'package:commerce_app/core/networking/widgets/textfield.dart';
import 'package:commerce_app/screens/modules/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: (BuildContext context, state) {
          if (state is LoginSuccess) {
            navigateToNextScreen(context, const HomeScreen());
          }
        },
        builder: (BuildContext context, state) {
          final cubit = LoginCubit.get(context);
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Login",
                  style: TextStyle(
                      fontSize: AppTheme.font28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 100,
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          keyboardType: TextInputType.emailAddress,
                          label: 'Email Address',
                          hint: 'Enter Email Address',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Your Email';
                            }
                            return null;
                          },
                          controller: emailController,
                          prefixIcon: const Icon(Icons.email),
                        ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          keyboardType: TextInputType.visiblePassword,
                          label: 'Passward',
                          hint: 'Enter password',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Your Password';
                            }
                            return null;
                          },
                          controller: passwordController,
                        ),
                        const SizedBox(height: 20),
                        DefaultButton(
                            backgroundColor: Colors.black,
                            buttonWidget: (state is LoginLoading)
                                ? const CircularProgressIndicator()
                                : const Text(
                                    'login',
                                    style: TextStyle(color: Colors.white),
                                  ),
                            function: () {
                              if (_formKey.currentState!.validate()) {
                                cubit.userLogin(emailController.text,
                                    passwordController.text);
                              }
                            }),
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            navigateToNextScreen(context, LoginScreen());
                          },
                          child: const Text(
                            'already have an account',
                            style: TextStyle(color: Colors.black, fontSize: 22),
                          ),
                        )
                      ],
                    ))
              ],
            ),
          );
        },
      ),
    );
  }
}
