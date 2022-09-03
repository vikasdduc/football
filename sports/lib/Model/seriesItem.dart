class SeriesItem{
  int _contest_id,_compition_id;
  String _title,_abbr,_type,_category,_match_format,_status,_season;

  SeriesItem(
      this._contest_id,
      this._compition_id,
      this._title,
      this._abbr,
      this._type,
      this._category,
      this._match_format,
      this._status,
      this._season);

  factory SeriesItem.fromJson(dynamic json){
    return SeriesItem(
      json["contest_id"],
      json["compition_id"],
      json["title"],
      json["abbr"],
      json["type"],
      json["category"],
      json["match_format"],
      json["status"],
      json["season"],
    );
  }

  get season => _season;

  get status => _status;

  get match_format => _match_format;

  get category => _category;

  get type => _type;

  get abbr => _abbr;

  String get title => _title;

  get compition_id => _compition_id;

  int get contest_id => _contest_id;
}