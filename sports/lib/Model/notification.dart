

class Notifications{

  int _id;
  String _message,_date;

  Notifications(this._id, this._message, this._date);

  factory Notifications.fromJson(dynamic json){
    return Notifications(
        json['id'],
        json['message'],
        json['date'],
    );
  }

  get data => _date;

  String get message => _message;

  int get id => _id;
}