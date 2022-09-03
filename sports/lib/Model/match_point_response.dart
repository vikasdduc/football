
class MatchPointResponse{
  bool status;
  String message;
  double total_point;
  List<MatchPlayerPoint> players;

  MatchPointResponse.fromJson(json){
    status = json["status"]==null?false:json["status"];
    message = "Successfully";
    total_point = json["total_points"]==null?0:double.parse(json["total_points"].toString());
    players = json["result"]==null?[]:(json["result"] as List).map((e) => MatchPlayerPoint.fromJson(e)).toList();
  }
  MatchPointResponse.withError(msg){
    status = false;
    message = msg;
  }
}

class MatchPlayerPoint{
  int pid,points;
  bool cap,vcap;
  MatchPlayerPoint.fromJson(json){
    pid = json["pid"]==null?0:json["pid"];
    points = json["points"]==null?0:json["points"];
    cap = json["is_captain"]==null?false:json["is_captain"];
    vcap = json["is_vice_captain"]==null?false:json["is_vice_captain"];
  }
}