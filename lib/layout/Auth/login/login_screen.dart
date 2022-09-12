// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, prefer_const_constructors, avoid_print

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/Auth/register/register.dart';
import 'package:shop_app/shared/components/conest.dart';

import '../../../modules/Home/home_screen.dart';
import '../../../shared/components/components.dart';
import '../../../shared/network/local/cache_helper.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';

class LoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => loginCubit(),
      child: BlocConsumer<loginCubit, LoginStates>(
        listener: (context, state) {
          if (state is ShopLoginSuccessStates) {
            if (state.loginModel!.status!) {
              ShowToast(
                text: state.loginModel!.message!,
                state: ToastStates.SUCCESS,
              );
              print(state.loginModel!.message);
              print(state.loginModel!.data!.token);

              CacheHelper.savaData(
                      key: "token", value: state.loginModel!.data!.token)
                  .then((value) {
                token = state.loginModel!.data!.token!;
                navigateToFinsh(context, ProductsScreen());
              });
            } else {
              ShowToast(
                text: state.loginModel!.message!,
                state: ToastStates.ERROR,
              );
              print(state.loginModel!.message);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Login Now to get our hot offers!",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        defaultTextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          prefix: Icons.email,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'Please enter email';
                            }
                            return null;
                          },
                          label: 'Email',
                          hint: 'Enter your email',
                          onSubmit: (val) {},
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        defaultTextFormField(
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          prefix: Icons.key,
                          suffix: loginCubit.get(context).suffix,
                          isPassword: loginCubit.get(context).isPassword,
                          suffixPressed: () {
                            loginCubit.get(context).ChangePassword();
                          },
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'Please enter password';
                            }
                            return null;
                          },
                          label: 'Password',
                          hint: 'Enter your password',
                                  onSubmit: (val) {},
                        ),
                        defaultTextButton(
                          function: () {},
                          text: "Forgotten password?",
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopLoginSuccessStates,
                          builder: (context) => Center(
                            child: defaultMaterialButton(
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  loginCubit.get(context).UserLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              },
                              text: 'Login',
                              radius: 20,
                            ),
                          ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text(
                              'Don\'t have an account?',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            defaultTextButton(
                              function: () {
                                navigateTo(context, Register());
                              },
                              text: 'Register Now!',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
