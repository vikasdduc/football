
import 'package:fantacySports/Model/updated_transaction.dart';

import 'Date_transaction.dart';

class TransactionHistoryResp{
  bool status,next;
  String message;
  // List<date_transaction> data;
  List<UpdatedTransaction> data;

  TransactionHistoryResp.fromJson(json){

    status = json['status'];
    next = json['next'];
    data = (json['data'] as List).map((e) => UpdatedTransaction.fromJson(e)).toList();
    // data = (json['data'] as List).map((e) => date_transaction.fromJson(e)).toList();
  }

  TransactionHistoryResp.withError(msg){
    status = false;
    next = false;
    message = msg;
  }
}