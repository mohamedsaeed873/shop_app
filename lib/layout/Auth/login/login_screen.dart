import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/Auth/register/register.dart';
import 'package:shop_app/layout/ShopApp/shopLayout.dart';
import 'package:shop_app/modules/Favorites/favorite_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

import '../../../shared/styles/colors.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';


class LoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return BlocProvider(
        create: (BuildContext context) => ShopLoginCubit(),
        child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
          listener: (context, state) {
        if (state is ShopLoginSuccessStates) {
              if (state.loginModel!.status!) {
                print(state.loginModel!.message);
                print(state.loginModel!.data!.token);
                ShowToast(
                  state: ToastStates.SUCCESS,
                  text: state.loginModel!.message!,
                );
               CacheHelper.savaData(
                      key: 'token', value: state.loginModel!.data!.token)
                   .then((value) => {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ShopLayout())),
                       });
              } else {
                print(state.loginModel!.message);
                ShowToast(
                  state: ToastStates.ERROR,
                  text: state.loginModel!.message!,
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
                          Text('LOGIN',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(
                                    color: Colors.black,
                                  )),
                          Text(
                            'Login now to browse our hot offers',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Colors.grey),
                          ),
                          SizedBox(
                            height: 40,
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
                            isPassword: ShopLoginCubit.get(context).ispassword,
                            type: TextInputType.visiblePassword,
                            onSubmit: (val) {
                              if (formKey.currentState!.validate()) {
                                ShopLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    context: context,
                                    password: passwordController.text);
                              }
                            },
                            validate: (String? val) {
                              if (val!.isEmpty) {
                                return 'please enter your password';
                              } else
                                return null;
                            },
                            label: "Password",

                            suffixPressed: () {
                              ShopLoginCubit.get(context)
                                  .ChangePasswordVisibility();
                            },
                            suffix:  ShopLoginCubit.get(context).suffix,
                            prefix: Icons.lock,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          ConditionalBuilder(
                            condition: state is! ShopLoginLoadingStates,
                            builder: (context) => defaultButton(
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    ShopLoginCubit.get(context).userLogin(
                                        email: emailController.text,
                                        context: context,
                                        password: passwordController.text);
                                  }
                                },
                                isUpperCase: true,
                                text: 'LOGIN'),
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
                                    navigateTo(context, Register());

                                  }, text: "REGISTER")
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
