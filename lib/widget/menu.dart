import 'package:e_posyandu/app_color.dart';
import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  final String? name;
  final IconData? icon;
  final VoidCallback? onTap;
  final bool? isLast;

  const Menu(
      {Key? key,
      @required this.name,
      @required this.icon,
      @required this.onTap,
      this.isLast = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: !isLast!
                  ? BorderSide(
                      color: AppColor.boxGrey.withOpacity(0.5), width: 1.5)
                  : BorderSide(color: Colors.transparent),
            )),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(right: 10),
              child: Icon(
                icon,
                color: AppColor.black,
                size: 18,
              ),
            ),
            Expanded(
              child: Text(
                name!,
                style: TextStyle(
                  color: AppColor.black,
                  fontSize: 14,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Icon(
                Icons.arrow_right_rounded,
                color: AppColor.black,
                size: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
