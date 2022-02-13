import 'package:http/http.dart' as http;

class NotificationsAPI {
  Future<dynamic> getNotifications() async {
    http.Response response;
    try {
      response = await http.get(
        Uri.parse("https://ktunotification.herokuapp.com/"),
      );
      return response.body;
    } catch (e) {
      throw NetworkException();
    }
  }
}

class NetworkException implements Exception {}
