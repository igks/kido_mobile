part of 'pages.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  void GoToMenu() async {
    await Future.delayed(Duration(milliseconds: svSplashTime), () {});
    context.read<PageBloc>().add(ToMenuPage());
  }

  @override
  void initState() {
    super.initState();
    GoToMenu();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    image: DecorationImage(
                        image: AssetImage("assets/images/KiDo.png"))),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Om Swastyastu",
                style: fontPacifico.copyWith(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: fontAccent1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
