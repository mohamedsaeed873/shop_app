
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/Auth/login/login_screen.dart';
import 'package:shop_app/layout/Auth/register/cubit/state.dart';
import 'package:shop_app/model/LoginModel/shopLoginModel.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/end_pointe.dart';
import 'package:shop_app/shared/network/remot/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates>{
  ShopRegisterCubit() : super(ShopRegisterInitialStates());

  static ShopRegisterCubit get(context)=>BlocProvider.of(context);
  ShopLoginModel? registerModel;

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
    required BuildContext context,
  }){
   emit(ShopRegisterLoadingStates());
    DioHelper.postData(
        url: REGISTER,
        data: {
          'name':name,
          'email':email,
          'password':password,
          'phone':phone,
        }
    ).then((value) {
      // ignore: avoid_print
      print(value.data);
      navigateToFinsh(context, LoginScreen());
      registerModel= ShopLoginModel.fromJson(value.data);
      emit(ShopRegisterSuccessStates(registerModel!));
    }).catchError((error){
      // ignore: avoid_print
      print(error.toString());
      emit(ShopRegisterErrorStates(error.toString()));
    });
  }


  IconData suffix= Icons.visibility_outlined;
  bool ispassword=true;
  // ignore: non_constant_identifier_names
  void ChangePasswordVisibility(){
    ispassword=!ispassword;
    suffix=ispassword?Icons.visibility_outlined
        :Icons.visibility_off_outlined;
    emit(ShopRegisterChangePasswordVisibilityStates());
  }
}

