class paytm_token{

  var _signature,_txnToken,_order_id;

  paytm_token(this._signature, this._txnToken,this._order_id);

  factory paytm_token.fromJson(dynamic json){
    return paytm_token(
      json["head"]["signature"],
      json["body"]["txnToken"],
      json["order_id"],
    );
  }


  get txnToken => _txnToken;

  get order_id => _order_id;

  get signature => _signature;
}