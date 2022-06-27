part of 'pages.dart';

class CachedPage extends StatefulWidget {
  final Map<String, dynamic> title;
  const CachedPage({Key? key, required this.title}) : super(key: key);

  @override
  _CachedPageState createState() => _CachedPageState();
}

class _CachedPageState extends State<CachedPage> {
  List<Model.Content> contents = [];
  bool isLoading = true;
  List<int> favorites = [];
  late BannerAd ads;
  bool isAdLoaded = true;

  Future<void> loadContent(int titleId) async {
    String url = "$svDomain/contents/$titleId";
    var response = await API.get(url);
    if (response?['success'] ?? false) {
      List<Model.Content> contentList = [];
      response['data'].forEach((content) {
        contentList.add(Model.Content.fromJson(content));
      });
      setState(() {
        contents = contentList;
        isLoading = false;
      });
    }
  }

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
    loadContent(widget.title['id']);
    getFavorite();

    print(widget.title);

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
          context.read<PageBloc>().add(ToMenuPage());
          return Future.value(false);
        },
        child: Scaffold(
            appBar: CustomAppBar(
              title: Text(widget.title['content']),
              leading: IconButton(
                onPressed: () {
                  context.read<PageBloc>().add(ToMenuPage());
                },
                icon: Icon(MdiIcons.chevronLeft),
              ),
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
            body: Container(
              child: Column(
                children: [
                  contents.length > 0 && !isLoading
                      ? Expanded(
                          child: ListView.builder(
                              itemCount: contents.length,
                              itemBuilder: (context, index) {
                                var content = contents[index];
                                return Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  child: Card(
                                    child: Container(
                                        padding: EdgeInsets.all(10),
                                        child: Column(
                                          children: [
                                            content.description != null
                                                ? Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    padding: EdgeInsets.all(5),
                                                    color: secondaryColor,
                                                    child: Text(
                                                      content.description!,
                                                      style: TextStyle(
                                                          fontSize: 12),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  )
                                                : SizedBox(),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              content.mantram,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle: FontStyle.italic),
                                              textAlign: TextAlign.center,
                                            ),
                                            Divider(),
                                            if (content.meaning != "-")
                                              Text(
                                                content.meaning,
                                                style: fontSecondary.copyWith(
                                                    fontSize: 16),
                                                textAlign: TextAlign.center,
                                              ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                IconButton(
                                                    onPressed: () {
                                                      updateFavorite(
                                                          content.id);
                                                    },
                                                    icon: favorites.contains(
                                                            content.id)
                                                        ? Icon(
                                                            MdiIcons.heart,
                                                            size: 30,
                                                            color: fontAccent1,
                                                          )
                                                        : Icon(
                                                            MdiIcons
                                                                .heartOutline,
                                                            size: 30,
                                                            color: fontAccent1))
                                              ],
                                            )
                                          ],
                                        )),
                                  ),
                                );
                              }),
                        )
                      : Expanded(
                          child: Container(
                              child: Center(
                            child: Spinner(),
                          )),
                        ),
                  if (isAdLoaded) AdsBanner(ads: ads)
                ],
              ),
            )));
  }
}
