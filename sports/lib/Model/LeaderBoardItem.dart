
class leaderBoard{
  int _id,_total_point,_rank;
  String _name,_email,_phone,_balance;

  leaderBoard(this._id, this._total_point, this._rank, this._name, this._email,
      this._phone, this._balance);

  factory leaderBoard.fromJson(json){
    return leaderBoard(
      json["id"],
      json["total_point"],
      json["rank"],
      json["name"],
      json["email"],
      json["phone"],
      json["balance"],
    );
  }

  get balance => _balance;

  get phone => _phone;

  get email => _email;

  String get name => _name;

  get rank => _rank;

  get total_point => _total_point;

  int get id => _id;
}