part of 'pages.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List<Model.Content> favorites = [];
  bool isLoading = true;
  late BannerAd ads;
  bool isAdsLoaded = false;

  void loadFavorite() async {
    var cachedFavorite = await Favorite.getCache();
    if (cachedFavorite != null && cachedFavorite != "") {
      var favoriteList = await Favorite.load(cachedFavorite);
      setState(() {
        favorites = favoriteList;
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  void removeFavorite(int id) async {
    setState(() {
      isLoading = true;
    });
    String? cacheFavorite = await Favorite.getCache();
    if (cacheFavorite != null && cacheFavorite != "") {
      var arrayString = cacheFavorite.split(",");
      var listId = arrayString.map(int.parse).toList();
      listId.removeWhere((element) => element == id);
      String updatedCache = listId.join(',');
      Favorite.updateCache(updatedCache);
      var favoriteList = await Favorite.load(updatedCache);
      setState(() {
        favorites = favoriteList;
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> loadBanner() async {
    ads = await Addsense.initBanner(() {
      setState(() {
        isAdsLoaded = true;
      });
    }, AdSize.banner);
    ads.load();
  }

  @override
  void initState() {
    super.initState();
    loadBanner();
    loadFavorite();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          context.read<PageBloc>().add(ToMenuPage());
          return Future.value(false);
        },
        child: Scaffold(
            appBar: CustomAppBar(
              title: Text("Favorit"),
              leading: IconButton(
                onPressed: () {
                  context.read<PageBloc>().add(ToMenuPage());
                },
                icon: Icon(
                  MdiIcons.homeCircle,
                  size: 30,
                  color: fontAccent1,
                ),
              ),
            ),
            body: !isLoading
                ? Column(
                    children: [
                      if (isAdsLoaded) AdsBanner(ads: ads),
                      Expanded(
                          child: favorites.length > 0
                              ? ListView.builder(
                                  itemCount: favorites.length,
                                  itemBuilder: (context, index) {
                                    Model.Content content = favorites[index];
                                    return GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 20, horizontal: 15),
                                        margin: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            gradient: LinearGradient(
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                                colors: [
                                                  secondaryColor,
                                                  Colors.white
                                                ])),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.7,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      context.read<PageBloc>().add(
                                                          ToFavoriteDetailPage(
                                                              content));
                                                    },
                                                    child: Text(
                                                      content.description ??
                                                          "Tanpa Judul",
                                                      style: TextStyle(
                                                          color: fontDark,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    removeFavorite(content.id);
                                                  },
                                                  child: Icon(
                                                      MdiIcons.deleteAlert,
                                                      color: fontAccent1),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                context.read<PageBloc>().add(
                                                    ToFavoriteDetailPage(
                                                        content));
                                              },
                                              child: Container(
                                                color: Colors.white,
                                                padding: EdgeInsets.all(8),
                                                child: SizedBox(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  child: Text(
                                                    "${content.mantram.substring(0, 30)} ....",
                                                    style: TextStyle(
                                                        color: fontDark,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  })
                              : Container(
                                  child: Center(
                                    child: Text(
                                        "Belum ada favorit yang di tambahkan."),
                                  ),
                                ))
                    ],
                  )
                : Container(
                    child: Center(
                      child: Spinner(),
                    ),
                  )));
  }
}
