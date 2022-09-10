import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/model/HomeModel/home_model.dart';
import 'package:shop_app/modules/Home/home_screen.dart';
import 'package:shop_app/shared/components/conest.dart';
import 'package:shop_app/shared/cubit/state.dart';
import 'package:shop_app/shared/network/end_pointe.dart';
import 'package:shop_app/shared/network/remot/dio_helper.dart';

import '../../modules/Categories/categories_screen.dart';
import '../../modules/Favorites/favorite_screen.dart';
import '../../modules/Settings/setting-screen.dart';

class ShopCupit extends Cubit<ShopStates> {
  ShopCupit() : super(ShopInitialState());

  static ShopCupit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens = [
     HomeScreen(),
    const Categories(),
    const Favorits(),
    const Setting(),
  ];

  void ChangeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNaveState());
  }

   HomeModel? hjomeModel;

  void GetHomeData() {
    emit(ShopLoadingHomeDataState());

    DioHelper.getData(url: HOME, token: token).then((value) {
      hjomeModel = HomeModel.fromJson(value.data);
      print(hjomeModel!.status);
      emit(ShopSuccessHomeDataState());
      printFullText(hjomeModel!.data!.banners![0].image.toString());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
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
      print(homeModel!.status);
      print(token);

      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }
}
