import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget>? widget;

  const MyAppBar({
    this.widget,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: IconButton(
        key: const Key("backIconButton"),
        icon: const Icon(
          Icons.arrow_back_rounded,
          color: Colors.black87,
          size: 20,
        ),
        onPressed: () {
          Get.toNamed("/home");
        },
      ),
      title: const Text(
        key: Key("pageTitleAppBar"),
        'Back',
        style: TextStyle(
          fontSize: 16,
          color: Colors.black87,
        ),
      ),
      actions: widget,
      centerTitle: false,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size(200, 40);
}
