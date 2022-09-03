

class pan{
  String _user_id,_pan_name,_pan_number;
  dynamic _pan_image;

  pan(this._user_id, this._pan_name, this._pan_number,
      this._pan_image);

  dynamic get pan_image => _pan_image;

  get pan_number => _pan_number;

  get pan_name => _pan_name;

  String get user_id => _user_id;
}