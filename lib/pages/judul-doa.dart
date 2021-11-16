part of 'pages.dart';

class JudulDoaPage extends StatefulWidget {
  final Model.Category category;

  const JudulDoaPage({Key? key, required this.category}) : super(key: key);

  @override
  _JudulDoaPageState createState() => _JudulDoaPageState();
}

class _JudulDoaPageState extends State<JudulDoaPage> {
  List<Model.Title> titles = [];
  bool isLoading = true;

  Future<void> loadTitle(int categoryId) async {
    String url = "$svDomain/titles/$categoryId";
    var response = await API.get(url);
    if (response['success'] ?? false) {
      List<Model.Title> titleList = [];
      response['data'].forEach((title) {
        titleList.add(Model.Title.fromJson(title));
      });
      setState(() {
        titles = titleList;
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
    loadTitle(widget.category.id);
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
              title: Text(widget.category.name),
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
            body: titles.length > 0 && !isLoading
                ? ListView.builder(
                    itemCount: titles.length,
                    itemBuilder: (context, index) {
                      Model.Title title = titles[index];
                      return GestureDetector(
                        onTap: () {
                          context
                              .read<PageBloc>()
                              .add(ToContentDoaPage(title, widget.category));
                        },
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
                            children: [
                              Icon(MdiIcons.adjust, color: fontAccent1),
                              SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                child: Text(
                                  title.content,
                                  style: TextStyle(
                                      color: fontDark,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    })
                : Container(
                    child: Center(
                      child: Spinner(),
                    ),
                  )));
  }
}
