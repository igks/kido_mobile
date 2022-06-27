part of 'pages.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  bool isLoading = true;
  bool isSearch = false;
  List<Model.Content> contents = [];

  void search(value) async {
    setState(() {
      isSearch = true;
    });
    String url = "$svDomain/search";
    var response = await API.post(url, {"params": value});
    List<Model.Content> foundContents = [];

    if (response['success'] ?? false) {
      if (response['data'].length > 0) {
        response['data'].forEach((content) {
          foundContents.add(Model.Content.fromJson(content));
        });
      }
    }
    setState(() {
      contents = foundContents;
      isLoading = false;
      isSearch = false;
    });
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
          title: Text("Halaman Pencarian"),
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
        body: Container(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: TextField(
                    controller: searchController,
                    onSubmitted: (value) {
                      search(value);
                    },
                    style: TextStyle(height: 1),
                    decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(5),
                        labelText: 'Ketik Kata Kunci...',
                        suffix: GestureDetector(
                          onTap: () {
                            searchController.text = "";
                          },
                          child: Container(
                            color: Colors.red[400],
                            child: Icon(
                              MdiIcons.close,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                        )),
                  )),
              !isLoading
                  ? contents.length > 0
                      ? Expanded(
                          child: ListView.builder(
                              itemCount: contents.length,
                              itemBuilder: (context, index) {
                                var content = contents[index];
                                return GestureDetector(
                                  onTap: () {
                                    context
                                        .read<PageBloc>()
                                        .add(ToFavoriteDetailPage(content));
                                  },
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
                                    child: Row(
                                      children: [
                                        Icon(MdiIcons.fullscreen,
                                            color: fontAccent1),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Flexible(
                                          child: Text(
                                            content.description ??
                                                "Tanpa Judul",
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
                              }))
                      : Expanded(
                          child: Container(
                          child: Center(
                            child: Text(
                                "Kata yang anda masukkan tidak ditemukan."),
                          ),
                        ))
                  : Expanded(
                      child: Container(
                      child: Center(
                        child: isSearch ? Spinner() : null,
                      ),
                    ))
            ],
          ),
        ),
      ),
    );
  }
}