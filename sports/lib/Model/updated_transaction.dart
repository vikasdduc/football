



class UpdatedTransaction{
  int id,status;
  String payment_method,uid,order_id,transaction_id,amount,reason,date;

  UpdatedTransaction(this.id, this.payment_method, this.uid, this.order_id,
      this.transaction_id, this.amount, this.status, this.reason, this.date);

  factory UpdatedTransaction.fromJson(json){
    return UpdatedTransaction(
      json['id'],
      json['payment_method'],
      json['uid'],
      json['order_id'],
      json['transaction_id'],
      json['amount'],
      json['status'],
      json['reason'],
      json['created_at'],
    );
  }

}