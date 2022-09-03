class Contest {
  var _contest_type,_contest_code,_name;

  var _id, _spots_left,_prize, _entry, _spots,_category_id,_user_id,_number_of_winners,_price_percentage,_is_guaranteed,_first_price;

  Contest(this._prize, this._entry, this._spots, this._id, this._spots_left,this._contest_type,
      this._category_id,this._number_of_winners,this._user_id,this._contest_code,this._name,this._price_percentage,this._is_guaranteed,this._first_price);

  factory Contest.fromJson(dynamic json){
    print('gurantee ${json['is_guaranteed']}');
    return Contest(
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
      json['price_percentage'],
      json['is_guaranteed']==0?false:true,
      json['first_price'],
    );
  }

  get content_type => _contest_type;

  get spots_left => _spots_left;

 get id => _id;

 get contest_type => _contest_type;

  get spots => _spots;

  get entry => _entry;

  get percent => _price_percentage;

  get name => _name;

  get contest_code => _contest_code;

  get first_price => _first_price;

  get prize => _prize;

  get number_of_winners => _number_of_winners;

  get user_id => _user_id;

  get category_id => _category_id;

  get isMega => _is_guaranteed;
}
