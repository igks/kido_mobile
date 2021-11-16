part of 'pages.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  List<Model.Category> categories = [];
  bool isLoading = true;

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
        ),
        body: categories.length > 0 && !isLoading
            ? GridView.count(
                crossAxisCount: 2,
                children: categories
                    .map((category) => GestureDetector(
                          onTap: () {
                            redirectTo(category);
                          },
                          child: Container(
                              padding: EdgeInsets.all(20),
                              child: Card(
                                  color: Colors.amber[200],
                                  child: Center(
                                      child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  )))),
                        ))
                    .toList())
            : Container(
                child: Center(
                  child: Spinner(),
                ),
              ));
  }
}
