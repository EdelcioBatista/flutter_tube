class Video {

  //uso o final quando a variavel não recebe um valor e não alterar mais
  final String id; //identificador do video
  final String title; //titulo do video
  final String thumb; //a imagem do video
  final String channel; //o canal que postou o video

  Video({this.id, this.title, this.thumb, this.channel});

  //a String recebida abaixo é a KEY e o dynamic pode ser qq valor
  factory Video.fromJson(Map<String, dynamic> json){

    if(json.containsKey("id"))

        return Video(
          id: json["id"]["videoId"],
          title: json["snippet"]["title"],
          thumb: json["snippet"]["thumbnails"]["high"]["url"],
          channel: json["snippet"]["channelTitle"]
        );
      else
        return Video(
          id: json["videoId"],
          title: json["title"],
          thumb: json["thumb"],
          channel: json["channel"]
        );

  }

  Map<String, dynamic> toJson(){
    return {
      "videoId": id,
      "title": title,
      "thumb": thumb,
      "channel": channel
    };
  }

}