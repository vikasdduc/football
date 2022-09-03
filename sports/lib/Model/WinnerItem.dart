

import 'package:fantacySports/Model/Profile.dart';

class winner_item{
  var _total_point,_rank;
  Profile _user;

  winner_item(this._total_point, this._rank, this._user);

  factory winner_item.fromJson(dynamic json){
   return winner_item(
     json["total_point"],
     json["rank"],
     Profile.fromJson(json["userDetail"]),
   );
  }

  Profile get user => _user;

  get rank => _rank;

  get total_point => _total_point;
}