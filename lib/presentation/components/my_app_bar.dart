import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

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
        key: Key("pageTitleAppBar"),
        'Back',
        style: TextStyle(
          fontSize: 16,
          color: Colors.black87,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(
            PhosphorIcons.regular.gear,
            color: Colors.white,
          ),
          tooltip: 'Edit',
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('This is a snackbar')));
          },
        ),
      ],
      centerTitle: false,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size(200, 40);
}
