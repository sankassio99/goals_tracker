import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget>? actions;
  final Widget? leading;
  final String? title;

  const MyAppBar({
    this.title,
    this.leading,
    this.actions,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      automaticallyImplyLeading: false,
      leading: leading,
      title: Text(
        key: const Key("pageTitleAppBar"),
        (title ?? ""),
        style: const TextStyle(
          fontSize: 18,
          color: Colors.black87,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: actions,
      centerTitle: true,
      elevation: 0,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(4.0),
        child: Container(
          color: Theme.of(context).colorScheme.outline,
          height: 2.0,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size(200, 40);
}
