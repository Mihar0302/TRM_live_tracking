import 'package:flutter/material.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import '../utils/app_color.dart';
import '../utils/app_images.dart';

class CustomLoadingPopup extends StatelessWidget {
  final bool lodaing;
  final Widget child;

  const CustomLoadingPopup(
      {super.key, required this.lodaing, required this.child});

  @override
  Widget build(BuildContext context) {
    return OverlayLoaderWithAppIcon(
        overlayBackgroundColor: Colors.black,
        isLoading: lodaing,
        circularProgressColor: AppColor.primaryColor,
        appIcon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(AppImages.logo),
        ),
        child: child);
  }
}
