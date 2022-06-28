part of '../sections.dart';

class LastVisited extends StatelessWidget {
  final Map<String, dynamic> lastVisited;

  const LastVisited({Key? key, required this.lastVisited}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, top: 30, bottom: 10),
          child: Text(
            "Terakhir kamu melihat",
            style: TextStyle(fontWeight: FontWeight.bold, color: fontDark),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: SizedBox(
            height: 80,
            child: GestureDetector(
              onTap: () {
                context.read<PageBloc>().add(ToCachedPage(lastVisited));
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [secondaryColor, Colors.white])),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        lastVisited['content'],
                        style: TextStyle(
                            color: fontDark,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
