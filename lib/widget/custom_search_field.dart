import 'package:flutter/material.dart';
import '../utils/app_color.dart';

class CustomSearchField extends StatelessWidget {
  final Size size;
  final TextEditingController controller;
  final Function? onChanged;
  final String? hintText;

  const CustomSearchField(
      {Key? key,
      required this.size,
      required this.controller,
      this.onChanged,
      this.hintText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.06,
      ),
      child: Container(
        height: size.width * 0.12,
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
        decoration: BoxDecoration(
            color: AppColor.greyColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(size.width * 0.03)),
        child: Row(
          children: [
            SizedBox(
              width: size.width * 0.06,
              height: size.width * 0.06,
              child: const Icon(Icons.search),
            ),
            Expanded(
              child: TextFormField(
                autofocus: false,
                onChanged: (value) {
                  onChanged!(value);
                },
                controller: controller,
                cursorColor: AppColor.greyColor,
                style: TextStyle(
                  fontSize: size.width * 0.04,
                  color: AppColor.blackColor,
                ),
                decoration: InputDecoration(
                  isDense: true,
                  hintText: hintText ?? "Search by ID, Date, Status",
                  hintStyle: TextStyle(
                      color: AppColor.greyColor.withOpacity(0.7),
                      fontSize: size.height * 0.017),
                  contentPadding: EdgeInsets.only(left: size.width * 0.05),
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
