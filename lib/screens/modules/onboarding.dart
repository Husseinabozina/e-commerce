import 'package:commerce_app/core/controllers/onboarding/on_boarding_cubit.dart';
import 'package:commerce_app/core/networking/config/appthem.dart';
import 'package:commerce_app/core/networking/widgets/botton.dart';
import 'package:commerce_app/core/managers/list.dart';
import 'package:commerce_app/screens/widget/build_onboarding_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnBoardingCubit, OnBoardingState>(
      listener: (context, state) {},
      builder: (context, state) {
        PageController onBoardingController = PageController();
        final cubit = OnBoardingCubit.get(context);

        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('data'),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 450,
                child: PageView.builder(
                  onPageChanged: (index) {
                    if (index == onBaordingScreens.length - 1) {
                      cubit.pageLast(index);
                    } else {
                      cubit.pageNotLast(index);
                    }
                  },
                  itemBuilder: (context, index) {
                    return buildOnBoardingItem(onBaordingScreens[index]);
                  },
                  controller: onBoardingController,
                  itemCount: onBaordingScreens.length,
                ),
              ),
              cubit.isPageLast
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: DefaultButton(
                          backgroundColor: Colors.black,
                          buttonWidget: const Text(
                            'GetStarted',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          function: () {
                            cubit.submit(context);
                          }),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: DefaultButton(
                          backgroundColor: Colors.black,
                          buttonWidget: const Text(
                            'Next',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          function: () {
                            onBoardingController.nextPage(
                                duration: const Duration(milliseconds: 750),
                                curve: Curves.fastLinearToSlowEaseIn);
                          }),
                    )
            ],
          ),
        );
      },
    );
  }
}
