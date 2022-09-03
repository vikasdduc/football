

class commentaries {

  var _event_id,_event,_over,_ball,_commentary,_text;
  var _batsman_id,_bowler_id,_score,_timestamp,_run;
  bool _noball_dismissal;

  commentaries(
      this._event_id,
      this._event,
      this._over,
      this._ball,
      this._commentary,
      this._text,
      this._batsman_id,
      this._bowler_id,
      this._score,
      this._timestamp,
      this._run,
      this._noball_dismissal);

  factory commentaries.fromJson(dynamic json){
    return commentaries(
      json["event_id"],
      json["event"],
      json["over"].toString(),
      json["ball"],
      json["commentary"],
      json["text"],
      json["batsman_id"],
      json["bowler_id"],
      json["score"],
      json["timestamp"],
      json["run"],
      json["noball_dismissal"]=='true'?true:false,
    );
  }
  @override
  String toString() {
    return 'commentaries{_event_id: $_event_id, _event: $_event, _over: $_over, _ball: $_ball, _commentary: $_commentary, _text: $_text, _batsman_id: $_batsman_id, _bowler_id: $_bowler_id, _score: $_score, _timestamp: $_timestamp, _run: $_run, _noball_dismissal: $_noball_dismissal}';
  }

  bool get noball_dismissal => _noball_dismissal;

  get run => _run;

  get timestamp => _timestamp;

  get score => _score;

  get bowler_id => _bowler_id;

  int get batsman_id => _batsman_id;

  get text => _text;

  get commentary => _commentary;

  get ball => _ball;

  get over => _over;

  get event => _event;

  String get event_id => _event_id;
}