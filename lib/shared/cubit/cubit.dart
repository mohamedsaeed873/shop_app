// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/model/HomeModel/home_model.dart';
import 'package:shop_app/modules/Home/home_screen.dart';
import 'package:shop_app/shared/components/conest.dart';
import 'package:shop_app/shared/cubit/state.dart';
import 'package:shop_app/shared/network/end_pointe.dart';
import 'package:shop_app/shared/network/remot/dio_helper.dart';

import '../../model/Category/category_details_model.dart';
import '../../model/Category/category_model.dart';
import '../../model/Favorite/favoriteModel.dart';
import '../../model/LoginModel/shopLoginModel.dart';
import '../../model/cart/add_cart_model.dart';
import '../../model/cart/get_cart_model.dart';
import '../../model/cart/update_cart_model.dart';
import '../../modules/Categories/categories_screen.dart';
import '../../modules/Favorites/favorite_screen.dart';
import '../../modules/Settings/setting-screen.dart';
import '../components/components.dart';
import '../network/local/cache_helper.dart';

class ShopCupit extends Cubit<ShopStates> {
  ShopCupit() : super(ShopInitialState());

  static ShopCupit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  Map<dynamic, dynamic> car = {};
  Map<dynamic, dynamic> favorites = {};

  List<Widget> bottomScreens = [
    ProductsScreen(),
    Categories(),
    FavoritesScreen(),
    SettingScreen(),
  ];


  // ignore: non_constant_identifier_names
  void ChangeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNaveState());
  }

  HomeModel? homeModel;


  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      //printFullText(homeModel.data.banners.toString());
      //print(homeModel!.status);
      print(token);

      homeModel!.data!.products.forEach((element) {
        favorites.addAll({
          element.id!: element.inFavorites!,
        });
      });
      print(favorites);

      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel? categoriesModel;

  void getCategories() {
    emit(ShopLoadingCategoriesState());
    DioHelper.getData(
      url: GetCategories,
      token: token,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      //printFullText(homeModel.data.banners.toString());
      print(categoriesModel!.status);
      print(token);

      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }


  CategoryDetailModel? categoriesDetailModel;
  void getCategoriesDetailData(int categoryID) {
    emit(CategoryDetailsLoadingStates());
    DioHelper.getData(url: "categories/$categoryID", query: {
      'category_id': '$categoryID',
    }).then((value) {
      categoriesDetailModel = CategoryDetailModel.fromJson(value.data);
      categoriesDetailModel!.data!.productData!.forEach((element) {});
      print('categories Detail ${categoriesDetailModel!.status}');
      emit(CategoryDetailsSuccessStates());
    }).catchError((error) {
      emit(CategoryDetailsErrorStates());
      print(error.toString());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites(int productID) {
    favorites[productID] = !favorites[productID];
    emit(ShopChangeFavoritesState());

    DioHelper.postData(url: FAVORITES, token: token, data: {
      'product_id': productID,
    }).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      print(value.data);

      if (!changeFavoritesModel!.status!) {
        favorites[productID] = !favorites[productID];
      } else {
        getFavoritesData();
      }
      emit(ShopSuccessFavoritesState(changeFavoritesModel!));
    }).catchError((error) {
      favorites[productID] = !favorites[productID];
      emit(ShopErrorFavoritesState());
    });
  }

  FavoritesModel? favoritesModel;

  void getFavoritesData() {
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavoritesState());
    });
  }

  LoginModel? UserData;

  void getUserData() {
    emit(ShopLoadingUserDataState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      UserData = LoginModel.fromJson(value.data);
      emit(ShopSuccessUserDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUserDataState());
    });
  }

  ProductResponse? productResponse;

  Future getProductData(productId) async {
    productResponse ;
    emit(ProductLoadingStates());
    return await DioHelper.getData(url: 'products/$productId', token: token)
        .then((value) {
      productResponse = ProductResponse.fromJson(value.data);
      //print('Product Detail '+productsModel.status.toString());
      emit(ProductSuccessStates(productResponse!));
    }).catchError((error) {
      emit(ProductErrorStates());
      print(error.toString());
    });
  }


  void UpdateUserData({
    required String email,
    required String name,
    required String phone,
    String? image,
  }) {
    emit(UserUpdateLoadingStates());

    DioHelper.putData(
      url: UPDATE,
      token: token,
      data: {
        'email': email,
        'name': name,
        'phone': phone,
      },
    ).then((value) {
      UserData = LoginModel.fromJson(value.data);
      emit(UserUpdateSuccessStates(UserData!));
    }).catchError((error) {
      print(error.toString());
      emit(UserUpdateErrorStates(error.toString()));
    });
  }


  // changeCart
  ChangeCartModel? changeCartModel;
  void changeCart(int productId) {
    // cart[productId] = !cart[productId];
    emit(ChangeCartStates());
    DioHelper.postData(
      url: CARTS,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      changeCartModel = ChangeCartModel.fromJson(value.data);
      // print('changeCartModel ' + changeCartModel.status.toString());
      if (changeCartModel!.status!) {
        getCartData();
        getHomeData();
      } else
        ShowToast(
          text: changeCartModel!.message!,
          state: ToastStates.SUCCESS,
        );
      emit(ChangeCartSuccessStates(changeCartModel!));
    }).catchError((error) {
      emit(ChangeCartErrorStates());
      print(error.toString());
    });
  }

  // get cart data
  CartModel? cartModel;

  void getCartData() {
    emit(CartLoadingStates());
    DioHelper.getData(url: CARTS, token: token).then((value) {
      cartModel = CartModel.fromJson(value.data);
      // print('Get Cart'+cartModel.toString());
      emit(GetCartSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(GetCartErrorStates());
    });
  }

// update cart
  UpdateCartModel? updateCartModel;
  void updateCartData(int id, int quantity) {
    emit(UpdateCartLoadingStates());
    DioHelper.putData(
        url: 'carts/$id',
        data: {
          'quantity': '$quantity',
        },
        token: token)
        .then((value) {
      updateCartModel = UpdateCartModel.fromJson(value.data);
      if (updateCartModel!.status!) {
        getCartData();
      } else
        ShowToast(
          text: updateCartModel!.message!,
          state: ToastStates.SUCCESS,
        );
      //  print('updateCartModel ' + updateCartModel.status.toString());
      emit(UpdateCartSuccessStates());
    }).catchError((error) {
      emit(UpdateCartErrorStates());
      print(error.toString());
    });
  }
}
