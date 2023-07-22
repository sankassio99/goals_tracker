import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget>? actions;
  final Widget? leading;
  final String? title;
  final Color? backgroundColor;

  const MyAppBar({
    this.title,
    this.leading,
    this.actions,
    super.key,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor:
          backgroundColor ?? Theme.of(context).colorScheme.background,
      automaticallyImplyLeading: false,
      leading: leading,
      title: Text(
        key: const Key("pageTitleAppBar"),
        (title ?? ""),
        style: TextStyle(
          fontSize: 18,
          color: Theme.of(context).colorScheme.primary,
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
  Size get preferredSize => const Size(200, 46);
}
