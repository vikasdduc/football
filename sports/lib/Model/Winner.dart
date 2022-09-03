
class winner{
  String _Rank,_Percentage;
  int _Winner;

  winner(this._Rank, this._Percentage, this._Winner);

  factory winner.fromJson(dynamic json){
    return winner(
      json['Rank'],
      json['Percentage'],
      json['Winner'],
    );
  }

  int get Winner => _Winner;

  get Percentage => _Percentage;

  String get Rank => _Rank;
}