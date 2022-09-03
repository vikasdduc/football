

class selby_Player{
  String _select_ratio,_caption_select_ratio,_vice_caption_select_ratio;
  int _fantasy_player_rating,_player_id;

  selby_Player(this._select_ratio, this._fantasy_player_rating,this._player_id,this._caption_select_ratio,this._vice_caption_select_ratio);

  factory selby_Player.fromJson(dynamic json){
    return selby_Player(
      json['select_ratio'],
      json['fantasy_player_rating'],
      json['player_id'],
      json['caption_select_ratio'],
      json['vice_caption_select_ratio'],
    );
  }

  get caption_select_ratio => _caption_select_ratio;

  get vice_caption_select_ratio => _vice_caption_select_ratio;

  get player_id => _player_id;

  int get fantasy_player_rating => _fantasy_player_rating;

  String get select_ratio => _select_ratio;
}