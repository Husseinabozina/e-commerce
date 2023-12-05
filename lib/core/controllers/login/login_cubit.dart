import 'package:commerce_app/core/networking/api/api.dart';
import 'package:commerce_app/core/networking/api_constants.dart';
import 'package:commerce_app/models/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  static LoginCubit get(context) => BlocProvider.of(context);
  Api api = ApiImpl();
  User? userModel;

  void userLogin(email, password) {
    api.post(url: ApiConstants.loginApi, data: {
      "email": email,
      "password": password,
    }).then((value) {
      userModel = User.fromJson(value.data);
      emit(LoginSuccess(user: userModel!));
    }).catchError((e) {
      print(e.toString());
      emit(LoginFailure());
    });
  }
}
