import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiBaseHelper {
  Future<dynamic> post(String url, dynamic body, apiCallFor) async {
    var responseJson;

    try {
      final response = await http.get(url);
      responseJson = _returnResponse(response, apiCallFor);
    } catch (e) {
      print("Error--$e");
    }
    return responseJson;
  }

  dynamic _returnResponse(http.Response response, apiCallFor) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 500:
      default:
    }
  }
}
