import 'dart:math';

import 'package:cashfree_pg/cashfree_pg.dart';
import 'package:fantacySports/Language/appLocalizations.dart';
import 'package:fantacySports/Model/Paytm_Token.dart';
import 'package:fantacySports/Model/Profile.dart';
import 'package:fantacySports/Model/Transaction.dart';
import 'package:fantacySports/Networking/AccessNetwork.dart';
import 'package:fantacySports/constance/constance.dart';
import 'package:fantacySports/widget/customButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_braintree/flutter_braintree.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:paytm_allinonesdk/paytm_allinonesdk.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../Model/Date_transaction.dart';
import '../../../main.dart';
import 'cashfree.dart';

class AddCashPage extends StatefulWidget {
  @override
  _AddCashPageState createState() => _AddCashPageState();
}

class _AddCashPageState extends State<AddCashPage> {
  int totalAmount = 0;

  TextEditingController _controller;

  AlertDialog alert;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFAFAFA),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).padding.top,
            color: Theme.of(context).primaryColor,
          ),
          Container(
            height: AppBar().preferredSize.height,
            color: Theme.of(context).primaryColor,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    AppLocalizations.of('Add Cash'),
                    style: Theme.of(context).textTheme.caption.copyWith(
                          color: Colors.white,
                          letterSpacing: 0.6,
                          fontSize: 22,
                        ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: AppBar().preferredSize.height,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: Row(
                children: [
                  Icon(
                    FontAwesomeIcons.wallet,
                    color: Colors.orange,
                    size: 22,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    AppLocalizations.of('Current Balance'),
                    style: Theme.of(context).textTheme.caption.copyWith(
                          color: Theme.of(context).textTheme.headline6.color,
                          letterSpacing: 0.6,
                          fontSize: 16,
                        ),
                  ),
                  Expanded(child: SizedBox()),
                  Text(
                    "₹${ConstanceData.wallet_amount}",
                    style: Theme.of(context).textTheme.caption.copyWith(
                          color: Theme.of(context).textTheme.headline6.color,
                          letterSpacing: 0.6,
                          fontSize: 14,
                        ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            height: 80,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 14,
                right: 14,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 65,
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.1),
                        border: Border(bottom: BorderSide(color: Colors.green)),
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 8, left: 14, right: 14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of('Amount to add'),
                              style:
                                  Theme.of(context).textTheme.caption.copyWith(
                                        color: Colors.green,
                                        letterSpacing: 0.6,
                                        fontSize: 12,
                                      ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextField(
                              onChanged: (txt) {
                                setState(() {
                                  print(txt);
                                  if (txt != '' &&
                                      txt != null &&
                                      txt != 'null') {
                                    totalAmount = int.parse(txt);
                                  } else {
                                    totalAmount = 0;
                                  }
                                });
                              },
                              controller: _controller,
                              decoration: new InputDecoration.collapsed(
                                hintText: 'Amount',
                              ),
                              keyboardType: TextInputType.number,
                              style:
                                  Theme.of(context).textTheme.caption.copyWith(
                                        color: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            .color,
                                        letterSpacing: 0.6,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   width: 10,
                  // ),
                  // GestureDetector(
                  //   onTap: () => {
                  //     setState(() {
                  //       _controller.text = '100';
                  //       totalAmount = 100;
                  //     })
                  //   },
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //         border: Border.all(
                  //           color: Theme.of(context).disabledColor,
                  //         ),
                  //         borderRadius: BorderRadius.circular(4)),
                  //     child: Padding(
                  //       padding: const EdgeInsets.only(
                  //           top: 8, bottom: 8, left: 14, right: 14),
                  //       child: Text(
                  //         "₹100",
                  //         style: Theme.of(context).textTheme.caption.copyWith(
                  //               color:
                  //                   Theme.of(context).textTheme.headline6.color,
                  //               letterSpacing: 0.6,
                  //               fontSize: 14,
                  //             ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   width: 10,
                  // ),
                  // GestureDetector(
                  //   onTap: () => {
                  //     setState(() {
                  //       _controller.text = '200';
                  //       totalAmount = 200;
                  //     })
                  //   },
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //         border: Border.all(
                  //           color: Theme.of(context).disabledColor,
                  //         ),
                  //         borderRadius: BorderRadius.circular(4)),
                  //     child: Padding(
                  //       padding: const EdgeInsets.only(
                  //           top: 8, bottom: 8, left: 14, right: 14),
                  //       child: Text(
                  //         "₹200",
                  //         style: Theme.of(context).textTheme.caption.copyWith(
                  //               color:
                  //                   Theme.of(context).textTheme.headline6.color,
                  //               letterSpacing: 0.6,
                  //               fontSize: 14,
                  //             ),
                  //       ),
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 14, right: 14, bottom: 20),
            child: CustomButton(
              text: AppLocalizations.of('Add ₹${totalAmount}'),
              onTap: () async {
                if (totalAmount != 0) {
                  startpayment();
                } else {
                  Fluttertoast.showToast(
                      msg: "Total amount should at least be 1 rupees",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void startpayment() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) => Card(
        color: Theme.of(context).appBarTheme.color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        child: Container(
          height: 180,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Theme.of(context).appBarTheme.color,
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 14, right: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  AppLocalizations.of('Select Payment Option'),
                  style: Theme.of(context).textTheme.caption.copyWith(
                        color: Colors.black,
                        letterSpacing: 0.6,
                        fontSize: 18,
                      ),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    // RazorPay();
                    paytm();
                  },
                  child: Row(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        child: Image.asset(
                          'assets/images/paytm.webp',
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Paytm",
                        style: Theme.of(context).textTheme.caption.copyWith(
                              color:
                                  Theme.of(context).textTheme.headline6.color,
                              letterSpacing: 0.6,
                              fontSize: 14,
                            ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    // RazorPay();
                    // paytm();
                    cashfree();
                  },
                  child: Row(
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        child: Image.asset(
                          'assets/images/cashfree.png',
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Cashfree",
                        style: Theme.of(context).textTheme.caption.copyWith(
                              color:
                                  Theme.of(context).textTheme.headline6.color,
                              letterSpacing: 0.6,
                              fontSize: 14,
                            ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  CheckValid(value) async {
    if (value == 'Token is Expired') {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.clear();
      Navigator.pushReplacementNamed(context, Routes.HOST);
    } else {}
  }

  void paytm() async {
    String r = Random().nextInt(999999).toString().padLeft(6, '0');
    access_network()
        .paytm_do_payment(ConstanceData.prof.id.toString(),
            'order_JFLkEB0mzZDRTH', totalAmount.toString())
        .then((_) {
      paytm_token token = _;
      continuePayment(token.order_id, token.txnToken);
    });
  }

  void continuePayment(orderId, token) {
    print('orderId ${orderId} ${token}');
    var response = AllInOneSdk.startTransaction(
      ConstanceData.mid,
      orderId,
      totalAmount.toString(),
      token,
      '${ConstanceData.callbackurl}?ORDER_ID=${orderId}',
      // 'https://apnateam.co.in/admin/public/api/paytm-callback-url',
      ConstanceData.isStaging,
      false,
    ).then((value) {
      print('eac1 ${value}');
      Navigator.pop(context);
      show(true, orderId, value);
    });
    response.then((value) {
      print('eac ${value}');
      access_network().transactionStatus(orderId.toString()).then((value) => {
            if (value == "TXN_SUCCESS")
              {show(true, orderId, value)}
            else
              {show(false, orderId, 'Transaction Failed')}
          });
      // Navigator.pop(context);
    }).catchError((onError) {
      if (onError is PlatformException) {
        print('as t2 ${onError}');
        Navigator.pop(context);
        show(false, orderId, onError);
      } else {
        print('as t3 ${onError.message}');
        Navigator.pop(context);
        show(false, orderId, onError);
      }
    });
  }

  show(bool success, String id, dynamic value) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              new Text(
                success ? 'Transaction successful' : 'Transaction failed',
                style: Theme.of(context).textTheme.caption.copyWith(
                      color: success ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
              ),
            ],
          ),
          content: SizedBox(
            height: 130,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: success
                        ? Colors.green.withOpacity(0.25)
                        : Colors.red.withOpacity(0.25),
                    // border color
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    success ? Icons.check : Icons.cancel,
                    color:
                        success ? Colors.green.shade900 : Colors.red.shade900,
                    size: 50,
                  ),
                ),
                SizedBox(
                  height: 13,
                ),
                Text(
                  success
                      ? 'Your Transaction Id is ${id}'
                      : 'Please try again later',
                  style: Theme.of(context).textTheme.caption.copyWith(
                        color: success ? Colors.green : Colors.red,
                        fontSize: 13,
                      ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              onPressed: () {
                if (success) {
                  Navigator.pop(context);
                  Navigator.pop(context);
                }
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Card(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  padding: EdgeInsets.all(7),
                  child: new Text(
                    'Done',
                    style: Theme.of(context).textTheme.caption.copyWith(
                          color: success ? Colors.green : Colors.red,
                          fontSize: 14,
                        ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    ).whenComplete(() {
      if (success) {
        access_network().getWallet().then((value) {
          if (value.status) {
            if (mounted) {
              setState(() {
                ConstanceData.wallet_amount =
                    int.parse(value.wallet_amount.toString());
                ConstanceData.winnings = int.parse(value.winnings.toString());
              });
            } else {
              ConstanceData.wallet_amount =
                  int.parse(value.wallet_amount.toString());
              ConstanceData.winnings = int.parse(value.winnings.toString());
            }
          }
          access_network().kyc_get().then((value) => {
                CheckValid(value),
                setState(() {
                  ConstanceData.setProfile(
                      Profile.fromJson(value['Get_Kyc_data']));
                }),

              });
        });
      }
      Future.value(false);
    });
    return Future.delayed(Duration(seconds: 3), () {
      return Future.value(false);
    });
  }

  showLoaderDialog(BuildContext context) {
    alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void cashfree() async {
    showLoaderDialog(context);
    access_network()
        .cashfreeTransaction(
            await ConstanceData.getId(),
            totalAmount.toString(),
            ConstanceData.prof.phone.toString(),
            ConstanceData.prof.name,
            ConstanceData.prof.email)
        .then((value) {
      Navigator.pop(context);
      print(value.notify_url);
      if (value.status) {
        print('orser ${value.orderid}');
        var data = {
          'stage': 'TEST',
          'appId': ConstanceData.cashfreeID,
          'orderId': value.orderid.toString(),
          'notifyUrl': value.notify_url,
          'orderCurrency': 'INR',
          'tokenData': value.cashfreeToken.cftoken,
          'orderAmount': totalAmount.toString(),
          'customerName': ConstanceData.prof.name,
          'customerEmail': ConstanceData.prof.email,
          'customerPhone': ConstanceData.prof.phone.toString(),
        };
        print(data);
        CashfreePGSDK.doPayment(data).then((value) {
          if (value["txStatus"] == "SUCCESS") {
            show(true, value["orderId"], value);
          } else {
            show(false, value["orderId"], value);
          }
        });
      } else {
        Fluttertoast.showToast(
            msg: value.message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        show(false, value.orderid, value);
      }

      // Navigator.push(context,
      //     MaterialPageRoute(builder: (BuildContext context) {
      //   return CashFreeWebview(
      //     value.paymentLink,
      //   );
      // }));
    });
  }
}
