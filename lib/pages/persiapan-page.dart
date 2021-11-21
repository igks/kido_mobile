part of 'pages.dart';

// ignore: must_be_immutable
class PersiapanPage extends StatelessWidget {
  List<Map<String, dynamic>> contents = [
    {
      "description": "Padma Asana (Sikap duduk bersila)",
      "doa": "Om prasada sthiti sarira siwa suci nirmalaya namah swaha",
      "meaning":
          "Ya Tuhan, dalam wujud Sang Hyang Siwa, hambaMu telah duduk tenang, suci dan tiada noda."
    },
    {
      "description": "Pranayama (Mengatur nafas)",
      "doa":
          "Om ang namah (menarik nafas)\nOm ung namah (menahan nafas)\nOm mang namah (menghembuskan nafas)",
      "meaning":
          "Ya Tuhan, engkau Pencipta, Pemelihara dan Pelebur alam semesta, hamba memujaMu."
    },
    {
      "description": "Kara Sudana (Membersihkan tangan)",
      "doa":
          "Om suddha mam swaha (tangan kanan)\nOm ati suddha mam swaha(tangan kiri)",
      "meaning":
          "Ya Tuhan, bersihkanlah tangan kanan hamba.\nYa Tuhan, bersihkanlah tangan kiri hamba."
    }
  ];

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
              "Persiapan Sikap",
              style: fontPrimary.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
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
            child: Column(
                children: contents
                    .map((content) => Card(
                          child: Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.all(5),
                                    color: secondaryColor,
                                    child: Text(
                                      content['description'],
                                      style: TextStyle(fontSize: 12),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    content['doa'],
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic),
                                    textAlign: TextAlign.center,
                                  ),
                                  Divider(),
                                  Text(
                                    content['meaning'],
                                    style: fontSecondary.copyWith(fontSize: 16),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              )),
                        ))
                    .toList()),
          ),
        ));
  }
}
