

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop_app/layout/Auth/login/cubit/state.dart';
import 'package:shop_app/layout/ShopApp/shopLayout.dart';
import 'package:shop_app/model/LoginModel/shopLoginModel.dart';
import 'package:shop_app/shared/network/end_pointe.dart';
import 'package:shop_app/shared/network/remot/dio_helper.dart';

import '../../../../shared/components/components.dart';
import '../../../../shared/network/local/cache_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialStates());

  static ShopLoginCubit get(context) => BlocProvider.of(context);
  ShopLoginModel? loginModel;

  void userLogin({
    required String email,
    required String password,
    required BuildContext context,
  }) {
    emit(ShopLoginLoadingStates());
    DioHelper.postData(url: LOGIN, data: {
      'email': email,
      'password': password,
    }).then((value) {
      // ignore: avoid_print
      print(value.data);
      navigateToFinsh(context, const ShopLayout());
      CacheHelper.savaData(key: 'token', value: value.data!.token);
      loginModel = ShopLoginModel.fromJson(value.data);
      emit(ShopLoginSuccessStates(loginModel!));
    }).catchError((error) {
      // ignore: avoid_print
      print(error.toString());
      emit(ShopLoginErrorStates(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;

  bool ispassword = true;

  // ignore: non_constant_identifier_names
  void ChangePasswordVisibility() {
    ispassword = !ispassword;

    suffix =
        ispassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopLoginChangePasswordVisibilityStates());
  }
}
