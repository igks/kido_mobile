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
  bool isAdLoaded = false;
  bool isError = false;

  Future<void> getCategory() async {
    setState(() {
      isLoading = true;
      isError = false;
    });
    try {
      String url = "$svDomain/categories";
      var response = await API.get(url);
      if (response['success']) {
        loadBanner();
        List<Model.Category> categoriesList = [];
        response['data'].forEach((data) {
          categoriesList.add(Model.Category.fromJson(data));
        });
        if (mounted)
          setState(() {
            categories = categoriesList;
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
    getCategory();
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
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, top: 20, bottom: 10),
                        child: Text(
                          "Paling sering dilihat pengguna",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: fontDark),
                        ),
                      ),
                      MostVisited(),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, top: 30, bottom: 10),
                        child: Text(
                          "Yang terakhir kamu lihat",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: fontDark),
                        ),
                      ),
                      LastVisited(),
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
                              getCategory();
                            },
                            child: Text("Muat Ulang"),
                            style:
                                ElevatedButton.styleFrom(primary: fontAccent1)),
                      ],
                    ),
                  ));
  }
}
