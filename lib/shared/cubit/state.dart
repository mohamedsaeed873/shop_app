import 'package:shop_app/model/Favorite/favoriteModel.dart';
import 'package:shop_app/model/HomeModel/home_model.dart';

import '../../model/LoginModel/shopLoginModel.dart';
import '../../model/cart/add_cart_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeBottomNaveState extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates {}

class ShopSuccessHomeDataState extends ShopStates {}

class ShopErrorHomeDataState extends ShopStates {}

class ShopLoadingCategoriesState extends ShopStates {}

class ShopSuccessCategoriesState extends ShopStates {}

class ShopErrorCategoriesState extends ShopStates {}

class ShopSuccessFavoritesState extends ShopStates {
  ChangeFavoritesModel? model;

  ShopSuccessFavoritesState(this.model);
}

class ShopChangeFavoritesState extends ShopStates {}

class ChangeFavoritesSuccessStates extends ShopStates
{
  final  ChangeFavoritesModel model;

  ChangeFavoritesSuccessStates(this.model);

}

class ShopErrorFavoritesState extends ShopStates {}

class ShopSuccessGetFavoritesState extends ShopStates {}

class ShopErrorGetFavoritesState extends ShopStates {}

class ShopLoadingGetFavoritesState extends ShopStates {}

class ShopSuccessUserDataState extends ShopStates {}

class ShopErrorUserDataState extends ShopStates {}

class ShopLoadingUserDataState extends ShopStates {}

class ProductLoadingStates extends ShopStates {}

class ProductSuccessStates extends ShopStates {
  ProductResponse? productResponse;

  ProductSuccessStates(this.productResponse);
}

class ProductErrorStates extends ShopStates {}

class ChangeCartStates extends ShopStates {}

class ChangeCartSuccessStates extends ShopStates {
  ChangeCartModel? model;

  ChangeCartSuccessStates(this.model);
}

class ChangeCartErrorStates extends ShopStates {}

class CartLoadingStates extends ShopStates {}

class GetCartSuccessStates extends ShopStates {}

class GetCartErrorStates extends ShopStates {}

class UpdateCartLoadingStates extends ShopStates {}

class UpdateCartSuccessStates extends ShopStates {}

class UpdateCartErrorStates extends ShopStates {}

class CategoryDetailsLoadingStates extends ShopStates {}

class CategoryDetailsSuccessStates extends ShopStates {}

class CategoryDetailsErrorStates extends ShopStates {}

class UserUpdateLoadingStates extends ShopStates {}

class UserUpdateSuccessStates extends ShopStates {
  LoginModel? userData;

  UserUpdateSuccessStates(this.userData);
}

class UserUpdateErrorStates extends ShopStates {
  final String error;

  UserUpdateErrorStates( this.error);
}
