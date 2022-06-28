part of 'widgets.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Widget? title;
  final List<Widget>? actions;
  final Widget? leading;

  CustomAppBar({Key? key, this.title, this.actions, this.leading})
      : preferredSize = Size.fromHeight(80.0),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: widget.title,
      leading: widget.leading,
      actions: widget.actions ?? [],
      centerTitle: true,
      backgroundColor: mainColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(50))),
    );
  }
}
