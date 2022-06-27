part of 'pages.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  List<Model.Category> categories = [];
  bool isLoading = true;
  late BannerAd ads;
  bool isAdLoaded = true;
  bool isError = false;

  Future<void> getCategory() async {
    setState(() {
      isLoading = true;
      isError = false;
    });
    try {
      String url = "$svDomain/categories";
      var response = await API.get(url);
      if (response['success']) {
        loadBanner();
        List<Model.Category> categoriesList = [];
        response['data'].forEach((data) {
          categoriesList.add(Model.Category.fromJson(data));
        });
        if (mounted)
          setState(() {
            categories = categoriesList;
            isLoading = false;
          });
      } else {
        if (mounted)
          setState(() {
            isLoading = false;
            isError = true;
          });
      }
    } catch (error) {
      if (mounted)
        setState(() {
          isLoading = false;
          isError = true;
        });
    }
  }

  void redirectTo(Model.Category category) {
    context.read<PageBloc>().add(ToJudulDoaPage(category));
  }

  void loadBanner() {
    ads = BannerAd(
        size: AdSize.banner,
        adUnitId: svBannerAdUnitId,
        listener: BannerAdListener(onAdLoaded: (_) {
          setState(() {
            isAdLoaded = true;
          });
        }, onAdFailedToLoad: (ad, error) {
          ad.dispose();
        }),
        request: AdRequest());

    ads.load();
  }

  @override
  void initState() {
    super.initState();
    getCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: Text(
            "K i D o",
            style: fontPrimary.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ),
        body: categories.length > 0 && !isLoading
            ? Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: categories.length + 1,
                          itemBuilder: (BuildContext ctx, int index) {
                            if (index == 0) {
                              return GestureDetector(
                                onTap: () {
                                  context
                                      .read<PageBloc>()
                                      .add(ToPersiapanPage());
                                },
                                child: Container(
                                    height: 80,
                                    width: 80,
                                    margin:
                                        EdgeInsets.only(left: 10, right: 10),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.amber[200]),
                                    padding: EdgeInsets.all(15),
                                    child: Center(
                                        child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          MdiIcons.accountCheck,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Sikap",
                                          style: fontPrimary.copyWith(
                                              color: fontAccent1,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ))),
                              );
                            }
                            return GestureDetector(
                              onTap: () {
                                redirectTo(categories[index - 1]);
                              },
                              child: Container(
                                  height: 80,
                                  width: 80,
                                  margin: EdgeInsets.only(left: 10, right: 10),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.amber[200]),
                                  padding: EdgeInsets.all(15),
                                  child: Center(
                                      child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        MdiIcons.bookOpenVariant,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        categories[index - 1].name,
                                        style: fontPrimary.copyWith(
                                            color: fontAccent1,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ))),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, top: 20, bottom: 10),
                        child: Text(
                          "Paling sering dilihat pengguna",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: fontDark),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: SizedBox(
                          height: 50,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            secondaryColor,
                                            Colors.white
                                          ])),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: GestureDetector(
                                          onTap: () {
                                            // context
                                            //     .read<PageBloc>()
                                            //     .add(ToFavoriteDetailPage(content));
                                          },
                                          child: Text(
                                            "Tanpa Judul hasdfhasldfhlasdfalshflahsdfhlasdf",
                                            style: TextStyle(
                                                color: fontDark,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, top: 30, bottom: 10),
                        child: Text(
                          "Yang terakhir kamu lihat",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: fontDark),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: SizedBox(
                          height: 80,
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.only(left: 10, right: 10),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [secondaryColor, Colors.white])),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: GestureDetector(
                                      onTap: () {
                                        // context
                                        //     .read<PageBloc>()
                                        //     .add(ToFavoriteDetailPage(content));
                                      },
                                      child: Text(
                                        "Tanpa Judul hasdfhasldfhlasdfalshflahsdfhlasdf",
                                        style: TextStyle(
                                            color: fontDark,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      if (isAdLoaded)
                        Center(
                          child: Container(
                            child: AdWidget(ad: ads),
                            width: ads.size.width.toDouble(),
                            height: ads.size.height.toDouble(),
                            alignment: Alignment.center,
                          ),
                        ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                  Positioned(
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
                                    context
                                        .read<PageBloc>()
                                        .add(ToSearchPage());
                                  },
                                  backgroundColor: secondaryColor,
                                  child: Icon(
                                    MdiIcons.crosshairs,
                                    size: 40,
                                  ),
                                )),
                            Center(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  InkWell(
                                      onTap: () {
                                        context
                                            .read<PageBloc>()
                                            .add(ToFavoritePage());
                                      },
                                      child: Icon(
                                        MdiIcons.heart,
                                        color: Colors.white,
                                        size: 35,
                                      )),
                                  InkWell(
                                      onTap: () {
                                        context
                                            .read<PageBloc>()
                                            .add(ToInformationPage());
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
                      )),
                ],
              )
            : !isError
                ? Container(
                    child: Center(
                      child: Spinner(),
                    ),
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Terjadi kesalahan jaringan!'),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              getCategory();
                            },
                            child: Text("Muat Ulang"),
                            style:
                                ElevatedButton.styleFrom(primary: fontAccent1)),
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
