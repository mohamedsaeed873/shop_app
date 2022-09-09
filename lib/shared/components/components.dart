import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/onBoarding/on_boarding.dart';

Widget buildBoardingItem(BoardingModel model) {
  return Column(
    children: [
      Expanded(child: Image(image: AssetImage('${model.image}'))),
      Text(
        '${model.title}',
        style: TextStyle(fontSize: 24.0),
      ),
      SizedBox(
        height: 30,
      ),
      Text('${model.body}'),
    ],
  );
}

Widget defaultTextFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmit,
  Function? onChange,
  Function? onTap,
  required Function validate,
  required String label,
  required IconData prefix,
  bool isPassword = false,
  bool isClickable = true,
  IconData? suffix,
  Function? suffixPressed,
  Color? fillColor,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      onFieldSubmitted: (s) {
        onSubmit!();
      },
      onChanged: (o) {
        onChange ?? '';
      },
      enabled: isClickable,
      onTap: () {
        onTap ?? '';
      },
      validator: (v) {
        return validate(v);
      },
      decoration: InputDecoration(
        labelText: label,
        // labelStyle: TextStyle(color: Colors.white),
        prefixIcon: Icon(
          prefix,
          color: Colors.black,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: () {
                  suffixPressed!();
                },
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: const OutlineInputBorder(),
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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );

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