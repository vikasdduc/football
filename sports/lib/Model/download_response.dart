class DownloadResponse{
  bool status;
  String message,link;
  DownloadResponse.fromJson(json){
    status = json['status'];
    message = json["team"];
    link = json["link"];
  }
  DownloadResponse.withError(msg){
    status = false;
    message = "Something went wrong";
  }

}