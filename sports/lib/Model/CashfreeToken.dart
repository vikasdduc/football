
class CashfreeToken{
  String status,message,cftoken;

  CashfreeToken(this.status, this.message, this.cftoken);

  factory CashfreeToken.fromJson(dynamic json){
    return CashfreeToken(
      json["status"],
      json["message"],
      json["cftoken"],
    );
  }

}
