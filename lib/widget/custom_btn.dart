import 'package:flutter/material.dart';

import '../utils/app_color.dart';

class Btn extends StatelessWidget {
  final Size size;
  final String title;
  final Function func;
  final Color? color;

  const Btn(
      {Key? key,
      required this.size,
      required this.title,
      required this.func,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.1,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? AppColor.primaryColor,
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
          ),
        ),
        onPressed: () {
          func();
        },
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: size.height * 0.020),
          child: Text(
            title,
            style:
                TextStyle(fontSize: size.width * 0.04, color: AppColor.white),
          ),
        ),
      ),
    );
  }
}
