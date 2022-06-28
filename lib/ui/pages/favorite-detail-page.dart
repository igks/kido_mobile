part of 'pages.dart';

class FavoriteDetailPage extends StatefulWidget {
  final Model.Content content;

  const FavoriteDetailPage({Key? key, required this.content}) : super(key: key);

  @override
  _FavoriteDetailPageState createState() => _FavoriteDetailPageState();
}

class _FavoriteDetailPageState extends State<FavoriteDetailPage> {
  bool isLoading = true;
  List<int> favorites = [];
  late BannerAd ads;
  bool isAdLoaded = true;

  Future<void> updateFavorite(int id) async {
    if (favorites.contains(id)) {
      favorites.removeWhere((element) => element == id);
    } else {
      favorites.add(id);
    }
    String cacheFavorite = favorites.join(',');
    Favorite.updateCache(cacheFavorite);
    setState(() {});
  }

  void getFavorite() async {
    String? cacheFavorite = await Favorite.getCache();
    if (cacheFavorite != null && cacheFavorite != "") {
      var arrayString = cacheFavorite.split(",");
      setState(() {
        favorites = arrayString.map(int.parse).toList();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getFavorite();

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
    return WillPopScope(
      onWillPop: () {
        context.read<PageBloc>().add(ToFavoritePage());
        return Future.value(false);
      },
      child: Scaffold(
          appBar: CustomAppBar(
            title: Text(widget.content.description ?? "Tanpa Judul"),
            actions: [
              IconButton(
                  onPressed: () {
                    context.read<PageBloc>().add(ToFavoritePage());
                  },
                  icon: Icon(
                    MdiIcons.heartCircle,
                    size: 30,
                    color: fontAccent1,
                  )),
              IconButton(
                  onPressed: () {
                    context.read<PageBloc>().add(ToSearchPage());
                  },
                  icon: Icon(
                    MdiIcons.fileFind,
                    size: 30,
                    color: fontAccent1,
                  )),
            ],
          ),
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Column(
                children: [
                  Card(
                    child: Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            widget.content.description != null
                                ? Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.all(5),
                                    color: secondaryColor,
                                    child: Text(
                                      widget.content.description!,
                                      style: TextStyle(fontSize: 11),
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                                : SizedBox(),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              widget.content.mantram,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic),
                              textAlign: TextAlign.center,
                            ),
                            Divider(),
                            if (widget.content.meaning != "-")
                              Text(
                                widget.content.meaning,
                                style: fontSecondary.copyWith(fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      updateFavorite(widget.content.id);
                                    },
                                    icon: favorites.contains(widget.content.id)
                                        ? Icon(
                                            MdiIcons.heart,
                                            size: 30,
                                            color: fontAccent1,
                                          )
                                        : Icon(MdiIcons.heartOutline,
                                            size: 30, color: fontAccent1))
                              ],
                            ),
                          ],
                        )),
                  ),
                  if (isAdLoaded)
                    Container(
                      child: AdWidget(ad: ads),
                      width: ads.size.width.toDouble(),
                      height: ads.size.height.toDouble(),
                      alignment: Alignment.center,
                    )
                ],
              ),
            ),
          )),
    );
  }
}
