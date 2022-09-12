import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
      print(value.data);
     navigateToFinsh(context, ShopLayout());
      CacheHelper.savaData(key: 'token', value: value.data!.token);

      loginModel = ShopLoginModel.fromJson(value.data);
      emit(ShopLoginSuccessStates(loginModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopLoginErrorStates(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;

  bool ispassword = true;

  void ChangePasswordVisibility() {
    ispassword = !ispassword;

    suffix =
        ispassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopLoginChangePasswordVisibilityStates());
  }
}
