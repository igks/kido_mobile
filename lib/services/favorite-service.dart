part of 'services.dart';

class Favorite {
  static Future<void> updateCache(String favorites) async {
    final storage = await SharedPreferences.getInstance();
    storage.setString('favorites', favorites);
  }

  static Future<String?> getCache() async {
    final storage = await SharedPreferences.getInstance();
    String? cachedFavorite = await storage.getString('favorites');
    return cachedFavorite;
  }

  static Future<List<Content>> load(String cachedFavorite) async {
    List<Content> favorites = [];
    Map<String, dynamic> body = {"params": cachedFavorite};
    String url = "$svDomain/favorites";
    var response = await API.post(url, body);
    if (response?['success'] ?? false) {
      response['data'].forEach((content) {
        favorites.add(Content.fromJson(content));
      });
    }
    return favorites;
  }

  static Future<void> clearFavorite() async {
    final storage = await SharedPreferences.getInstance();
    storage.remove('favorites');
  }
}
