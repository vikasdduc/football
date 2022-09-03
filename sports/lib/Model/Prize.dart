class prize{
  var _rank;
  var _price_pool,_winnings;

  prize(this._rank, this._price_pool, this._winnings);

  factory prize.fromJson(dynamic json){
    return prize(
      json["rank"],
      json["price_pool"],
      json["winnings"],
    );
  }

  get winnings => _winnings;

 get price_pool => _price_pool;

 get rank => _rank;
}