import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trm/utils/app_images.dart';

class EmptyActiveOrder extends StatelessWidget {
  final String text;

  const EmptyActiveOrder({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 400,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppImages.orderEmpty,
              width: 186,
              height: 180,
              fit: BoxFit.contain,
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              text,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class EmptyOrder extends StatelessWidget {
  const EmptyOrder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 400,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppImages.orderEmpty,
              width: 186,
              height: 180,
              fit: BoxFit.contain,
            ),
            SizedBox(
              height: 24,
            ),
            Text(
              "YOU_HAVE_NO_ORDER_HISTORY",
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              "WAIT_NOTE".tr,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
