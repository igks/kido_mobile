part of '../sections.dart';

class MostVisited extends StatelessWidget {
  final List<Map<String, dynamic>> mostVisited;
  const MostVisited({Key? key, required this.mostVisited}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, top: 20, bottom: 10),
          child: Text(
            "Paling sering dilihat pengguna",
            style: TextStyle(fontWeight: FontWeight.bold, color: fontDark),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 5),
          child: SizedBox(
              height: 50,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: mostVisited.length,
                  itemBuilder: (BuildContext ctx, int index) {
                    return GestureDetector(
                      onTap: () {
                        print(mostVisited[index]['id']);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        padding: EdgeInsets.only(left: 10, right: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [secondaryColor, Colors.white])),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              mostVisited[index]['name'].toString(),
                              style: TextStyle(
                                color: fontDark,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    );
                  })),
        ),
      ],
    );
  }
}
