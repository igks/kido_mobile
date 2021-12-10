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

  Future<void> getCategory() async {
    String url = "$svDomain/categories";
    var response = await API.get(url);
    if (response['success']) {
      List<Model.Category> categoriesList = [];
      response['data'].forEach((data) {
        categoriesList.add(Model.Category.fromJson(data));
      });
      if (mounted)
        setState(() {
          categories = categoriesList;
          isLoading = false;
        });
    }
  }

  void redirectTo(Model.Category category) {
    context.read<PageBloc>().add(ToJudulDoaPage(category));
  }

  @override
  void initState() {
    super.initState();
    getCategory();

    ads = BannerAd(
        size: AdSize.largeBanner,
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
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: Text(
            "Menu",
            style: fontPrimary.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
          ),
          leading: IconButton(
              onPressed: () {
                context.read<PageBloc>().add(ToFavoritePage());
              },
              icon: Icon(
                MdiIcons.heartCircle,
                color: fontAccent1,
                size: 30,
              )),
          actions: [
            IconButton(
                onPressed: () {
                  context.read<PageBloc>().add(ToInformationPage());
                },
                icon: Icon(
                  MdiIcons.informationOutline,
                  color: fontAccent1,
                  size: 30,
                )),
          ],
        ),
        body: categories.length > 0 && !isLoading
            ? Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: Card(
                        color: Colors.amber[200],
                        child: GestureDetector(
                          onTap: () {
                            context.read<PageBloc>().add(ToPersiapanPage());
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 15),
                            child: Center(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Persiapan Sikap",
                                  style: fontPrimary.copyWith(
                                      color: fontAccent1,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            )),
                          ),
                        )),
                  ),
                  Expanded(
                    child: GridView.count(
                        crossAxisCount: 2,
                        children: categories
                            .map((category) => GestureDetector(
                                  onTap: () {
                                    redirectTo(category);
                                  },
                                  child: Container(
                                      padding: EdgeInsets.all(15),
                                      child: Card(
                                          color: Colors.amber[200],
                                          child: Center(
                                              child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                MdiIcons.bookOpenVariant,
                                                color: Colors.white,
                                                size: 40,
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                category.name,
                                                style: fontPrimary.copyWith(
                                                    color: fontAccent1,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          )))),
                                ))
                            .toList()),
                  ),
                  if (isAdLoaded)
                    Container(
                      child: AdWidget(ad: ads),
                      width: ads.size.width.toDouble(),
                      height: ads.size.height.toDouble(),
                      alignment: Alignment.center,
                    )
                ],
              )
            : Container(
                child: Center(
                  child: Spinner(),
                ),
              ));
  }
}
