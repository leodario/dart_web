import 'dart:html';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  
}

Future getWeather(String city){
  String url = 'https://api.hgbrasil.com/weather?key=fc5d1bd4&format=json-cors&locale=pt&city_name=$city';
  return http.get(url);
}

void loadData(List cities){
  var empty = querySelector('#empty');

  if(empty != null)
    empty.remove();

    cities.forEach((city){
      insertData(getWeather(city));
    });
}

void insertData(Future data) async{

}