import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/author_response.dart';

class AuthorProvider{

  static Future<Map<String, String>> getHeaderWithoutAuthToken() async {
    var headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Access-Control-Allow-Origin': '*'
    };
    return headers;
  }

  Future<List<Author>?> getAuthorApiResponse() async {
    final header = await getHeaderWithoutAuthToken();
    Uri url = Uri.parse('https://picsum.photos/v2/list#');
    var response = await http.get(url);
    if(response.statusCode == 200){
      List data = await json.decode(response.body);
      return data.map((e) => Author.fromJson(e)).toList();
    }
  }
}