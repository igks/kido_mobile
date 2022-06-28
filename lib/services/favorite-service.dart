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

class LastVisit {
  static Future<void> save(Title title) async {
    final storage = await SharedPreferences.getInstance();
    storage.setString('last-visited', jsonEncode(title));
  }

  static Future<Map<String, dynamic>?> read() async {
    final storage = await SharedPreferences.getInstance();
    String? lastVisited = await storage.getString('last-visited');
    if (lastVisited == null) return null;

    return jsonDecode(lastVisited);
  }
}
