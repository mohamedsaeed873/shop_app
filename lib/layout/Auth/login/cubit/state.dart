
import 'package:shop_app/model/LoginModel/shopLoginModel.dart';

abstract class LoginStates{}

class ShopLoginInitialStates extends LoginStates{}

class ShopLoginLoadingStates extends LoginStates{}

class ShopLoginSuccessStates extends LoginStates{
  LoginModel? loginModel;

  ShopLoginSuccessStates(this.loginModel);
}

class ShopLoginErrorStates extends LoginStates{

  final String? error;

  ShopLoginErrorStates(this.error);
}

class ShopLoginChangePasswordVisibilityStates extends LoginStates{}

