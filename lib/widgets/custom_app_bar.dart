import 'package:flutter/material.dart';


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final PreferredSizeWidget? bottom;
  final List<Widget>? actions;

  const CustomAppBar({
    super.key,
    required this.title,
    this.bottom,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      bottom: bottom,
      actions: actions,
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(bottom == null ? kToolbarHeight : kToolbarHeight + bottom!.preferredSize.height);
}
