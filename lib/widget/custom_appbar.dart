import 'package:flutter/material.dart';

import '../utils/app_color.dart';
import '../utils/app_images.dart';

class CustomAppbar extends StatelessWidget {
  final String lable;
  final Function fun;
  final Function funfilter;
  final bool changimg;
  final double sizechange;
  final bool filter;
  final bool widget;
  final Widget? child;
  final Size size;

  const CustomAppbar({
    Key? key,
    required this.lable,
    required this.fun,
    this.changimg = true,
    required this.sizechange,
    this.filter = false,
    required this.funfilter,
    this.widget = false,
    this.child,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 15,
        bottom: 12,
      ),
      decoration: BoxDecoration(
        color: AppColor.primaryColor,
      ),
      child: Stack(
        children: [
          Center(
              child: widget
                  ? child
                  : Text(
                      lable,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        fontSize: sizechange,
                        fontFamily: "palanquin_regular",
                        fontWeight: FontWeight.w500,
                        color: AppColor.white,
                      ),
                    )),
          filter
              ? Container()
              : Positioned(
                  left: size.width * 0.05,
                  top: 0,
                  bottom: 0,
                  child: InkWell(
                    onTap: () => fun(),
                    child: changimg
                        ? Image.asset(AppImages.logo,
                            fit: BoxFit.contain,
                            color: AppColor.white,
                            height: size.height * 0.06,
                            width: size.width * 0.08)
                        : const Icon(Icons.arrow_back_ios_new_rounded,
                            color: Colors.white),
                  ),
                ),
        ],
      ),
    );
  }
}
