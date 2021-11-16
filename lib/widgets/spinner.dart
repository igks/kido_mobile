part of 'widgets.dart';

class Spinner extends StatelessWidget {
  final double size;
  const Spinner({Key? key, this.size = 30}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(fontAccent1),
      ),
    );
  }
}
