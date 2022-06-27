part of 'services.dart';

class Addsense {
  static initBanner(Function onLoaded, AdSize size) async {
    return BannerAd(
        size: size,
        adUnitId: svBannerAdUnitId,
        listener: BannerAdListener(onAdLoaded: (_) {
          onLoaded();
        }, onAdFailedToLoad: (ad, error) {
          ad.dispose();
        }),
        request: AdRequest());
  }
}
