import 'dart:html';
import 'dart:convert';
import 'package:dialog/dialog.dart';
import 'package:http/http.dart' as http;

void main() {
  List cities = List();
  /* cities.add('Nova Friburgo');
  cities.add('Rio de Janeiro');
  cities.add('Itaperuna');
  cities.add('São Paulo');
  cities.add('Campinas');
  cities.add('Belo Horizonte');
  cities.add('Vitória');
  cities.add('Serra');
  cities.add('Cariacica');
  cities.add('Londres');
  cities.add('Jacaraípe'); */

  loadData(cities);

  querySelector('#searchCity').onClick.listen((a) async{
    var myPrompt = await prompt('Qual cidade você quer buscar?');

    if(myPrompt.toString().length > 0)
      loadData([myPrompt.toString()]);
    else
      alert('Nenhuma cidade informada!');  
  });
}

Future getWeather(String city){
  String url = 'https://api.hgbrasil.com/weather?key=34d240cf&format=json-cors&locale=pt&city_name=$city';
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
  var insertData = await data;
  var body = json.decode(insertData.body);

  if(body['results']['forecast'].length > 0){
    String html = '<div class="row">';
    html += formatedHTML(body['results']['city_name']);
    html += formatedHTML(body['results']['temp']);
    html += formatedHTML(body['results']['description']);
    html += formatedHTML(body['results']['wind_speedy']);
    html += formatedHTML(body['results']['sunrise']);
    html += formatedHTML(body['results']['sunset']);
    html += '</div>';

    querySelector('.table').innerHtml += html;
  }

}

String formatedHTML(var data){
  return '<div class="cell">$data</div>';
}