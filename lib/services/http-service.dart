part of 'services.dart';

class API {
  static responseHandler(response) {
    var responseBody = jsonDecode(response.body.toString());
    bool success = false;
    var data;
    var error;
    var errors;

    if (responseBody?['is_success'] ?? false) {
      success = true;
      data = responseBody['data'];
      return {
        'success': success,
        'data': data,
        'error': error,
        'errors': errors
      };
    } else {
      success = false;
      if (responseBody['error'] != null) {
        error = responseBody['error'];
      }
      if (responseBody['errors'] != null) {
        errors = responseBody['errors'];
      }
      return {
        'success': success,
        'data': data,
        'error': error,
        'errors': errors
      };
    }
  }

  static get(String url) async {
    var target = Uri.parse(url);
    var response = await http.get(target, headers: {
      "APIKEY": "ezfvopbzvdamzfueomizobonkvqkabds",
    });
    return responseHandler(response);
  }

  static post(String url, Map<String, dynamic> body) async {
    var target = Uri.parse(url);
    var response = await http.post(target,
        headers: <String, String>{
          "APIKEY": "ezfvopbzvdamzfueomizobonkvqkabds",
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(body));
    return responseHandler(response);
  }

  static put(String url, Map<String, dynamic> body) async {
    var target = Uri.parse(url);
    var response = await http.put(target, body: body);
    return responseHandler(response);
  }
}

class Url {
  static String favorites = "http://10.0.2.2:8000/api/v1/favorites";
  static String search = "http://10.0.2.2:8000/api/v1/search";
  static String categories = "http://10.0.2.2:8000/api/v1/categories";

  static String titles(int categoryId) {
    return "http://10.0.2.2:8000/api/v1/titles/$categoryId";
  }

  static String contents(int titleId) {
    return "http://10.0.2.2:8000/api/v1/contents/$titleId";
  }

  static String contet(int id) {
    return "http://10.0.2.2:8000/api/v1/contents/$id/show";
  }
}
