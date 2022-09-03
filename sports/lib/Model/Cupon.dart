

class cupon{
  int _id,_value;
  String _title,_expire,_updated_at;

  cupon(this._id, this._value, this._title, this._expire,this._updated_at);


  factory cupon.fromJson(dynamic json){
    return cupon(
      json["id"],
      json["value"],
      json["title"],
      json["expire"],
      json["updated_at"],
    );
  }

  get expire => _expire;

  String get title => _title;

  get value => _value;

  get updated_at => _updated_at;

  int get id => _id;
}