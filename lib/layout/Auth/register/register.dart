import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/Auth/login/login_screen.dart';
import 'package:shop_app/layout/ShopApp/shopLayout.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

import '../../../shared/styles/colors.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';

class Register extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => ShopRegisterCubit(),
        child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
          listener: (context, state) {
            if (state is ShopRegisterSuccessStates) {
              if (state.loginModel.status!) {
                print(state.loginModel.message);
                print(state.loginModel.data!.token);

                ShowToast(
                  state: ToastStates.SUCCESS,
                  text: state.loginModel.message!,
                );
                CacheHelper.savaData(
                        key: 'token', value: state.loginModel.data!.token)
                    .then((value) => {navigateToFinsh(context, LoginScreen())}).catchError((error){
                      print('mohamed${error}');

                });
              } else {
                print(state.loginModel.message);

                ShowToast(
                  state: ToastStates.ERROR,
                  text: state.loginModel.message!,
                );
              }
            }
          },
          builder: (context, state) {
            return Scaffold(
                appBar: AppBar(),
                body: Center(
                    child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('REGISTER',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(
                                    color: Colors.black,
                                  )),
                          Text(
                            'Register now to browse our hot offers',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Colors.grey),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          defaultTextFormField(
                            controller: nameController,
                            type: TextInputType.name,
                            validate: (String? val) {
                              if (val!.isEmpty) {
                                return 'please enter your User Name';
                              } else
                                return null;
                            },
                            label: "User Name",
                            prefix: Icons.person,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          defaultTextFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validate: (String? val) {
                              if (val!.isEmpty) {
                                return 'please enter your emailAddress';
                              } else
                                return null;
                            },
                            label: "Email Address",
                            prefix: Icons.email_outlined,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          defaultTextFormField(
                            controller: passwordController,
                            isPassword:
                                ShopRegisterCubit.get(context).ispassword,
                            type: TextInputType.visiblePassword,
                            onSubmit: (val) {},
                            validate: (String? val) {
                              if (val!.isEmpty) {
                                return 'please enter your password';
                              } else
                                return null;
                            },
                            label: "Password",
                            suffixPressed: () {
                              ShopRegisterCubit.get(context)
                                  .ChangePasswordVisibility();
                            },
                            suffix: ShopRegisterCubit.get(context).suffix,
                            prefix: Icons.lock,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          defaultTextFormField(
                            controller: phoneController,
                            type: TextInputType.phone,
                            validate: (String? val) {
                              if (val!.isEmpty) {
                                return 'please enter your PhoneNumber';
                              } else
                                return null;
                            },
                            label: "Phone Number",
                            prefix: Icons.phone,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          ConditionalBuilder(
                            condition: state is! ShopRegisterLoadingStates,
                            builder: (context) => defaultButton(
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    ShopRegisterCubit.get(context).userRegister(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      context: context,
                                    );
                                  }
                                },
                                isUpperCase: true,
                                text: 'REGISTER'),
                            fallback: (context) => Center(
                              child: CircularProgressIndicator(
                                color: defaultColor,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Don\'t have an account?'),
                              defaultTextButton(
                                  function: () {
                                    navigateTo(context, LoginScreen());
                                  },
                                  text: "Login")
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                )));
          },
        ));
  }
}
