part of 'pages.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List<Model.Content> favorites = [];
  bool isLoading = true;

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

  @override
  void initState() {
    super.initState();
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
                ? favorites.length > 0
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
                                        context
                                            .read<PageBloc>()
                                            .add(ToFavoriteDetailPage(content));
                                      },
                                      child: Text(
                                        content.description ?? "Tanpa Judul",
                                        style: TextStyle(
                                            color: fontDark,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
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
                                    child: Icon(MdiIcons.deleteAlert,
                                        color: fontAccent1),
                                  )
                                ],
                              ),
                            ),
                          );
                        })
                    : Container(
                        child: Center(
                          child: Text("Belum ada favorit yang di tambahkan."),
                        ),
                      )
                : Container(
                    child: Center(
                      child: Spinner(),
                    ),
                  )));
  }
}
