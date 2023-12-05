import 'package:commerce_app/core/controllers/register/register_cubit.dart';
import 'package:commerce_app/core/managers/navigation.dart';
import 'package:commerce_app/core/managers/values.dart';
import 'package:commerce_app/core/networking/cache/cache_helper.dart';
import 'package:commerce_app/core/networking/config/appthem.dart';
import 'package:commerce_app/core/networking/widgets/botton.dart';
import 'package:commerce_app/core/networking/widgets/textfield.dart';
import 'package:commerce_app/screens/modules/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nationalIdController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterDone) {
          if (state.user.status == 'success') {
            CacheHelper.save(key: 'userId', value: state.user.user!.nationalId!)
                .then((value) => {nationalId = state.user.user!.nationalId});
            CacheHelper.save(key: 'token', value: state.user.user!.token!)
                .then((value) {
              token = state.user.user!.token!;
              navigateToNextScreen(context, LoginScreen());
            });
          } else {
            print(state.user.message);
          }
        } else {
          const CircularProgressIndicator();
        }
      },
      builder: (context, state) {
        final cubit = RegisterCubit.get(context);

        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Pixel",
                    style: TextStyle(
                        fontSize: AppTheme.font28, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 50),
                    child: GestureDetector(
                      onTap: () {
                        cubit.addImage();
                      },
                      child: CircleAvatar(
                        radius: 40,
                        child: Center(
                          child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: NetworkImage(
                                  'https://www.pngall.com/wp-content/uploads/5/User-Profile-PNG-High-Quality-Image.png'),
                              fit: BoxFit.cover,
                            )),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            keyboardType: TextInputType.text,
                            label: 'Full Name',
                            hint: 'Enter Full Name',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Your Name';
                              }
                              return null;
                            },
                            controller: nameController,
                            prefixIcon: const Icon(Icons.person),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
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
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                            keyboardType: TextInputType.number,
                            label: 'Phone Number',
                            hint: 'Enter phone number',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Your Phone';
                              }
                              return null;
                            },
                            controller: phoneController,
                            prefixIcon: const Icon(Icons.phone),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
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
                            prefixIcon: const Icon(Icons.password),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          CustomTextField(
                            keyboardType: TextInputType.number,
                            label: 'National ID',
                            hint: 'Enter National ID',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Your National Id ';
                              }
                              return null;
                            },
                            controller: nationalIdController,
                            prefixIcon: const Icon(Icons.video_stable),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          DefaultButton(
                              backgroundColor: Colors.black,
                              buttonWidget: (state is RegisterLoading)
                                  ? const CircularProgressIndicator()
                                  : const Text(
                                      'Sign UP',
                                      style: TextStyle(color: Colors.white),
                                    ),
                              function: () {
                                if (_formKey.currentState!.validate()) {
                                  cubit.userRegister(
                                      nameController.text,
                                      emailController.text,
                                      phoneController.text,
                                      nationalIdController.text,
                                      passwordController.text);
                                }
                              }),
                          InkWell(
                            onTap: () {
                              navigateToNextScreen(context, LoginScreen());
                            },
                            child: const Text(
                              'already have an account',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 22),
                            ),
                          )
                        ],
                      ))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
