part of 'pages.dart';

class ContentDoaPage extends StatefulWidget {
  final Model.Title title;
  final Model.Category category;
  const ContentDoaPage({Key? key, required this.title, required this.category})
      : super(key: key);

  @override
  _ContentDoaPageState createState() => _ContentDoaPageState();
}

class _ContentDoaPageState extends State<ContentDoaPage> {
  List<Model.Content> contents = [];
  bool isLoading = true;
  List<int> favorites = [];

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
    loadContent(widget.title.id);
    getFavorite();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          context.read<PageBloc>().add(ToJudulDoaPage(widget.category));
          return Future.value(false);
        },
        child: Scaffold(
          appBar: CustomAppBar(
            title: Text(widget.title.content),
            leading: IconButton(
              onPressed: () {
                context.read<PageBloc>().add(ToJudulDoaPage(widget.category));
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
          body: contents.length > 0 && !isLoading
              ? ListView.builder(
                  itemCount: contents.length,
                  itemBuilder: (context, index) {
                    var content = contents[index];
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      child: Card(
                        child: Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: [
                                content.description != null
                                    ? Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        padding: EdgeInsets.all(5),
                                        color: secondaryColor,
                                        child: Text(
                                          content.description!,
                                          style: TextStyle(fontSize: 11),
                                          textAlign: TextAlign.center,
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
                                    style: fontSecondary.copyWith(fontSize: 16),
                                    textAlign: TextAlign.center,
                                  ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          updateFavorite(content.id);
                                        },
                                        icon: favorites.contains(content.id)
                                            ? Icon(
                                                MdiIcons.heart,
                                                size: 30,
                                                color: fontAccent1,
                                              )
                                            : Icon(MdiIcons.heartOutline,
                                                size: 30, color: fontAccent1))
                                  ],
                                )
                              ],
                            )),
                      ),
                    );
                  })
              : Container(
                  child: Center(
                  child: Spinner(),
                )),
        ));
  }
}
