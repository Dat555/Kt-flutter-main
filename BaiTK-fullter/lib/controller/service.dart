import 'dart:convert';
import 'package:flutter_application_1/model/tesla_model.dart';
import 'package:http/http.dart' as http;

class Service {
  Future<Tesla_model> fetchDataTesla(dynamic s) async {
    String url = s == null
        ? "https://newsapi.org/v2/everything?q=tesla&from=2021-10-14&sortBy=publishedAt&apiKey=f650a93f63634105a75a352e57de91ec"
        : s;
    var reponse = await http.get(Uri.parse(url));
    if (reponse.statusCode == 200) {
      var jsonData = json.decode(reponse.body);
      print(jsonData);
      Tesla_model tl = TeslaFromJson(reponse.body);
      print(tl);
      return tl;
    } else {
      return throw Exception('Không có dữ liệu');
    }
  }
}
