class WalletData{
  bool status;
  int winnings;
  String wallet_amount, msg;

  WalletData(this.status, this.winnings, this.wallet_amount,this.msg);

  factory WalletData.fromJson(dynamic json){
    print(json["status"]==true);
    return WalletData(
      json["status"]=="true"?true:false,
      json["winnings"]==null||json["winnings"]=="null"?"0":json["winnings"],
      json["wallet_amount"].toString(),
      "Successful"
    );
  }
}