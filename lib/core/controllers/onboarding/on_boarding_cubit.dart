import 'package:commerce_app/core/managers/values.dart';
import 'package:commerce_app/core/networking/cache/cache_helper.dart';
import 'package:commerce_app/core/managers/navigation.dart';
import 'package:commerce_app/screens/modules/register.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'on_boarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  OnBoardingCubit() : super(OnBoardingInitial());
  static OnBoardingCubit get(context) => BlocProvider.of(context);

  bool isPageLast = false;
  int screenIndex = 0;
  void pageLast(index) {
    isPageLast = true;
    screenIndex = index;
    emit(PageLast());
  }

  void pageNotLast(index) {
    isPageLast = false;
    screenIndex = index;
    emit(NotPageLast());
  }

  void submit(context) {
    CacheHelper.save(key: "Boarding", value: true)
        .then((value) => navigateToNextScreen(context, RegisterScreen()));
  }
}
