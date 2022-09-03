

class recently_played{
  String _short_title,_status_note,_teama_name,_teamb_name,_date_start,_teama_logo,_teamb_logo,_teama_id,_teamb_id,_match_id;
 dynamic _total_point,_teamA,_teamB,_competition_id,_team_id;


  recently_played(this._short_title, this._status_note, this._teama_name,
      this._teamb_name, this._date_start, this._teama_logo,
      this._teamb_logo, this._total_point,this._teamA,this._teamB,this._competition_id,this._teama_id,this._teamb_id,this._match_id,this._team_id);

  factory recently_played.fromJson(json){
    return recently_played(
      json['short_title'],
      json['status_note'],
      json['teama']['short_name'],
      json['teamb']['short_name'],
      json['date_start'],
      json['teama']['logo_url'],
      json['teamb']['logo_url'],
      json['highest_total_point'],
      json['teama_name'],
      json['teamb_name'],
      json['competition_id'],
      json['teama']['team_id'].toString(),
      json['teamb']['team_id'].toString(),
      json['match_id'].toString(),
      json['team_id'].toString(),
    );
  }
  get team_id => _team_id;

  get teama_id => _teama_id;

  get total_point => _total_point;

  get teamb_logo => _teamb_logo;

  get teama_logo => _teama_logo;

  get teamA => _teamA;

  get date_start => _date_start;

  get teamb_name => _teamb_name;

  get teama_name => _teama_name;

  get status_note => _status_note;

  get match_id => _match_id;

  String get short_title => _short_title;

  get teamB => _teamB;

  get competition_id => _competition_id;

  get teamb_id => _teamb_id;
}