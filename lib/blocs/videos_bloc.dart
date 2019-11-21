import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter_tube/api.dart';
import 'package:flutter_tube/models/video.dart';

class VideosBloc implements BlocBase {

  Api api;

  List<Video> videos;

  final StreamController<List<Video>> _videosController = StreamController<List<Video>>(); //quando nomeados com "_" no inicio, quer dizer que só será utlizado dentro da classe onde é criada
  Stream get outVideos => _videosController.stream;

  final StreamController<String> _seaechController = StreamController<String>();
  Sink get inSearch => _seaechController.sink;

  VideosBloc(){
    api = Api();

    _seaechController.stream.listen(_search);
  }

  Future _search(String search) async {

    if(search != null){
      _videosController.sink.add([]);
      videos = await api.search(search);
    } else {
      videos += await api.nextPage();
    }
    
    _videosController.sink.add(videos);
    
  }
  
  @override
  void dispose() {
    _videosController.close();
    _seaechController.close();    
  }

}