
import 'package:fantacySports/Model/updated_transaction.dart';

import 'Transaction.dart';

class date_transaction{
  List<Transaction> _transactions;

  date_transaction(this._transactions);

  factory date_transaction.fromJson(json){
    return date_transaction(
        (json['data'] as List).map((e) =>Transaction.fromJson(e)).toList()
    );
  }


  List<Transaction> get transactions => _transactions;
}
class date_transaction2{
  List<UpdatedTransaction> _transactions;

  date_transaction2(this._transactions);



  factory date_transaction2.fromJson(json){
    return date_transaction2(
        (json['data'] as List).map((e) =>UpdatedTransaction.fromJson(e)).toList()
    );
  }


  List<UpdatedTransaction> get transactions => _transactions;
}