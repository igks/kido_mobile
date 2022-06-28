part of '../sections.dart';

class HomeCategories extends StatelessWidget {
  final List<Model.Category> categories;
  const HomeCategories({Key? key, required this.categories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void redirectTo(Model.Category category) {
      context.read<PageBloc>().add(ToJudulDoaPage(category));
    }

    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length + 1,
        itemBuilder: (BuildContext ctx, int index) {
          if (index == 0) {
            return GestureDetector(
              onTap: () {
                context.read<PageBloc>().add(ToPersiapanPage());
              },
              child: Container(
                  height: 80,
                  width: 80,
                  margin: EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.amber[200]),
                  padding: EdgeInsets.all(15),
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        MdiIcons.accountCheck,
                        color: Colors.white,
                        size: 30,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Sikap",
                        style: fontPrimary.copyWith(
                            color: fontAccent1,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ))),
            );
          }
          return GestureDetector(
            onTap: () {
              redirectTo(categories[index - 1]);
            },
            child: Container(
                height: 80,
                width: 80,
                margin: EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.amber[200]),
                padding: EdgeInsets.all(15),
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      MdiIcons.bookOpenVariant,
                      color: Colors.white,
                      size: 30,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      categories[index - 1].name,
                      style: fontPrimary.copyWith(
                          color: fontAccent1,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ))),
          );
        },
      ),
    );
  }
}
