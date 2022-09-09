
import 'package:shop_app/model/LoginModel/shopLoginModel.dart';

abstract class ShopLoginStates{}

class ShopLoginInitialStates extends ShopLoginStates{}

class ShopLoginLoadingStates extends ShopLoginStates{}

class ShopLoginSuccessStates extends ShopLoginStates{
   ShopLoginModel? loginModel;

  ShopLoginSuccessStates(this.loginModel);
}

class ShopLoginErrorStates extends ShopLoginStates{

  final String? error;

  ShopLoginErrorStates(this.error);
}

class ShopLoginChangePasswordVisibilityStates extends ShopLoginStates{}

