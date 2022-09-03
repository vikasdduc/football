import 'Transaction.dart';

class large_transaction{
  List<Transaction> _list;

  large_transaction(this._list);

  factory large_transaction.fromJson(json){
    return large_transaction(
      json["list"]
    );
  }


  List<Transaction> get list => _list;
}