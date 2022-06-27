part of 'widgets.dart';

class AdsBanner extends StatelessWidget {
  final BannerAd ads;
  const AdsBanner({Key? key, required this.ads}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Center(
          child: Container(
            child: AdWidget(ad: ads),
            width: ads.size.width.toDouble(),
            height: ads.size.height.toDouble(),
            alignment: Alignment.center,
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
