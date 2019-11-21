import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tube/blocs/favorite_bloc.dart';
import 'package:flutter_tube/blocs/videos_bloc.dart';
import 'package:flutter_tube/screens/home.dart';
import 'package:flutter_tube/api.dart';

void main() {

  Api api = Api();
  api.search("eletro");  

  runApp(MyApp());

}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: VideosBloc(),
      child: BlocProvider(
        bloc: FavoriteBloc(),
          child: MaterialApp(
            title: 'Flutter Tube',
            debugShowCheckedModeBanner: false,
            home: Home(),
      ),
      )
    );
  }
  
}
