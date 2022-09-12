import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/model/HomeModel/home_model.dart';
import 'package:shop_app/modules/Home/home_screen.dart';
import 'package:shop_app/shared/components/conest.dart';
import 'package:shop_app/shared/cubit/state.dart';
import 'package:shop_app/shared/network/end_pointe.dart';
import 'package:shop_app/shared/network/remot/dio_helper.dart';

import '../../model/Category/category_model.dart';
import '../../model/Favorite/favoriteModel.dart';
import '../../modules/Categories/categories_screen.dart';
import '../../modules/Favorites/favorite_screen.dart';
import '../../modules/Settings/setting-screen.dart';

class ShopCupit extends Cubit<ShopStates> {
  ShopCupit() : super(ShopInitialState());

  static ShopCupit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens = [
    ProductsScreen(),
    Categories(),
     FavoritesScreen(),
     Setting(),
  ];

  void ChangeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNaveState());
  }

  HomeModel? homeModel;
  Map<dynamic, dynamic> favorites = {};

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

  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites(int id) {
    favorites[id] = !favorites[id];
    emit(ShopChangeFavoritesState());
    DioHelper.postData(
      url: FAVORITES,
      data: {
        "product_id": id,
      },
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      print(value.data);
      if (!changeFavoritesModel!.status!) {
        favorites[id] = !favorites[id];
      }
      emit(ShopSuccessFavoritesState(changeFavoritesModel));
    }).catchError((onError) {
      favorites[id] = !favorites[id];
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
}
