// ignore: duplicate_ignore, 
// ignore_for_file: avoid_print

// ignore_for_file:

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/Auth/register/register.dart';
import 'package:shop_app/layout/ShopApp/shopLayout.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/conest.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

import '../../../shared/styles/colors.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';


// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  LoginScreen({Key? key}) : super(key: key);

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
<<<<<<< HEAD
                // ignore:
                print(state.loginModel!.message);
                //print(state.loginModel!.data!.token);
                ShowToast(
                  state: ToastStates.SUCCESS,
                  text: state.loginModel!.message!,
                );
               CacheHelper.savaData(
                      key: 'token', value: state.loginModel!.data!.token)
                   .then((value) => {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const ShopLayout())),
                       });
=======
                ShowToast(
                  text: state.loginModel!.message!,
                  state: ToastStates.SUCCESS,
                );
                print(state.loginModel!.message);
                print(state.loginModel!.data!.token);

                CacheHelper.savaData(
                    key: "token", value: state.loginModel!.data!.token)
                    .then((value) {
                  token = state.loginModel!.data!.token;
                  navigateToFinsh(context, ShopLayout());
                });
>>>>>>> 5b57fedc3859fb07452041e73b517208d017bf0a
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
                         const SizedBox(
                            height: 40,
                          ),
                          defaultTextFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validate: (String? val) {
                              if (val!.isEmpty) {
                                return 'please enter your emailAddress';
                              } else {
                                return null;
                              }
                            },
                            label: "Email Address",
                            prefix: Icons.email_outlined,
                          ),
                        const  SizedBox(
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
                              } else {
                                return null;
                              }
                            },
                            label: "Password",

                            suffixPressed: () {
                              ShopLoginCubit.get(context)
                                  .ChangePasswordVisibility();
                            },
                            suffix:  ShopLoginCubit.get(context).suffix,
                            prefix: Icons.lock,
                          ),
                          const SizedBox(
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
                            fallback: (context) => const Center(
                              child: CircularProgressIndicator(
                                color: defaultColor,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Don\'t have an account?'),
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
