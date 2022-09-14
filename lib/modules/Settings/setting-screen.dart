// ignore_for_file: use_key_in_widget_constructors, unused_local_variable, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/state.dart';

import '../../shared/components/conest.dart';
import '../cart/cart.dart';
import '../edit/edit.dart';

class SettingScreen extends StatefulWidget {
  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    bool value = false;

    return BlocConsumer<ShopCupit, ShopStates>(
      listener: (context, state) {
        if (state is ShopSuccessUserDataState) {}
      },
      builder: (context, state) {
        var model = ShopCupit.get(context).UserData;
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 200,
                      color: Colors.blue,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 90,
                          backgroundImage: NetworkImage(model!.data!.image!),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: IconButton(
                          onPressed: () {
                            navigateTo(context, EditScreen());
                          },
                          icon: Icon(
                            Icons.edit,
                            size: 30,
                          )),
                    ),
                    Positioned(

                      bottom: 10,
                      left: 20,
                      child: Text(
                        model.data!.email!,
                        style: TextStyle(
                            color: Colors.grey, fontSize: 20),
                      ),
                    ),
                    Positioned(
                      bottom: 50,
                      left: 20,
                      child: Text(
                        model.data!.name!,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                  ],
                ),
                //thisIs MyProfile

                InkWell(
                  onTap: () {
                    navigateTo(context, EditScreen());
                  },
                  child: Container(
                    padding: EdgeInsets.all(15),
                    child: Row(
                      children: [
                        Icon(
                          Icons.person,
                          color: Colors.blue,
                          size: 35,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'My Profile',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Spacer(),
                        Icon(
                          Icons.chevron_right_outlined,
                          color: Colors.black,

                          size: 35,
                        ),
                      ],
                    ),
                  ),
                ),

                //thisIs Notifications
                InkWell(
                  onTap: () {
                    //navigateTo(context, EditScreen());
                  },
                  child: Container(
                    padding: EdgeInsets.all(15),
                    child: Row(
                      children: [
                        Icon(
                          Icons.notifications,
                          color: Colors.blue,
                          size: 35,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'Notifications',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Spacer(),
                        Icon(
                          Icons.chevron_right_outlined,
                          color: Colors.black,

                          size: 35,
                        ),
                      ],
                    ),
                  ),
                ),
                //thisIs My Orders
                InkWell(
                  onTap: () {
                    navigateTo(context, CartScreen());
                  },
                  child: Container(
                    padding: EdgeInsets.all(15),
                    child: Row(
                      children: [
                        Icon(
                          Icons.shopping_cart_outlined,
                          color: Colors.blue,
                          size: 35,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'My Orders',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),

                        ),
                        Spacer(),
                        Icon(
                          Icons.chevron_right_outlined,
                          color: Colors.black,

                          size: 35,
                        ),
                      ],
                    ),
                  ),
                ),
                //thisIs Complaints
                InkWell(
                  onTap: () {
                    //  navigateTo(context, EditScreen());
                  },
                  child: Container(
                    padding: EdgeInsets.all(15),
                    child: Row(
                      children: [
                        Icon(
                          Icons.markunread_sharp,
                          color: Colors.blue,
                          size: 35,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'Connect with us',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Spacer(),
                        Icon(
                          Icons.chevron_right_outlined,
                          color: Colors.black,

                          size: 35,
                        ),
                      ],
                    ),
                  ),
                ),

                InkWell(
                  onTap: () {
                    //  navigateTo(context, EditScreen());
                  },
                  child: Container(
                    padding: EdgeInsets.all(15),
                    child: Row(
                      children: [
                        Icon(
                          Icons.share,
                          color: Colors.blue,
                          size: 35,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'Share',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Spacer(),
                        Icon(
                          Icons.chevron_right_outlined,
                          color: Colors.black,

                          size: 35,
                        ),
                      ],
                    ),
                  ),
                ),

                //thisIs About us

                InkWell(
                  onTap: () {
                    // navigateTo(context, EditScreen());
                  },
                  child: Container(
                    padding: EdgeInsets.all(15),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info,
                          color: Colors.blue,
                          size: 35,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'About us',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Spacer(),
                        Icon(
                          Icons.chevron_right_outlined,
                          color: Colors.black,

                          size: 35,
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    SignOut(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(15),
                    child: Row(
                      children: [
                        Icon(
                          Icons.logout,
                          color: Colors.blue,
                          size: 35,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'Log Out',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Spacer(),
                        Icon(
                          Icons.chevron_right_outlined,
                          color: Colors.black,

                          size: 35,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
