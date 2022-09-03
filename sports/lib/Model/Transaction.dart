
class Transaction{
  var _id;
  var _uid,_order_id,_transaction_id,_amount,_description,_date,_team_name,_ac_date;

  Transaction(
      this._id, this._uid, this._order_id, this._transaction_id, this._amount,this._description,this._date,this._team_name,this._ac_date);

  factory Transaction.fromJson(dynamic json){
    return Transaction(
      json['id'],
      json['uid'],
      json['order_id'],
      json['transaction_id'],
      json['amount'],
      json['description'],
      json['created_at'],
      json['team_name'],
      json['date'],
    );
  }

  get amount => _amount;

  get transaction_id => _transaction_id;

   get order_id => _order_id;

  get uid => _uid;

  get team_name => _team_name;

  get date => _date;

  get ac_date => _ac_date;

  get description => _description;

 get id => _id;
}