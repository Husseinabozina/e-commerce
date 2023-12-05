import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:commerce_app/core/networking/api/api.dart';
import 'package:commerce_app/core/networking/api_constants.dart';
import 'package:commerce_app/models/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  static RegisterCubit get(context) => BlocProvider.of(context);
  Api api = ApiImpl();
  User? userModel;
  void userRegister(name, email, phone, nationalId, password) {
    emit(RegisterLoading());
    api.post(url: ApiConstants.registerApi, data: {
      "name": name,
      "email": email,
      "phone": phone,
      "nationalId": nationalId,
      "gender": 'male',
      "password": password,
      "profileImage": userImage
    }).then((value) {
      userModel = User.fromJson(value.data);
      print(userModel!.user!.name!);
      emit(RegisterDone(user: userModel!));
    }).catchError((e) {
      print(e.toString());
      emit(RegisterError());
    });
  }

  ImagePicker picker = ImagePicker();
  File? image;
  Uint8List? bytes;
  String? userImage;
  Future<void> addImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      bytes = File(image!.path).readAsBytesSync();
      userImage = base64Encode(bytes!);
      print("images =$userImage");
      emit(ChooseImage());
    } else {
      print('no image selected');
    }
  }
}
