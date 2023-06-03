import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({
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
        key: const Key("pageTitleAppBar"),
        'Back',
        style: TextStyle(
          fontSize: 16,
          color: Colors.black87,
        ),
      ),
      actions: [],
      centerTitle: false,
      elevation: 0,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size(200, 40);
}
