
class user_play_History{
  int _no_of_contests,_no_of_match,_no_of_series,_no_of_wins;

  user_play_History(this._no_of_contests, this._no_of_match, this._no_of_series,
      this._no_of_wins);

  factory user_play_History.fromJson(json){
    return user_play_History(
      json['no_of_contests'],
      json['no_of_match'],
      json['no_of_series'],
      json['no_of_wins'],
    );
  }

  get no_of_wins => _no_of_wins;

  get no_of_series => _no_of_series;

  get no_of_match => _no_of_match;

  int get no_of_contests => _no_of_contests;
}