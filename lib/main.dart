// ignore_for_file: must_be_immutable, unused_local_variable, unnecessary_null_comparison, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/onBoarding/on_boarding.dart';
import 'package:shop_app/shared/components/conest.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/state.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remot/dio_helper.dart';
import 'package:shop_app/shared/styles/styles.dart';
import 'package:shop_app/test/startWidget.dart';

import 'bloc_observer.dart';
import 'layout/Auth/login/login_screen.dart';
import 'layout/ShopApp/shopLayout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  BlocOverrides.runZoned(
    () {},
    blocObserver: MyBlocObserver(),
  );
  await DioHelper.init();
  await CacheHelper.init();

  //bool? isDark = CacheHelper.getBoolean(key: 'isDark');
  Widget widget;

  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');

  token = CacheHelper.getData(key: 'token');

  if (onBoarding != null) {
    if (token != null)
      widget = ShopLayout();
    else
      widget = LoginScreen();
  } else {
    widget = OnBoarding();
  }

  runApp(Myapp(
    startWidget: widget,
     //isDark: isDark,
  ));
}

class Myapp extends StatelessWidget {
  //final bool? isDark;
  final Widget startWidget;

  Myapp({Key? key, required this.startWidget,
    //this.isDark
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => ShopCupit()
              ..getHomeData()
              ..getUserData()
              ..getCartData()
              ..getFavoritesData()
              ..getCategories()),
      ],
      child: BlocConsumer<ShopCupit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.light,
            debugShowCheckedModeBanner: false,
            home:startWidget,
          );
        },
      ),
    );
  }
}
