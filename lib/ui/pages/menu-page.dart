part of 'pages.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  List<Model.Category> categories = [];
  List<Map<String, dynamic>> mostVisitedState = [];
  Map<String, dynamic>? lastVisitState;

  bool isLoading = true;
  late BannerAd ads;
  bool isAdLoaded = false;
  bool isError = false;

  Future<void> getData() async {
    setState(() {
      isLoading = true;
      isError = false;
    });
    try {
      loadBanner();
      var response = await API.get("$svDomain/categories");
      var mostVisited = await API.get("$svDomain/top");
      if (response['success'] && mostVisited['success']) {
        List<Model.Category> categoriesList = [];
        response['data'].forEach((data) {
          categoriesList.add(Model.Category.fromJson(data));
        });

        List<Map<String, dynamic>> mostVisitedList = [];
        mostVisited['data'].forEach((data) {
          mostVisitedList.add(data);
        });

        var lastVisited = await LastVisit.read();

        if (mounted)
          setState(() {
            categories = categoriesList;
            mostVisitedState = mostVisitedList;
            lastVisitState = lastVisited;
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

  Future<void> loadBanner() async {
    ads = await Addsense.initBanner(() {
      setState(() {
        isAdLoaded = true;
      });
    }, AdSize.banner);
    ads.load();
  }

  @override
  void initState() {
    super.initState();
    getData();
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
                      HomeCategories(categories: categories),
                      if (mostVisitedState.length > 0)
                        MostVisited(
                          mostVisited: mostVisitedState,
                        ),
                      if (lastVisitState != null)
                        LastVisited(lastVisited: lastVisitState!),
                      SizedBox(
                        height: 20,
                      ),
                      if (isAdLoaded) AdsBanner(ads: ads)
                    ],
                  ),
                  BottomNavbar()
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
                              getData();
                            },
                            child: Text("Muat Ulang"),
                            style:
                                ElevatedButton.styleFrom(primary: fontAccent1)),
                      ],
                    ),
                  ));
  }
}
