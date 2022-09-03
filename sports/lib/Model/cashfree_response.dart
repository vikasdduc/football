import 'CashfreeToken.dart';

class CashfreeResponse {
  bool status;
  String message, notify_url,orderid;
  CashfreeToken cashfreeToken;

  CashfreeResponse(
      this.status, this.message, this.notify_url,this.orderid, this.cashfreeToken);

  factory CashfreeResponse.fromJson(json) {
    return CashfreeResponse(
      json["status"],
      json["message"],
      json["notify_url"],
      json["orderId"],
      CashfreeToken.fromJson(json["data"]),
    );
  }
}
