part of '../sections.dart';

class BottomNavbar extends StatelessWidget {
  const BottomNavbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 0,
        left: 0,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 80,
          child: Stack(
            children: [
              CustomPaint(
                size: Size(MediaQuery.of(context).size.width, 80),
                painter: NavPainter(),
              ),
              Center(
                  heightFactor: 0.5,
                  child: FloatingActionButton(
                    onPressed: () {
                      context.read<PageBloc>().add(ToSearchPage());
                    },
                    backgroundColor: secondaryColor,
                    child: Icon(
                      MdiIcons.crosshairs,
                      size: 40,
                    ),
                  )),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                        onTap: () {
                          context.read<PageBloc>().add(ToFavoritePage());
                        },
                        child: Icon(
                          MdiIcons.heart,
                          color: Colors.white,
                          size: 35,
                        )),
                    InkWell(
                        onTap: () {
                          context.read<PageBloc>().add(ToInformationPage());
                        },
                        child: Icon(
                          MdiIcons.information,
                          color: Colors.white,
                          size: 35,
                        )),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

class NavPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = mainColor
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path = Path();

    path.moveTo(0, size.height * 0.3006800);
    path.quadraticBezierTo(size.width * 0.1653111, size.height * 0.1002800,
        size.width * 0.2774111, size.height * 0.1004000);
    path.cubicTo(
        size.width * 0.3336444,
        size.height * 0.1004200,
        size.width * 0.3889444,
        size.height * 0.1006200,
        size.width * 0.3898556,
        size.height * 0.2020000);
    path.cubicTo(
        size.width * 0.3891444,
        size.height * 0.8994600,
        size.width * 0.6131444,
        size.height * 0.8964000,
        size.width * 0.6091889,
        size.height * 0.1986800);
    path.cubicTo(
        size.width * 0.6109333,
        size.height * 0.1009800,
        size.width * 0.6679333,
        size.height * 0.0990800,
        size.width * 0.7216778,
        size.height * 0.0996400);
    path.quadraticBezierTo(size.width * 0.8340556, size.height * 0.0988600,
        size.width, size.height * 0.3009800);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, size.height * 0.3006800);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
