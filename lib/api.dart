import 'dart:convert';

import 'package:http/http.dart' as http;

import 'models/video.dart';

const API_KEY = "AIzaSyCvNfKJ204H4NoVOiQfGFQD19yAb2QDDDs";

class Api {

  String _search;
  String _nextToken;

  Future<List<Video>> search(String search) async {

    _search = search;

    http.Response response = await http.get(
      //variaveis abaixo:
      //  search que essa classe recebe como parametro
      //  type é igual a video nesse caso
      //  key é a chave de aceeso acima
      //  e no máximo 10 resultados
      "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$search&type=video&key=$API_KEY&maxResults=10"
    );

    // a clase abaixo, decode, é própria, minha mesmo
    return decode(response);
    
  }

  Future<List<Video>> nextPage() async {
    http.Response response = await http.get(    
      "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$_search&type=video&key=$API_KEY&maxResults=10&pageToken=$_nextToken"
    );

    // a clase abaixo, decode, é minha mesmo
    return decode(response);

  }

  //o termo response é uma varialve do tipo http.response
  List<Video> decode(http.Response response) {

    if(response.statusCode == 200){
      var decoded = json.decode(response.body);

      _nextToken = decoded["nextPageToken"];

      //o Video abaixo é a classe criada em video.dart
      List<Video> videos = decoded["items"].map<Video>(
        (map){
          return Video.fromJson(map);
        }
      ).toList();

      return videos;
    } else {
      throw Exception("Falha ao carregar os videos");
    }

  }
}