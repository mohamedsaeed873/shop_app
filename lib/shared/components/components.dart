// ignore_for_file: non_constant_identifier_names, avoid_types_as_parameter_names, constant_identifier_names

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/onBoarding/on_boarding.dart';
import 'package:shop_app/shared/styles/colors.dart';

Widget myDivider() => Container(
  width: double.infinity,
  height: 1.0,
  color: Colors.grey[300],
);


Widget defaultMaterialButton({
  required Function function,
  required String text,
  double width = 200,
  double height = 40.0,
  double radius = 3.0,
  bool isUpperCase = true,
  Function? onTap,
}) =>
    Container(
      width: width,
      height: height,
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: defaultColor,
        //  color: background,
      ),
    );

Widget buildBoardingItem(BoardingModel model) {
  return Column(
    children: [
      Expanded(child: Image(image: AssetImage('${model.image}'))),
      Text(
        '${model.title}',
        style: const TextStyle(fontSize: 24.0),
      ),
      const SizedBox(
        height: 30,
      ),
      Text('${model.body}'),
    ],
  );
}

Widget defaultTextFormField({
  FocusNode? focusNode,
  required TextEditingController controller,
  required TextInputType keyboardType,
  required String? Function(String?) validate,
  required String label,
  String? hint,
  onTap,
  onChanged,
  Function(String)? onFieldSubmitted,
  bool isPassword = false,
  bool isClickable = true,
  InputDecoration? decoration,
  IconData? suffix,
  IconData? prefix,
  Function? suffixPressed,  Null Function(dynamic val)? onSubmit,
}) =>
    TextFormField(
      focusNode: FocusNode(),
      style: TextStyle(),
      maxLines: 1,
      minLines: 1,
      controller: controller,
      validator: validate,
      enabled: isClickable,
      onTap: onTap,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      obscureText: isPassword,
      keyboardType: keyboardType,
      autofocus: false,
      decoration: InputDecoration(
        prefixIcon: Icon(
          prefix,
          color: Colors.grey,
        ),
        suffixIcon: suffix != null
            ? IconButton(
          onPressed: () {
            suffixPressed!();
          },
          icon: Icon(
            suffix,
            color: Colors.grey,
          ),
        )
            : null,
        filled: true,
        isCollapsed: false,
        hoverColor: Colors.red.withOpacity(0.2),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
          borderSide: BorderSide(
            color: defaultColor,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
          borderSide: BorderSide(
            color: defaultColor,
          ),
        ),
        labelText: label,
        labelStyle: TextStyle(
          fontStyle: FontStyle.italic,
        ),
        hintText: hint,
        hintStyle: TextStyle(color: Colors.white),
        focusColor: Colors.white,
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
          borderSide: BorderSide(
            color: defaultColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
          borderSide: BorderSide(
            color: defaultColor,
          ),
        ),
      ),
    );

Widget defaultTextButton({
  required Function function,
  required String text,
}) =>
    TextButton(
      onPressed: () {
        function();
      },
      child: Text(text.toUpperCase()),
    );

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 3.0,
  required Function function,
  required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
      ),
    );

// ignore:
void navigateTo(context, Widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Widget,
      ),
    );

void navigateToFinsh(context, Widget) => Navigator.pushReplacement(
    context, MaterialPageRoute(builder: (context) => Widget));

void ShowToast({
  required String text,
  required ToastStates state,
}) =>
  Fluttertoast.showToast(
      msg: text,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: ShoosToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0);

enum ToastStates { SUCCESS , ERROR , WARNING }

Color ShoosToastColor(ToastStates state){
  Color color ;
  switch(state){

    case ToastStates.SUCCESS:
      color=Colors.green;
      break;

    case ToastStates.ERROR:
      color=Colors.red;
      break;

    case ToastStates.WARNING:
      color=Colors.amber;
      break;
  }

  return color;

}
