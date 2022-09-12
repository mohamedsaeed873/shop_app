// ignore_for_file: unnecessary_import, camel_case_types, non_constant_identifier_names, duplicate_ignore

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/Auth/login/cubit/state.dart';

import '../../../../model/LoginModel/shopLoginModel.dart';
import '../../../../shared/network/end_pointe.dart';
import '../../../../shared/network/remot/dio_helper.dart';

class loginCubit extends Cubit<LoginStates> {
  loginCubit() : super(ShopLoginInitialStates());
  static loginCubit get(context) => BlocProvider.of(context);

  LoginModel? loginModel;

  void UserLogin({required String email, required String password}) {
    emit(ShopLoginLoadingStates());
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      emit(ShopLoginSuccessStates(loginModel!));
    }).catchError((error) {
      emit(ShopLoginErrorStates(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  // ignore: non_constant_identifier_names
  void ChangePassword() {
    isPassword = !isPassword;
    suffix =
    isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(ShopLoginChangePasswordVisibilityStates());
  }
}
