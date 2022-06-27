part of 'pages.dart';

class InformationPage extends StatelessWidget {
  const InformationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        context.read<PageBloc>().add(ToMenuPage());
        return Future.value(false);
      },
      child: Scaffold(
        appBar: CustomAppBar(
          title: Text(
            "Tentang KiDo",
            style: fontPrimary.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
          ),
          leading: IconButton(
              onPressed: () {
                context.read<PageBloc>().add(ToMenuPage());
              },
              icon: Icon(
                MdiIcons.homeCircle,
                color: fontAccent1,
                size: 30,
              )),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      image: DecorationImage(
                          image: AssetImage("assets/images/KiDo.png"))),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "       KiDo (Kidung & Doa) adalah aplikasi buku saku yang berisi doa - doa dan kidung suci agama Hindu.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "       Dengan mamanfaatkan kemajuan teknologi, aplikasi ini diharapkan dapat membantu umat Hindu agar tidak perlu lagi membawa buku yang tebal saat melaksanakan upcara keagamaan cukup dengan hanphone dan aplikasi ini pengguna dapat melihat semua doa - doa dan kidung upacara keagamaan.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 14),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
