class week{
  int _week_no;
  String _start_date,_end_date;

  week(this._week_no, this._start_date, this._end_date);

  factory week.fromJson(dynamic json){
    return week(
      json["week_no"],
      json["start_date"],
      json["end_date"],
    );
  }

  get end_date => _end_date;

  String get start_date => _start_date;

  int get week_no => _week_no;
}