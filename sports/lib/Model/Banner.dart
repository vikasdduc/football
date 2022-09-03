

class banner{
  int _id;
  String _url;

  banner(this._id, this._url);

  factory banner.fromJson(dynamic json){
    return banner(
      json["id"],
      json["img"],
    );
  }

  String get url => _url;

  int get id => _id;
}