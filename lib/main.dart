
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/state.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remot/dio_helper.dart';
import 'package:shop_app/shared/styles/styles.dart';
import 'package:shop_app/test/startWidget.dart';

import 'bloc_observer.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ignore: deprecated_member_use
  BlocOverrides.runZoned(
    () {},
    blocObserver: MyBlocObserver(),
  );
  DioHelper.init();
  await CacheHelper.init();
  //Widget widget;

   /* bool onBoarding = CacheHelper.getData(key: 'onBoarding');
    String token = CacheHelper.getData(key: 'token');


    if (onBoarding != null) {
      if (token != null) {
      widget =  ShopLayout();
      } else {
        widget =  LoginScreen();
      }
    } else {
      widget = OnBoarding();
    }*/


  runApp(const MyApp());
  //startWidget: widget
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  //final Widget startWidget;

 // MyApp({required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (BuildContext context) => ShopCupit()..getHomeData()),
        ],
        child: BlocConsumer<ShopCupit, ShopStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Shop App',
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: ThemeMode.light,
              home: const StartWidget(),

            );
          },
        ));
  }
}
