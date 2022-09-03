import 'GetTeam_2.dart';

class ContestJoined {
  String _contest_type,_contest_code,_name;


  var _price_percentage,_is_guaranteed,_first_price;
  int _id, _spots_left,_prize, _entry, _spots,_category_id,_user_id,_number_of_winners;

  List<GetTeam_2> _team;

  ContestJoined(this._prize, this._entry, this._spots, this._id, this._spots_left,this._contest_type,
      this._category_id,this._number_of_winners,this._user_id,this._contest_code,this._name,this._team,this._price_percentage,this._is_guaranteed,this._first_price);

  factory ContestJoined.fromJson(dynamic json){
    return ContestJoined(
      json['prize'],
      json['entry'],
      json['total_spots'],
      json['id'],
      json['spots_left'],
      json['contest_type'],
      json['category_id'],
      json['number_of_winners'],
      json['user_id'],
      json['contest_code'],
      json['contest_name'],
        json['joincontent'][0]['teams']==null?[]:(json['joincontent'][0]['teams'] as List).map((e) => GetTeam_2.fromJson(e)).toList() ,
      json['price_percentage'],
      json['is_guaranteed']==0?false:true,
      json['first_price'],
    );
  }

  get content_type => _contest_type;

  get spots_left => _spots_left;

  int get id => _id;

  String get contest_type => _contest_type;

  get spots => _spots;

  List<GetTeam_2> get team => _team;

  get entry => _entry;

  get name => _name;

  get contest_code => _contest_code;

  get prize => _prize;

  get number_of_winners => _number_of_winners;
  get percent => _price_percentage;

  get isMega => _is_guaranteed;
  get first_price => _first_price;
  get user_id => _user_id;

  get category_id => _category_id;
}
